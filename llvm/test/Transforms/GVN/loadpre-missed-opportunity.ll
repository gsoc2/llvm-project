; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -gvn -gvn-max-block-speculations=1 -S | FileCheck -check-prefixes=ALL,PRE %s
; RUN: opt < %s -gvn -gvn-max-block-speculations=0 -S | FileCheck -check-prefixes=ALL,CHECK %s

define i32 @loadpre_opportunity(i32** %arg, i1 %arg1, i1 %arg2, i1 %arg3) {
; PRE-LABEL: @loadpre_opportunity(
; PRE-NEXT:  bb:
; PRE-NEXT:    [[I:%.*]] = load i32*, i32** [[ARG:%.*]], align 8
; PRE-NEXT:    [[I6:%.*]] = call i32 @use(i32* [[I]])
; PRE-NEXT:    br label [[BB11:%.*]]
; PRE:       bb7:
; PRE-NEXT:    [[I8:%.*]] = phi i32* [ [[I8_PRE:%.*]], [[BB17_BB7_CRIT_EDGE:%.*]] ], [ [[I81:%.*]], [[BB11]] ]
; PRE-NEXT:    [[I10:%.*]] = call i32 @use(i32* [[I8]])
; PRE-NEXT:    br label [[BB11]]
; PRE:       bb11:
; PRE-NEXT:    [[I81]] = phi i32* [ [[I]], [[BB:%.*]] ], [ [[I8]], [[BB7:%.*]] ]
; PRE-NEXT:    [[I12:%.*]] = phi i32 [ [[I6]], [[BB]] ], [ [[I10]], [[BB7]] ]
; PRE-NEXT:    br i1 [[ARG1:%.*]], label [[BB7]], label [[BB13:%.*]]
; PRE:       bb13:
; PRE-NEXT:    call void @somecall()
; PRE-NEXT:    br i1 [[ARG2:%.*]], label [[BB14:%.*]], label [[BB17:%.*]]
; PRE:       bb14:
; PRE-NEXT:    br label [[BB15:%.*]]
; PRE:       bb15:
; PRE-NEXT:    br i1 [[ARG3:%.*]], label [[BB16:%.*]], label [[BB15]]
; PRE:       bb16:
; PRE-NEXT:    br label [[BB17]]
; PRE:       bb17:
; PRE-NEXT:    [[I18:%.*]] = call i1 @cond()
; PRE-NEXT:    br i1 [[I18]], label [[BB17_BB7_CRIT_EDGE]], label [[BB19:%.*]]
; PRE:       bb17.bb7_crit_edge:
; PRE-NEXT:    [[I8_PRE]] = load i32*, i32** [[ARG]], align 8
; PRE-NEXT:    br label [[BB7]]
; PRE:       bb19:
; PRE-NEXT:    ret i32 [[I12]]
;
; CHECK-LABEL: @loadpre_opportunity(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32*, i32** [[ARG:%.*]], align 8
; CHECK-NEXT:    [[I6:%.*]] = call i32 @use(i32* [[I]])
; CHECK-NEXT:    br label [[BB11:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    [[I8:%.*]] = load i32*, i32** [[ARG]], align 8
; CHECK-NEXT:    [[I10:%.*]] = call i32 @use(i32* [[I8]])
; CHECK-NEXT:    br label [[BB11]]
; CHECK:       bb11:
; CHECK-NEXT:    [[I12:%.*]] = phi i32 [ [[I6]], [[BB:%.*]] ], [ [[I10]], [[BB7:%.*]] ]
; CHECK-NEXT:    br i1 [[ARG1:%.*]], label [[BB7]], label [[BB13:%.*]]
; CHECK:       bb13:
; CHECK-NEXT:    call void @somecall()
; CHECK-NEXT:    br i1 [[ARG2:%.*]], label [[BB14:%.*]], label [[BB17:%.*]]
; CHECK:       bb14:
; CHECK-NEXT:    br label [[BB15:%.*]]
; CHECK:       bb15:
; CHECK-NEXT:    br i1 [[ARG3:%.*]], label [[BB16:%.*]], label [[BB15]]
; CHECK:       bb16:
; CHECK-NEXT:    br label [[BB17]]
; CHECK:       bb17:
; CHECK-NEXT:    [[I18:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[I18]], label [[BB7]], label [[BB19:%.*]]
; CHECK:       bb19:
; CHECK-NEXT:    ret i32 [[I12]]
;
bb:
  %i = load i32*, i32** %arg, align 8
  %i4 = getelementptr inbounds i32, i32* %i, i64 0
  br label %bb5

bb5:
  %i6 = call i32 @use(i32* %i4)
  br label %bb11

bb7:
  %i8 = load i32*, i32** %arg, align 8
  %i9 = getelementptr inbounds i32, i32* %i8, i64 0
  %i10 = call i32 @use(i32* %i9)
  br label %bb11

bb11:
  %i12 = phi i32 [ %i6, %bb5 ], [ %i10, %bb7 ]
  br i1 %arg1, label %bb7, label %bb13

bb13:
  call void @somecall()
  br i1 %arg2, label %bb14, label %bb17

bb14:
  br label %bb15

bb15:
  br i1 %arg3, label %bb16, label %bb15

bb16:
  br label %bb17

bb17:
  %i18 = call i1 @cond()
  br i1 %i18, label %bb7, label %bb19

bb19:
  ret i32 %i12
}

declare void @somecall()
declare i32 @use(i32*) readnone
declare i1 @cond() readnone
