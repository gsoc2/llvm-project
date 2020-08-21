; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-idiom -S %s | FileCheck %s

; Make sure we do not delete instructions not inserted during expansion, e.g.
; because the expande re-used existing instructions.

define void @test(i64 %init, float* %ptr) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header:
; CHECK-NEXT:    [[J_0:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[OUTER_LATCH:%.*]] ]
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[ADD:%.*]], [[OUTER_LATCH]] ]
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds float, float* [[PTR:%.*]], i32 [[I_0]]
; CHECK-NEXT:    br label [[INNER:%.*]]
; CHECK:       inner:
; CHECK-NEXT:    [[INNER_IV:%.*]] = phi i64 [ [[INNER_IV_NEXT:%.*]], [[INNER]] ], [ [[INIT:%.*]], [[OUTER_HEADER]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, float* [[PTR]], i64 [[INNER_IV]]
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast float* [[ARRAYIDX]] to i32*
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[TMP0]], align 4
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds float, float* [[ADD_PTR]], i64 [[INNER_IV]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast float* [[ARRAYIDX3]] to i32*
; CHECK-NEXT:    store i32 [[TMP1]], i32* [[TMP2]], align 4
; CHECK-NEXT:    [[INNER_IV_NEXT]] = add nsw i64 [[INNER_IV]], 1
; CHECK-NEXT:    [[EC_1:%.*]] = icmp eq i64 [[INNER_IV_NEXT]], 0
; CHECK-NEXT:    br i1 [[EC_1]], label [[OUTER_LATCH]], label [[INNER]]
; CHECK:       outer.latch:
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[J_0]], 1
; CHECK-NEXT:    [[ADD]] = add nuw nsw i32 [[I_0]], [[INC]]
; CHECK-NEXT:    [[EC_2:%.*]] = icmp eq i32 [[ADD]], 4000
; CHECK-NEXT:    br i1 [[EC_2]], label [[EXIT:%.*]], label [[OUTER_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %outer.header

outer.header:
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %outer.latch ]
  %i.0 = phi i32 [ 0, %entry ], [ %add, %outer.latch ]
  %add.ptr = getelementptr inbounds float, float* %ptr, i32 %i.0
  br label %inner

inner:
  %inner.iv = phi i64 [ %inner.iv.next, %inner ], [ %init, %outer.header ]
  %arrayidx = getelementptr inbounds float, float* %ptr, i64 %inner.iv
  %0 = bitcast float* %arrayidx to i32*
  %1 = load i32, i32* %0, align 4
  %arrayidx3 = getelementptr inbounds float, float* %add.ptr, i64 %inner.iv
  %2 = bitcast float* %arrayidx3 to i32*
  store i32 %1, i32* %2, align 4
  %inner.iv.next = add nsw i64 %inner.iv, 1
  %ec.1 = icmp eq i64 %inner.iv.next, 0
  br i1 %ec.1, label %outer.latch, label %inner

outer.latch:
  %inc = add nuw nsw i32 %j.0, 1
  %add = add nuw nsw i32 %i.0, %inc
  %ec.2 = icmp eq i32 %add, 4000
  br i1 %ec.2, label %exit, label %outer.header

exit:
  ret void
}
