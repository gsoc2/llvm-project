; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -O0 -mtriple=powerpc64le-unknown-unknown | FileCheck %s

; Function Attrs: nobuiltin nounwind readonly
define i8 @popcount128(i128* nocapture nonnull readonly %0) {
; CHECK-LABEL: popcount128:
; CHECK:       # %bb.0: # %Entry
; CHECK-NEXT:    ld 4, 0(3)
; CHECK-NEXT:    ld 3, 8(3)
; CHECK-NEXT:    popcntd 3, 3
; CHECK-NEXT:    popcntd 4, 4
; CHECK-NEXT:    add 3, 4, 3
; CHECK-NEXT:    # kill: def $r3 killed $r3 killed $x3
; CHECK-NEXT:    clrldi 3, 3, 56
; CHECK-NEXT:    blr
Entry:
  %1 = load i128, i128* %0, align 16
  %2 = tail call i128 @llvm.ctpop.i128(i128 %1)
  %3 = trunc i128 %2 to i8
  ret i8 %3
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i128 @llvm.ctpop.i128(i128)

; Function Attrs: nobuiltin nounwind readonly
define i16 @popcount256(i256* nocapture nonnull readonly %0) {
; CHECK-LABEL: popcount256:
; CHECK:       # %bb.0: # %Entry
; CHECK-NEXT:    ld 4, 0(3)
; CHECK-NEXT:    ld 5, 8(3)
; CHECK-NEXT:    ld 6, 16(3)
; CHECK-NEXT:    ld 3, 24(3)
; CHECK-NEXT:    popcntd 3, 3
; CHECK-NEXT:    popcntd 6, 6
; CHECK-NEXT:    add 3, 6, 3
; CHECK-NEXT:    popcntd 5, 5
; CHECK-NEXT:    popcntd 4, 4
; CHECK-NEXT:    add 4, 4, 5
; CHECK-NEXT:    add 3, 4, 3
; CHECK-NEXT:    # kill: def $r3 killed $r3 killed $x3
; CHECK-NEXT:    clrldi 3, 3, 48
; CHECK-NEXT:    blr
Entry:
  %1 = load i256, i256* %0, align 16
  %2 = tail call i256 @llvm.ctpop.i256(i256 %1)
  %3 = trunc i256 %2 to i16
  ret i16 %3
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i256 @llvm.ctpop.i256(i256)

define <1 x i128> @popcount1x128(<1 x i128> %0) {
; CHECK-LABEL: popcount1x128:
; CHECK:       # %bb.0: # %Entry
; CHECK-NEXT:    xxlor 0, 34, 34
; CHECK-NEXT:    # kill: def $f0 killed $f0 killed $vsl0
; CHECK-NEXT:    mffprd 3, 0
; CHECK-NEXT:    popcntd 3, 3
; CHECK-NEXT:    xxswapd 0, 34
; CHECK-NEXT:    # kill: def $f0 killed $f0 killed $vsl0
; CHECK-NEXT:    mffprd 4, 0
; CHECK-NEXT:    popcntd 4, 4
; CHECK-NEXT:    add 3, 4, 3
; CHECK-NEXT:    mtfprd 0, 3
; CHECK-NEXT:    # kill: def $vsl0 killed $f0
; CHECK-NEXT:    li 3, 0
; CHECK-NEXT:    mtfprd 1, 3
; CHECK-NEXT:    # kill: def $vsl1 killed $f1
; CHECK-NEXT:    xxmrghd 34, 1, 0
; CHECK-NEXT:    blr
Entry:
  %1 = tail call <1 x i128> @llvm.ctpop.v1.i128(<1 x i128> %0)
  ret <1 x i128> %1
}

declare <1 x i128> @llvm.ctpop.v1.i128(<1 x i128>)
