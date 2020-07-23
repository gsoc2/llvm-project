; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux | FileCheck %s --check-prefixes=X64,SSE
; RUN: llc < %s -mtriple=x86_64-linux -mattr=avx | FileCheck %s --check-prefixes=X64,AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-linux -mattr=avx2 | FileCheck %s --check-prefixes=X64,AVX,AVX2
; RUN: llc < %s -mtriple=i686 -mattr=cmov | FileCheck %s --check-prefix=X86

declare i8 @llvm.umin.i8(i8, i8)
declare i16 @llvm.umin.i16(i16, i16)
declare i24 @llvm.umin.i24(i24, i24)
declare i32 @llvm.umin.i32(i32, i32)
declare i64 @llvm.umin.i64(i64, i64)
declare i128 @llvm.umin.i128(i128, i128)

declare <1 x i32> @llvm.umin.v1i32(<1 x i32>, <1 x i32>)
declare <2 x i32> @llvm.umin.v2i32(<2 x i32>, <2 x i32>)
declare <3 x i32> @llvm.umin.v3i32(<3 x i32>, <3 x i32>)
declare <4 x i32> @llvm.umin.v4i32(<4 x i32>, <4 x i32>)
declare <8 x i32> @llvm.umin.v8i32(<8 x i32>, <8 x i32>)

declare <8 x i16> @llvm.umin.v8i16(<8 x i16>, <8 x i16>)
declare <16 x i8> @llvm.umin.v16i8(<16 x i8>, <16 x i8>)

define i8 @test_i8(i8 %a, i8 %b) nounwind {
; X64-LABEL: test_i8:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    cmpb %al, %dil
; X64-NEXT:    cmovbl %edi, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: test_i8:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    cmpb %al, %cl
; X86-NEXT:    cmovbl %ecx, %eax
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
  %r = call i8 @llvm.umin.i8(i8 %a, i8 %b)
  ret i8 %r
}

define i16 @test_i16(i16 %a, i16 %b) nounwind {
; X64-LABEL: test_i16:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    cmpw %ax, %di
; X64-NEXT:    cmovbl %edi, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: test_i16:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    cmpw %ax, %cx
; X86-NEXT:    cmovbl %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
  %r = call i16 @llvm.umin.i16(i16 %a, i16 %b)
  ret i16 %r
}

define i24 @test_i24(i24 %a, i24 %b) nounwind {
; X64-LABEL: test_i24:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $16777215, %esi # imm = 0xFFFFFF
; X64-NEXT:    andl $16777215, %eax # imm = 0xFFFFFF
; X64-NEXT:    cmpl %esi, %eax
; X64-NEXT:    cmovael %esi, %eax
; X64-NEXT:    retq
;
; X86-LABEL: test_i24:
; X86:       # %bb.0:
; X86-NEXT:    movl $16777215, %eax # imm = 0xFFFFFF
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    andl %eax, %ecx
; X86-NEXT:    andl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    cmovael %ecx, %eax
; X86-NEXT:    retl
  %r = call i24 @llvm.umin.i24(i24 %a, i24 %b)
  ret i24 %r
}

define i32 @test_i32(i32 %a, i32 %b) nounwind {
; X64-LABEL: test_i32:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    cmpl %esi, %edi
; X64-NEXT:    cmovbl %edi, %eax
; X64-NEXT:    retq
;
; X86-LABEL: test_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    cmpl %eax, %ecx
; X86-NEXT:    cmovbl %ecx, %eax
; X86-NEXT:    retl
  %r = call i32 @llvm.umin.i32(i32 %a, i32 %b)
  ret i32 %r
}

define i64 @test_i64(i64 %a, i64 %b) nounwind {
; X64-LABEL: test_i64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rsi, %rax
; X64-NEXT:    cmpq %rsi, %rdi
; X64-NEXT:    cmovbq %rdi, %rax
; X64-NEXT:    retq
;
; X86-LABEL: test_i64:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    cmpl %eax, %ecx
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    cmovbl %ecx, %edi
; X86-NEXT:    cmpl %edx, %esi
; X86-NEXT:    cmovbl %ecx, %eax
; X86-NEXT:    cmovel %edi, %eax
; X86-NEXT:    cmovbl %esi, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    retl
  %r = call i64 @llvm.umin.i64(i64 %a, i64 %b)
  ret i64 %r
}

