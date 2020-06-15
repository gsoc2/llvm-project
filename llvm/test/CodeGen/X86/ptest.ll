; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2,-avx | FileCheck %s --check-prefixes=SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1,-avx | FileCheck %s --check-prefixes=SSE,SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx,-avx2   | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,+avx512dq,+avx512bw | FileCheck %s --check-prefixes=AVX,AVX512

define i32 @veccond128(<4 x i32> %input) {
; SSE2-LABEL: veccond128:
; SSE2:       # %bb.0: # %entry
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    pcmpeqb %xmm0, %xmm1
; SSE2-NEXT:    pmovmskb %xmm1, %eax
; SSE2-NEXT:    cmpl $65535, %eax # imm = 0xFFFF
; SSE2-NEXT:    je .LBB0_2
; SSE2-NEXT:  # %bb.1: # %if-true-block
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    retq
; SSE2-NEXT:  .LBB0_2: # %endif-block
; SSE2-NEXT:    movl $1, %eax
; SSE2-NEXT:    retq
;
; SSE41-LABEL: veccond128:
; SSE41:       # %bb.0: # %entry
; SSE41-NEXT:    ptest %xmm0, %xmm0
; SSE41-NEXT:    je .LBB0_2
; SSE41-NEXT:  # %bb.1: # %if-true-block
; SSE41-NEXT:    xorl %eax, %eax
; SSE41-NEXT:    retq
; SSE41-NEXT:  .LBB0_2: # %endif-block
; SSE41-NEXT:    movl $1, %eax
; SSE41-NEXT:    retq
;
; AVX-LABEL: veccond128:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vptest %xmm0, %xmm0
; AVX-NEXT:    je .LBB0_2
; AVX-NEXT:  # %bb.1: # %if-true-block
; AVX-NEXT:    xorl %eax, %eax
; AVX-NEXT:    retq
; AVX-NEXT:  .LBB0_2: # %endif-block
; AVX-NEXT:    movl $1, %eax
; AVX-NEXT:    retq
entry:
  %0 = bitcast <4 x i32> %input to i128
  %1 = icmp ne i128 %0, 0
  br i1 %1, label %if-true-block, label %endif-block
if-true-block:
  ret i32 0
endif-block:
  ret i32 1
}

define i32 @veccond256(<8 x i32> %input) {
; SSE2-LABEL: veccond256:
; SSE2:       # %bb.0: # %entry
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    pcmpeqb %xmm0, %xmm1
; SSE2-NEXT:    pmovmskb %xmm1, %eax
; SSE2-NEXT:    cmpl $65535, %eax # imm = 0xFFFF
; SSE2-NEXT:    je .LBB1_2
; SSE2-NEXT:  # %bb.1: # %if-true-block
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    retq
; SSE2-NEXT:  .LBB1_2: # %endif-block
; SSE2-NEXT:    movl $1, %eax
; SSE2-NEXT:    retq
;
; SSE41-LABEL: veccond256:
; SSE41:       # %bb.0: # %entry
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    ptest %xmm0, %xmm0
; SSE41-NEXT:    je .LBB1_2
; SSE41-NEXT:  # %bb.1: # %if-true-block
; SSE41-NEXT:    xorl %eax, %eax
; SSE41-NEXT:    retq
; SSE41-NEXT:  .LBB1_2: # %endif-block
; SSE41-NEXT:    movl $1, %eax
; SSE41-NEXT:    retq
;
; AVX-LABEL: veccond256:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vptest %ymm0, %ymm0
; AVX-NEXT:    je .LBB1_2
; AVX-NEXT:  # %bb.1: # %if-true-block
; AVX-NEXT:    xorl %eax, %eax
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
; AVX-NEXT:  .LBB1_2: # %endif-block
; AVX-NEXT:    movl $1, %eax
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
entry:
  %0 = bitcast <8 x i32> %input to i256
  %1 = icmp ne i256 %0, 0
  br i1 %1, label %if-true-block, label %endif-block
if-true-block:
  ret i32 0
endif-block:
  ret i32 1
}

