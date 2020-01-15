; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O3 -mtriple=powerpc64le-unknown-unknown -ppc-asm-full-reg-names \
; RUN:   -verify-machineinstrs -mcpu=pwr7 < %s | FileCheck %s
define dso_local <16 x i8 > @vectorsaddb(<16 x i8 > %a, <16 x i8 > %b) {
; CHECK-LABEL: vectorsaddb:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vaddsbs v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <16 x i8> @llvm.sadd.sat.v16i8(<16 x i8> %a, <16 x i8> %b)
  ret <16 x i8> %call
}

define dso_local <16 x i8 > @vectorssubb(<16 x i8 > %a, <16 x i8 > %b) {
; CHECK-LABEL: vectorssubb:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsubsbs v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <16 x i8> @llvm.ssub.sat.v16i8(<16 x i8> %a, <16 x i8> %b)
  ret <16 x i8> %call
}

define dso_local <16 x i8 > @vectoruaddb(<16 x i8 > %a, <16 x i8 > %b) {
; CHECK-LABEL: vectoruaddb:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vaddubs v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <16 x i8> @llvm.uadd.sat.v16i8(<16 x i8> %a, <16 x i8> %b)
  ret <16 x i8> %call
}

define dso_local <16 x i8 > @vectorusubb(<16 x i8 > %a, <16 x i8 > %b) {
; CHECK-LABEL: vectorusubb:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsububs v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <16 x i8> @llvm.usub.sat.v16i8(<16 x i8> %a, <16 x i8> %b)
  ret <16 x i8> %call
}

define dso_local <8 x i16 > @vectorsaddh(<8 x i16 > %a, <8 x i16 > %b) {
; CHECK-LABEL: vectorsaddh:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vaddshs v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <8 x i16> @llvm.sadd.sat.v8i16(<8 x i16> %a, <8 x i16> %b)
  ret <8 x i16> %call
}

define dso_local <8 x i16 > @vectorssubh(<8 x i16 > %a, <8 x i16 > %b) {
; CHECK-LABEL: vectorssubh:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsubshs v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <8 x i16> @llvm.ssub.sat.v8i16(<8 x i16> %a, <8 x i16> %b)
  ret <8 x i16> %call
}

define dso_local <8 x i16 > @vectoruaddh(<8 x i16 > %a, <8 x i16 > %b) {
; CHECK-LABEL: vectoruaddh:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vadduhs v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <8 x i16> @llvm.uadd.sat.v8i16(<8 x i16> %a, <8 x i16> %b)
  ret <8 x i16> %call
}

define dso_local <8 x i16 > @vectorusubh(<8 x i16 > %a, <8 x i16 > %b) {
; CHECK-LABEL: vectorusubh:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsubuhs v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <8 x i16> @llvm.usub.sat.v8i16(<8 x i16> %a, <8 x i16> %b)
  ret <8 x i16> %call
}

define dso_local <4 x i32 > @vectorsaddw(<4 x i32 > %a, <4 x i32 > %b) {
; CHECK-LABEL: vectorsaddw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vaddsws v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <4 x i32> @llvm.sadd.sat.v4i32(<4 x i32> %a, <4 x i32> %b)
  ret <4 x i32> %call
}

define dso_local <4 x i32 > @vectorssubw(<4 x i32 > %a, <4 x i32 > %b) {
; CHECK-LABEL: vectorssubw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsubsws v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> %a, <4 x i32> %b)
  ret <4 x i32> %call
}

define dso_local <4 x i32 > @vectoruaddw(<4 x i32 > %a, <4 x i32 > %b) {
; CHECK-LABEL: vectoruaddw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vadduws v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <4 x i32> @llvm.uadd.sat.v4i32(<4 x i32> %a, <4 x i32> %b)
  ret <4 x i32> %call
}

define dso_local <4 x i32 > @vectorusubw(<4 x i32 > %a, <4 x i32 > %b) {
; CHECK-LABEL: vectorusubw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsubuws v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %call = call <4 x i32> @llvm.usub.sat.v4i32(<4 x i32> %a, <4 x i32> %b)
  ret <4 x i32> %call
}

declare <16 x i8> @llvm.sadd.sat.v16i8(<16 x i8>, <16 x i8>)
declare <16 x i8> @llvm.ssub.sat.v16i8(<16 x i8>, <16 x i8>)
declare <16 x i8> @llvm.uadd.sat.v16i8(<16 x i8>, <16 x i8>)
declare <16 x i8> @llvm.usub.sat.v16i8(<16 x i8>, <16 x i8>)
declare <8 x i16> @llvm.sadd.sat.v8i16(<8 x i16>, <8 x i16>)
declare <8 x i16> @llvm.ssub.sat.v8i16(<8 x i16>, <8 x i16>)
declare <8 x i16> @llvm.uadd.sat.v8i16(<8 x i16>, <8 x i16>)
declare <8 x i16> @llvm.usub.sat.v8i16(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.sadd.sat.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.uadd.sat.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.usub.sat.v4i32(<4 x i32>, <4 x i32>)
