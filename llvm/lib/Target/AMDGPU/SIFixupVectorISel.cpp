//===-- SIFixupVectorISel.cpp - Fixup post ISel vector issues -------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
/// \file
/// SIFixupVectorISel pass cleans up post ISEL Vector issues.
/// Currently this will convert GLOBAL_{LOAD|STORE}_*
/// and GLOBAL_Atomic_* instructions into their _SADDR variants,
/// feeding the sreg into the saddr field of the new instruction.
/// We currently handle a REG_SEQUENCE feeding the vaddr
/// and decompose it into a base and index.
///
/// Transform:
/// %17:vgpr_32, %19:sreg_64_xexec = V_ADD_I32_e64 %21:sgpr_32, %22:vgpr_32
/// %18:vgpr_32, %20:sreg_64_xexec = V_ADDC_U32_e64 %25:vgpr_32,
///                                    %24:vgpr_32, %19:sreg_64_xexec
/// %16:vreg_64 = REG_SEQUENCE %17:vgpr_32, %sub0, %18:vgpr_32, %sub1
/// %11:vreg_64 = COPY %16:vreg_64
/// %10:vgpr_32 = GLOBAL_LOAD_DWORD killed %11:vreg_64, 16, 0, 0
/// Into:
/// %4:sreg_64_xexec = S_LOAD_DWORDX2_IMM %1:sgpr_64, 36, 0
/// %14:vreg_64 = REG_SEQUENCE %6:vgpr_32, %sub0, %15:vgpr_32, %sub1
/// %10:vgpr_32 = GLOBAL_LOAD_DWORD_SADDR %14:vreg_64, %4:sreg_64_xexec,16...
///
//===----------------------------------------------------------------------===//
//

#include "AMDGPU.h"
#include "AMDGPUSubtarget.h"
#include "MCTargetDesc/AMDGPUMCTargetDesc.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/Support/Debug.h"
#include "llvm/Target/TargetMachine.h"
#define DEBUG_TYPE "si-fixup-vector-isel"

using namespace llvm;

static cl::opt<bool> EnableGlobalSGPRAddr(
  "amdgpu-enable-global-sgpr-addr",
  cl::desc("Enable use of SGPR regs for GLOBAL LOAD/STORE instructions"),
  cl::init(false));

STATISTIC(NumSGPRGlobalOccurs, "Number of global ld/st opportunities");
STATISTIC(NumSGPRGlobalSaddrs, "Number of global sgpr instructions converted");

namespace {

class SIFixupVectorISel : public MachineFunctionPass {
public:
  static char ID;

public:
  SIFixupVectorISel() : MachineFunctionPass(ID) {
    initializeSIFixupVectorISelPass(*PassRegistry::getPassRegistry());
  }

  bool runOnMachineFunction(MachineFunction &MF) override;

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesCFG();
    MachineFunctionPass::getAnalysisUsage(AU);
  }
};

} // End anonymous namespace.

INITIALIZE_PASS(SIFixupVectorISel, DEBUG_TYPE,
                "SI Fixup Vector ISel", false, false)

char SIFixupVectorISel::ID = 0;

char &llvm::SIFixupVectorISelID = SIFixupVectorISel::ID;

FunctionPass *llvm::createSIFixupVectorISelPass() {
  return new SIFixupVectorISel();
}

static bool findSRegBaseAndIndex(MachineOperand *Op,
                                 unsigned &BaseReg,
                                 unsigned &IndexReg,
                                 MachineRegisterInfo &MRI,
                                 const SIRegisterInfo *TRI) {
  SmallVector<MachineOperand *, 8> Worklist;
  Worklist.push_back(Op);
  while (!Worklist.empty()) {
    MachineOperand *WOp = Worklist.pop_back_val();
    if (!WOp->isReg() || !Register::isVirtualRegister(WOp->getReg()))
      continue;
    MachineInstr *DefInst = MRI.getUniqueVRegDef(WOp->getReg());
    switch (DefInst->getOpcode()) {
    default:
      continue;
    case AMDGPU::COPY:
      Worklist.push_back(&DefInst->getOperand(1));
      break;
    case AMDGPU::REG_SEQUENCE:
      if (DefInst->getNumOperands() != 5)
        continue;
      Worklist.push_back(&DefInst->getOperand(1));
      Worklist.push_back(&DefInst->getOperand(3));
      break;
    case AMDGPU::V_ADD_I32_e64:
      // The V_ADD_* and its analogous V_ADDCV_* are generated by
      // a previous pass which lowered from an ADD_64_PSEUDO,
      // which generates subregs to break up the 64 bit args.
      if (DefInst->getOperand(2).getSubReg() != AMDGPU::NoSubRegister)
        continue;
      BaseReg = DefInst->getOperand(2).getReg();
      if (DefInst->getOperand(3).getSubReg() != AMDGPU::NoSubRegister)
        continue;
      IndexReg = DefInst->getOperand(3).getReg();
      // Chase the IndexReg.
      MachineInstr *MI = MRI.getUniqueVRegDef(IndexReg);
      if (!MI || !MI->isCopy())
        continue;
      // Make sure the reg class is 64 bit for Index.
      // If the Index register is a subreg, we want it to reference
      // a 64 bit register which we will use as the Index reg.
      const TargetRegisterClass *IdxRC, *BaseRC;
      IdxRC = MRI.getRegClass(MI->getOperand(1).getReg());
      if (AMDGPU::getRegBitWidth(IdxRC->getID()) != 64)
        continue;
      IndexReg = MI->getOperand(1).getReg();
      // Chase the BaseReg.
      MI = MRI.getUniqueVRegDef(BaseReg);
      if (!MI || !MI->isCopy())
        continue;
      // Make sure the register class is 64 bit for Base.
      BaseReg = MI->getOperand(1).getReg();
      BaseRC = MRI.getRegClass(BaseReg);
      if (AMDGPU::getRegBitWidth(BaseRC->getID()) != 64)
        continue;
      // Make sure Base is SReg and Index is VReg.
      if (!TRI->isSGPRReg(MRI, BaseReg))
        return false;
      if (!TRI->hasVGPRs(MRI.getRegClass(IndexReg)))
        return false;
      // clear any killed flags on Index and Base regs, used later.
      MRI.clearKillFlags(IndexReg);
      MRI.clearKillFlags(BaseReg);
      return true;
    }
  }
  return false;
}

