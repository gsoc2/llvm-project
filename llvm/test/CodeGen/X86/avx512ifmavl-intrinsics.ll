; NOTE: Assertions have been autogenerated by update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=knl -mattr=+avx512vl -mattr=+avx512ifma | FileCheck %s

declare <2 x i64> @llvm.x86.avx512.mask.vpmadd52h.uq.128(<2 x i64>, <2 x i64>, <2 x i64>, i8)

define <2 x i64>@test_int_x86_avx512_mask_vpmadd52h_uq_128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 %x3) {
; CHECK-LABEL: test_int_x86_avx512_mask_vpmadd52h_uq_128:
; CHECK:       ## BB#0:
; CHECK-NEXT:    kmovw %edi, %k1
; CHECK-NEXT:    vmovdqa %xmm0, %xmm3
; CHECK-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm3 {%k1}
; CHECK-NEXT:    vmovdqa %xmm0, %xmm4
; CHECK-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm4
; CHECK-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; CHECK-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm0 {%k1}
; CHECK-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm2 {%k1} {z}
; CHECK-NEXT:    vpaddq %xmm0, %xmm3, %xmm0
; CHECK-NEXT:    vpaddq %xmm2, %xmm4, %xmm1
; CHECK-NEXT:    vpaddq %xmm0, %xmm1, %xmm0
; CHECK-NEXT:    retq

  %res = call <2 x i64> @llvm.x86.avx512.mask.vpmadd52h.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 %x3)
  %res1 = call <2 x i64> @llvm.x86.avx512.mask.vpmadd52h.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> zeroinitializer, i8 %x3)
  %res2 = call <2 x i64> @llvm.x86.avx512.mask.vpmadd52h.uq.128(<2 x i64> zeroinitializer, <2 x i64> %x1, <2 x i64> zeroinitializer, i8 %x3)
  %res3 = call <2 x i64> @llvm.x86.avx512.mask.vpmadd52h.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 -1)
  %res4 = add <2 x i64> %res, %res1
  %res5 = add <2 x i64> %res3, %res2
  %res6 = add <2 x i64> %res5, %res4
  ret <2 x i64> %res6
}

declare <4 x i64> @llvm.x86.avx512.mask.vpmadd52h.uq.256(<4 x i64>, <4 x i64>, <4 x i64>, i8)

define <4 x i64>@test_int_x86_avx512_mask_vpmadd52h_uq_256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 %x3) {
; CHECK-LABEL: test_int_x86_avx512_mask_vpmadd52h_uq_256:
; CHECK:       ## BB#0:
; CHECK-NEXT:    kmovw %edi, %k1
; CHECK-NEXT:    vmovdqa %ymm0, %ymm3
; CHECK-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm3 {%k1}
; CHECK-NEXT:    vmovdqa %ymm0, %ymm4
; CHECK-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm4
; CHECK-NEXT:    vpxor %ymm2, %ymm2, %ymm2
; CHECK-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm0 {%k1}
; CHECK-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm2 {%k1} {z}
; CHECK-NEXT:    vpaddq %ymm0, %ymm3, %ymm0
; CHECK-NEXT:    vpaddq %ymm2, %ymm4, %ymm1
; CHECK-NEXT:    vpaddq %ymm0, %ymm1, %ymm0
; CHECK-NEXT:    retq

  %res = call <4 x i64> @llvm.x86.avx512.mask.vpmadd52h.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 %x3)
  %res1 = call <4 x i64> @llvm.x86.avx512.mask.vpmadd52h.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> zeroinitializer, i8 %x3)
  %res2 = call <4 x i64> @llvm.x86.avx512.mask.vpmadd52h.uq.256(<4 x i64> zeroinitializer, <4 x i64> %x1, <4 x i64> zeroinitializer, i8 %x3)
  %res3 = call <4 x i64> @llvm.x86.avx512.mask.vpmadd52h.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 -1)
  %res4 = add <4 x i64> %res, %res1
  %res5 = add <4 x i64> %res3, %res2
  %res6 = add <4 x i64> %res5, %res4
  ret <4 x i64> %res6
}

