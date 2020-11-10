; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-- \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -target-abi=elfv2 -mtriple=powerpc64-- \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -target-abi=elfv2 -mtriple=powerpc64-- \
; RUN:   -mcpu=pwr9 -ppc-asm-full-reg-names < %s | FileCheck %s --check-prefix=CHECK-P9

 define float @FloatConstantPool() {
; CHECK-LABEL: FloatConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plfs f1, .LCPI0_0@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: FloatConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI0_0@toc@ha
; CHECK-P9-NEXT:    lfs f1, .LCPI0_0@toc@l(r3)
; CHECK-P9-NEXT:    blr
entry:
  ret float 0x380FFFF840000000
}

 define double @DoubleConstantPool() {
; CHECK-LABEL: DoubleConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plfd f1, .LCPI1_0@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: DoubleConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI1_0@toc@ha
; CHECK-P9-NEXT:    lfd f1, .LCPI1_0@toc@l(r3)
; CHECK-P9-NEXT:    blr
entry:
  ret double 2.225070e-308
}

 define ppc_fp128 @LongDoubleConstantPool() {
; CHECK-LABEL: LongDoubleConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plfd f1, .LCPI2_0@PCREL(0), 1
; CHECK-NEXT:    plfd f2, .LCPI2_1@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: LongDoubleConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI2_0@toc@ha
; CHECK-P9-NEXT:    lfd f1, .LCPI2_0@toc@l(r3)
; CHECK-P9-NEXT:    addis r3, r2, .LCPI2_1@toc@ha
; CHECK-P9-NEXT:    lfd f2, .LCPI2_1@toc@l(r3)
; CHECK-P9-NEXT:    blr
entry:
  ret ppc_fp128 0xM03600000DBA876CC800D16974FD9D27B
}

 define fp128 @__Float128ConstantPool() {
; CHECK-LABEL: __Float128ConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv vs34, .LCPI3_0@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: __Float128ConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI3_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI3_0@toc@l
; CHECK-P9-NEXT:    lxvx vs34, 0, r3
; CHECK-P9-NEXT:    blr
entry:
  ret fp128 0xL00000000000000003C00FFFFC5D02B3A
}

 define <16 x i8> @VectorCharConstantPool() {
; CHECK-LABEL: VectorCharConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv vs34, .LCPI4_0@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: VectorCharConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI4_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI4_0@toc@l
; CHECK-P9-NEXT:    lxvx vs34, 0, r3
; CHECK-P9-NEXT:    blr
entry:
  ret <16 x i8> <i8 -128, i8 -127, i8 -126, i8 -125, i8 -124, i8 -123, i8 -122, i8 -121, i8 -120, i8 -119, i8 -118, i8 -117, i8 -116, i8 -115, i8 -114, i8 -113>
}

 define <8 x i16> @VectorShortConstantPool() {
; CHECK-LABEL: VectorShortConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv vs34, .LCPI5_0@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: VectorShortConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI5_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI5_0@toc@l
; CHECK-P9-NEXT:    lxvx vs34, 0, r3
; CHECK-P9-NEXT:    blr
entry:
  ret <8 x i16> <i16 -32768, i16 -32767, i16 -32766, i16 -32765, i16 -32764, i16 -32763, i16 -32762, i16 -32761>
}

 define <4 x i32> @VectorIntConstantPool() {
; CHECK-LABEL: VectorIntConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv vs34, .LCPI6_0@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: VectorIntConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI6_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI6_0@toc@l
; CHECK-P9-NEXT:    lxvx vs34, 0, r3
; CHECK-P9-NEXT:    blr
entry:
  ret <4 x i32> <i32 -2147483648, i32 -2147483647, i32 -2147483646, i32 -2147483645>
}

 define <2 x i64> @VectorLongLongConstantPool() {
; CHECK-LABEL: VectorLongLongConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv vs34, .LCPI7_0@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: VectorLongLongConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI7_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI7_0@toc@l
; CHECK-P9-NEXT:    lxvx vs34, 0, r3
; CHECK-P9-NEXT:    blr
entry:
  ret <2 x i64> <i64 -9223372036854775808, i64 -9223372036854775807>
}

 define <1 x i128> @VectorInt128ConstantPool() {
; CHECK-LABEL: VectorInt128ConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv vs34, .LCPI8_0@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: VectorInt128ConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI8_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI8_0@toc@l
; CHECK-P9-NEXT:    lxvx vs34, 0, r3
; CHECK-P9-NEXT:    blr
entry:
  ret <1 x i128> <i128 -27670116110564327424>
}

 define <4 x float> @VectorFloatConstantPool() {
; CHECK-LABEL: VectorFloatConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv vs34, .LCPI9_0@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: VectorFloatConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI9_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI9_0@toc@l
; CHECK-P9-NEXT:    lxvx vs34, 0, r3
; CHECK-P9-NEXT:    blr
entry:
  ret <4 x float> <float 0x380FFFF840000000, float 0x380FFF57C0000000, float 0x3843FFFB20000000, float 0x3843FF96C0000000>
}

 define <2 x double> @VectorDoubleConstantPool() {
; CHECK-LABEL: VectorDoubleConstantPool:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv vs34, .LCPI10_0@PCREL(0), 1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: VectorDoubleConstantPool:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI10_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI10_0@toc@l
; CHECK-P9-NEXT:    lxvx vs34, 0, r3
; CHECK-P9-NEXT:    blr
entry:
  ret <2 x double> <double 2.225070e-308, double 2.225000e-308>
}

