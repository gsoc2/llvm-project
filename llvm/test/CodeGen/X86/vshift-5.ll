; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown -mattr=+sse2 | FileCheck %s --check-prefix=CHECK --check-prefix=X32
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse2 | FileCheck %s --check-prefix=CHECK --check-prefix=X64

; When loading the shift amount from memory, avoid generating the splat.

define void @shift5a(<4 x i32> %val, <4 x i32>* %dst, i32* %pamt) nounwind {
; X32-LABEL: shift5a:
; X32:       # %bb.0: # %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; X32-NEXT:    pslld %xmm1, %xmm0
; X32-NEXT:    movdqa %xmm0, (%eax)
; X32-NEXT:    retl
;
; X64-LABEL: shift5a:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; X64-NEXT:    pslld %xmm1, %xmm0
; X64-NEXT:    movdqa %xmm0, (%rdi)
; X64-NEXT:    retq
entry:
  %amt = load i32, i32* %pamt
  %tmp0 = insertelement <4 x i32> undef, i32 %amt, i32 0
  %shamt = shufflevector <4 x i32> %tmp0, <4 x i32> undef, <4 x i32> zeroinitializer
  %shl = shl <4 x i32> %val, %shamt
  store <4 x i32> %shl, <4 x i32>* %dst
  ret void
}


define void @shift5b(<4 x i32> %val, <4 x i32>* %dst, i32* %pamt) nounwind {
; X32-LABEL: shift5b:
; X32:       # %bb.0: # %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; X32-NEXT:    psrad %xmm1, %xmm0
; X32-NEXT:    movdqa %xmm0, (%eax)
; X32-NEXT:    retl
;
; X64-LABEL: shift5b:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; X64-NEXT:    psrad %xmm1, %xmm0
; X64-NEXT:    movdqa %xmm0, (%rdi)
; X64-NEXT:    retq
entry:
  %amt = load i32, i32* %pamt
  %tmp0 = insertelement <4 x i32> undef, i32 %amt, i32 0
  %shamt = shufflevector <4 x i32> %tmp0, <4 x i32> undef, <4 x i32> zeroinitializer
  %shr = ashr <4 x i32> %val, %shamt
  store <4 x i32> %shr, <4 x i32>* %dst
  ret void
}


define void @shift5c(<4 x i32> %val, <4 x i32>* %dst, i32 %amt) nounwind {
; X32-LABEL: shift5c:
; X32:       # %bb.0: # %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; X32-NEXT:    pslld %xmm1, %xmm0
; X32-NEXT:    movdqa %xmm0, (%eax)
; X32-NEXT:    retl
;
; X64-LABEL: shift5c:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movd %esi, %xmm1
; X64-NEXT:    pslld %xmm1, %xmm0
; X64-NEXT:    movdqa %xmm0, (%rdi)
; X64-NEXT:    retq
entry:
  %tmp0 = insertelement <4 x i32> undef, i32 %amt, i32 0
  %shamt = shufflevector <4 x i32> %tmp0, <4 x i32> undef, <4 x i32> zeroinitializer
  %shl = shl <4 x i32> %val, %shamt
  store <4 x i32> %shl, <4 x i32>* %dst
  ret void
}


define void @shift5d(<4 x i32> %val, <4 x i32>* %dst, i32 %amt) nounwind {
; X32-LABEL: shift5d:
; X32:       # %bb.0: # %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; X32-NEXT:    psrad %xmm1, %xmm0
; X32-NEXT:    movdqa %xmm0, (%eax)
; X32-NEXT:    retl
;
; X64-LABEL: shift5d:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movd %esi, %xmm1
; X64-NEXT:    psrad %xmm1, %xmm0
; X64-NEXT:    movdqa %xmm0, (%rdi)
; X64-NEXT:    retq
entry:
  %tmp0 = insertelement <4 x i32> undef, i32 %amt, i32 0
  %shamt = shufflevector <4 x i32> %tmp0, <4 x i32> undef, <4 x i32> zeroinitializer
  %shr = ashr <4 x i32> %val, %shamt
  store <4 x i32> %shr, <4 x i32>* %dst
  ret void
}