declare <2 x i64> @llvm.x86.avx512.maskz.vpmadd52h.uq.128(<2 x i64>, <2 x i64>, <2 x i64>, i8)

define <2 x i64>@test_int_x86_avx512_maskz_vpmadd52h_uq_128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 %x3) {
; CHECK-LABEL: test_int_x86_avx512_maskz_vpmadd52h_uq_128:
; CHECK:       ## BB#0:
; CHECK-NEXT:    kmovw %edi, %k1
; CHECK-NEXT:    vmovdqa %xmm0, %xmm3
; CHECK-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm3 {%k1} {z}
; CHECK-NEXT:    vmovdqa %xmm0, %xmm4
; CHECK-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm4
; CHECK-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; CHECK-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm0 {%k1} {z}
; CHECK-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm2 {%k1} {z}
; CHECK-NEXT:    vpaddq %xmm0, %xmm3, %xmm0
; CHECK-NEXT:    vpaddq %xmm2, %xmm4, %xmm1
; CHECK-NEXT:    vpaddq %xmm0, %xmm1, %xmm0
; CHECK-NEXT:    retq

  %res = call <2 x i64> @llvm.x86.avx512.maskz.vpmadd52h.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 %x3)
  %res1 = call <2 x i64> @llvm.x86.avx512.maskz.vpmadd52h.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> zeroinitializer, i8 %x3)
  %res2 = call <2 x i64> @llvm.x86.avx512.maskz.vpmadd52h.uq.128(<2 x i64> zeroinitializer, <2 x i64> %x1, <2 x i64> zeroinitializer, i8 %x3)
  %res3 = call <2 x i64> @llvm.x86.avx512.maskz.vpmadd52h.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 -1)
  %res4 = add <2 x i64> %res, %res1
  %res5 = add <2 x i64> %res3, %res2
  %res6 = add <2 x i64> %res5, %res4
  ret <2 x i64> %res6
}

declare <4 x i64> @llvm.x86.avx512.maskz.vpmadd52h.uq.256(<4 x i64>, <4 x i64>, <4 x i64>, i8)

define <4 x i64>@test_int_x86_avx512_maskz_vpmadd52h_uq_256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 %x3) {
; CHECK-LABEL: test_int_x86_avx512_maskz_vpmadd52h_uq_256:
; CHECK:       ## BB#0:
; CHECK-NEXT:    kmovw %edi, %k1
; CHECK-NEXT:    vmovdqa %ymm0, %ymm3
; CHECK-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm3 {%k1} {z}
; CHECK-NEXT:    vmovdqa %ymm0, %ymm4
; CHECK-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm4
; CHECK-NEXT:    vpxor %ymm2, %ymm2, %ymm2
; CHECK-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm0 {%k1} {z}
; CHECK-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm2 {%k1} {z}
; CHECK-NEXT:    vpaddq %ymm0, %ymm3, %ymm0
; CHECK-NEXT:    vpaddq %ymm2, %ymm4, %ymm1
; CHECK-NEXT:    vpaddq %ymm0, %ymm1, %ymm0
; CHECK-NEXT:    retq

  %res = call <4 x i64> @llvm.x86.avx512.maskz.vpmadd52h.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 %x3)
  %res1 = call <4 x i64> @llvm.x86.avx512.maskz.vpmadd52h.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> zeroinitializer, i8 %x3)
  %res2 = call <4 x i64> @llvm.x86.avx512.maskz.vpmadd52h.uq.256(<4 x i64> zeroinitializer, <4 x i64> %x1, <4 x i64> zeroinitializer, i8 %x3)
  %res3 = call <4 x i64> @llvm.x86.avx512.maskz.vpmadd52h.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 -1)
  %res4 = add <4 x i64> %res, %res1
  %res5 = add <4 x i64> %res3, %res2
  %res6 = add <4 x i64> %res5, %res4
  ret <4 x i64> %res6
}