define double @two_constants(double %a) {
; CHECK-LABEL: two_constants:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plfd f0, .LCPI11_0@PCREL(0), 1
; CHECK-NEXT:    xsadddp f0, f1, f0
; CHECK-NEXT:    plfd f1, .LCPI11_1@PCREL(0), 1
; CHECK-NEXT:    xsadddp f1, f0, f1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: two_constants:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI11_0@toc@ha
; CHECK-P9-NEXT:    lfd f0, .LCPI11_0@toc@l(r3)
; CHECK-P9-NEXT:    addis r3, r2, .LCPI11_1@toc@ha
; CHECK-P9-NEXT:    xsadddp f0, f1, f0
; CHECK-P9-NEXT:    lfd f1, .LCPI11_1@toc@l(r3)
; CHECK-P9-NEXT:    xsadddp f1, f0, f1
; CHECK-P9-NEXT:    blr
entry:
  %0 = fadd double %a, 3.344000e+00
  %1 = fadd double %0, 2.344000e+00
  ret double %1
}

define double @two_constants_two_bb(i32 %m, double %a) {
; CHECK-LABEL: two_constants_two_bb:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmplwi r3, 0
; CHECK-NEXT:    beq cr0, .LBB12_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    plfd f1, .LCPI12_0@PCREL(0), 1
; CHECK-NEXT:    blr
; CHECK-NEXT:  .LBB12_2: # %if.end
; CHECK-NEXT:    plfd f0, .LCPI12_1@PCREL(0), 1
; CHECK-NEXT:    xsadddp f1, f1, f0
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: two_constants_two_bb:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    cmplwi r3, 0
; CHECK-P9-NEXT:    beq cr0, .LBB12_2
; CHECK-P9-NEXT:  # %bb.1:
; CHECK-P9-NEXT:    addis r3, r2, .LCPI12_0@toc@ha
; CHECK-P9-NEXT:    lfd f1, .LCPI12_0@toc@l(r3)
; CHECK-P9-NEXT:    blr
; CHECK-P9-NEXT:  .LBB12_2: # %if.end
; CHECK-P9-NEXT:    addis r3, r2, .LCPI12_1@toc@ha
; CHECK-P9-NEXT:    lfd f0, .LCPI12_1@toc@l(r3)
; CHECK-P9-NEXT:    xsadddp f1, f1, f0
; CHECK-P9-NEXT:    blr
entry:
  %tobool.not = icmp eq i32 %m, 0
  br i1 %tobool.not, label %if.end, label %return

if.end:
  %add = fadd double %a, 9.880000e+00
  br label %return

return:
  %retval.0 = phi double [ %add, %if.end ], [ 4.555000e+00, %entry ]
  ret double %retval.0
}

