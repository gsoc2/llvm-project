; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=ppc32-- | FileCheck %s --check-prefixes=CHECK,CHECK32
; RUN: llc < %s -mtriple=powerpc64le-- | FileCheck %s --check-prefixes=CHECK,CHECK64

declare i8 @llvm.fshl.i8(i8, i8, i8)
declare i16 @llvm.fshl.i16(i16, i16, i16)
declare i32 @llvm.fshl.i32(i32, i32, i32)
declare i64 @llvm.fshl.i64(i64, i64, i64)
declare <4 x i32> @llvm.fshl.v4i32(<4 x i32>, <4 x i32>, <4 x i32>)

declare i8 @llvm.fshr.i8(i8, i8, i8)
declare i16 @llvm.fshr.i16(i16, i16, i16)
declare i32 @llvm.fshr.i32(i32, i32, i32)
declare i64 @llvm.fshr.i64(i64, i64, i64)
declare <4 x i32> @llvm.fshr.v4i32(<4 x i32>, <4 x i32>, <4 x i32>)

; General case - all operands can be variables.

define i32 @fshl_i32(i32 %x, i32 %y, i32 %z) {
; CHECK32-LABEL: fshl_i32:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    clrlwi 5, 5, 27
; CHECK32-NEXT:    slw 3, 3, 5
; CHECK32-NEXT:    subfic 5, 5, 32
; CHECK32-NEXT:    srw 4, 4, 5
; CHECK32-NEXT:    or 3, 3, 4
; CHECK32-NEXT:    blr
;
; CHECK64-LABEL: fshl_i32:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    clrlwi 5, 5, 27
; CHECK64-NEXT:    subfic 6, 5, 32
; CHECK64-NEXT:    slw 3, 3, 5
; CHECK64-NEXT:    srw 4, 4, 6
; CHECK64-NEXT:    or 3, 3, 4
; CHECK64-NEXT:    blr
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 %z)
  ret i32 %f
}

define i64 @fshl_i64(i64 %x, i64 %y, i64 %z) {
; CHECK32-LABEL: fshl_i64:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    clrlwi 7, 8, 26
; CHECK32-NEXT:    not 8, 8
; CHECK32-NEXT:    rotlwi 6, 6, 31
; CHECK32-NEXT:    subfic 10, 7, 32
; CHECK32-NEXT:    srwi 9, 5, 1
; CHECK32-NEXT:    slw 3, 3, 7
; CHECK32-NEXT:    clrlwi 8, 8, 26
; CHECK32-NEXT:    rlwimi 6, 5, 31, 0, 0
; CHECK32-NEXT:    srw 5, 4, 10
; CHECK32-NEXT:    srw 10, 9, 8
; CHECK32-NEXT:    srw 6, 6, 8
; CHECK32-NEXT:    or 3, 3, 5
; CHECK32-NEXT:    subfic 5, 8, 32
; CHECK32-NEXT:    addi 8, 8, -32
; CHECK32-NEXT:    slw 5, 9, 5
; CHECK32-NEXT:    srw 8, 9, 8
; CHECK32-NEXT:    addi 9, 7, -32
; CHECK32-NEXT:    slw 9, 4, 9
; CHECK32-NEXT:    or 5, 6, 5
; CHECK32-NEXT:    or 3, 3, 9
; CHECK32-NEXT:    or 5, 5, 8
; CHECK32-NEXT:    slw 4, 4, 7
; CHECK32-NEXT:    or 3, 3, 10
; CHECK32-NEXT:    or 4, 4, 5
; CHECK32-NEXT:    blr
;
; CHECK64-LABEL: fshl_i64:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    clrlwi 5, 5, 26
; CHECK64-NEXT:    subfic 6, 5, 64
; CHECK64-NEXT:    sld 3, 3, 5
; CHECK64-NEXT:    srd 4, 4, 6
; CHECK64-NEXT:    or 3, 3, 4
; CHECK64-NEXT:    blr
  %f = call i64 @llvm.fshl.i64(i64 %x, i64 %y, i64 %z)
  ret i64 %f
}