declare <2 x i64> @llvm.x86.avx512.mask.vpmadd52l.uq.128(<2 x i64>, <2 x i64>, <2 x i64>, i8)

define <2 x i64>@test_int_x86_avx512_mask_vpmadd52l_uq_128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 %x3) {
; CHECK-LABEL: test_int_x86_avx512_mask_vpmadd52l_uq_128:
; CHECK:       ## BB#0:
; CHECK-NEXT:    kmovw %edi, %k1
; CHECK-NEXT:    vmovdqa %xmm0, %xmm3
; CHECK-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm3 {%k1}
; CHECK-NEXT:    vmovdqa %xmm0, %xmm4
; CHECK-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm4
; CHECK-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; CHECK-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm0 {%k1}
; CHECK-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm2 {%k1} {z}
; CHECK-NEXT:    vpaddq %xmm0, %xmm3, %xmm0
; CHECK-NEXT:    vpaddq %xmm2, %xmm4, %xmm1
; CHECK-NEXT:    vpaddq %xmm0, %xmm1, %xmm0
; CHECK-NEXT:    retq

  %res = call <2 x i64> @llvm.x86.avx512.mask.vpmadd52l.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 %x3)
  %res1 = call <2 x i64> @llvm.x86.avx512.mask.vpmadd52l.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> zeroinitializer, i8 %x3)
  %res2 = call <2 x i64> @llvm.x86.avx512.mask.vpmadd52l.uq.128(<2 x i64> zeroinitializer, <2 x i64> %x1, <2 x i64> zeroinitializer, i8 %x3)
  %res3 = call <2 x i64> @llvm.x86.avx512.mask.vpmadd52l.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 -1)
  %res4 = add <2 x i64> %res, %res1
  %res5 = add <2 x i64> %res3, %res2
  %res6 = add <2 x i64> %res5, %res4
  ret <2 x i64> %res6
}

declare <4 x i64> @llvm.x86.avx512.mask.vpmadd52l.uq.256(<4 x i64>, <4 x i64>, <4 x i64>, i8)

define <4 x i64>@test_int_x86_avx512_mask_vpmadd52l_uq_256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 %x3) {
; CHECK-LABEL: test_int_x86_avx512_mask_vpmadd52l_uq_256:
; CHECK:       ## BB#0:
; CHECK-NEXT:    kmovw %edi, %k1
; CHECK-NEXT:    vmovdqa %ymm0, %ymm3
; CHECK-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm3 {%k1}
; CHECK-NEXT:    vmovdqa %ymm0, %ymm4
; CHECK-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm4
; CHECK-NEXT:    vpxor %ymm2, %ymm2, %ymm2
; CHECK-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm0 {%k1}
; CHECK-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm2 {%k1} {z}
; CHECK-NEXT:    vpaddq %ymm0, %ymm3, %ymm0
; CHECK-NEXT:    vpaddq %ymm2, %ymm4, %ymm1
; CHECK-NEXT:    vpaddq %ymm0, %ymm1, %ymm0
; CHECK-NEXT:    retq

  %res = call <4 x i64> @llvm.x86.avx512.mask.vpmadd52l.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 %x3)
  %res1 = call <4 x i64> @llvm.x86.avx512.mask.vpmadd52l.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> zeroinitializer, i8 %x3)
  %res2 = call <4 x i64> @llvm.x86.avx512.mask.vpmadd52l.uq.256(<4 x i64> zeroinitializer, <4 x i64> %x1, <4 x i64> zeroinitializer, i8 %x3)
  %res3 = call <4 x i64> @llvm.x86.avx512.mask.vpmadd52l.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 -1)
  %res4 = add <4 x i64> %res, %res1
  %res5 = add <4 x i64> %res3, %res2
  %res6 = add <4 x i64> %res5, %res4
  ret <4 x i64> %res6
}

declare <2 x i64> @llvm.x86.avx512.maskz.vpmadd52l.uq.128(<2 x i64>, <2 x i64>, <2 x i64>, i8)