define double @three_constants_f64(double %a, double %c) {
; CHECK-LABEL: three_constants_f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plfd f0, .LCPI13_0@PCREL(0), 1
; CHECK-NEXT:    xsadddp f0, f1, f0
; CHECK-NEXT:    plfd f1, .LCPI13_1@PCREL(0), 1
; CHECK-NEXT:    xsadddp f0, f0, f1
; CHECK-NEXT:    plfd f1, .LCPI13_2@PCREL(0), 1
; CHECK-NEXT:    xsadddp f1, f0, f1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: three_constants_f64:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI13_0@toc@ha
; CHECK-P9-NEXT:    lfd f0, .LCPI13_0@toc@l(r3)
; CHECK-P9-NEXT:    addis r3, r2, .LCPI13_1@toc@ha
; CHECK-P9-NEXT:    xsadddp f0, f1, f0
; CHECK-P9-NEXT:    lfd f1, .LCPI13_1@toc@l(r3)
; CHECK-P9-NEXT:    addis r3, r2, .LCPI13_2@toc@ha
; CHECK-P9-NEXT:    xsadddp f0, f0, f1
; CHECK-P9-NEXT:    lfd f1, .LCPI13_2@toc@l(r3)
; CHECK-P9-NEXT:    xsadddp f1, f0, f1
; CHECK-P9-NEXT:    blr
entry:
  %0 = fadd double %a, 3.344000e+00
  %1 = fadd double %0, 2.344000e+00
  %2 = fadd double %1, 2.394000e+00
  ret double %2
}

define float @three_constants_f32(float %a, float %c) {
; CHECK-LABEL: three_constants_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxspltidp vs0, 1083294351
; CHECK-NEXT:    xsaddsp f0, f1, f0
; CHECK-NEXT:    xxspltidp vs1, 1083296911
; CHECK-NEXT:    xsaddsp f0, f0, f1
; CHECK-NEXT:    xxspltidp vs1, 1083292559
; CHECK-NEXT:    xsaddsp f1, f0, f1
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: three_constants_f32:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI14_0@toc@ha
; CHECK-P9-NEXT:    lfs f0, .LCPI14_0@toc@l(r3)
; CHECK-P9-NEXT:    addis r3, r2, .LCPI14_1@toc@ha
; CHECK-P9-NEXT:    xsaddsp f0, f1, f0
; CHECK-P9-NEXT:    lfs f1, .LCPI14_1@toc@l(r3)
; CHECK-P9-NEXT:    addis r3, r2, .LCPI14_2@toc@ha
; CHECK-P9-NEXT:    xsaddsp f0, f0, f1
; CHECK-P9-NEXT:    lfs f1, .LCPI14_2@toc@l(r3)
; CHECK-P9-NEXT:    xsaddsp f1, f0, f1
; CHECK-P9-NEXT:    blr
entry:
  %0 = fadd float %a, 0x40123851E0000000
  %1 = fadd float %0, 0x40123991E0000000
  %2 = fadd float %1, 0x40123771E0000000
  ret float %2
}

define fp128 @three_constants_f128(fp128 %a, fp128 %c) {
; CHECK-LABEL: three_constants_f128:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv vs35, .LCPI15_0@PCREL(0), 1
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    plxv vs35, .LCPI15_1@PCREL(0), 1
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    plxv vs35, .LCPI15_2@PCREL(0), 1
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: three_constants_f128:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI15_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI15_0@toc@l
; CHECK-P9-NEXT:    lxvx vs35, 0, r3
; CHECK-P9-NEXT:    addis r3, r2, .LCPI15_1@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI15_1@toc@l
; CHECK-P9-NEXT:    xsaddqp v2, v2, v3
; CHECK-P9-NEXT:    lxvx vs35, 0, r3
; CHECK-P9-NEXT:    addis r3, r2, .LCPI15_2@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI15_2@toc@l
; CHECK-P9-NEXT:    xsaddqp v2, v2, v3
; CHECK-P9-NEXT:    lxvx vs35, 0, r3
; CHECK-P9-NEXT:    xsaddqp v2, v2, v3
; CHECK-P9-NEXT:    blr
entry:
  %0 = fadd fp128 %a, 0xL8000000000000000400123851EB851EB
  %1 = fadd fp128 %0, 0xL8000000000000000400123851EB991EB
  %2 = fadd fp128 %1, 0xL8000000000000000400123851EB771EB
  ret fp128 %2
}

