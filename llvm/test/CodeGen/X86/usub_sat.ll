; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686 -mattr=cmov | FileCheck %s --check-prefixes=CHECK,X86
; RUN: llc < %s -mtriple=x86_64-linux | FileCheck %s --check-prefixes=CHECK,X64

declare  i4  @llvm.usub.sat.i4   (i4,  i4)
declare  i32 @llvm.usub.sat.i32  (i32, i32)
declare  i64 @llvm.usub.sat.i64  (i64, i64)
declare  <4 x i32> @llvm.usub.sat.v4i32(<4 x i32>, <4 x i32>)

define i32 @func(i32 %x, i32 %y) nounwind {
; X86-LABEL: func:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmovbl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: func:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    subl %esi, %edi
; X64-NEXT:    cmovael %edi, %eax
; X64-NEXT:    retq
  %tmp = call i32 @llvm.usub.sat.i32(i32 %x, i32 %y);
  ret i32 %tmp;
}

define i64 @func2(i64 %x, i64 %y) nounwind {
; X86-LABEL: func2:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    cmovbl %ecx, %edx
; X86-NEXT:    cmovbl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: func2:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    subq %rsi, %rdi
; X64-NEXT:    cmovaeq %rdi, %rax
; X64-NEXT:    retq
  %tmp = call i64 @llvm.usub.sat.i64(i64 %x, i64 %y);
  ret i64 %tmp;
}

define i4 @func3(i4 %x, i4 %y) nounwind {
; X86-LABEL: func3:
; X86:       # %bb.0:
; X86-NEXT:    movb {{[0-9]+}}(%esp), %al
; X86-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X86-NEXT:    shlb $4, %cl
; X86-NEXT:    shlb $4, %al
; X86-NEXT:    subb %cl, %al
; X86-NEXT:    jae .LBB2_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:  .LBB2_2:
; X86-NEXT:    shrb $4, %al
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: func3:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shlb $4, %sil
; X64-NEXT:    shlb $4, %al
; X64-NEXT:    subb %sil, %al
; X64-NEXT:    jae .LBB2_2
; X64-NEXT:  # %bb.1:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:  .LBB2_2:
; X64-NEXT:    shrb $4, %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %tmp = call i4 @llvm.usub.sat.i4(i4 %x, i4 %y);
  ret i4 %tmp;
}

define <4 x i32> @vec(<4 x i32> %x, <4 x i32> %y) nounwind {
; X86-LABEL: vec:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    xorl %ebx, %ebx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    cmovbl %ebx, %edi
; X86-NEXT:    subl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    cmovbl %ebx, %esi
; X86-NEXT:    subl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    cmovbl %ebx, %edx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    cmovbl %ebx, %ecx
; X86-NEXT:    movl %ecx, 12(%eax)
; X86-NEXT:    movl %edx, 8(%eax)
; X86-NEXT:    movl %esi, 4(%eax)
; X86-NEXT:    movl %edi, (%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl $4
;
; X64-LABEL: vec:
; X64:       # %bb.0:
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[3,1,2,3]
; X64-NEXT:    movd %xmm2, %eax
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[3,1,2,3]
; X64-NEXT:    movd %xmm2, %ecx
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    cmovbl %edx, %ecx
; X64-NEXT:    movd %ecx, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm1[2,3,0,1]
; X64-NEXT:    movd %xmm3, %eax
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[2,3,0,1]
; X64-NEXT:    movd %xmm3, %ecx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    cmovbl %edx, %ecx
; X64-NEXT:    movd %ecx, %xmm3
; X64-NEXT:    punpckldq {{.*#+}} xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
; X64-NEXT:    movd %xmm1, %eax
; X64-NEXT:    movd %xmm0, %ecx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    cmovbl %edx, %ecx
; X64-NEXT:    movd %ecx, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,2,3]
; X64-NEXT:    movd %xmm1, %eax
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; X64-NEXT:    movd %xmm0, %ecx
; X64-NEXT:    subl %eax, %ecx
; X64-NEXT:    cmovbl %edx, %ecx
; X64-NEXT:    movd %ecx, %xmm0
; X64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; X64-NEXT:    punpcklqdq {{.*#+}} xmm2 = xmm2[0],xmm3[0]
; X64-NEXT:    movdqa %xmm2, %xmm0
; X64-NEXT:    retq
  %tmp = call <4 x i32> @llvm.usub.sat.v4i32(<4 x i32> %x, <4 x i32> %y);
  ret <4 x i32> %tmp;
}
