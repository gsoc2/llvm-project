; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=powerpc64le-linux-gnu < %s | FileCheck %s -check-prefix=PPC64LE

define void @test(i8* %ptr, i8 %cmp, i8 %val) {
; PPC64LE-LABEL: test:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    rlwinm 4, 4, 0, 24, 31
; PPC64LE-NEXT:  .LBB0_1: #
; PPC64LE-NEXT:    lbarx 6, 0, 3
; PPC64LE-NEXT:    cmpw 4, 6
; PPC64LE-NEXT:    bne 0, .LBB0_3
; PPC64LE-NEXT:  # %bb.2: #
; PPC64LE-NEXT:    stbcx. 5, 0, 3
; PPC64LE-NEXT:    beqlr 0
; PPC64LE-NEXT:    b .LBB0_1
; PPC64LE-NEXT:  .LBB0_3:
; PPC64LE-NEXT:    stbcx. 6, 0, 3
; PPC64LE-NEXT:    blr
  %res = cmpxchg i8* %ptr, i8 %cmp, i8 %val monotonic monotonic
  ret void
}