define ppc_fp128 @three_constants_ppcf128(ppc_fp128 %a, ppc_fp128 %c) {
; CHECK-LABEL: three_constants_ppcf128:
; CHECK:         .localentry three_constants_ppcf128, 1
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    mflr r0
; CHECK-NEXT:    std r0, 16(r1)
; CHECK-NEXT:    stdu r1, -32(r1)
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    plfd f3, .LCPI16_0@PCREL(0), 1
; CHECK-NEXT:    xxlxor f4, f4, f4
; CHECK-NEXT:    bl __gcc_qadd@notoc
; CHECK-NEXT:    plfd f3, .LCPI16_1@PCREL(0), 1
; CHECK-NEXT:    xxlxor f4, f4, f4
; CHECK-NEXT:    bl __gcc_qadd@notoc
; CHECK-NEXT:    plfd f3, .LCPI16_2@PCREL(0), 1
; CHECK-NEXT:    xxlxor f4, f4, f4
; CHECK-NEXT:    bl __gcc_qadd@notoc
; CHECK-NEXT:    addi r1, r1, 32
; CHECK-NEXT:    ld r0, 16(r1)
; CHECK-NEXT:    mtlr r0
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: three_constants_ppcf128:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    mflr r0
; CHECK-P9-NEXT:    std r0, 16(r1)
; CHECK-P9-NEXT:    stdu r1, -32(r1)
; CHECK-P9-NEXT:    .cfi_def_cfa_offset 32
; CHECK-P9-NEXT:    .cfi_offset lr, 16
; CHECK-P9-NEXT:    addis r3, r2, .LCPI16_0@toc@ha
; CHECK-P9-NEXT:    xxlxor f4, f4, f4
; CHECK-P9-NEXT:    lfd f3, .LCPI16_0@toc@l(r3)
; CHECK-P9-NEXT:    bl __gcc_qadd
; CHECK-P9-NEXT:    nop
; CHECK-P9-NEXT:    addis r3, r2, .LCPI16_1@toc@ha
; CHECK-P9-NEXT:    xxlxor f4, f4, f4
; CHECK-P9-NEXT:    lfd f3, .LCPI16_1@toc@l(r3)
; CHECK-P9-NEXT:    bl __gcc_qadd
; CHECK-P9-NEXT:    nop
; CHECK-P9-NEXT:    addis r3, r2, .LCPI16_2@toc@ha
; CHECK-P9-NEXT:    xxlxor f4, f4, f4
; CHECK-P9-NEXT:    lfd f3, .LCPI16_2@toc@l(r3)
; CHECK-P9-NEXT:    bl __gcc_qadd
; CHECK-P9-NEXT:    nop
; CHECK-P9-NEXT:    addi r1, r1, 32
; CHECK-P9-NEXT:    ld r0, 16(r1)
; CHECK-P9-NEXT:    mtlr r0
; CHECK-P9-NEXT:    blr
entry:
  %0 = fadd ppc_fp128 %a, 0xM40123851EB851EB80000000000000000
  %1 = fadd ppc_fp128 %0, 0xM4012385199851EB80000000000000000
  %2 = fadd ppc_fp128 %1, 0xM4012385100851EB80000000000000000
  ret ppc_fp128 %2
}

define <2 x double> @three_constants_vector(<2 x double> %a, <2 x double> %c) {
; CHECK-LABEL: three_constants_vector:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv vs0, .LCPI17_0@PCREL(0), 1
; CHECK-NEXT:    plxv vs2, .LCPI17_1@PCREL(0), 1
; CHECK-NEXT:    xvadddp vs1, vs34, vs0
; CHECK-NEXT:    xvadddp vs1, vs1, vs2
; CHECK-NEXT:    xvadddp vs34, vs1, vs0
; CHECK-NEXT:    blr
;
; CHECK-P9-LABEL: three_constants_vector:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI17_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI17_0@toc@l
; CHECK-P9-NEXT:    lxvx vs0, 0, r3
; CHECK-P9-NEXT:    addis r3, r2, .LCPI17_1@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI17_1@toc@l
; CHECK-P9-NEXT:    lxvx vs2, 0, r3
; CHECK-P9-NEXT:    xvadddp vs1, vs34, vs0
; CHECK-P9-NEXT:    xvadddp vs1, vs1, vs2
; CHECK-P9-NEXT:    xvadddp vs34, vs1, vs0
; CHECK-P9-NEXT:    blr
entry:
  %0 = fadd <2 x double> %a, <double 4.555000e+00, double 9.880000e+00>
  %1 = fadd <2 x double> %0, <double 4.555000e+00, double 9.980000e+00>
  %2 = fadd <2 x double> %1, <double 4.555000e+00, double 9.880000e+00>
  ret <2 x double> %2
}
