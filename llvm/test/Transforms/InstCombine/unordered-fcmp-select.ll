; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

define float @select_max_ugt(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_max_ugt(
; CHECK-NEXT:    [[CMP_INV:%.*]] = fcmp arcp ole float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_INV]], float [[B]], float [[A]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp arcp ugt float %a, %b
  %sel = select arcp i1 %cmp, float %a, float %b
  ret float %sel
}

define float @select_max_uge(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_max_uge(
; CHECK-NEXT:    [[CMP_INV:%.*]] = fcmp nnan olt float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_INV]], float [[B]], float [[A]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp nnan uge float %a, %b
  %sel = select ninf i1 %cmp, float %a, float %b
  ret float %sel
}

define float @select_min_ugt(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_min_ugt(
; CHECK-NEXT:    [[CMP_INV:%.*]] = fcmp fast ole float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_INV]], float [[A]], float [[B]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp fast ugt float %a, %b
  %sel = select reassoc i1 %cmp, float %b, float %a
  ret float %sel
}

define float @select_min_uge(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_min_uge(
; CHECK-NEXT:    [[CMP_INV:%.*]] = fcmp nsz olt float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_INV]], float [[A]], float [[B]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp nsz uge float %a, %b
  %sel = select fast i1 %cmp, float %b, float %a
  ret float %sel
}

define float @select_max_ult(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_max_ult(
; CHECK-NEXT:    [[CMP_INV:%.*]] = fcmp arcp oge float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_INV]], float [[A]], float [[B]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp arcp ult float %a, %b
  %sel = select ninf nnan i1 %cmp, float %b, float %a
  ret float %sel
}

define float @select_max_ule(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_max_ule(
; CHECK-NEXT:    [[CMP_INV:%.*]] = fcmp fast ogt float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_INV]], float [[A]], float [[B]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp fast ule float %a, %b
  %sel = select nsz i1 %cmp, float %b, float %a
  ret float %sel
}

define float @select_min_ult(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_min_ult(
; CHECK-NEXT:    [[CMP_INV:%.*]] = fcmp nsz oge float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_INV]], float [[B]], float [[A]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp nsz ult float %a, %b
  %sel = select fast i1 %cmp, float %a, float %b
  ret float %sel
}

define float @select_min_ule(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_min_ule(
; CHECK-NEXT:    [[CMP_INV:%.*]] = fcmp arcp ogt float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_INV]], float [[B]], float [[A]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp arcp ule float %a, %b
  %sel = select ninf i1 %cmp, float %a, float %b
  ret float %sel
}

define float @select_fcmp_une(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_fcmp_une(
; CHECK-NEXT:    [[CMP_INV:%.*]] = fcmp reassoc oeq float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_INV]], float [[B]], float [[A]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp reassoc une float %a, %b
  %sel = select nnan i1 %cmp, float %a, float %b
  ret float %sel
}

define float @select_fcmp_ueq(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_fcmp_ueq(
; CHECK-NEXT:    [[CMP_INV:%.*]] = fcmp reassoc one float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_INV]], float [[B]], float [[A]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp reassoc ueq float %a, %b
  %sel = select arcp nnan i1 %cmp, float %a, float %b
  ret float %sel
}

declare void @foo(i1)

define float @select_max_ugt_2_use_cmp(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_max_ugt_2_use_cmp(
; CHECK-NEXT:    [[CMP:%.*]] = fcmp reassoc ugt float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    call void @foo(i1 [[CMP]])
; CHECK-NEXT:    [[SEL:%.*]] = select fast i1 [[CMP]], float [[A]], float [[B]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp reassoc ugt float %a, %b
  call void @foo(i1 %cmp)
  %sel = select fast i1 %cmp, float %a, float %b
  ret float %sel
}

define float @select_min_uge_2_use_cmp(float %a, float %b) {
; CHECK-LABEL: define {{[^@]+}}@select_min_uge_2_use_cmp(
; CHECK-NEXT:    [[CMP:%.*]] = fcmp ninf uge float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    call void @foo(i1 [[CMP]])
; CHECK-NEXT:    [[SEL:%.*]] = select nsz i1 [[CMP]], float [[B]], float [[A]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %cmp = fcmp ninf uge float %a, %b
  call void @foo(i1 %cmp)
  %sel = select nsz i1 %cmp, float %b, float %a
  ret float %sel
}
