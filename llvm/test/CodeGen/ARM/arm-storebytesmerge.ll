; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm-eabi -mattr=+neon %s -o - | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7em-arm-none-eabi"

; Function Attrs: nounwind
define arm_aapcs_vfpcc void @test(i8* %v50) #0 {
; CHECK-LABEL: test:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    movw r1, #35722
; CHECK-NEXT:    movt r1, #36236
; CHECK-NEXT:    str.w r1, [r0, #394]
; CHECK-NEXT:    movw r1, #36750
; CHECK-NEXT:    movt r1, #37264
; CHECK-NEXT:    str.w r1, [r0, #398]
; CHECK-NEXT:    movw r1, #37778
; CHECK-NEXT:    movt r1, #38292
; CHECK-NEXT:    str.w r1, [r0, #402]
; CHECK-NEXT:    movw r1, #38806
; CHECK-NEXT:    movt r1, #39320
; CHECK-NEXT:    str.w r1, [r0, #406]
; CHECK-NEXT:    movw r1, #39834
; CHECK-NEXT:    strh.w r1, [r0, #410]
; CHECK-NEXT:    movw r1, #40348
; CHECK-NEXT:    movt r1, #40862
; CHECK-NEXT:    str.w r1, [r0, #412]
; CHECK-NEXT:    movw r1, #41376
; CHECK-NEXT:    movt r1, #41890
; CHECK-NEXT:    str.w r1, [r0, #416]
; CHECK-NEXT:    movw r1, #42404
; CHECK-NEXT:    movt r1, #42918
; CHECK-NEXT:    str.w r1, [r0, #420]
; CHECK-NEXT:    movw r1, #43432
; CHECK-NEXT:    movt r1, #43946
; CHECK-NEXT:    str.w r1, [r0, #424]
; CHECK-NEXT:    movw r1, #44460
; CHECK-NEXT:    movt r1, #44974
; CHECK-NEXT:    str.w r1, [r0, #428]
; CHECK-NEXT:    movw r1, #45488
; CHECK-NEXT:    strh.w r1, [r0, #432]
; CHECK-NEXT:    movw r1, #46002
; CHECK-NEXT:    movt r1, #46516
; CHECK-NEXT:    str.w r1, [r0, #434]
; CHECK-NEXT:    movw r1, #47030
; CHECK-NEXT:    strh.w r1, [r0, #438]
; CHECK-NEXT:    movw r1, #47544
; CHECK-NEXT:    movt r1, #48058
; CHECK-NEXT:    str.w r1, [r0, #440]
; CHECK-NEXT:    movw r1, #48572
; CHECK-NEXT:    movt r1, #49086
; CHECK-NEXT:    str.w r1, [r0, #444]
; CHECK-NEXT:    movw r1, #49600
; CHECK-NEXT:    strh.w r1, [r0, #448]
; CHECK-NEXT:    movs r1, #194
; CHECK-NEXT:    strb.w r1, [r0, #450]
; CHECK-NEXT:    movw r1, #50371
; CHECK-NEXT:    movt r1, #50885
; CHECK-NEXT:    str.w r1, [r0, #451]
; CHECK-NEXT:    movw r1, #51399
; CHECK-NEXT:    movt r1, #51913
; CHECK-NEXT:    str.w r1, [r0, #455]
; CHECK-NEXT:    movw r1, #52427
; CHECK-NEXT:    movt r1, #52941
; CHECK-NEXT:    str.w r1, [r0, #459]
; CHECK-NEXT:    movw r1, #53455
; CHECK-NEXT:    movt r1, #53969
; CHECK-NEXT:    str.w r1, [r0, #463]
; CHECK-NEXT:    movw r1, #54483
; CHECK-NEXT:    strh.w r1, [r0, #467]
; CHECK-NEXT:    movw r1, #54997
; CHECK-NEXT:    movt r1, #55511
; CHECK-NEXT:    str.w r1, [r0, #469]
; CHECK-NEXT:    movw r1, #56025
; CHECK-NEXT:    movt r1, #56539
; CHECK-NEXT:    str.w r1, [r0, #473]
; CHECK-NEXT:    movw r1, #57053
; CHECK-NEXT:    movt r1, #57567
; CHECK-NEXT:    str.w r1, [r0, #477]
; CHECK-NEXT:    movw r1, #58081
; CHECK-NEXT:    movt r1, #58595
; CHECK-NEXT:    str.w r1, [r0, #481]
; CHECK-NEXT:    movw r1, #59109
; CHECK-NEXT:    movt r1, #59623
; CHECK-NEXT:    str.w r1, [r0, #485]
; CHECK-NEXT:    movw r1, #60137
; CHECK-NEXT:    strh.w r1, [r0, #489]
; CHECK-NEXT:    movw r1, #60651
; CHECK-NEXT:    movt r1, #61165
; CHECK-NEXT:    str.w r1, [r0, #491]
; CHECK-NEXT:    movw r1, #61679
; CHECK-NEXT:    strh.w r1, [r0, #495]
; CHECK-NEXT:    movw r1, #62193
; CHECK-NEXT:    movt r1, #62707
; CHECK-NEXT:    str.w r1, [r0, #497]
; CHECK-NEXT:    movw r1, #63221
; CHECK-NEXT:    movt r1, #63735
; CHECK-NEXT:    str.w r1, [r0, #501]
; CHECK-NEXT:    movw r1, #64249
; CHECK-NEXT:    strh.w r1, [r0, #505]
; CHECK-NEXT:    movs r1, #251
; CHECK-NEXT:    strb.w r1, [r0, #507]
; CHECK-NEXT:    movw r1, #65020
; CHECK-NEXT:    movt r1, #65534
; CHECK-NEXT:    str.w r1, [r0, #508]
; CHECK-NEXT:    bx lr
  %v190 = getelementptr inbounds i8, i8* %v50, i32 394
  store i8 -118, i8* %v190, align 1
  %v191 = getelementptr inbounds i8, i8* %v50, i32 395
  store i8 -117, i8* %v191, align 1
  %v192 = getelementptr inbounds i8, i8* %v50, i32 396
  store i8 -116, i8* %v192, align 1
  %v193 = getelementptr inbounds i8, i8* %v50, i32 397
  store i8 -115, i8* %v193, align 1
  %v194 = getelementptr inbounds i8, i8* %v50, i32 398
  store i8 -114, i8* %v194, align 1
  %v195 = getelementptr inbounds i8, i8* %v50, i32 399
  store i8 -113, i8* %v195, align 1
  %v196 = getelementptr inbounds i8, i8* %v50, i32 400
  store i8 -112, i8* %v196, align 1
  %v197 = getelementptr inbounds i8, i8* %v50, i32 401
  store i8 -111, i8* %v197, align 1
  %v198 = getelementptr inbounds i8, i8* %v50, i32 402
  store i8 -110, i8* %v198, align 1
  %v199 = getelementptr inbounds i8, i8* %v50, i32 403
  store i8 -109, i8* %v199, align 1
  %v200 = getelementptr inbounds i8, i8* %v50, i32 404
  store i8 -108, i8* %v200, align 1
  %v201 = getelementptr inbounds i8, i8* %v50, i32 405
  store i8 -107, i8* %v201, align 1
  %v202 = getelementptr inbounds i8, i8* %v50, i32 406
  store i8 -106, i8* %v202, align 1
  %v203 = getelementptr inbounds i8, i8* %v50, i32 407
  store i8 -105, i8* %v203, align 1
  %v204 = getelementptr inbounds i8, i8* %v50, i32 408
  store i8 -104, i8* %v204, align 1
  %v205 = getelementptr inbounds i8, i8* %v50, i32 409
  store i8 -103, i8* %v205, align 1
  %v206 = getelementptr inbounds i8, i8* %v50, i32 410
  store i8 -102, i8* %v206, align 1
  %v207 = getelementptr inbounds i8, i8* %v50, i32 411
  store i8 -101, i8* %v207, align 1
  %v208 = getelementptr inbounds i8, i8* %v50, i32 412
  store i8 -100, i8* %v208, align 1
  %v209 = getelementptr inbounds i8, i8* %v50, i32 413
  store i8 -99, i8* %v209, align 1
  %v210 = getelementptr inbounds i8, i8* %v50, i32 414
  store i8 -98, i8* %v210, align 1
  %v211 = getelementptr inbounds i8, i8* %v50, i32 415
  store i8 -97, i8* %v211, align 1
  %v212 = getelementptr inbounds i8, i8* %v50, i32 416
  store i8 -96, i8* %v212, align 1
  %v213 = getelementptr inbounds i8, i8* %v50, i32 417
  store i8 -95, i8* %v213, align 1
  %v214 = getelementptr inbounds i8, i8* %v50, i32 418
  store i8 -94, i8* %v214, align 1
  %v215 = getelementptr inbounds i8, i8* %v50, i32 419
  store i8 -93, i8* %v215, align 1
  %v216 = getelementptr inbounds i8, i8* %v50, i32 420
  store i8 -92, i8* %v216, align 1
  %v217 = getelementptr inbounds i8, i8* %v50, i32 421
  store i8 -91, i8* %v217, align 1
  %v218 = getelementptr inbounds i8, i8* %v50, i32 422
  store i8 -90, i8* %v218, align 1
  %v219 = getelementptr inbounds i8, i8* %v50, i32 423
  store i8 -89, i8* %v219, align 1
  %v220 = getelementptr inbounds i8, i8* %v50, i32 424
  store i8 -88, i8* %v220, align 1
  %v221 = getelementptr inbounds i8, i8* %v50, i32 425
  store i8 -87, i8* %v221, align 1
  %v222 = getelementptr inbounds i8, i8* %v50, i32 426
  store i8 -86, i8* %v222, align 1
  %v223 = getelementptr inbounds i8, i8* %v50, i32 427
  store i8 -85, i8* %v223, align 1
  %v224 = getelementptr inbounds i8, i8* %v50, i32 428
  store i8 -84, i8* %v224, align 1
  %v225 = getelementptr inbounds i8, i8* %v50, i32 429
  store i8 -83, i8* %v225, align 1
  %v226 = getelementptr inbounds i8, i8* %v50, i32 430
  store i8 -82, i8* %v226, align 1
  %v227 = getelementptr inbounds i8, i8* %v50, i32 431
  store i8 -81, i8* %v227, align 1
  %v228 = getelementptr inbounds i8, i8* %v50, i32 432
  store i8 -80, i8* %v228, align 1
  %v229 = getelementptr inbounds i8, i8* %v50, i32 433
  store i8 -79, i8* %v229, align 1
  %v230 = getelementptr inbounds i8, i8* %v50, i32 434
  store i8 -78, i8* %v230, align 1
  %v231 = getelementptr inbounds i8, i8* %v50, i32 435
  store i8 -77, i8* %v231, align 1
  %v232 = getelementptr inbounds i8, i8* %v50, i32 436
  store i8 -76, i8* %v232, align 1
  %v233 = getelementptr inbounds i8, i8* %v50, i32 437
  store i8 -75, i8* %v233, align 1
  %v234 = getelementptr inbounds i8, i8* %v50, i32 438
  store i8 -74, i8* %v234, align 1
  %v235 = getelementptr inbounds i8, i8* %v50, i32 439
  store i8 -73, i8* %v235, align 1
  %v236 = getelementptr inbounds i8, i8* %v50, i32 440
  store i8 -72, i8* %v236, align 1
  %v237 = getelementptr inbounds i8, i8* %v50, i32 441
  store i8 -71, i8* %v237, align 1
  %v238 = getelementptr inbounds i8, i8* %v50, i32 442
  store i8 -70, i8* %v238, align 1
  %v239 = getelementptr inbounds i8, i8* %v50, i32 443
  store i8 -69, i8* %v239, align 1
  %v240 = getelementptr inbounds i8, i8* %v50, i32 444
  store i8 -68, i8* %v240, align 1
  %v241 = getelementptr inbounds i8, i8* %v50, i32 445
  store i8 -67, i8* %v241, align 1
  %v242 = getelementptr inbounds i8, i8* %v50, i32 446
  store i8 -66, i8* %v242, align 1
  %v243 = getelementptr inbounds i8, i8* %v50, i32 447
  store i8 -65, i8* %v243, align 1
  %v244 = getelementptr inbounds i8, i8* %v50, i32 448
  store i8 -64, i8* %v244, align 1
  %v245 = getelementptr inbounds i8, i8* %v50, i32 449
  store i8 -63, i8* %v245, align 1
  %v246 = getelementptr inbounds i8, i8* %v50, i32 450
  store i8 -62, i8* %v246, align 1
  %v247 = getelementptr inbounds i8, i8* %v50, i32 451
  store i8 -61, i8* %v247, align 1
  %v248 = getelementptr inbounds i8, i8* %v50, i32 452
  store i8 -60, i8* %v248, align 1
  %v249 = getelementptr inbounds i8, i8* %v50, i32 453
  store i8 -59, i8* %v249, align 1
  %v250 = getelementptr inbounds i8, i8* %v50, i32 454
  store i8 -58, i8* %v250, align 1
  %v251 = getelementptr inbounds i8, i8* %v50, i32 455
  store i8 -57, i8* %v251, align 1
  %v252 = getelementptr inbounds i8, i8* %v50, i32 456
  store i8 -56, i8* %v252, align 1
  %v253 = getelementptr inbounds i8, i8* %v50, i32 457
  store i8 -55, i8* %v253, align 1
  %v254 = getelementptr inbounds i8, i8* %v50, i32 458
  store i8 -54, i8* %v254, align 1
  %v255 = getelementptr inbounds i8, i8* %v50, i32 459
  store i8 -53, i8* %v255, align 1
  %v256 = getelementptr inbounds i8, i8* %v50, i32 460
  store i8 -52, i8* %v256, align 1
  %v257 = getelementptr inbounds i8, i8* %v50, i32 461
  store i8 -51, i8* %v257, align 1
  %v258 = getelementptr inbounds i8, i8* %v50, i32 462
  store i8 -50, i8* %v258, align 1
  %v259 = getelementptr inbounds i8, i8* %v50, i32 463
  store i8 -49, i8* %v259, align 1
  %v260 = getelementptr inbounds i8, i8* %v50, i32 464
  store i8 -48, i8* %v260, align 1
  %v261 = getelementptr inbounds i8, i8* %v50, i32 465
  store i8 -47, i8* %v261, align 1
  %v262 = getelementptr inbounds i8, i8* %v50, i32 466
  store i8 -46, i8* %v262, align 1
  %v263 = getelementptr inbounds i8, i8* %v50, i32 467
  store i8 -45, i8* %v263, align 1
  %v264 = getelementptr inbounds i8, i8* %v50, i32 468
  store i8 -44, i8* %v264, align 1
  %v265 = getelementptr inbounds i8, i8* %v50, i32 469
  store i8 -43, i8* %v265, align 1
  %v266 = getelementptr inbounds i8, i8* %v50, i32 470
  store i8 -42, i8* %v266, align 1
  %v267 = getelementptr inbounds i8, i8* %v50, i32 471
  store i8 -41, i8* %v267, align 1
  %v268 = getelementptr inbounds i8, i8* %v50, i32 472
  store i8 -40, i8* %v268, align 1
  %v269 = getelementptr inbounds i8, i8* %v50, i32 473
  store i8 -39, i8* %v269, align 1
  %v270 = getelementptr inbounds i8, i8* %v50, i32 474
  store i8 -38, i8* %v270, align 1
  %v271 = getelementptr inbounds i8, i8* %v50, i32 475
  store i8 -37, i8* %v271, align 1
  %v272 = getelementptr inbounds i8, i8* %v50, i32 476
  store i8 -36, i8* %v272, align 1
  %v273 = getelementptr inbounds i8, i8* %v50, i32 477
  store i8 -35, i8* %v273, align 1
  %v274 = getelementptr inbounds i8, i8* %v50, i32 478
  store i8 -34, i8* %v274, align 1
  %v275 = getelementptr inbounds i8, i8* %v50, i32 479
  store i8 -33, i8* %v275, align 1
  %v276 = getelementptr inbounds i8, i8* %v50, i32 480
  store i8 -32, i8* %v276, align 1
  %v277 = getelementptr inbounds i8, i8* %v50, i32 481
  store i8 -31, i8* %v277, align 1
  %v278 = getelementptr inbounds i8, i8* %v50, i32 482
  store i8 -30, i8* %v278, align 1
  %v279 = getelementptr inbounds i8, i8* %v50, i32 483
  store i8 -29, i8* %v279, align 1
  %v280 = getelementptr inbounds i8, i8* %v50, i32 484
  store i8 -28, i8* %v280, align 1
  %v281 = getelementptr inbounds i8, i8* %v50, i32 485
  store i8 -27, i8* %v281, align 1
  %v282 = getelementptr inbounds i8, i8* %v50, i32 486
  store i8 -26, i8* %v282, align 1
  %v283 = getelementptr inbounds i8, i8* %v50, i32 487
  store i8 -25, i8* %v283, align 1
  %v284 = getelementptr inbounds i8, i8* %v50, i32 488
  store i8 -24, i8* %v284, align 1
  %v285 = getelementptr inbounds i8, i8* %v50, i32 489
  store i8 -23, i8* %v285, align 1
  %v286 = getelementptr inbounds i8, i8* %v50, i32 490
  store i8 -22, i8* %v286, align 1
  %v287 = getelementptr inbounds i8, i8* %v50, i32 491
  store i8 -21, i8* %v287, align 1
  %v288 = getelementptr inbounds i8, i8* %v50, i32 492
  store i8 -20, i8* %v288, align 1
  %v289 = getelementptr inbounds i8, i8* %v50, i32 493
  store i8 -19, i8* %v289, align 1
  %v290 = getelementptr inbounds i8, i8* %v50, i32 494
  store i8 -18, i8* %v290, align 1
  %v291 = getelementptr inbounds i8, i8* %v50, i32 495
  store i8 -17, i8* %v291, align 1
  %v292 = getelementptr inbounds i8, i8* %v50, i32 496
  store i8 -16, i8* %v292, align 1
  %v293 = getelementptr inbounds i8, i8* %v50, i32 497
  store i8 -15, i8* %v293, align 1
  %v294 = getelementptr inbounds i8, i8* %v50, i32 498
  store i8 -14, i8* %v294, align 1
  %v295 = getelementptr inbounds i8, i8* %v50, i32 499
  store i8 -13, i8* %v295, align 1
  %v296 = getelementptr inbounds i8, i8* %v50, i32 500
  store i8 -12, i8* %v296, align 1
  %v297 = getelementptr inbounds i8, i8* %v50, i32 501
  store i8 -11, i8* %v297, align 1
  %v298 = getelementptr inbounds i8, i8* %v50, i32 502
  store i8 -10, i8* %v298, align 1
  %v299 = getelementptr inbounds i8, i8* %v50, i32 503
  store i8 -9, i8* %v299, align 1
  %v300 = getelementptr inbounds i8, i8* %v50, i32 504
  store i8 -8, i8* %v300, align 1
  %v301 = getelementptr inbounds i8, i8* %v50, i32 505
  store i8 -7, i8* %v301, align 1
  %v302 = getelementptr inbounds i8, i8* %v50, i32 506
  store i8 -6, i8* %v302, align 1
  %v303 = getelementptr inbounds i8, i8* %v50, i32 507
  store i8 -5, i8* %v303, align 1
  %v304 = getelementptr inbounds i8, i8* %v50, i32 508
  store i8 -4, i8* %v304, align 1
  %v305 = getelementptr inbounds i8, i8* %v50, i32 509
  store i8 -3, i8* %v305, align 1
  %v306 = getelementptr inbounds i8, i8* %v50, i32 510
  store i8 -2, i8* %v306, align 1
  %v307 = getelementptr inbounds i8, i8* %v50, i32 511
  store i8 -1, i8* %v307, align 1
  ret void
  }

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "denormal-fp-math"="preserve-sign" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m7" "target-features"="+d16,+dsp,+fp-armv8,+hwdiv,+thumb-mode,-crc,-crypto,-dotprod,-fp-only-sp,-fullfp16,-hwdiv-arm,-neon,-ras" "unsafe-fp-math"="false" "use-soft-float"="false" }