define i32 @veccond512(<16 x i32> %input) {
; SSE2-LABEL: veccond512:
; SSE2:       # %bb.0: # %entry
; SSE2-NEXT:    por %xmm3, %xmm1
; SSE2-NEXT:    por %xmm2, %xmm1
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    pxor %xmm0, %xmm0
; SSE2-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE2-NEXT:    pmovmskb %xmm0, %eax
; SSE2-NEXT:    cmpl $65535, %eax # imm = 0xFFFF
; SSE2-NEXT:    je .LBB2_2
; SSE2-NEXT:  # %bb.1: # %if-true-block
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    retq
; SSE2-NEXT:  .LBB2_2: # %endif-block
; SSE2-NEXT:    movl $1, %eax
; SSE2-NEXT:    retq
;
; SSE41-LABEL: veccond512:
; SSE41:       # %bb.0: # %entry
; SSE41-NEXT:    por %xmm3, %xmm1
; SSE41-NEXT:    por %xmm2, %xmm1
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    ptest %xmm1, %xmm1
; SSE41-NEXT:    je .LBB2_2
; SSE41-NEXT:  # %bb.1: # %if-true-block
; SSE41-NEXT:    xorl %eax, %eax
; SSE41-NEXT:    retq
; SSE41-NEXT:  .LBB2_2: # %endif-block
; SSE41-NEXT:    movl $1, %eax
; SSE41-NEXT:    retq
;
; AVX1-LABEL: veccond512:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vptest %ymm0, %ymm0
; AVX1-NEXT:    je .LBB2_2
; AVX1-NEXT:  # %bb.1: # %if-true-block
; AVX1-NEXT:    xorl %eax, %eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
; AVX1-NEXT:  .LBB2_2: # %endif-block
; AVX1-NEXT:    movl $1, %eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX512-LABEL: veccond512:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vextracti32x4 $3, %zmm0, %xmm1
; AVX512-NEXT:    vmovq %xmm1, %rax
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm2
; AVX512-NEXT:    vmovq %xmm2, %rcx
; AVX512-NEXT:    orq %rax, %rcx
; AVX512-NEXT:    vextracti32x4 $2, %zmm0, %xmm3
; AVX512-NEXT:    vmovq %xmm3, %rax
; AVX512-NEXT:    orq %rcx, %rax
; AVX512-NEXT:    vmovq %xmm0, %rcx
; AVX512-NEXT:    orq %rax, %rcx
; AVX512-NEXT:    vpextrq $1, %xmm1, %rax
; AVX512-NEXT:    vpextrq $1, %xmm2, %rdx
; AVX512-NEXT:    orq %rax, %rdx
; AVX512-NEXT:    vpextrq $1, %xmm3, %rax
; AVX512-NEXT:    orq %rdx, %rax
; AVX512-NEXT:    vpextrq $1, %xmm0, %rdx
; AVX512-NEXT:    orq %rax, %rdx
; AVX512-NEXT:    orq %rcx, %rdx
; AVX512-NEXT:    je .LBB2_2
; AVX512-NEXT:  # %bb.1: # %if-true-block
; AVX512-NEXT:    xorl %eax, %eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
; AVX512-NEXT:  .LBB2_2: # %endif-block
; AVX512-NEXT:    movl $1, %eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
entry:
  %0 = bitcast <16 x i32> %input to i512
  %1 = icmp ne i512 %0, 0
  br i1 %1, label %if-true-block, label %endif-block
if-true-block:
  ret i32 0
endif-block:
  ret i32 1
}

define i32 @vectest128(<4 x i32> %input) {
; SSE2-LABEL: vectest128:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    pcmpeqb %xmm0, %xmm1
; SSE2-NEXT:    pmovmskb %xmm1, %ecx
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    cmpl $65535, %ecx # imm = 0xFFFF
; SSE2-NEXT:    setne %al
; SSE2-NEXT:    retq
;
; SSE41-LABEL: vectest128:
; SSE41:       # %bb.0:
; SSE41-NEXT:    xorl %eax, %eax
; SSE41-NEXT:    ptest %xmm0, %xmm0
; SSE41-NEXT:    setne %al
; SSE41-NEXT:    retq
;
; AVX-LABEL: vectest128:
; AVX:       # %bb.0:
; AVX-NEXT:    xorl %eax, %eax
; AVX-NEXT:    vptest %xmm0, %xmm0
; AVX-NEXT:    setne %al
; AVX-NEXT:    retq
  %t0 = bitcast <4 x i32> %input to i128
  %t1 = icmp ne i128 %t0, 0
  %t2 = zext i1 %t1 to i32
  ret i32 %t2
}

