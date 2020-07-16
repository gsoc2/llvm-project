; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -analyze -enable-new-pm=0 -scalar-evolution -scalar-evolution-classify-expressions=0 2>&1 | FileCheck %s
; RUN: opt < %s -disable-output "-passes=print<scalar-evolution>" -scalar-evolution-classify-expressions=0 2>&1 2>&1 | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @unsimplified_and1(i32 %n) {
; CHECK-LABEL: 'unsimplified_and1'
; CHECK-NEXT:  Determining loop execution counts for: @unsimplified_and1
; CHECK-NEXT:  Loop %loop: backedge-taken count is %n
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %n
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ule i32 %iv.inc, %n
  %and = and i1 %becond, true
  br i1 %and, label %loop, label %leave

leave:
  ret void
}

define void @unsimplified_and2(i32 %n) {
; CHECK-LABEL: 'unsimplified_and2'
; CHECK-NEXT:  Determining loop execution counts for: @unsimplified_and2
; CHECK-NEXT:  Loop %loop: backedge-taken count is %n
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %n
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ule i32 %iv.inc, %n
  %and = and i1 true, %becond
  br i1 %and, label %loop, label %leave

leave:
  ret void
}

define void @unsimplified_and3(i32 %n) {
; CHECK-LABEL: 'unsimplified_and3'
; CHECK-NEXT:  Determining loop execution counts for: @unsimplified_and3
; CHECK-NEXT:  Loop %loop: backedge-taken count is false
; CHECK-NEXT:  Loop %loop: max backedge-taken count is false
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is false
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ule i32 %iv.inc, %n
  %and = and i1 false, %becond
  br i1 %and, label %loop, label %leave

leave:
  ret void
}

define void @unsimplified_and4(i32 %n) {
; CHECK-LABEL: 'unsimplified_and4'
; CHECK-NEXT:  Determining loop execution counts for: @unsimplified_and4
; CHECK-NEXT:  Loop %loop: backedge-taken count is false
; CHECK-NEXT:  Loop %loop: max backedge-taken count is false
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is false
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ule i32 %iv.inc, %n
  %and = and i1 %becond, false
  br i1 %and, label %loop, label %leave

leave:
  ret void
}

define void @unsimplified_or1(i32 %n) {
; CHECK-LABEL: 'unsimplified_or1'
; CHECK-NEXT:  Determining loop execution counts for: @unsimplified_or1
; CHECK-NEXT:  Loop %loop: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable predicated backedge-taken count.
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ule i32 %iv.inc, %n
  %or = or i1 %becond, true
  br i1 %or, label %loop, label %leave

leave:
  ret void
}

define void @unsimplified_or2(i32 %n) {
; CHECK-LABEL: 'unsimplified_or2'
; CHECK-NEXT:  Determining loop execution counts for: @unsimplified_or2
; CHECK-NEXT:  Loop %loop: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable predicated backedge-taken count.
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ule i32 %iv.inc, %n
  %or = or i1 true, %becond
  br i1 %or, label %loop, label %leave

leave:
  ret void
}

define void @unsimplified_or3(i32 %n) {
; CHECK-LABEL: 'unsimplified_or3'
; CHECK-NEXT:  Determining loop execution counts for: @unsimplified_or3
; CHECK-NEXT:  Loop %loop: backedge-taken count is %n
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %n
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ule i32 %iv.inc, %n
  %or = or i1 false, %becond
  br i1 %or, label %loop, label %leave

leave:
  ret void
}

define void @unsimplified_or4(i32 %n) {
; CHECK-LABEL: 'unsimplified_or4'
; CHECK-NEXT:  Determining loop execution counts for: @unsimplified_or4
; CHECK-NEXT:  Loop %loop: backedge-taken count is %n
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %n
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ule i32 %iv.inc, %n
  %or = or i1 %becond, false
  br i1 %or, label %loop, label %leave

leave:
  ret void
}

define void @reversed_and1(i32 %n) {
; CHECK-LABEL: 'reversed_and1'
; CHECK-NEXT:  Determining loop execution counts for: @reversed_and1
; CHECK-NEXT:  Loop %loop: backedge-taken count is %n
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %n
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ugt i32 %iv.inc, %n
  %and = and i1 %becond, true
  br i1 %and, label %leave, label %loop

leave:
  ret void
}

define void @reversed_and2(i32 %n) {
; CHECK-LABEL: 'reversed_and2'
; CHECK-NEXT:  Determining loop execution counts for: @reversed_and2
; CHECK-NEXT:  Loop %loop: backedge-taken count is %n
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %n
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ugt i32 %iv.inc, %n
  %and = and i1 true, %becond
  br i1 %and, label %leave, label %loop

leave:
  ret void
}

define void @reversed_and3(i32 %n) {
; CHECK-LABEL: 'reversed_and3'
; CHECK-NEXT:  Determining loop execution counts for: @reversed_and3
; CHECK-NEXT:  Loop %loop: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable predicated backedge-taken count.
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ugt i32 %iv.inc, %n
  %and = and i1 false, %becond
  br i1 %and, label %leave, label %loop

leave:
  ret void
}

define void @reversed_and4(i32 %n) {
; CHECK-LABEL: 'reversed_and4'
; CHECK-NEXT:  Determining loop execution counts for: @reversed_and4
; CHECK-NEXT:  Loop %loop: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable predicated backedge-taken count.
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ugt i32 %iv.inc, %n
  %and = and i1 %becond, false
  br i1 %and, label %leave, label %loop

leave:
  ret void
}

define void @reversed_or1(i32 %n) {
; CHECK-LABEL: 'reversed_or1'
; CHECK-NEXT:  Determining loop execution counts for: @reversed_or1
; CHECK-NEXT:  Loop %loop: backedge-taken count is false
; CHECK-NEXT:  Loop %loop: max backedge-taken count is false
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is false
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ugt i32 %iv.inc, %n
  %or = or i1 %becond, true
  br i1 %or, label %leave, label %loop

leave:
  ret void
}

define void @reversed_or2(i32 %n) {
; CHECK-LABEL: 'reversed_or2'
; CHECK-NEXT:  Determining loop execution counts for: @reversed_or2
; CHECK-NEXT:  Loop %loop: backedge-taken count is false
; CHECK-NEXT:  Loop %loop: max backedge-taken count is false
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is false
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ugt i32 %iv.inc, %n
  %or = or i1 true, %becond
  br i1 %or, label %leave, label %loop

leave:
  ret void
}

define void @reversed_or3(i32 %n) {
; CHECK-LABEL: 'reversed_or3'
; CHECK-NEXT:  Determining loop execution counts for: @reversed_or3
; CHECK-NEXT:  Loop %loop: backedge-taken count is %n
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %n
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ugt i32 %iv.inc, %n
  %or = or i1 false, %becond
  br i1 %or, label %leave, label %loop

leave:
  ret void
}

define void @reversed_or4(i32 %n) {
; CHECK-LABEL: 'reversed_or4'
; CHECK-NEXT:  Determining loop execution counts for: @reversed_or4
; CHECK-NEXT:  Loop %loop: backedge-taken count is %n
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %n
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.inc, %loop ]
  %iv.inc = add nsw i32 %iv, 1
  %becond = icmp ugt i32 %iv.inc, %n
  %or = or i1 %becond, false
  br i1 %or, label %leave, label %loop

leave:
  ret void
}
