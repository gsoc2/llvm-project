; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

define i1 @is_pow2or0_negate_op(i32 %x) {
; CHECK-LABEL: @is_pow2or0_negate_op(
; CHECK-NEXT:    [[NEG:%.*]] = sub i32 0, [[X:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[NEG]], [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %neg = sub i32 0, %x
  %and = and i32 %neg, %x
  %cmp = icmp eq i32 %and, %x
  ret i1 %cmp
}

define <2 x i1> @is_pow2or0_negate_op_vec(<2 x i32> %x) {
; CHECK-LABEL: @is_pow2or0_negate_op_vec(
; CHECK-NEXT:    [[NEG:%.*]] = sub <2 x i32> zeroinitializer, [[X:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and <2 x i32> [[NEG]], [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x i32> [[AND]], [[X]]
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %neg = sub <2 x i32> zeroinitializer, %x
  %and = and <2 x i32> %neg, %x
  %cmp = icmp eq <2 x i32> %and, %x
  ret <2 x i1> %cmp
}

define i1 @is_pow2or0_decrement_op(i8 %x) {
; CHECK-LABEL: @is_pow2or0_decrement_op(
; CHECK-NEXT:    [[DEC:%.*]] = add i8 [[X:%.*]], -1
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[DEC]], [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[AND]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %dec = add i8 %x, -1
  %and = and i8 %dec, %x
  %cmp = icmp eq i8 %and, 0
  ret i1 %cmp
}

define <2 x i1> @is_pow2or0_decrement_op_vec(<2 x i8> %x) {
; CHECK-LABEL: @is_pow2or0_decrement_op_vec(
; CHECK-NEXT:    [[DEC:%.*]] = add <2 x i8> [[X:%.*]], <i8 -1, i8 -1>
; CHECK-NEXT:    [[AND:%.*]] = and <2 x i8> [[DEC]], [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x i8> [[AND]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %dec = add <2 x i8> %x, <i8 -1, i8 -1>
  %and = and <2 x i8> %dec, %x
  %cmp = icmp eq <2 x i8> %and, zeroinitializer
  ret <2 x i1> %cmp
}

define i1 @isnot_pow2or0_negate_op(i32 %x) {
; CHECK-LABEL: @isnot_pow2or0_negate_op(
; CHECK-NEXT:    [[NEG:%.*]] = sub i32 0, [[X:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[NEG]], [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[AND]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %neg = sub i32 0, %x
  %and = and i32 %neg, %x
  %cmp = icmp ne i32 %and, %x
  ret i1 %cmp
}

define <2 x i1> @isnot_pow2or0_negate_op_vec(<2 x i32> %x) {
; CHECK-LABEL: @isnot_pow2or0_negate_op_vec(
; CHECK-NEXT:    [[NEG:%.*]] = sub <2 x i32> zeroinitializer, [[X:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and <2 x i32> [[NEG]], [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne <2 x i32> [[AND]], [[X]]
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %neg = sub <2 x i32> zeroinitializer, %x
  %and = and <2 x i32> %neg, %x
  %cmp = icmp ne <2 x i32> %and, %x
  ret <2 x i1> %cmp
}

define i1 @isnot_pow2or0_decrement_op(i8 %x) {
; CHECK-LABEL: @isnot_pow2or0_decrement_op(
; CHECK-NEXT:    [[DEC:%.*]] = add i8 [[X:%.*]], -1
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[DEC]], [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[AND]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %dec = add i8 %x, -1
  %and = and i8 %dec, %x
  %cmp = icmp ne i8 %and, 0
  ret i1 %cmp
}

define <2 x i1> @isnot_pow2or0_decrement_op_vec(<2 x i8> %x) {
; CHECK-LABEL: @isnot_pow2or0_decrement_op_vec(
; CHECK-NEXT:    [[DEC:%.*]] = add <2 x i8> [[X:%.*]], <i8 -1, i8 -1>
; CHECK-NEXT:    [[AND:%.*]] = and <2 x i8> [[DEC]], [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne <2 x i8> [[AND]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %dec = add <2 x i8> %x, <i8 -1, i8 -1>
  %and = and <2 x i8> %dec, %x
  %cmp = icmp ne <2 x i8> %and, zeroinitializer
  ret <2 x i1> %cmp
}

define i1 @is_pow2or0_negate_op_commute1(i32 %p) {
; CHECK-LABEL: @is_pow2or0_negate_op_commute1(
; CHECK-NEXT:    [[X:%.*]] = srem i32 42, [[P:%.*]]
; CHECK-NEXT:    [[NEG:%.*]] = sub nsw i32 0, [[X]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X]], [[NEG]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x = srem i32 42, %p ; thwart complexity-based canonicalization
  %neg = sub i32 0, %x
  %and = and i32 %x, %neg
  %cmp = icmp eq i32 %and, %x
  ret i1 %cmp
}

; x can't be <= complexity of the 'neg' but >= complexity of the 'and'.

define i1 @isnot_pow2or0_negate_op_commute2(i32 %p) {
; CHECK-LABEL: @isnot_pow2or0_negate_op_commute2(
; CHECK-NEXT:    [[X:%.*]] = urem i32 42, [[P:%.*]]
; CHECK-NEXT:    [[NEG:%.*]] = sub nsw i32 0, [[X]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X]], [[NEG]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[X]], [[AND]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x = urem i32 42, %p ; thwart complexity-based canonicalization
  %neg = sub i32 0, %x
  %and = and i32 %neg, %x
  %cmp = icmp ne i32 %x, %and
  ret i1 %cmp
}

define i1 @isnot_pow2or0_negate_op_commute3(i32 %p) {
; CHECK-LABEL: @isnot_pow2or0_negate_op_commute3(
; CHECK-NEXT:    [[X:%.*]] = urem i32 42, [[P:%.*]]
; CHECK-NEXT:    [[NEG:%.*]] = sub nsw i32 0, [[X]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X]], [[NEG]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[X]], [[AND]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x = urem i32 42, %p ; thwart complexity-based canonicalization
  %neg = sub i32 0, %x
  %and = and i32 %x, %neg
  %cmp = icmp ne i32 %x, %and
  ret i1 %cmp
}

declare void @use(i32)

define i1 @is_pow2or0_negate_op_extra_use1(i32 %x) {
; CHECK-LABEL: @is_pow2or0_negate_op_extra_use1(
; CHECK-NEXT:    [[NEG:%.*]] = sub i32 0, [[X:%.*]]
; CHECK-NEXT:    call void @use(i32 [[NEG]])
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[NEG]], [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %neg = sub i32 0, %x
  call void @use(i32 %neg)
  %and = and i32 %neg, %x
  %cmp = icmp eq i32 %and, %x
  ret i1 %cmp
}

define i1 @is_pow2or0_negate_op_extra_use2(i32 %x) {
; CHECK-LABEL: @is_pow2or0_negate_op_extra_use2(
; CHECK-NEXT:    [[NEG:%.*]] = sub i32 0, [[X:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[NEG]], [[X]]
; CHECK-NEXT:    call void @use(i32 [[AND]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %neg = sub i32 0, %x
  %and = and i32 %neg, %x
  call void @use(i32 %and)
  %cmp = icmp eq i32 %and, %x
  ret i1 %cmp
}