; Verify that weird types are minimally supported.
declare i37 @llvm.fshl.i37(i37, i37, i37)
define i37 @fshl_i37(i37 %x, i37 %y, i37 %z) {
; CHECK32-LABEL: fshl_i37:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    mflr 0
; CHECK32-NEXT:    stw 0, 4(1)
; CHECK32-NEXT:    stwu 1, -32(1)
; CHECK32-NEXT:    .cfi_def_cfa_offset 32
; CHECK32-NEXT:    .cfi_offset lr, 4
; CHECK32-NEXT:    .cfi_offset r27, -20
; CHECK32-NEXT:    .cfi_offset r28, -16
; CHECK32-NEXT:    .cfi_offset r29, -12
; CHECK32-NEXT:    .cfi_offset r30, -8
; CHECK32-NEXT:    stw 27, 12(1) # 4-byte Folded Spill
; CHECK32-NEXT:    mr 27, 3
; CHECK32-NEXT:    stw 28, 16(1) # 4-byte Folded Spill
; CHECK32-NEXT:    mr 28, 4
; CHECK32-NEXT:    stw 29, 20(1) # 4-byte Folded Spill
; CHECK32-NEXT:    mr 29, 5
; CHECK32-NEXT:    stw 30, 24(1) # 4-byte Folded Spill
; CHECK32-NEXT:    mr 30, 6
; CHECK32-NEXT:    mr 3, 7
; CHECK32-NEXT:    mr 4, 8
; CHECK32-NEXT:    li 5, 0
; CHECK32-NEXT:    li 6, 37
; CHECK32-NEXT:    bl __umoddi3
; CHECK32-NEXT:    clrlwi 6, 4, 26
; CHECK32-NEXT:    srwi 3, 30, 6
; CHECK32-NEXT:    not 4, 4
; CHECK32-NEXT:    subfic 8, 6, 32
; CHECK32-NEXT:    slwi 5, 30, 26
; CHECK32-NEXT:    rlwimi 3, 29, 26, 1, 5
; CHECK32-NEXT:    slw 7, 27, 6
; CHECK32-NEXT:    clrlwi 4, 4, 26
; CHECK32-NEXT:    srw 8, 28, 8
; CHECK32-NEXT:    srw 9, 3, 4
; CHECK32-NEXT:    srw 5, 5, 4
; CHECK32-NEXT:    or 7, 7, 8
; CHECK32-NEXT:    subfic 8, 4, 32
; CHECK32-NEXT:    addi 4, 4, -32
; CHECK32-NEXT:    slw 8, 3, 8
; CHECK32-NEXT:    srw 4, 3, 4
; CHECK32-NEXT:    addi 3, 6, -32
; CHECK32-NEXT:    slw 3, 28, 3
; CHECK32-NEXT:    or 5, 5, 8
; CHECK32-NEXT:    or 3, 7, 3
; CHECK32-NEXT:    or 4, 5, 4
; CHECK32-NEXT:    slw 5, 28, 6
; CHECK32-NEXT:    or 3, 3, 9
; CHECK32-NEXT:    or 4, 5, 4
; CHECK32-NEXT:    lwz 30, 24(1) # 4-byte Folded Reload
; CHECK32-NEXT:    lwz 29, 20(1) # 4-byte Folded Reload
; CHECK32-NEXT:    lwz 28, 16(1) # 4-byte Folded Reload
; CHECK32-NEXT:    lwz 27, 12(1) # 4-byte Folded Reload
; CHECK32-NEXT:    lwz 0, 36(1)
; CHECK32-NEXT:    addi 1, 1, 32
; CHECK32-NEXT:    mtlr 0
; CHECK32-NEXT:    blr
;
; CHECK64-LABEL: fshl_i37:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    lis 6, -8857
; CHECK64-NEXT:    sldi 4, 4, 27
; CHECK64-NEXT:    ori 6, 6, 51366
; CHECK64-NEXT:    sldi 6, 6, 32
; CHECK64-NEXT:    oris 6, 6, 3542
; CHECK64-NEXT:    ori 6, 6, 31883
; CHECK64-NEXT:    mulhdu 6, 5, 6
; CHECK64-NEXT:    rldicl 6, 6, 59, 5
; CHECK64-NEXT:    mulli 6, 6, 37
; CHECK64-NEXT:    sub 5, 5, 6
; CHECK64-NEXT:    clrlwi 5, 5, 26
; CHECK64-NEXT:    subfic 6, 5, 64
; CHECK64-NEXT:    sld 3, 3, 5
; CHECK64-NEXT:    srd 4, 4, 6
; CHECK64-NEXT:    or 3, 3, 4
; CHECK64-NEXT:    blr
  %f = call i37 @llvm.fshl.i37(i37 %x, i37 %y, i37 %z)
  ret i37 %f
}