define i32 @vectest256(<8 x i32> %input) {
; SSE2-LABEL: vectest256:
; SSE2:       # %bb.0:
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    pcmpeqb %xmm0, %xmm1
; SSE2-NEXT:    pmovmskb %xmm1, %ecx
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    cmpl $65535, %ecx # imm = 0xFFFF
; SSE2-NEXT:    setne %al
; SSE2-NEXT:    retq
;
; SSE41-LABEL: vectest256:
; SSE41:       # %bb.0:
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    xorl %eax, %eax
; SSE41-NEXT:    ptest %xmm0, %xmm0
; SSE41-NEXT:    setne %al
; SSE41-NEXT:    retq
;
; AVX-LABEL: vectest256:
; AVX:       # %bb.0:
; AVX-NEXT:    xorl %eax, %eax
; AVX-NEXT:    vptest %ymm0, %ymm0
; AVX-NEXT:    setne %al
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
  %t0 = bitcast <8 x i32> %input to i256
  %t1 = icmp ne i256 %t0, 0
  %t2 = zext i1 %t1 to i32
  ret i32 %t2
}

define i32 @vectest512(<16 x i32> %input) {
; SSE2-LABEL: vectest512:
; SSE2:       # %bb.0:
; SSE2-NEXT:    por %xmm3, %xmm1
; SSE2-NEXT:    por %xmm2, %xmm1
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    pxor %xmm0, %xmm0
; SSE2-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE2-NEXT:    pmovmskb %xmm0, %ecx
; SSE2-NEXT:    xorl %eax, %eax
; SSE2-NEXT:    cmpl $65535, %ecx # imm = 0xFFFF
; SSE2-NEXT:    setne %al
; SSE2-NEXT:    retq
;
; SSE41-LABEL: vectest512:
; SSE41:       # %bb.0:
; SSE41-NEXT:    por %xmm3, %xmm1
; SSE41-NEXT:    por %xmm2, %xmm1
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    xorl %eax, %eax
; SSE41-NEXT:    ptest %xmm1, %xmm1
; SSE41-NEXT:    setne %al
; SSE41-NEXT:    retq
;
; AVX1-LABEL: vectest512:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    xorl %eax, %eax
; AVX1-NEXT:    vptest %ymm0, %ymm0
; AVX1-NEXT:    setne %al
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX512-LABEL: vectest512:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextracti32x4 $3, %zmm0, %xmm1
; AVX512-NEXT:    vmovq %xmm1, %rax
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm2
; AVX512-NEXT:    vmovq %xmm2, %rcx
; AVX512-NEXT:    orq %rax, %rcx
; AVX512-NEXT:    vextracti32x4 $2, %zmm0, %xmm3
; AVX512-NEXT:    vmovq %xmm3, %rax
; AVX512-NEXT:    orq %rcx, %rax
; AVX512-NEXT:    vmovq %xmm0, %rcx
; AVX512-NEXT:    orq %rax, %rcx
; AVX512-NEXT:    vpextrq $1, %xmm1, %rax
; AVX512-NEXT:    vpextrq $1, %xmm2, %rdx
; AVX512-NEXT:    orq %rax, %rdx
; AVX512-NEXT:    vpextrq $1, %xmm3, %rax
; AVX512-NEXT:    orq %rdx, %rax
; AVX512-NEXT:    vpextrq $1, %xmm0, %rdx
; AVX512-NEXT:    orq %rax, %rdx
; AVX512-NEXT:    xorl %eax, %eax
; AVX512-NEXT:    orq %rcx, %rdx
; AVX512-NEXT:    setne %al
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %t0 = bitcast <16 x i32> %input to i512
  %t1 = icmp ne i512 %t0, 0
  %t2 = zext i1 %t1 to i32
  ret i32 %t2
}

define i32 @vecsel128(<4 x i32> %input, i32 %a, i32 %b) {
; SSE2-LABEL: vecsel128:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movl %edi, %eax
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    pcmpeqb %xmm0, %xmm1
; SSE2-NEXT:    pmovmskb %xmm1, %ecx
; SSE2-NEXT:    cmpl $65535, %ecx # imm = 0xFFFF
; SSE2-NEXT:    cmovel %esi, %eax
; SSE2-NEXT:    retq
;
; SSE41-LABEL: vecsel128:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movl %edi, %eax
; SSE41-NEXT:    ptest %xmm0, %xmm0
; SSE41-NEXT:    cmovel %esi, %eax
; SSE41-NEXT:    retq
;
; AVX-LABEL: vecsel128:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %xmm0, %xmm0
; AVX-NEXT:    cmovel %esi, %eax
; AVX-NEXT:    retq
  %t0 = bitcast <4 x i32> %input to i128
  %t1 = icmp ne i128 %t0, 0
  %t2 = select i1 %t1, i32 %a, i32 %b
  ret i32 %t2
}

