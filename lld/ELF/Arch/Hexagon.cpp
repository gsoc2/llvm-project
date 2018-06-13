//===-- Hexagon.cpp -------------------------------------------------------===//
//
//                             The LLVM Linker
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "InputFiles.h"
#include "Symbols.h"
#include "Target.h"
#include "lld/Common/ErrorHandler.h"
#include "llvm/BinaryFormat/ELF.h"
#include "llvm/Object/ELF.h"
#include "llvm/Support/Endian.h"

using namespace llvm;
using namespace llvm::object;
using namespace llvm::support::endian;
using namespace llvm::ELF;
using namespace lld;
using namespace lld::elf;

namespace {
class Hexagon final : public TargetInfo {
public:
  uint32_t calcEFlags() const override;
  uint32_t applyMask(uint32_t Mask, uint32_t Data) const;
  RelExpr getRelExpr(RelType Type, const Symbol &S,
                     const uint8_t *Loc) const override;
  void relocateOne(uint8_t *Loc, RelType Type, uint64_t Val) const override;
};
} // namespace

// Support V60 only at the moment.
uint32_t Hexagon::calcEFlags() const {
  return 0x60;
}

uint32_t Hexagon::applyMask(uint32_t Mask, uint32_t Data) const {
  uint32_t Result = 0;
  size_t Off = 0;

  for (size_t Bit = 0; Bit != 32; ++Bit) {
    uint32_t ValBit = (Data >> Off) & 1;
    uint32_t MaskBit = (Mask >> Bit) & 1;
    if (MaskBit) {
      Result |= (ValBit << Bit);
      ++Off;
    }
  }
  return Result;
}

RelExpr Hexagon::getRelExpr(RelType Type, const Symbol &S,
                                 const uint8_t *Loc) const {
  switch (Type) {
  case R_HEX_B22_PCREL:
    return R_PC;
  default:
    return R_ABS;
  }
}

static void or32le(uint8_t *P, int32_t V) { write32le(P, read32le(P) | V); }

void Hexagon::relocateOne(uint8_t *Loc, RelType Type, uint64_t Val) const {
  switch (Type) {
  case R_HEX_NONE:
    break;
  case R_HEX_B22_PCREL:
    or32le(Loc, applyMask(0x01ff3ffe, ((Val >> 2) & 0x3fffff)));
    break;
  default:
    error(getErrorLocation(Loc) + "unrecognized reloc " + toString(Type));
    break;
  }
}

TargetInfo *elf::getHexagonTargetInfo() {
  static Hexagon Target;
  return &Target;
}