; extract(concat(0b1110000, 0b1111111) << 2) = 0b1000011

declare i7 @llvm.fshl.i7(i7, i7, i7)
define i7 @fshl_i7_const_fold() {
; CHECK-LABEL: fshl_i7_const_fold:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li 3, 67
; CHECK-NEXT:    blr
  %f = call i7 @llvm.fshl.i7(i7 112, i7 127, i7 2)
  ret i7 %f
}

; With constant shift amount, this is rotate + insert (missing extended mnemonics).

define i32 @fshl_i32_const_shift(i32 %x, i32 %y) {
; CHECK-LABEL: fshl_i32_const_shift:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotlwi 4, 4, 9
; CHECK-NEXT:    rlwimi 4, 3, 9, 0, 22
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 9)
  ret i32 %f
}

; Check modulo math on shift amount.

define i32 @fshl_i32_const_overshift(i32 %x, i32 %y) {
; CHECK-LABEL: fshl_i32_const_overshift:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotlwi 4, 4, 9
; CHECK-NEXT:    rlwimi 4, 3, 9, 0, 22
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 41)
  ret i32 %f
}

; 64-bit should also work.

define i64 @fshl_i64_const_overshift(i64 %x, i64 %y) {
; CHECK32-LABEL: fshl_i64_const_overshift:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    rotlwi 6, 6, 9
; CHECK32-NEXT:    rotlwi 3, 5, 9
; CHECK32-NEXT:    rlwimi 6, 5, 9, 0, 22
; CHECK32-NEXT:    rlwimi 3, 4, 9, 0, 22
; CHECK32-NEXT:    mr 4, 6
; CHECK32-NEXT:    blr
;
; CHECK64-LABEL: fshl_i64_const_overshift:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    rotldi 4, 4, 41
; CHECK64-NEXT:    rldimi 4, 3, 41, 0
; CHECK64-NEXT:    mr 3, 4
; CHECK64-NEXT:    blr
  %f = call i64 @llvm.fshl.i64(i64 %x, i64 %y, i64 105)
  ret i64 %f
}

; This should work without any node-specific logic.

define i8 @fshl_i8_const_fold() {
; CHECK-LABEL: fshl_i8_const_fold:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li 3, 128
; CHECK-NEXT:    blr
  %f = call i8 @llvm.fshl.i8(i8 255, i8 0, i8 7)
  ret i8 %f
}

; Repeat everything for funnel shift right.

; General case - all operands can be variables.

define i32 @fshr_i32(i32 %x, i32 %y, i32 %z) {
; CHECK32-LABEL: fshr_i32:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    clrlwi 5, 5, 27
; CHECK32-NEXT:    srw 4, 4, 5
; CHECK32-NEXT:    subfic 5, 5, 32
; CHECK32-NEXT:    slw 3, 3, 5
; CHECK32-NEXT:    or 3, 3, 4
; CHECK32-NEXT:    blr
;
; CHECK64-LABEL: fshr_i32:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    clrlwi 5, 5, 27
; CHECK64-NEXT:    subfic 6, 5, 32
; CHECK64-NEXT:    srw 4, 4, 5
; CHECK64-NEXT:    slw 3, 3, 6
; CHECK64-NEXT:    or 3, 3, 4
; CHECK64-NEXT:    blr
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %y, i32 %z)
  ret i32 %f
}