define i32 @vecsel256(<8 x i32> %input, i32 %a, i32 %b) {
; SSE2-LABEL: vecsel256:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movl %edi, %eax
; SSE2-NEXT:    por %xmm1, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    pcmpeqb %xmm0, %xmm1
; SSE2-NEXT:    pmovmskb %xmm1, %ecx
; SSE2-NEXT:    cmpl $65535, %ecx # imm = 0xFFFF
; SSE2-NEXT:    cmovel %esi, %eax
; SSE2-NEXT:    retq
;
; SSE41-LABEL: vecsel256:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movl %edi, %eax
; SSE41-NEXT:    por %xmm1, %xmm0
; SSE41-NEXT:    ptest %xmm0, %xmm0
; SSE41-NEXT:    cmovel %esi, %eax
; SSE41-NEXT:    retq
;
; AVX-LABEL: vecsel256:
; AVX:       # %bb.0:
; AVX-NEXT:    movl %edi, %eax
; AVX-NEXT:    vptest %ymm0, %ymm0
; AVX-NEXT:    cmovel %esi, %eax
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
  %t0 = bitcast <8 x i32> %input to i256
  %t1 = icmp ne i256 %t0, 0
  %t2 = select i1 %t1, i32 %a, i32 %b
  ret i32 %t2
}

define i32 @vecsel512(<16 x i32> %input, i32 %a, i32 %b) {
; SSE2-LABEL: vecsel512:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movl %edi, %eax
; SSE2-NEXT:    por %xmm3, %xmm1
; SSE2-NEXT:    por %xmm2, %xmm1
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    pxor %xmm0, %xmm0
; SSE2-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE2-NEXT:    pmovmskb %xmm0, %ecx
; SSE2-NEXT:    cmpl $65535, %ecx # imm = 0xFFFF
; SSE2-NEXT:    cmovel %esi, %eax
; SSE2-NEXT:    retq
;
; SSE41-LABEL: vecsel512:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movl %edi, %eax
; SSE41-NEXT:    por %xmm3, %xmm1
; SSE41-NEXT:    por %xmm2, %xmm1
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    ptest %xmm1, %xmm1
; SSE41-NEXT:    cmovel %esi, %eax
; SSE41-NEXT:    retq
;
; AVX1-LABEL: vecsel512:
; AVX1:       # %bb.0:
; AVX1-NEXT:    movl %edi, %eax
; AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vptest %ymm0, %ymm0
; AVX1-NEXT:    cmovel %esi, %eax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX512-LABEL: vecsel512:
; AVX512:       # %bb.0:
; AVX512-NEXT:    movl %edi, %eax
; AVX512-NEXT:    vextracti32x4 $3, %zmm0, %xmm1
; AVX512-NEXT:    vmovq %xmm1, %rcx
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm2
; AVX512-NEXT:    vmovq %xmm2, %rdx
; AVX512-NEXT:    orq %rcx, %rdx
; AVX512-NEXT:    vextracti32x4 $2, %zmm0, %xmm3
; AVX512-NEXT:    vmovq %xmm3, %rcx
; AVX512-NEXT:    orq %rdx, %rcx
; AVX512-NEXT:    vmovq %xmm0, %rdx
; AVX512-NEXT:    orq %rcx, %rdx
; AVX512-NEXT:    vpextrq $1, %xmm1, %rcx
; AVX512-NEXT:    vpextrq $1, %xmm2, %rdi
; AVX512-NEXT:    orq %rcx, %rdi
; AVX512-NEXT:    vpextrq $1, %xmm3, %rcx
; AVX512-NEXT:    orq %rdi, %rcx
; AVX512-NEXT:    vpextrq $1, %xmm0, %rdi
; AVX512-NEXT:    orq %rcx, %rdi
; AVX512-NEXT:    orq %rdx, %rdi
; AVX512-NEXT:    cmovel %esi, %eax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %t0 = bitcast <16 x i32> %input to i512
  %t1 = icmp ne i512 %t0, 0
  %t2 = select i1 %t1, i32 %a, i32 %b
  ret i32 %t2
}
