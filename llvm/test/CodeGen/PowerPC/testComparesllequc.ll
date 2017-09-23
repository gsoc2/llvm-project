; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl

@glob = common local_unnamed_addr global i8 0, align 1

; Function Attrs: norecurse nounwind readnone
define i64 @test_llequc(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: test_llequc:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    xor r3, r3, r4
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv3 = zext i1 %cmp to i64
  ret i64 %conv3
}

; Function Attrs: norecurse nounwind readnone
define i64 @test_llequc_sext(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: test_llequc_sext:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    xor r3, r3, r4
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv3 = sext i1 %cmp to i64
  ret i64 %conv3
}

; Function Attrs: norecurse nounwind readnone
define i64 @test_llequc_z(i8 zeroext %a) {
; CHECK-LABEL: test_llequc_z:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, 0
  %conv2 = zext i1 %cmp to i64
  ret i64 %conv2
}

; Function Attrs: norecurse nounwind readnone
define i64 @test_llequc_sext_z(i8 zeroext %a) {
; CHECK-LABEL: test_llequc_sext_z:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, 0
  %conv2 = sext i1 %cmp to i64
  ret i64 %conv2
}

; Function Attrs: norecurse nounwind
define void @test_llequc_store(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: test_llequc_store:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    addis r5, r2, .LC0@toc@ha
; CHECK-NEXT:    xor r3, r3, r4
; CHECK-NEXT:    ld r12, .LC0@toc@l(r5)
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    stb r3, 0(r12)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv3 = zext i1 %cmp to i8
  store i8 %conv3, i8* @glob, align 1
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_llequc_sext_store(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: test_llequc_sext_store:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    xor r3, r3, r4
; CHECK-NEXT:    addis r5, r2, .LC0@toc@ha
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    ld r4, .LC0@toc@l(r5)
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    stb r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, %b
  %conv3 = sext i1 %cmp to i8
  store i8 %conv3, i8* @glob, align 1
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_llequc_z_store(i8 zeroext %a) {
; CHECK-LABEL: test_llequc_z_store:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    addis r4, r2, .LC0@toc@ha
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    ld r4, .LC0@toc@l(r4)
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    stb r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, 0
  %conv2 = zext i1 %cmp to i8
  store i8 %conv2, i8* @glob, align 1
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_llequc_sext_z_store(i8 zeroext %a) {
; CHECK-LABEL: test_llequc_sext_z_store:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    addis r4, r2, .LC0@toc@ha
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    ld r4, .LC0@toc@l(r4)
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    stb r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i8 %a, 0
  %conv2 = sext i1 %cmp to i8
  store i8 %conv2, i8* @glob, align 1
  ret void
}