define <2 x i64>@test_int_x86_avx512_maskz_vpmadd52l_uq_128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 %x3) {
; CHECK-LABEL: test_int_x86_avx512_maskz_vpmadd52l_uq_128:
; CHECK:       ## BB#0:
; CHECK-NEXT:    kmovw %edi, %k1
; CHECK-NEXT:    vmovdqa %xmm0, %xmm3
; CHECK-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm3 {%k1} {z}
; CHECK-NEXT:    vmovdqa %xmm0, %xmm4
; CHECK-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm4
; CHECK-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; CHECK-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm0 {%k1} {z}
; CHECK-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm2 {%k1} {z}
; CHECK-NEXT:    vpaddq %xmm0, %xmm3, %xmm0
; CHECK-NEXT:    vpaddq %xmm2, %xmm4, %xmm1
; CHECK-NEXT:    vpaddq %xmm0, %xmm1, %xmm0
; CHECK-NEXT:    retq

  %res = call <2 x i64> @llvm.x86.avx512.maskz.vpmadd52l.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 %x3)
  %res1 = call <2 x i64> @llvm.x86.avx512.maskz.vpmadd52l.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> zeroinitializer, i8 %x3)
  %res2 = call <2 x i64> @llvm.x86.avx512.maskz.vpmadd52l.uq.128(<2 x i64> zeroinitializer, <2 x i64> %x1, <2 x i64> zeroinitializer, i8 %x3)
  %res3 = call <2 x i64> @llvm.x86.avx512.maskz.vpmadd52l.uq.128(<2 x i64> %x0, <2 x i64> %x1, <2 x i64> %x2, i8 -1)
  %res4 = add <2 x i64> %res, %res1
  %res5 = add <2 x i64> %res3, %res2
  %res6 = add <2 x i64> %res5, %res4
  ret <2 x i64> %res6
}

declare <4 x i64> @llvm.x86.avx512.maskz.vpmadd52l.uq.256(<4 x i64>, <4 x i64>, <4 x i64>, i8)

define <4 x i64>@test_int_x86_avx512_maskz_vpmadd52l_uq_256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 %x3) {
; CHECK-LABEL: test_int_x86_avx512_maskz_vpmadd52l_uq_256:
; CHECK:       ## BB#0:
; CHECK-NEXT:    kmovw %edi, %k1
; CHECK-NEXT:    vmovdqa %ymm0, %ymm3
; CHECK-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm3 {%k1} {z}
; CHECK-NEXT:    vmovdqa %ymm0, %ymm4
; CHECK-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm4
; CHECK-NEXT:    vpxor %ymm2, %ymm2, %ymm2
; CHECK-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm0 {%k1} {z}
; CHECK-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm2 {%k1} {z}
; CHECK-NEXT:    vpaddq %ymm0, %ymm3, %ymm0
; CHECK-NEXT:    vpaddq %ymm2, %ymm4, %ymm1
; CHECK-NEXT:    vpaddq %ymm0, %ymm1, %ymm0
; CHECK-NEXT:    retq

  %res = call <4 x i64> @llvm.x86.avx512.maskz.vpmadd52l.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 %x3)
  %res1 = call <4 x i64> @llvm.x86.avx512.maskz.vpmadd52l.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> zeroinitializer, i8 %x3)
  %res2 = call <4 x i64> @llvm.x86.avx512.maskz.vpmadd52l.uq.256(<4 x i64> zeroinitializer, <4 x i64> %x1, <4 x i64> zeroinitializer, i8 %x3)
  %res3 = call <4 x i64> @llvm.x86.avx512.maskz.vpmadd52l.uq.256(<4 x i64> %x0, <4 x i64> %x1, <4 x i64> %x2, i8 -1)
  %res4 = add <4 x i64> %res, %res1
  %res5 = add <4 x i64> %res3, %res2
  %res6 = add <4 x i64> %res5, %res4
  ret <4 x i64> %res6
}