define i128 @test_i128(i128 %a, i128 %b) nounwind {
; X64-LABEL: test_i128:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdx, %rax
; X64-NEXT:    cmpq %rdx, %rdi
; X64-NEXT:    cmovbq %rdi, %rdx
; X64-NEXT:    cmpq %rcx, %rsi
; X64-NEXT:    cmovbq %rdi, %rax
; X64-NEXT:    cmoveq %rdx, %rax
; X64-NEXT:    cmovbq %rsi, %rcx
; X64-NEXT:    movq %rcx, %rdx
; X64-NEXT:    retq
;
; X86-LABEL: test_i128:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    subl $8, %esp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    movl %ecx, %ebx
; X86-NEXT:    cmovbl %eax, %ebx
; X86-NEXT:    cmpl %esi, %edi
; X86-NEXT:    movl %ecx, %ebp
; X86-NEXT:    cmovbl %eax, %ebp
; X86-NEXT:    cmovel %ebx, %ebp
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    cmovbl %edi, %eax
; X86-NEXT:    movl %eax, (%esp) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    cmpl %edx, %edi
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    cmovbl %edi, %eax
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    movl %ebx, %edi
; X86-NEXT:    sbbl %eax, %edi
; X86-NEXT:    cmovbl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    cmovbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ebx, %edi
; X86-NEXT:    xorl %eax, %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    xorl %edx, %ebx
; X86-NEXT:    orl %edi, %ebx
; X86-NEXT:    cmovel %ebp, %ecx
; X86-NEXT:    cmovel (%esp), %esi # 4-byte Folded Reload
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    cmpl %eax, %edi
; X86-NEXT:    cmovbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    cmovel {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Folded Reload
; X86-NEXT:    cmovbl %edi, %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl %eax, 12(%edi)
; X86-NEXT:    movl %edx, 8(%edi)
; X86-NEXT:    movl %esi, 4(%edi)
; X86-NEXT:    movl %ecx, (%edi)
; X86-NEXT:    movl %edi, %eax
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl $4
  %r = call i128 @llvm.umin.i128(i128 %a, i128 %b)
  ret i128 %r
}

define <1 x i32> @test_v1i32(<1 x i32> %a, <1 x i32> %b) nounwind {
; X64-LABEL: test_v1i32:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    cmpl %esi, %edi
; X64-NEXT:    cmovbl %edi, %eax
; X64-NEXT:    retq
;
; X86-LABEL: test_v1i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    cmpl %eax, %ecx
; X86-NEXT:    cmovbl %ecx, %eax
; X86-NEXT:    retl
  %r = call <1 x i32> @llvm.umin.v1i32(<1 x i32> %a, <1 x i32> %b)
  ret <1 x i32> %r
}

define <2 x i32> @test_v2i32(<2 x i32> %a, <2 x i32> %b) nounwind {
; SSE-LABEL: test_v2i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE-NEXT:    movdqa %xmm0, %xmm3
; SSE-NEXT:    pxor %xmm2, %xmm3
; SSE-NEXT:    pxor %xmm1, %xmm2
; SSE-NEXT:    pcmpgtd %xmm3, %xmm2
; SSE-NEXT:    pand %xmm2, %xmm0
; SSE-NEXT:    pandn %xmm1, %xmm2
; SSE-NEXT:    por %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminud %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; X86-LABEL: test_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    cmpl %eax, %esi
; X86-NEXT:    cmovbl %esi, %eax
; X86-NEXT:    cmpl %edx, %ecx
; X86-NEXT:    cmovbl %ecx, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %r = call <2 x i32> @llvm.umin.v2i32(<2 x i32> %a, <2 x i32> %b)
  ret <2 x i32> %r
}

define <3 x i32> @test_v3i32(<3 x i32> %a, <3 x i32> %b) nounwind {
; SSE-LABEL: test_v3i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE-NEXT:    movdqa %xmm0, %xmm3
; SSE-NEXT:    pxor %xmm2, %xmm3
; SSE-NEXT:    pxor %xmm1, %xmm2
; SSE-NEXT:    pcmpgtd %xmm3, %xmm2
; SSE-NEXT:    pand %xmm2, %xmm0
; SSE-NEXT:    pandn %xmm1, %xmm2
; SSE-NEXT:    por %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v3i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminud %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; X86-LABEL: test_v3i32:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    cmpl %eax, %ebx
; X86-NEXT:    cmovbl %ebx, %eax
; X86-NEXT:    cmpl %edx, %edi
; X86-NEXT:    cmovbl %edi, %edx
; X86-NEXT:    cmpl %ecx, %esi
; X86-NEXT:    cmovbl %esi, %ecx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
  %r = call <3 x i32> @llvm.umin.v3i32(<3 x i32> %a, <3 x i32> %b)
  ret <3 x i32> %r
}

define <4 x i32> @test_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE-LABEL: test_v4i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648,2147483648,2147483648]
; SSE-NEXT:    movdqa %xmm0, %xmm3
; SSE-NEXT:    pxor %xmm2, %xmm3
; SSE-NEXT:    pxor %xmm1, %xmm2
; SSE-NEXT:    pcmpgtd %xmm3, %xmm2
; SSE-NEXT:    pand %xmm2, %xmm0
; SSE-NEXT:    pandn %xmm1, %xmm2
; SSE-NEXT:    por %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminud %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; X86-LABEL: test_v4i32:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %edi, %eax
; X86-NEXT:    cmovbl %eax, %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %esi, %eax
; X86-NEXT:    cmovbl %eax, %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %edx, %eax
; X86-NEXT:    cmovbl %eax, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %ecx, 12(%eax)
; X86-NEXT:    movl %edx, 8(%eax)
; X86-NEXT:    movl %esi, 4(%eax)
; X86-NEXT:    movl %edi, (%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    retl $4
  %r = call <4 x i32> @llvm.umin.v4i32(<4 x i32> %a, <4 x i32> %b)
  ret <4 x i32> %r
}