define i64 @fshr_i64(i64 %x, i64 %y, i64 %z) {
; CHECK32-LABEL: fshr_i64:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    clrlwi 7, 8, 26
; CHECK32-NEXT:    slwi 9, 4, 1
; CHECK32-NEXT:    not 8, 8
; CHECK32-NEXT:    rotlwi 4, 4, 1
; CHECK32-NEXT:    subfic 10, 7, 32
; CHECK32-NEXT:    srw 6, 6, 7
; CHECK32-NEXT:    clrlwi 8, 8, 26
; CHECK32-NEXT:    rlwimi 4, 3, 1, 0, 30
; CHECK32-NEXT:    slw 3, 5, 10
; CHECK32-NEXT:    slw 10, 9, 8
; CHECK32-NEXT:    slw 4, 4, 8
; CHECK32-NEXT:    or 3, 6, 3
; CHECK32-NEXT:    subfic 6, 8, 32
; CHECK32-NEXT:    addi 8, 8, -32
; CHECK32-NEXT:    srw 6, 9, 6
; CHECK32-NEXT:    slw 8, 9, 8
; CHECK32-NEXT:    addi 9, 7, -32
; CHECK32-NEXT:    srw 9, 5, 9
; CHECK32-NEXT:    or 3, 3, 9
; CHECK32-NEXT:    or 6, 4, 6
; CHECK32-NEXT:    or 4, 10, 3
; CHECK32-NEXT:    or 3, 6, 8
; CHECK32-NEXT:    srw 5, 5, 7
; CHECK32-NEXT:    or 3, 3, 5
; CHECK32-NEXT:    blr
;
; CHECK64-LABEL: fshr_i64:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    clrlwi 5, 5, 26
; CHECK64-NEXT:    subfic 6, 5, 64
; CHECK64-NEXT:    srd 4, 4, 5
; CHECK64-NEXT:    sld 3, 3, 6
; CHECK64-NEXT:    or 3, 3, 4
; CHECK64-NEXT:    blr
  %f = call i64 @llvm.fshr.i64(i64 %x, i64 %y, i64 %z)
  ret i64 %f
}

