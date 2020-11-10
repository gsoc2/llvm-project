; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -O1                   -enable-knowledge-retention -S < %s  | FileCheck %s
; RUN: opt -passes='default<O1>' -enable-knowledge-retention -S < %s  | FileCheck %s

%0 = type { %0* }

define %0* @f1() local_unnamed_addr {
; CHECK-LABEL: @f1(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB3:%.*]]
; CHECK:       bb3:
; CHECK-NEXT:    [[I1:%.*]] = phi %0* [ [[I5:%.*]], [[BB3]] ], [ undef, [[BB:%.*]] ]
; CHECK-NEXT:    call void @llvm.assume(i1 true) [ "nonnull"(%0* [[I1]]) ]
; CHECK-NEXT:    [[I4:%.*]] = getelementptr inbounds [[TMP0:%.*]], %0* [[I1]], i64 0, i32 0
; CHECK-NEXT:    [[I5]] = load %0*, %0** [[I4]], align 8
; CHECK-NEXT:    [[I2:%.*]] = icmp eq %0* [[I5]], null
; CHECK-NEXT:    br i1 [[I2]], label [[BB6:%.*]], label [[BB3]]
; CHECK:       bb6:
; CHECK-NEXT:    ret %0* undef
;
bb:
  br label %bb1

bb1:
  %i = phi %0* [ undef, %bb ], [ %i5, %bb3 ]
  %i2 = icmp eq %0* %i, null
  br i1 %i2, label %bb6, label %bb3

bb3:
  call void @llvm.assume(i1 true) [ "nonnull"(%0* %i) ]
  %i4 = getelementptr inbounds %0, %0* %i, i64 0, i32 0
  %i5 = load %0*, %0** %i4, align 8
  br label %bb1

bb6:
  ret %0* undef
}

declare void @llvm.assume(i1)