define <8 x i32> @test_v8i32(<8 x i32> %a, <8 x i32> %b) nounwind {
; SSE-LABEL: test_v8i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa {{.*#+}} xmm4 = [2147483648,2147483648,2147483648,2147483648]
; SSE-NEXT:    movdqa %xmm0, %xmm5
; SSE-NEXT:    pxor %xmm4, %xmm5
; SSE-NEXT:    movdqa %xmm2, %xmm6
; SSE-NEXT:    pxor %xmm4, %xmm6
; SSE-NEXT:    pcmpgtd %xmm5, %xmm6
; SSE-NEXT:    pand %xmm6, %xmm0
; SSE-NEXT:    pandn %xmm2, %xmm6
; SSE-NEXT:    por %xmm6, %xmm0
; SSE-NEXT:    movdqa %xmm1, %xmm2
; SSE-NEXT:    pxor %xmm4, %xmm2
; SSE-NEXT:    pxor %xmm3, %xmm4
; SSE-NEXT:    pcmpgtd %xmm2, %xmm4
; SSE-NEXT:    pand %xmm4, %xmm1
; SSE-NEXT:    pandn %xmm3, %xmm4
; SSE-NEXT:    por %xmm4, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: test_v8i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm3
; AVX1-NEXT:    vpminud %xmm2, %xmm3, %xmm2
; AVX1-NEXT:    vpminud %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_v8i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpminud %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; X86-LABEL: test_v8i32:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    subl $8, %esp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %ebp, %eax
; X86-NEXT:    cmovbl %eax, %ebp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %ebx, %eax
; X86-NEXT:    cmovbl %eax, %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %edi, %eax
; X86-NEXT:    cmovbl %eax, %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %esi, %eax
; X86-NEXT:    cmovbl %eax, %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %edx, %eax
; X86-NEXT:    cmovbl %eax, %edx
; X86-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, (%esp) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    cmpl %eax, %edx
; X86-NEXT:    cmovbl %edx, %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %eax, 28(%edx)
; X86-NEXT:    movl %ecx, 24(%edx)
; X86-NEXT:    movl (%esp), %eax # 4-byte Reload
; X86-NEXT:    movl %eax, 20(%edx)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X86-NEXT:    movl %eax, 16(%edx)
; X86-NEXT:    movl %esi, 12(%edx)
; X86-NEXT:    movl %edi, 8(%edx)
; X86-NEXT:    movl %ebx, 4(%edx)
; X86-NEXT:    movl %ebp, (%edx)
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl $4
  %r = call <8 x i32> @llvm.umin.v8i32(<8 x i32> %a, <8 x i32> %b)
  ret <8 x i32> %r
}

define <8 x i16> @test_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: test_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [32768,32768,32768,32768,32768,32768,32768,32768]
; SSE-NEXT:    pxor %xmm2, %xmm1
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    pminsw %xmm1, %xmm0
; SSE-NEXT:    pxor %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminuw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; X86-LABEL: test_v8i16:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    subl $8, %esp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpw %bp, %ax
; X86-NEXT:    cmovbl %eax, %ebp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpw %bx, %ax
; X86-NEXT:    cmovbl %eax, %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpw %di, %ax
; X86-NEXT:    cmovbl %eax, %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpw %si, %ax
; X86-NEXT:    cmovbl %eax, %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpw %dx, %ax
; X86-NEXT:    cmovbl %eax, %edx
; X86-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpw %cx, %ax
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, (%esp) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpw %dx, %ax
; X86-NEXT:    cmovbl %eax, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    cmpw %ax, %cx
; X86-NEXT:    cmovbl %ecx, %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movw %ax, 14(%ecx)
; X86-NEXT:    movw %dx, 12(%ecx)
; X86-NEXT:    movl (%esp), %eax # 4-byte Reload
; X86-NEXT:    movw %ax, 10(%ecx)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X86-NEXT:    movw %ax, 8(%ecx)
; X86-NEXT:    movw %si, 6(%ecx)
; X86-NEXT:    movw %di, 4(%ecx)
; X86-NEXT:    movw %bx, 2(%ecx)
; X86-NEXT:    movw %bp, (%ecx)
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl $4
  %r = call <8 x i16> @llvm.umin.v8i16(<8 x i16> %a, <8 x i16> %b)
  ret <8 x i16> %r
}

define <16 x i8> @test_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE-LABEL: test_v16i8:
; SSE:       # %bb.0:
; SSE-NEXT:    pminub %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminub %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; X86-LABEL: test_v16i8:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    subl $40, %esp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %bl, %al
; X86-NEXT:    cmovbl %eax, %ebx
; X86-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %dl, %al
; X86-NEXT:    cmovbl %eax, %edx
; X86-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, (%esp) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, %ebp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %bl, %al
; X86-NEXT:    cmovbl %eax, %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %dl, %al
; X86-NEXT:    cmovbl %eax, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpb %cl, %al
; X86-NEXT:    cmovbl %eax, %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movb %cl, 15(%eax)
; X86-NEXT:    movb %dl, 14(%eax)
; X86-NEXT:    movb %bl, 13(%eax)
; X86-NEXT:    movl %esi, %ecx
; X86-NEXT:    movb %cl, 12(%eax)
; X86-NEXT:    movl %edi, %ecx
; X86-NEXT:    movb %cl, 11(%eax)
; X86-NEXT:    movl %ebp, %ecx
; X86-NEXT:    movb %cl, 10(%eax)
; X86-NEXT:    movl (%esp), %ecx # 4-byte Reload
; X86-NEXT:    movb %cl, 9(%eax)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    movb %cl, 8(%eax)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    movb %cl, 7(%eax)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    movb %cl, 6(%eax)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    movb %cl, 5(%eax)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    movb %cl, 4(%eax)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    movb %cl, 3(%eax)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    movb %cl, 2(%eax)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    movb %cl, 1(%eax)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    movb %cl, (%eax)
; X86-NEXT:    addl $40, %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl $4
  %r = call <16 x i8> @llvm.umin.v16i8(<16 x i8> %a, <16 x i8> %b)
  ret <16 x i8> %r
}
