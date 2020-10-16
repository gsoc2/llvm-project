// RUN: %clang_cc1 -triple riscv32 -emit-llvm %s -o - | FileCheck %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +f -target-abi ilp32f -emit-llvm %s -o - \
// RUN:     | FileCheck %s

// This file contains test cases that will have the same output for the ilp32
// and ilp32f ABIs.

#include <stddef.h>
#include <stdint.h>

struct tiny {
  uint8_t a, b, c, d;
};

struct small {
  int32_t a, *b;
};

struct small_aligned {
  int64_t a;
};

struct large {
  int32_t a, b, c, d;
};

// Scalars passed on the stack should not have signext/zeroext attributes
// (they are anyext).

// CHECK-LABEL: define i32 @f_scalar_stack_1(i32 %a, i64 %b, i32 %c, double %d, fp128 %e, i8 zeroext %f, i8 %g, i8 %h)
int f_scalar_stack_1(int32_t a, int64_t b, int32_t c, double d, long double e,
                     uint8_t f, int8_t g, uint8_t h) {
  return g + h;
}

// Ensure that scalars passed on the stack are still determined correctly in
// the presence of large return values that consume a register due to the need
// to pass a pointer.

// CHECK-LABEL: define void @f_scalar_stack_2(%struct.large* noalias sret(%struct.large) align 4 %agg.result, i32 %a, i64 %b, double %c, fp128 %d, i8 zeroext %e, i8 %f, i8 %g)
struct large f_scalar_stack_2(int32_t a, int64_t b, double c, long double d,
                              uint8_t e, int8_t f, uint8_t g) {
  return (struct large){a, e, f, g};
}

// Aggregates and >=XLen scalars passed on the stack should be lowered just as
// they would be if passed via registers.

// CHECK-LABEL: define void @f_scalar_stack_3(double %a, i64 %b, double %c, i64 %d, i32 %e, i64 %f, i32 %g, double %h, fp128 %i)
void f_scalar_stack_3(double a, int64_t b, double c, int64_t d, int e,
                      int64_t f, int32_t g, double h, long double i) {}

// CHECK-LABEL: define void @f_agg_stack(double %a, i64 %b, double %c, i64 %d, i32 %e.coerce, [2 x i32] %f.coerce, i64 %g.coerce, %struct.large* %h)
void f_agg_stack(double a, int64_t b, double c, int64_t d, struct tiny e,
                 struct small f, struct small_aligned g, struct large h) {}
