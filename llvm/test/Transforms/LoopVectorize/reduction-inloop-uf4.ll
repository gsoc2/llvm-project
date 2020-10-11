; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s  -loop-vectorize -force-vector-interleave=4 -force-vector-width=4 -prefer-inloop-reductions -force-reduction-intrinsics -dce -instcombine -S | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"

define i32 @reduction_sum_single(i32* noalias nocapture %A) {
; CHECK-LABEL: @reduction_sum_single(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[TMP9:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[TMP11:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI2:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[TMP13:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI3:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[TMP15:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[TMP0]] to <4 x i32>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, <4 x i32>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, i32* [[TMP0]], i64 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast i32* [[TMP2]] to <4 x i32>*
; CHECK-NEXT:    [[WIDE_LOAD4:%.*]] = load <4 x i32>, <4 x i32>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, i32* [[TMP0]], i64 8
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast i32* [[TMP4]] to <4 x i32>*
; CHECK-NEXT:    [[WIDE_LOAD5:%.*]] = load <4 x i32>, <4 x i32>* [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, i32* [[TMP0]], i64 12
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast i32* [[TMP6]] to <4 x i32>*
; CHECK-NEXT:    [[WIDE_LOAD6:%.*]] = load <4 x i32>, <4 x i32>* [[TMP7]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[WIDE_LOAD]])
; CHECK-NEXT:    [[TMP9]] = add i32 [[TMP8]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP10:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[WIDE_LOAD4]])
; CHECK-NEXT:    [[TMP11]] = add i32 [[TMP10]], [[VEC_PHI1]]
; CHECK-NEXT:    [[TMP12:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[WIDE_LOAD5]])
; CHECK-NEXT:    [[TMP13]] = add i32 [[TMP12]], [[VEC_PHI2]]
; CHECK-NEXT:    [[TMP14:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[WIDE_LOAD6]])
; CHECK-NEXT:    [[TMP15]] = add i32 [[TMP14]], [[VEC_PHI3]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP16:%.*]] = icmp eq i64 [[INDEX_NEXT]], 256
; CHECK-NEXT:    br i1 [[TMP16]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop !0
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add i32 [[TMP11]], [[TMP9]]
; CHECK-NEXT:    [[BIN_RDX7:%.*]] = add i32 [[TMP13]], [[BIN_RDX]]
; CHECK-NEXT:    [[BIN_RDX8:%.*]] = add i32 [[TMP15]], [[BIN_RDX7]]
; CHECK-NEXT:    br i1 true, label [[DOT_CRIT_EDGE:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[DOTLR_PH:%.*]]
; CHECK:       .lr.ph:
; CHECK-NEXT:    br i1 undef, label [[DOT_CRIT_EDGE]], label [[DOTLR_PH]], !llvm.loop !2
; CHECK:       ._crit_edge:
; CHECK-NEXT:    [[SUM_0_LCSSA:%.*]] = phi i32 [ undef, [[DOTLR_PH]] ], [ [[BIN_RDX8]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[SUM_0_LCSSA]]
;
entry:
  br label %.lr.ph

.lr.ph:                                           ; preds = %entry, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %entry ]
  %sum.02 = phi i32 [ %l7, %.lr.ph ], [ 0, %entry ]
  %l2 = getelementptr inbounds i32, i32* %A, i64 %indvars.iv
  %l3 = load i32, i32* %l2, align 4
  %l7 = add i32 %sum.02, %l3
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, 256
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph
  %sum.0.lcssa = phi i32 [ %l7, %.lr.ph ]
  ret i32 %sum.0.lcssa
}

define i32 @predicated(i32* noalias nocapture %A) {
; CHECK-LABEL: @predicated(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[PRED_LOAD_CONTINUE36:%.*]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[PRED_LOAD_CONTINUE36]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[TMP101:%.*]], [[PRED_LOAD_CONTINUE36]] ]
; CHECK-NEXT:    [[VEC_PHI4:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[TMP104:%.*]], [[PRED_LOAD_CONTINUE36]] ]
; CHECK-NEXT:    [[VEC_PHI5:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[TMP107:%.*]], [[PRED_LOAD_CONTINUE36]] ]
; CHECK-NEXT:    [[VEC_PHI6:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[TMP110:%.*]], [[PRED_LOAD_CONTINUE36]] ]
; CHECK-NEXT:    [[STEP_ADD:%.*]] = add <4 x i64> [[VEC_IND]], <i64 4, i64 4, i64 4, i64 4>
; CHECK-NEXT:    [[STEP_ADD1:%.*]] = add <4 x i64> [[VEC_IND]], <i64 8, i64 8, i64 8, i64 8>
; CHECK-NEXT:    [[STEP_ADD2:%.*]] = add <4 x i64> [[VEC_IND]], <i64 12, i64 12, i64 12, i64 12>
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ult <4 x i64> [[VEC_IND]], <i64 257, i64 257, i64 257, i64 257>
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult <4 x i64> [[STEP_ADD]], <i64 257, i64 257, i64 257, i64 257>
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ult <4 x i64> [[STEP_ADD1]], <i64 257, i64 257, i64 257, i64 257>
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult <4 x i64> [[STEP_ADD2]], <i64 257, i64 257, i64 257, i64 257>
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <4 x i1> [[TMP0]], i32 0
; CHECK-NEXT:    br i1 [[TMP4]], label [[PRED_LOAD_IF:%.*]], label [[PRED_LOAD_CONTINUE:%.*]]
; CHECK:       pred.load.if:
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, i32* [[TMP5]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x i32> undef, i32 [[TMP6]], i32 0
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE]]
; CHECK:       pred.load.continue:
; CHECK-NEXT:    [[TMP8:%.*]] = phi <4 x i32> [ undef, [[VECTOR_BODY]] ], [ [[TMP7]], [[PRED_LOAD_IF]] ]
; CHECK-NEXT:    [[TMP9:%.*]] = extractelement <4 x i1> [[TMP0]], i32 1
; CHECK-NEXT:    br i1 [[TMP9]], label [[PRED_LOAD_IF7:%.*]], label [[PRED_LOAD_CONTINUE8:%.*]]
; CHECK:       pred.load.if7:
; CHECK-NEXT:    [[TMP10:%.*]] = or i64 [[INDEX]], 1
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP10]]
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, i32* [[TMP11]], align 4
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <4 x i32> [[TMP8]], i32 [[TMP12]], i32 1
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE8]]
; CHECK:       pred.load.continue8:
; CHECK-NEXT:    [[TMP14:%.*]] = phi <4 x i32> [ [[TMP8]], [[PRED_LOAD_CONTINUE]] ], [ [[TMP13]], [[PRED_LOAD_IF7]] ]
; CHECK-NEXT:    [[TMP15:%.*]] = extractelement <4 x i1> [[TMP0]], i32 2
; CHECK-NEXT:    br i1 [[TMP15]], label [[PRED_LOAD_IF9:%.*]], label [[PRED_LOAD_CONTINUE10:%.*]]
; CHECK:       pred.load.if9:
; CHECK-NEXT:    [[TMP16:%.*]] = or i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP16]]
; CHECK-NEXT:    [[TMP18:%.*]] = load i32, i32* [[TMP17]], align 4
; CHECK-NEXT:    [[TMP19:%.*]] = insertelement <4 x i32> [[TMP14]], i32 [[TMP18]], i32 2
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE10]]
; CHECK:       pred.load.continue10:
; CHECK-NEXT:    [[TMP20:%.*]] = phi <4 x i32> [ [[TMP14]], [[PRED_LOAD_CONTINUE8]] ], [ [[TMP19]], [[PRED_LOAD_IF9]] ]
; CHECK-NEXT:    [[TMP21:%.*]] = extractelement <4 x i1> [[TMP0]], i32 3
; CHECK-NEXT:    br i1 [[TMP21]], label [[PRED_LOAD_IF11:%.*]], label [[PRED_LOAD_CONTINUE12:%.*]]
; CHECK:       pred.load.if11:
; CHECK-NEXT:    [[TMP22:%.*]] = or i64 [[INDEX]], 3
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP22]]
; CHECK-NEXT:    [[TMP24:%.*]] = load i32, i32* [[TMP23]], align 4
; CHECK-NEXT:    [[TMP25:%.*]] = insertelement <4 x i32> [[TMP20]], i32 [[TMP24]], i32 3
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE12]]
; CHECK:       pred.load.continue12:
; CHECK-NEXT:    [[TMP26:%.*]] = phi <4 x i32> [ [[TMP20]], [[PRED_LOAD_CONTINUE10]] ], [ [[TMP25]], [[PRED_LOAD_IF11]] ]
; CHECK-NEXT:    [[TMP27:%.*]] = extractelement <4 x i1> [[TMP1]], i32 0
; CHECK-NEXT:    br i1 [[TMP27]], label [[PRED_LOAD_IF13:%.*]], label [[PRED_LOAD_CONTINUE14:%.*]]
; CHECK:       pred.load.if13:
; CHECK-NEXT:    [[TMP28:%.*]] = or i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP29:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP28]]
; CHECK-NEXT:    [[TMP30:%.*]] = load i32, i32* [[TMP29]], align 4
; CHECK-NEXT:    [[TMP31:%.*]] = insertelement <4 x i32> undef, i32 [[TMP30]], i32 0
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE14]]
; CHECK:       pred.load.continue14:
; CHECK-NEXT:    [[TMP32:%.*]] = phi <4 x i32> [ undef, [[PRED_LOAD_CONTINUE12]] ], [ [[TMP31]], [[PRED_LOAD_IF13]] ]
; CHECK-NEXT:    [[TMP33:%.*]] = extractelement <4 x i1> [[TMP1]], i32 1
; CHECK-NEXT:    br i1 [[TMP33]], label [[PRED_LOAD_IF15:%.*]], label [[PRED_LOAD_CONTINUE16:%.*]]
; CHECK:       pred.load.if15:
; CHECK-NEXT:    [[TMP34:%.*]] = or i64 [[INDEX]], 5
; CHECK-NEXT:    [[TMP35:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP34]]
; CHECK-NEXT:    [[TMP36:%.*]] = load i32, i32* [[TMP35]], align 4
; CHECK-NEXT:    [[TMP37:%.*]] = insertelement <4 x i32> [[TMP32]], i32 [[TMP36]], i32 1
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE16]]
; CHECK:       pred.load.continue16:
; CHECK-NEXT:    [[TMP38:%.*]] = phi <4 x i32> [ [[TMP32]], [[PRED_LOAD_CONTINUE14]] ], [ [[TMP37]], [[PRED_LOAD_IF15]] ]
; CHECK-NEXT:    [[TMP39:%.*]] = extractelement <4 x i1> [[TMP1]], i32 2
; CHECK-NEXT:    br i1 [[TMP39]], label [[PRED_LOAD_IF17:%.*]], label [[PRED_LOAD_CONTINUE18:%.*]]
; CHECK:       pred.load.if17:
; CHECK-NEXT:    [[TMP40:%.*]] = or i64 [[INDEX]], 6
; CHECK-NEXT:    [[TMP41:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP40]]
; CHECK-NEXT:    [[TMP42:%.*]] = load i32, i32* [[TMP41]], align 4
; CHECK-NEXT:    [[TMP43:%.*]] = insertelement <4 x i32> [[TMP38]], i32 [[TMP42]], i32 2
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE18]]
; CHECK:       pred.load.continue18:
; CHECK-NEXT:    [[TMP44:%.*]] = phi <4 x i32> [ [[TMP38]], [[PRED_LOAD_CONTINUE16]] ], [ [[TMP43]], [[PRED_LOAD_IF17]] ]
; CHECK-NEXT:    [[TMP45:%.*]] = extractelement <4 x i1> [[TMP1]], i32 3
; CHECK-NEXT:    br i1 [[TMP45]], label [[PRED_LOAD_IF19:%.*]], label [[PRED_LOAD_CONTINUE20:%.*]]
; CHECK:       pred.load.if19:
; CHECK-NEXT:    [[TMP46:%.*]] = or i64 [[INDEX]], 7
; CHECK-NEXT:    [[TMP47:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP46]]
; CHECK-NEXT:    [[TMP48:%.*]] = load i32, i32* [[TMP47]], align 4
; CHECK-NEXT:    [[TMP49:%.*]] = insertelement <4 x i32> [[TMP44]], i32 [[TMP48]], i32 3
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE20]]
; CHECK:       pred.load.continue20:
; CHECK-NEXT:    [[TMP50:%.*]] = phi <4 x i32> [ [[TMP44]], [[PRED_LOAD_CONTINUE18]] ], [ [[TMP49]], [[PRED_LOAD_IF19]] ]
; CHECK-NEXT:    [[TMP51:%.*]] = extractelement <4 x i1> [[TMP2]], i32 0
; CHECK-NEXT:    br i1 [[TMP51]], label [[PRED_LOAD_IF21:%.*]], label [[PRED_LOAD_CONTINUE22:%.*]]
; CHECK:       pred.load.if21:
; CHECK-NEXT:    [[TMP52:%.*]] = or i64 [[INDEX]], 8
; CHECK-NEXT:    [[TMP53:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP52]]
; CHECK-NEXT:    [[TMP54:%.*]] = load i32, i32* [[TMP53]], align 4
; CHECK-NEXT:    [[TMP55:%.*]] = insertelement <4 x i32> undef, i32 [[TMP54]], i32 0
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE22]]
; CHECK:       pred.load.continue22:
; CHECK-NEXT:    [[TMP56:%.*]] = phi <4 x i32> [ undef, [[PRED_LOAD_CONTINUE20]] ], [ [[TMP55]], [[PRED_LOAD_IF21]] ]
; CHECK-NEXT:    [[TMP57:%.*]] = extractelement <4 x i1> [[TMP2]], i32 1
; CHECK-NEXT:    br i1 [[TMP57]], label [[PRED_LOAD_IF23:%.*]], label [[PRED_LOAD_CONTINUE24:%.*]]
; CHECK:       pred.load.if23:
; CHECK-NEXT:    [[TMP58:%.*]] = or i64 [[INDEX]], 9
; CHECK-NEXT:    [[TMP59:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP58]]
; CHECK-NEXT:    [[TMP60:%.*]] = load i32, i32* [[TMP59]], align 4
; CHECK-NEXT:    [[TMP61:%.*]] = insertelement <4 x i32> [[TMP56]], i32 [[TMP60]], i32 1
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE24]]
; CHECK:       pred.load.continue24:
; CHECK-NEXT:    [[TMP62:%.*]] = phi <4 x i32> [ [[TMP56]], [[PRED_LOAD_CONTINUE22]] ], [ [[TMP61]], [[PRED_LOAD_IF23]] ]
; CHECK-NEXT:    [[TMP63:%.*]] = extractelement <4 x i1> [[TMP2]], i32 2
; CHECK-NEXT:    br i1 [[TMP63]], label [[PRED_LOAD_IF25:%.*]], label [[PRED_LOAD_CONTINUE26:%.*]]
; CHECK:       pred.load.if25:
; CHECK-NEXT:    [[TMP64:%.*]] = or i64 [[INDEX]], 10
; CHECK-NEXT:    [[TMP65:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP64]]
; CHECK-NEXT:    [[TMP66:%.*]] = load i32, i32* [[TMP65]], align 4
; CHECK-NEXT:    [[TMP67:%.*]] = insertelement <4 x i32> [[TMP62]], i32 [[TMP66]], i32 2
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE26]]
; CHECK:       pred.load.continue26:
; CHECK-NEXT:    [[TMP68:%.*]] = phi <4 x i32> [ [[TMP62]], [[PRED_LOAD_CONTINUE24]] ], [ [[TMP67]], [[PRED_LOAD_IF25]] ]
; CHECK-NEXT:    [[TMP69:%.*]] = extractelement <4 x i1> [[TMP2]], i32 3
; CHECK-NEXT:    br i1 [[TMP69]], label [[PRED_LOAD_IF27:%.*]], label [[PRED_LOAD_CONTINUE28:%.*]]
; CHECK:       pred.load.if27:
; CHECK-NEXT:    [[TMP70:%.*]] = or i64 [[INDEX]], 11
; CHECK-NEXT:    [[TMP71:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP70]]
; CHECK-NEXT:    [[TMP72:%.*]] = load i32, i32* [[TMP71]], align 4
; CHECK-NEXT:    [[TMP73:%.*]] = insertelement <4 x i32> [[TMP68]], i32 [[TMP72]], i32 3
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE28]]
; CHECK:       pred.load.continue28:
; CHECK-NEXT:    [[TMP74:%.*]] = phi <4 x i32> [ [[TMP68]], [[PRED_LOAD_CONTINUE26]] ], [ [[TMP73]], [[PRED_LOAD_IF27]] ]
; CHECK-NEXT:    [[TMP75:%.*]] = extractelement <4 x i1> [[TMP3]], i32 0
; CHECK-NEXT:    br i1 [[TMP75]], label [[PRED_LOAD_IF29:%.*]], label [[PRED_LOAD_CONTINUE30:%.*]]
; CHECK:       pred.load.if29:
; CHECK-NEXT:    [[TMP76:%.*]] = or i64 [[INDEX]], 12
; CHECK-NEXT:    [[TMP77:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP76]]
; CHECK-NEXT:    [[TMP78:%.*]] = load i32, i32* [[TMP77]], align 4
; CHECK-NEXT:    [[TMP79:%.*]] = insertelement <4 x i32> undef, i32 [[TMP78]], i32 0
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE30]]
; CHECK:       pred.load.continue30:
; CHECK-NEXT:    [[TMP80:%.*]] = phi <4 x i32> [ undef, [[PRED_LOAD_CONTINUE28]] ], [ [[TMP79]], [[PRED_LOAD_IF29]] ]
; CHECK-NEXT:    [[TMP81:%.*]] = extractelement <4 x i1> [[TMP3]], i32 1
; CHECK-NEXT:    br i1 [[TMP81]], label [[PRED_LOAD_IF31:%.*]], label [[PRED_LOAD_CONTINUE32:%.*]]
; CHECK:       pred.load.if31:
; CHECK-NEXT:    [[TMP82:%.*]] = or i64 [[INDEX]], 13
; CHECK-NEXT:    [[TMP83:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP82]]
; CHECK-NEXT:    [[TMP84:%.*]] = load i32, i32* [[TMP83]], align 4
; CHECK-NEXT:    [[TMP85:%.*]] = insertelement <4 x i32> [[TMP80]], i32 [[TMP84]], i32 1
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE32]]
; CHECK:       pred.load.continue32:
; CHECK-NEXT:    [[TMP86:%.*]] = phi <4 x i32> [ [[TMP80]], [[PRED_LOAD_CONTINUE30]] ], [ [[TMP85]], [[PRED_LOAD_IF31]] ]
; CHECK-NEXT:    [[TMP87:%.*]] = extractelement <4 x i1> [[TMP3]], i32 2
; CHECK-NEXT:    br i1 [[TMP87]], label [[PRED_LOAD_IF33:%.*]], label [[PRED_LOAD_CONTINUE34:%.*]]
; CHECK:       pred.load.if33:
; CHECK-NEXT:    [[TMP88:%.*]] = or i64 [[INDEX]], 14
; CHECK-NEXT:    [[TMP89:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP88]]
; CHECK-NEXT:    [[TMP90:%.*]] = load i32, i32* [[TMP89]], align 4
; CHECK-NEXT:    [[TMP91:%.*]] = insertelement <4 x i32> [[TMP86]], i32 [[TMP90]], i32 2
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE34]]
; CHECK:       pred.load.continue34:
; CHECK-NEXT:    [[TMP92:%.*]] = phi <4 x i32> [ [[TMP86]], [[PRED_LOAD_CONTINUE32]] ], [ [[TMP91]], [[PRED_LOAD_IF33]] ]
; CHECK-NEXT:    [[TMP93:%.*]] = extractelement <4 x i1> [[TMP3]], i32 3
; CHECK-NEXT:    br i1 [[TMP93]], label [[PRED_LOAD_IF35:%.*]], label [[PRED_LOAD_CONTINUE36]]
; CHECK:       pred.load.if35:
; CHECK-NEXT:    [[TMP94:%.*]] = or i64 [[INDEX]], 15
; CHECK-NEXT:    [[TMP95:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[TMP94]]
; CHECK-NEXT:    [[TMP96:%.*]] = load i32, i32* [[TMP95]], align 4
; CHECK-NEXT:    [[TMP97:%.*]] = insertelement <4 x i32> [[TMP92]], i32 [[TMP96]], i32 3
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE36]]
; CHECK:       pred.load.continue36:
; CHECK-NEXT:    [[TMP98:%.*]] = phi <4 x i32> [ [[TMP92]], [[PRED_LOAD_CONTINUE34]] ], [ [[TMP97]], [[PRED_LOAD_IF35]] ]
; CHECK-NEXT:    [[TMP99:%.*]] = select <4 x i1> [[TMP0]], <4 x i32> [[TMP26]], <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP100:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP99]])
; CHECK-NEXT:    [[TMP101]] = add i32 [[TMP100]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP102:%.*]] = select <4 x i1> [[TMP1]], <4 x i32> [[TMP50]], <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP103:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP102]])
; CHECK-NEXT:    [[TMP104]] = add i32 [[TMP103]], [[VEC_PHI4]]
; CHECK-NEXT:    [[TMP105:%.*]] = select <4 x i1> [[TMP2]], <4 x i32> [[TMP74]], <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP106:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP105]])
; CHECK-NEXT:    [[TMP107]] = add i32 [[TMP106]], [[VEC_PHI5]]
; CHECK-NEXT:    [[TMP108:%.*]] = select <4 x i1> [[TMP3]], <4 x i32> [[TMP98]], <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP109:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP108]])
; CHECK-NEXT:    [[TMP110]] = add i32 [[TMP109]], [[VEC_PHI6]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], 16
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i64> [[VEC_IND]], <i64 16, i64 16, i64 16, i64 16>
; CHECK-NEXT:    [[TMP111:%.*]] = icmp eq i64 [[INDEX_NEXT]], 272
; CHECK-NEXT:    br i1 [[TMP111]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop !4
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add i32 [[TMP104]], [[TMP101]]
; CHECK-NEXT:    [[BIN_RDX37:%.*]] = add i32 [[TMP107]], [[BIN_RDX]]
; CHECK-NEXT:    [[BIN_RDX38:%.*]] = add i32 [[TMP110]], [[BIN_RDX37]]
; CHECK-NEXT:    br i1 true, label [[DOT_CRIT_EDGE:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[DOTLR_PH:%.*]]
; CHECK:       .lr.ph:
; CHECK-NEXT:    br i1 undef, label [[DOT_CRIT_EDGE]], label [[DOTLR_PH]], !llvm.loop !5
; CHECK:       ._crit_edge:
; CHECK-NEXT:    [[SUM_0_LCSSA:%.*]] = phi i32 [ undef, [[DOTLR_PH]] ], [ [[BIN_RDX38]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[SUM_0_LCSSA]]
;
entry:
  br label %.lr.ph

.lr.ph:                                           ; preds = %entry, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %entry ]
  %sum.02 = phi i32 [ %l7, %.lr.ph ], [ 0, %entry ]
  %l2 = getelementptr inbounds i32, i32* %A, i64 %indvars.iv
  %l3 = load i32, i32* %l2, align 4
  %l7 = add i32 %sum.02, %l3
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, 257
  br i1 %exitcond, label %._crit_edge, label %.lr.ph, !llvm.loop !6

._crit_edge:                                      ; preds = %.lr.ph
  %sum.0.lcssa = phi i32 [ %l7, %.lr.ph ]
  ret i32 %sum.0.lcssa
}

!6 = distinct !{!6, !7, !8}
!7 = !{!"llvm.loop.vectorize.predicate.enable", i1 true}
!8 = !{!"llvm.loop.vectorize.enable", i1 true}