; Verify that weird types are minimally supported.
declare i37 @llvm.fshr.i37(i37, i37, i37)
define i37 @fshr_i37(i37 %x, i37 %y, i37 %z) {
; CHECK32-LABEL: fshr_i37:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    mflr 0
; CHECK32-NEXT:    stw 0, 4(1)
; CHECK32-NEXT:    stwu 1, -32(1)
; CHECK32-NEXT:    .cfi_def_cfa_offset 32
; CHECK32-NEXT:    .cfi_offset lr, 4
; CHECK32-NEXT:    .cfi_offset r27, -20
; CHECK32-NEXT:    .cfi_offset r28, -16
; CHECK32-NEXT:    .cfi_offset r29, -12
; CHECK32-NEXT:    .cfi_offset r30, -8
; CHECK32-NEXT:    stw 27, 12(1) # 4-byte Folded Spill
; CHECK32-NEXT:    mr 27, 3
; CHECK32-NEXT:    stw 28, 16(1) # 4-byte Folded Spill
; CHECK32-NEXT:    mr 28, 4
; CHECK32-NEXT:    stw 29, 20(1) # 4-byte Folded Spill
; CHECK32-NEXT:    mr 29, 5
; CHECK32-NEXT:    stw 30, 24(1) # 4-byte Folded Spill
; CHECK32-NEXT:    mr 30, 6
; CHECK32-NEXT:    mr 3, 7
; CHECK32-NEXT:    mr 4, 8
; CHECK32-NEXT:    li 5, 0
; CHECK32-NEXT:    li 6, 37
; CHECK32-NEXT:    bl __umoddi3
; CHECK32-NEXT:    addi 4, 4, 27
; CHECK32-NEXT:    rotlwi 5, 30, 27
; CHECK32-NEXT:    clrlwi 8, 4, 26
; CHECK32-NEXT:    slwi 3, 30, 27
; CHECK32-NEXT:    rotlwi 7, 28, 1
; CHECK32-NEXT:    rlwimi 5, 29, 27, 0, 4
; CHECK32-NEXT:    not 4, 4
; CHECK32-NEXT:    subfic 9, 8, 32
; CHECK32-NEXT:    slwi 6, 28, 1
; CHECK32-NEXT:    rlwimi 7, 27, 1, 0, 30
; CHECK32-NEXT:    srw 3, 3, 8
; CHECK32-NEXT:    clrlwi 4, 4, 26
; CHECK32-NEXT:    slw 9, 5, 9
; CHECK32-NEXT:    slw 10, 6, 4
; CHECK32-NEXT:    slw 7, 7, 4
; CHECK32-NEXT:    or 3, 3, 9
; CHECK32-NEXT:    subfic 9, 4, 32
; CHECK32-NEXT:    addi 4, 4, -32
; CHECK32-NEXT:    srw 9, 6, 9
; CHECK32-NEXT:    slw 6, 6, 4
; CHECK32-NEXT:    addi 4, 8, -32
; CHECK32-NEXT:    srw 4, 5, 4
; CHECK32-NEXT:    or 3, 3, 4
; CHECK32-NEXT:    or 7, 7, 9
; CHECK32-NEXT:    or 4, 10, 3
; CHECK32-NEXT:    or 3, 7, 6
; CHECK32-NEXT:    srw 5, 5, 8
; CHECK32-NEXT:    or 3, 3, 5
; CHECK32-NEXT:    lwz 30, 24(1) # 4-byte Folded Reload
; CHECK32-NEXT:    lwz 29, 20(1) # 4-byte Folded Reload
; CHECK32-NEXT:    lwz 28, 16(1) # 4-byte Folded Reload
; CHECK32-NEXT:    lwz 27, 12(1) # 4-byte Folded Reload
; CHECK32-NEXT:    lwz 0, 36(1)
; CHECK32-NEXT:    addi 1, 1, 32
; CHECK32-NEXT:    mtlr 0
; CHECK32-NEXT:    blr
;
; CHECK64-LABEL: fshr_i37:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    lis 6, -8857
; CHECK64-NEXT:    sldi 4, 4, 27
; CHECK64-NEXT:    ori 6, 6, 51366
; CHECK64-NEXT:    sldi 6, 6, 32
; CHECK64-NEXT:    oris 6, 6, 3542
; CHECK64-NEXT:    ori 6, 6, 31883
; CHECK64-NEXT:    mulhdu 6, 5, 6
; CHECK64-NEXT:    rldicl 6, 6, 59, 5
; CHECK64-NEXT:    mulli 6, 6, 37
; CHECK64-NEXT:    sub 5, 5, 6
; CHECK64-NEXT:    addi 5, 5, 27
; CHECK64-NEXT:    clrlwi 5, 5, 26
; CHECK64-NEXT:    subfic 6, 5, 64
; CHECK64-NEXT:    srd 4, 4, 5
; CHECK64-NEXT:    sld 3, 3, 6
; CHECK64-NEXT:    or 3, 3, 4
; CHECK64-NEXT:    blr
  %f = call i37 @llvm.fshr.i37(i37 %x, i37 %y, i37 %z)
  ret i37 %f
}

; extract(concat(0b1110000, 0b1111111) >> 2) = 0b0011111

declare i7 @llvm.fshr.i7(i7, i7, i7)
define i7 @fshr_i7_const_fold() {
; CHECK-LABEL: fshr_i7_const_fold:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li 3, 31
; CHECK-NEXT:    blr
  %f = call i7 @llvm.fshr.i7(i7 112, i7 127, i7 2)
  ret i7 %f
}

