; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl

@glob = common local_unnamed_addr global i16 0, align 2

; Function Attrs: norecurse nounwind readnone
define i64 @test_llequs(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: test_llequs:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    xor r3, r3, r4
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv3 = zext i1 %cmp to i64
  ret i64 %conv3
}

; Function Attrs: norecurse nounwind readnone
define i64 @test_llequs_sext(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: test_llequs_sext:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    xor r3, r3, r4
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

; Function Attrs: norecurse nounwind readnone
define i64 @test_llequs_z(i16 zeroext %a) {
; CHECK-LABEL: test_llequs_z:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, 0
  %conv2 = zext i1 %cmp to i64
  ret i64 %conv2
}

; Function Attrs: norecurse nounwind readnone
define i64 @test_llequs_sext_z(i16 zeroext %a) {
; CHECK-LABEL: test_llequs_sext_z:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, 0
  %conv2 = sext i1 %cmp to i64
  ret i64 %conv2
}

; Function Attrs: norecurse nounwind
define void @test_llequs_store(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: test_llequs_store:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    addis r5, r2, .LC0@toc@ha
; CHECK-NEXT:    xor r3, r3, r4
; CHECK-NEXT:    ld r12, .LC0@toc@l(r5)
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    sth r3, 0(r12)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv3 = zext i1 %cmp to i16
  store i16 %conv3, i16* @glob, align 2
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_llequs_sext_store(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: test_llequs_sext_store:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    xor r3, r3, r4
; CHECK-NEXT:    addis r5, r2, .LC0@toc@ha
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    ld r4, .LC0@toc@l(r5)
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    sth r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, %b
  %conv3 = sext i1 %cmp to i16
  store i16 %conv3, i16* @glob, align 2
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_llequs_z_store(i16 zeroext %a) {
; CHECK-LABEL: test_llequs_z_store:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    addis r4, r2, .LC0@toc@ha
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    ld r4, .LC0@toc@l(r4)
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    sth r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, 0
  %conv2 = zext i1 %cmp to i16
  store i16 %conv2, i16* @glob, align 2
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_llequs_sext_z_store(i16 zeroext %a) {
; CHECK-LABEL: test_llequs_sext_z_store:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    addis r4, r2, .LC0@toc@ha
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    ld r4, .LC0@toc@l(r4)
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    sth r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i16 %a, 0
  %conv2 = sext i1 %cmp to i16
  store i16 %conv2, i16* @glob, align 2
  ret void
}