// Identify Global LOAD|STORE/ATOMIC and try to convert to _SADDR.
static bool fixupGlobalSaddr(MachineBasicBlock &MBB,
                             MachineFunction &MF,
                             MachineRegisterInfo &MRI,
                             const GCNSubtarget &ST,
                             const SIInstrInfo *TII,
                             const SIRegisterInfo *TRI) {
  if (!EnableGlobalSGPRAddr)
    return false;
  bool FuncModified = false;
  MachineBasicBlock::iterator I, Next;
  for (I = MBB.begin(); I != MBB.end(); I = Next) {
    Next = std::next(I);
    MachineInstr &MI = *I;
    int NewOpcd = AMDGPU::getGlobalSaddrOp(MI.getOpcode());
    if (NewOpcd < 0)
      continue;
    // Update our statistics on opportunities seen.
    ++NumSGPRGlobalOccurs;
    LLVM_DEBUG(dbgs() << "Global Mem opp " << MI << '\n');
    // Need a Base and Index or we cant transform to _SADDR.
    unsigned BaseReg = 0;
    unsigned IndexReg = 0;
    MachineOperand *Op = TII->getNamedOperand(MI, AMDGPU::OpName::vaddr);
    if (!findSRegBaseAndIndex(Op, BaseReg, IndexReg, MRI, TRI))
      continue;
    ++NumSGPRGlobalSaddrs;
    FuncModified = true;
    // Create the new _SADDR Memory instruction.
    bool HasVdst = TII->getNamedOperand(MI, AMDGPU::OpName::vdst) != nullptr;
    MachineOperand *VData = TII->getNamedOperand(MI, AMDGPU::OpName::vdata);
    MachineInstr *NewGlob = nullptr;
    NewGlob = BuildMI(MBB, I, MI.getDebugLoc(), TII->get(NewOpcd));
    if (HasVdst)
      NewGlob->addOperand(MF, MI.getOperand(0));
    NewGlob->addOperand(MF, MachineOperand::CreateReg(IndexReg, false));
    if (VData)
      NewGlob->addOperand(MF, *VData);
    NewGlob->addOperand(MF, MachineOperand::CreateReg(BaseReg, false));
    NewGlob->addOperand(*TII->getNamedOperand(MI, AMDGPU::OpName::offset));

    MachineOperand *Glc = TII->getNamedOperand(MI, AMDGPU::OpName::glc);
    // Atomics dont have a GLC, so omit the field if not there.
    if (Glc)
      NewGlob->addOperand(MF, *Glc);

    MachineOperand *DLC = TII->getNamedOperand(MI, AMDGPU::OpName::dlc);
    if (DLC)
      NewGlob->addOperand(MF, *DLC);

    NewGlob->addOperand(*TII->getNamedOperand(MI, AMDGPU::OpName::slc));
    // _D16 have an vdst_in operand, copy it in.
    MachineOperand *VDstInOp = TII->getNamedOperand(MI,
                                      AMDGPU::OpName::vdst_in);
    if (VDstInOp)
      NewGlob->addOperand(MF, *VDstInOp);
    NewGlob->copyImplicitOps(MF, MI);
    NewGlob->cloneMemRefs(MF, MI);
    // Remove the old Global Memop instruction.
    MI.eraseFromParent();
    LLVM_DEBUG(dbgs() << "New Global Mem " << *NewGlob << '\n');
  }
  return FuncModified;
}

bool SIFixupVectorISel::runOnMachineFunction(MachineFunction &MF) {
  // Only need to run this in SelectionDAG path.
  if (MF.getProperties().hasProperty(
        MachineFunctionProperties::Property::Selected))
    return false;

  if (skipFunction(MF.getFunction()))
    return false;

  MachineRegisterInfo &MRI = MF.getRegInfo();
  const GCNSubtarget &ST = MF.getSubtarget<GCNSubtarget>();
  const SIInstrInfo *TII = ST.getInstrInfo();
  const SIRegisterInfo *TRI = ST.getRegisterInfo();

  bool FuncModified = false;
  for (MachineBasicBlock &MBB : MF) {
    // Cleanup missed Saddr opportunites from ISel.
    FuncModified |= fixupGlobalSaddr(MBB, MF, MRI, ST, TII, TRI);
  }
  return FuncModified;
}