; With constant shift amount, this is rotate + insert (missing extended mnemonics).

define i32 @fshr_i32_const_shift(i32 %x, i32 %y) {
; CHECK-LABEL: fshr_i32_const_shift:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotlwi 4, 4, 23
; CHECK-NEXT:    rlwimi 4, 3, 23, 0, 8
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %y, i32 9)
  ret i32 %f
}

; Check modulo math on shift amount. 41-32=9.

define i32 @fshr_i32_const_overshift(i32 %x, i32 %y) {
; CHECK-LABEL: fshr_i32_const_overshift:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rotlwi 4, 4, 23
; CHECK-NEXT:    rlwimi 4, 3, 23, 0, 8
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %y, i32 41)
  ret i32 %f
}

; 64-bit should also work. 105-64 = 41.

define i64 @fshr_i64_const_overshift(i64 %x, i64 %y) {
; CHECK32-LABEL: fshr_i64_const_overshift:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    rotlwi 6, 4, 23
; CHECK32-NEXT:    rotlwi 5, 5, 23
; CHECK32-NEXT:    rlwimi 6, 3, 23, 0, 8
; CHECK32-NEXT:    rlwimi 5, 4, 23, 0, 8
; CHECK32-NEXT:    mr 3, 6
; CHECK32-NEXT:    mr 4, 5
; CHECK32-NEXT:    blr
;
; CHECK64-LABEL: fshr_i64_const_overshift:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    rotldi 4, 4, 23
; CHECK64-NEXT:    rldimi 4, 3, 23, 0
; CHECK64-NEXT:    mr 3, 4
; CHECK64-NEXT:    blr
  %f = call i64 @llvm.fshr.i64(i64 %x, i64 %y, i64 105)
  ret i64 %f
}

; This should work without any node-specific logic.

define i8 @fshr_i8_const_fold() {
; CHECK-LABEL: fshr_i8_const_fold:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li 3, 254
; CHECK-NEXT:    blr
  %f = call i8 @llvm.fshr.i8(i8 255, i8 0, i8 7)
  ret i8 %f
}

define i32 @fshl_i32_shift_by_bitwidth(i32 %x, i32 %y) {
; CHECK-LABEL: fshl_i32_shift_by_bitwidth:
; CHECK:       # %bb.0:
; CHECK-NEXT:    blr
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 32)
  ret i32 %f
}

define i32 @fshr_i32_shift_by_bitwidth(i32 %x, i32 %y) {
; CHECK-LABEL: fshr_i32_shift_by_bitwidth:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mr 3, 4
; CHECK-NEXT:    blr
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %y, i32 32)
  ret i32 %f
}

define <4 x i32> @fshl_v4i32_shift_by_bitwidth(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: fshl_v4i32_shift_by_bitwidth:
; CHECK:       # %bb.0:
; CHECK-NEXT:    blr
  %f = call <4 x i32> @llvm.fshl.v4i32(<4 x i32> %x, <4 x i32> %y, <4 x i32> <i32 32, i32 32, i32 32, i32 32>)
  ret <4 x i32> %f
}

define <4 x i32> @fshr_v4i32_shift_by_bitwidth(<4 x i32> %x, <4 x i32> %y) {
; CHECK32-LABEL: fshr_v4i32_shift_by_bitwidth:
; CHECK32:       # %bb.0:
; CHECK32-NEXT:    mr 6, 10
; CHECK32-NEXT:    mr 5, 9
; CHECK32-NEXT:    mr 4, 8
; CHECK32-NEXT:    mr 3, 7
; CHECK32-NEXT:    blr
;
; CHECK64-LABEL: fshr_v4i32_shift_by_bitwidth:
; CHECK64:       # %bb.0:
; CHECK64-NEXT:    vmr 2, 3
; CHECK64-NEXT:    blr
  %f = call <4 x i32> @llvm.fshr.v4i32(<4 x i32> %x, <4 x i32> %y, <4 x i32> <i32 32, i32 32, i32 32, i32 32>)
  ret <4 x i32> %f
}

