// RUN: %clang_cc1 -DLAMBDA -verify -fopenmp -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-llvm %s -o - | FileCheck %s --check-prefix LAMBDA --check-prefix LAMBDA-64
// RUN: %clang_cc1 -DLAMBDA -fopenmp -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1 -DLAMBDA -fopenmp -x c++ -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -std=c++11 -include-pch %t -verify %s -emit-llvm -o - | FileCheck %s --check-prefix LAMBDA --check-prefix LAMBDA-64
// RUN: %clang_cc1 -DLAMBDA -verify -fopenmp -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -emit-llvm %s -o - | FileCheck %s --check-prefix LAMBDA --check-prefix LAMBDA-32
// RUN: %clang_cc1 -DLAMBDA -fopenmp -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1 -DLAMBDA -fopenmp -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -std=c++11 -include-pch %t -verify %s -emit-llvm -o - | FileCheck %s --check-prefix LAMBDA --check-prefix LAMBDA-32

// RUN: %clang_cc1 -DLAMBDA -verify -fopenmp-simd -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-llvm %s -o - | FileCheck --check-prefix SIMD-ONLY0 %s
// RUN: %clang_cc1 -DLAMBDA -fopenmp-simd -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1 -DLAMBDA -fopenmp-simd -x c++ -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -std=c++11 -include-pch %t -verify %s -emit-llvm -o - | FileCheck --check-prefix SIMD-ONLY0 %s
// RUN: %clang_cc1 -DLAMBDA -verify -fopenmp-simd -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -emit-llvm %s -o - | FileCheck --check-prefix SIMD-ONLY0 %s
// RUN: %clang_cc1 -DLAMBDA -fopenmp-simd -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1 -DLAMBDA -fopenmp-simd -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -std=c++11 -include-pch %t -verify %s -emit-llvm -o - | FileCheck --check-prefix SIMD-ONLY0 %s
// SIMD-ONLY0-NOT: {{__kmpc|__tgt}}

// RUN: %clang_cc1  -verify -fopenmp -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-llvm %s -o - | FileCheck %s --check-prefix CHECK --check-prefix CHECK-64
// RUN: %clang_cc1  -fopenmp -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1  -fopenmp -x c++ -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -std=c++11 -include-pch %t -verify %s -emit-llvm -o - | FileCheck %s --check-prefix CHECK --check-prefix CHECK-64
// RUN: %clang_cc1  -verify -fopenmp -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -emit-llvm %s -o - | FileCheck %s --check-prefix CHECK --check-prefix CHECK-32
// RUN: %clang_cc1  -fopenmp -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1  -fopenmp -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -std=c++11 -include-pch %t -verify %s -emit-llvm -o - | FileCheck %s --check-prefix CHECK --check-prefix CHECK-32

// RUN: %clang_cc1  -verify -fopenmp-simd -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-llvm %s -o - | FileCheck --check-prefix SIMD-ONLY1 %s
// RUN: %clang_cc1  -fopenmp-simd -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1  -fopenmp-simd -x c++ -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -std=c++11 -include-pch %t -verify %s -emit-llvm -o - | FileCheck --check-prefix SIMD-ONLY1 %s
// RUN: %clang_cc1  -verify -fopenmp-simd -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -emit-llvm %s -o - | FileCheck --check-prefix SIMD-ONLY1 %s
// RUN: %clang_cc1  -fopenmp-simd -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1  -fopenmp-simd -x c++ -std=c++11 -triple i386-unknown-unknown -fopenmp-targets=i386-pc-linux-gnu -std=c++11 -include-pch %t -verify %s -emit-llvm -o - | FileCheck --check-prefix SIMD-ONLY1 %s
// SIMD-ONLY1-NOT: {{__kmpc|__tgt}}
// expected-no-diagnostics
#ifndef HEADER
#define HEADER

template <class T>
struct S {
  T f;
  S(T a) : f(a) {}
  S() : f() {}
  operator T() { return T(); }
  ~S() {}
};

// CHECK: [[S_FLOAT_TY:%.+]] = type { float }
// CHECK: [[S_INT_TY:%.+]] = type { i{{[0-9]+}} }
template <typename T>
T tmain() {
  S<T> test;
  T t_var = T();
  T vec[] = {1, 2};
  S<T> s_arr[] = {1, 2};
  S<T> &var = test;
  #pragma omp target
  #pragma omp teams
#pragma omp distribute parallel for simd lastprivate(t_var, vec, s_arr, s_arr, var, var)
  for (int i = 0; i < 2; ++i) {
    vec[i] = t_var;
    s_arr[i] = var;
  }
  return T();
}

int main() {
  static int svar;
  volatile double g;
  volatile double &g1 = g;

  #ifdef LAMBDA
  // LAMBDA-LABEL: @main
  // LAMBDA: call{{.*}} void [[OUTER_LAMBDA:@.+]](
  [&]() {
    static float sfvar;
    // LAMBDA: define{{.*}} internal{{.*}} void [[OUTER_LAMBDA]](
    // LAMBDA: call i{{[0-9]+}} @__tgt_target_teams(
    // LAMBDA: call void [[OFFLOADING_FUN:@.+]](

    // LAMBDA: define{{.+}} void [[OFFLOADING_FUN]](
    // LAMBDA: call {{.*}}void {{.+}} @__kmpc_fork_teams({{.+}}, i32 4, {{.+}}* [[OMP_OUTLINED:@.+]] to {{.+}})
    #pragma omp target
    #pragma omp teams
#pragma omp distribute parallel for simd lastprivate(g, g1, svar, sfvar)
    for (int i = 0; i < 2; ++i) {
      // LAMBDA: define{{.*}} internal{{.*}} void [[OMP_OUTLINED]](i32* noalias %{{.+}}, i32* noalias %{{.+}}, double*{{.+}} [[G_IN:%.+]], double*{{.+}} [[G1_IN:%.+]], i{{[0-9]+}}*{{.+}} [[SVAR_IN:%.+]], float*{{.+}} [[SFVAR_IN:%.+]])
      // LAMBDA: [[G_PRIVATE_ADDR:%.+]] = alloca double*,
      // LAMBDA: [[G1_PRIVATE_ADDR:%.+]] = alloca double*,
      // LAMBDA: [[SVAR_PRIVATE_ADDR:%.+]] = alloca i{{[0-9]+}}*,
      // LAMBDA: [[SFVAR_PRIVATE_ADDR:%.+]] = alloca float*,
      // LAMBDA: [[TMP_G1:%.+]] = alloca double*,
      // loop variables
      // LAMBDA: {{.+}} = alloca i{{[0-9]+}},
      // LAMBDA: {{.+}} = alloca i{{[0-9]+}},
      // LAMBDA: {{.+}} = alloca i{{[0-9]+}},
      // LAMBDA: {{.+}} = alloca i{{[0-9]+}},
      // LAMBDA: {{.+}} = alloca i{{[0-9]+}},
      // LAMBDA: [[OMP_IS_LAST:%.+]] = alloca i{{[0-9]+}},
      // LAMBDA: [[G_PRIVATE:%.+]] = alloca double,
      // LAMBDA: [[G1_PRIVATE:%.+]] = alloca double,
      // LAMBDA: [[TMP_G1_PRIVATE:%.+]] = alloca double*,
      // LAMBDA: [[SVAR_PRIVATE:%.+]] = alloca i{{[0-9]+}},
      // LAMBDA: [[SFVAR_PRIVATE:%.+]] = alloca float,

      // init addr alloca's
      // LAMBDA: store double* [[G_IN]], double** [[G_PRIVATE_ADDR]],
      // LAMBDA: store double* [[G1_IN]], double** [[G1_PRIVATE_ADDR]],
      // LAMBDA: store i{{[0-9]+}}* [[SVAR_IN]], i{{[0-9]+}}** [[SVAR_PRIVATE_ADDR]],
      // LAMBDA: store float* [[SFVAR_IN]], float** [[SFVAR_PRIVATE_ADDR]],

      // init private variables
      // LAMBDA: [[G_IN_REF:%.+]] = load double*, double** [[G_PRIVATE_ADDR]],
      // LAMBDA: [[SVAR_IN_REF:%.+]] = load i{{[0-9]+}}*, i{{[0-9]+}}** [[SVAR_PRIVATE_ADDR]],
      // LAMBDA: [[SFVAR_IN_REF:%.+]] = load float*, float** [[SFVAR_PRIVATE_ADDR]],
      // LAMBDA: [[G1_IN_REF:%.+]] = load double*, double** [[G1_PRIVATE_ADDR]],
      // LAMBDA: store double* [[G1_IN_REF]], double** [[TMP_G1]],
      // LAMBDA: [[TMP_G1_VAL:%.+]] = load double*, double** [[TMP_G1]],
      // LAMBDA: store double* [[G1_PRIVATE]], double** [[TMP_G1_PRIVATE]],

      // LAMBDA: call {{.*}}void @__kmpc_for_static_init_4(
      // LAMBDA: [[G1_PAR:%.+]] = load{{.+}}, {{.+}} [[TMP_G1_PRIVATE]],
      // LAMBDA-64: call{{.+}} @__kmpc_fork_call({{.+}}, {{.+}}, {{.+}}[[OMP_PARFOR_OUTLINED:@.+]] to void ({{.+}})*), {{.+}}, {{.+}}, {{.+}} [[G_PRIVATE]], {{.+}} [[G1_PAR]], {{.+}} [[SVAR_PRIVATE]], {{.+}} [[SFVAR_PRIVATE]])
      // LAMBDA-32: call{{.+}} @__kmpc_fork_call({{.+}}, {{.+}}, {{.+}}[[OMP_PARFOR_OUTLINED:@.+]] to void ({{.+}})*), {{.+}}, {{.+}}, {{.+}} [[G_PRIVATE]], {{.+}} [[G1_PAR]], {{.+}} [[SVAR_PRIVATE]], {{.+}} [[SFVAR_PRIVATE]])
      // LAMBDA: call {{.*}}void @__kmpc_for_static_fini(

      // linear counter
      // LAMBDA: [[OMP_IS_LAST_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[OMP_IS_LAST]],
      // LAMBDA: [[IS_LAST_IT:%.+]] = icmp ne i{{[0-9]+}} [[OMP_IS_LAST_VAL]], 0
      // LAMBDA: br i1 [[IS_LAST_IT]], label %[[OMP_COUNTER_BLOCK:.+]], label %[[OMP_COUNTER_DONE:.+]]
      // LAMBDA: [[OMP_COUNTER_BLOCK]]:
      // LAMBDA: store i{{[0-9]+}} 2, i{{[0-9]+}}* %
      // LAMBDA: br label %[[OMP_COUNTER_DONE]]
      // LAMBDA: [[OMP_COUNTER_DONE]]:

      // lastprivate
      // LAMBDA: [[OMP_IS_LAST_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[OMP_IS_LAST]],
      // LAMBDA: [[IS_LAST_IT:%.+]] = icmp ne i{{[0-9]+}} [[OMP_IS_LAST_VAL]], 0
      // LAMBDA: br i1 [[IS_LAST_IT]], label %[[OMP_LASTPRIV_BLOCK:.+]], label %[[OMP_LASTPRIV_DONE:.+]]

      // LAMBDA: [[OMP_LASTPRIV_BLOCK]]:
      // LAMBDA: [[G_PRIV_VAL:%.+]] = load double, double* [[G_PRIVATE]],
      // LAMBDA: store{{.*}} double [[G_PRIV_VAL]], double* [[G_IN_REF]],
      // LAMBDA: [[TMP_G1_PRIV_REF:%.+]] = load double*, double** [[TMP_G1_PRIVATE]],
      // LAMBDA: [[TMP_G1_PRIV_VAL:%.+]] = load double, double* [[TMP_G1_PRIV_REF]],
      // LAMBDA: store{{.*}} double [[TMP_G1_PRIV_VAL]], double* [[TMP_G1_VAL]],

      // LAMBDA: [[SVAR_PRIV_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[SVAR_PRIVATE]],
      // LAMBDA: store i{{[0-9]+}} [[SVAR_PRIV_VAL]], i{{[0-9]+}}* [[SVAR_IN_REF]],
      // LAMBDA: [[SFVAR_PRIV_VAL:%.+]] = load float, float* [[SFVAR_PRIVATE]],
      // LAMBDA: store float [[SFVAR_PRIV_VAL]], float* [[SFVAR_IN_REF]],
      // LAMBDA: br label %[[OMP_LASTPRIV_DONE]]
      // LAMBDA: [[OMP_LASTPRIV_DONE]]:
      // LAMBDA: ret

      g = 1;
      g1 = 1;
      svar = 3;
      sfvar = 4.0;
      // outlined function for 'parallel for'
      // LAMBDA-64: define{{.+}} void [[OMP_PARFOR_OUTLINED]](i32* noalias %{{.+}}, i32* noalias %{{.+}}, {{.+}}, {{.+}}, {{.+}} [[G_IN:%.+]], {{.+}} [[G1_IN:%.+]], {{.+}} [[SVAR_IN:%.+]], {{.+}} [[SFVAR_IN:%.+]])
      // LAMBDA-32: define{{.+}} void [[OMP_PARFOR_OUTLINED]](i32* noalias %{{.+}}, i32* noalias %{{.+}}, {{.+}}, {{.+}}, {{.+}} [[G_IN:%.+]], {{.+}} [[G1_IN:%.+]], {{.+}} [[SVAR_IN:%.+]], {{.+}} [[SFVAR_IN:%.+]])

      // addr alloca's
      // LAMBDA: [[G_PRIVATE_ADDR:%.+]] = alloca double*,
      // LAMBDA: [[G1_PRIVATE_ADDR:%.+]] = alloca double*,
      // LAMBDA: [[SVAR_PRIVATE_ADDR:%.+]] = alloca i{{[0-9]+}}*,
      // LAMBDA: [[SFVAR_PRIVATE_ADDR:%.+]] = alloca float*,

      // loop variables
      // LAMBDA: {{.+}} = alloca i{{[0-9]+}},
      // LAMBDA: {{.+}} = alloca i{{[0-9]+}},
      // LAMBDA: {{.+}} = alloca i{{[0-9]+}},
      // LAMBDA: {{.+}} = alloca i{{[0-9]+}},
      // LAMBDA: {{.+}} = alloca i{{[0-9]+}},

      // private alloca's
      // LAMBDA: [[OMP_IS_LAST:%.+]] = alloca i{{[0-9]+}},
      // LAMBDA: [[G_PRIVATE:%.+]] = alloca double,
      // LAMBDA: [[G1_PRIVATE:%.+]] = alloca double,
      // LAMBDA: [[TMP_G1_PRIVATE:%.+]] = alloca double*,
      // LAMBDA: [[SVAR_PRIVATE:%.+]] = alloca i{{[0-9]+}},
      // LAMBDA: [[SFVAR_PRIVATE:%.+]] = alloca float,

            // init addr alloca's
      // LAMBDA: store double* [[G_IN]], double** [[G_PRIVATE_ADDR]],
      // LAMBDA: store double* [[G1_IN]], double** [[G1_PRIVATE_ADDR]],
      // LAMBDA: store i{{[0-9]+}}* [[SVAR_IN]], i{{[0-9]+}}** [[SVAR_PRIVATE_ADDR]],
      // LAMBDA: store float* [[SFVAR_IN]], float** [[SFVAR_PRIVATE_ADDR]],

      // init private variables
      // LAMBDA: [[G_IN_REF:%.+]] = load double*, double** [[G_PRIVATE_ADDR]],
      // LAMBDA: [[SVAR_IN_REF:%.+]] = load i{{[0-9]+}}*, i{{[0-9]+}}** [[SVAR_PRIVATE_ADDR]],
      // LAMBDA: [[SFVAR_IN_REF:%.+]] = load float*, float** [[SFVAR_PRIVATE_ADDR]],

      // LAMBDA: [[G1_IN_REF:%.+]] = load double*, double** [[G1_PRIVATE_ADDR]],
      // LAMBDA: store double* [[G1_PRIVATE]], double** [[TMP_G1_PRIVATE]],

      // LAMBDA: call {{.*}}void @__kmpc_for_static_init_4(

      // loop body
      // LAMBDA: store double 1.0{{.+}}, double* [[G_PRIVATE]],
      // LAMBDA: [[TMP_G1_REF:%.+]] = load double*, double** [[TMP_G1_PRIVATE]],
      // LAMBDA: store{{.+}} double 1.0{{.+}}, double* [[TMP_G1_REF]],
      // LAMBDA: store i{{[0-9]+}} 3, i{{[0-9]+}}* [[SVAR_PRIVATE]],
      // LAMBDA: store float 4.0{{.+}}, float* [[SFVAR_PRIVATE]],
      // LAMBDA: [[G_PRIVATE_ADDR_REF:%.+]] = getelementptr inbounds %{{.+}}, %{{.+}}* [[ARG:%.+]], i{{[0-9]+}} 0, i{{[0-9]+}} 0
      // LAMBDA: store double* [[G_PRIVATE]], double** [[G_PRIVATE_ADDR_REF]],
      // LAMBDA: [[TMP_PRIVATE_ADDR_REF:%.+]] = getelementptr inbounds %{{.+}}, %{{.+}}* [[ARG:%.+]], i{{[0-9]+}} 0, i{{[0-9]+}} 1
      // LAMBDA: [[G1_PRIVATE_ADDR_FROM_TMP:%.+]] = load double*, double** [[TMP_G1_PRIVATE]],
      // LAMBDA: store double* [[G1_PRIVATE_ADDR_FROM_TMP]], double** [[TMP_PRIVATE_ADDR_REF]],
      // LAMBDA: [[SVAR_PRIVATE_ADDR_REF:%.+]] = getelementptr inbounds %{{.+}}, %{{.+}}* [[ARG:%.+]], i{{[0-9]+}} 0, i{{[0-9]+}} 2
      // LAMBDA: store i{{[0-9]+}}* [[SVAR_PRIVATE]], i{{[0-9]+}}** [[SVAR_PRIVATE_ADDR_REF]]
      // LAMBDA: [[SFVAR_PRIVATE_ADDR_REF:%.+]] = getelementptr inbounds %{{.+}}, %{{.+}}* [[ARG:%.+]], i{{[0-9]+}} 0, i{{[0-9]+}} 3
      // LAMBDA: store float* [[SFVAR_PRIVATE]], float** [[SFVAR_PRIVATE_ADDR_REF]]
      // LAMBDA: call{{.*}} void [[INNER_LAMBDA:@.+]](%{{.+}}* [[ARG]])

      // LAMBDA: call {{.*}}void @__kmpc_for_static_fini(

      // lastprivate
      // LAMBDA: [[OMP_IS_LAST_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[OMP_IS_LAST]],
      // LAMBDA: [[OMP_IS_LAST_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[OMP_IS_LAST]],
      // LAMBDA: [[IS_LAST_IT:%.+]] = icmp ne i{{[0-9]+}} [[OMP_IS_LAST_VAL]], 0
      // LAMBDA: br i1 [[IS_LAST_IT]], label %[[OMP_LASTPRIV_BLOCK:.+]], label %[[OMP_LASTPRIV_DONE:.+]]
      // LAMBDA: [[OMP_LASTPRIV_BLOCK]]:
      // LAMBDA: [[G_PRIV_VAL:%.+]] = load double, double* [[G_PRIVATE]],
      // LAMBDA: store{{.*}} double [[G_PRIV_VAL]], double* [[G_IN_REF]],
      // LAMBDA: [[TMP_G1_PRIV_REF:%.+]] = load double*, double** [[TMP_G1_PRIVATE]],
      // LAMBDA: [[TMP_G1_PRIV_VAL:%.+]] = load double, double* [[TMP_G1_PRIV_REF]],
      // LAMBDA: store{{.*}} double [[TMP_G1_PRIV_VAL]], double* [[G1_IN_REF]],
      // LAMBDA: [[SVAR_PRIV_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[SVAR_PRIVATE]],
      // LAMBDA: store i{{[0-9]+}} [[SVAR_PRIV_VAL]], i{{[0-9]+}}* [[SVAR_IN_REF]],
      // LAMBDA: [[SFVAR_PRIV_VAL:%.+]] = load float, float* [[SFVAR_PRIVATE]],
      // LAMBDA: store float [[SFVAR_PRIV_VAL]], float* [[SFVAR_IN_REF]],
      // LAMBDA: br label %[[OMP_LASTPRIV_DONE]]
      // LAMBDA: [[OMP_LASTPRIV_DONE]]:
      // LAMBDA: ret

      [&]() {
	// LAMBDA: define {{.+}} void [[INNER_LAMBDA]](%{{.+}}* [[ARG_PTR:%.+]])
	// LAMBDA: store %{{.+}}* [[ARG_PTR]], %{{.+}}** [[ARG_PTR_REF:%.+]],
	g = 2;
	g1 = 2;
	svar = 4;
	sfvar = 8.0;
	// LAMBDA: [[ARG_PTR:%.+]] = load %{{.+}}*, %{{.+}}** [[ARG_PTR_REF]]
	// LAMBDA: [[G_PTR_REF:%.+]] = getelementptr inbounds %{{.+}}, %{{.+}}* [[ARG_PTR]], i{{[0-9]+}} 0, i{{[0-9]+}} 0
	// LAMBDA: [[G_REF:%.+]] = load double*, double** [[G_PTR_REF]]
	// LAMBDA: store double 2.0{{.+}}, double* [[G_REF]]

	// LAMBDA: [[TMP_PTR_REF:%.+]] = getelementptr inbounds %{{.+}}, %{{.+}}* [[ARG_PTR]], i{{[0-9]+}} 0, i{{[0-9]+}} 1
	// LAMBDA: [[G1_REF:%.+]] = load double*, double** [[TMP_PTR_REF]]
	// LAMBDA: store double 2.0{{.+}}, double* [[G1_REF]],
	// LAMBDA: [[SVAR_PTR_REF:%.+]] = getelementptr inbounds %{{.+}}, %{{.+}}* [[ARG_PTR]], i{{[0-9]+}} 0, i{{[0-9]+}} 2
	// LAMBDA: [[SVAR_REF:%.+]] = load i{{[0-9]+}}*, i{{[0-9]+}}** [[SVAR_PTR_REF]]
	// LAMBDA: store i{{[0-9]+}} 4, i{{[0-9]+}}* [[SVAR_REF]]
	// LAMBDA: [[SFVAR_PTR_REF:%.+]] = getelementptr inbounds %{{.+}}, %{{.+}}* [[ARG_PTR]], i{{[0-9]+}} 0, i{{[0-9]+}} 3
	// LAMBDA: [[SFVAR_REF:%.+]] = load float*, float** [[SFVAR_PTR_REF]]
	// LAMBDA: store float 8.0{{.+}}, float* [[SFVAR_REF]]
      }();
    }
  }();
  return 0;
  #else
  S<float> test;
  int t_var = 0;
  int vec[] = {1, 2};
  S<float> s_arr[] = {1, 2};
  S<float> &var = test;

  #pragma omp target
  #pragma omp teams
#pragma omp distribute parallel for simd lastprivate(t_var, vec, s_arr, s_arr, var, var, svar)
  for (int i = 0; i < 2; ++i) {
    vec[i] = t_var;
    s_arr[i] = var;
  }
  int i;

  return tmain<int>();
  #endif
}

// CHECK: define{{.*}} i{{[0-9]+}} @main()
// CHECK: [[TEST:%.+]] = alloca [[S_FLOAT_TY]],
// CHECK: call {{.*}} [[S_FLOAT_TY_DEF_CONSTR:@.+]]([[S_FLOAT_TY]]* [[TEST]])
// CHECK: call i{{[0-9]+}} @__tgt_target_teams(
// CHECK: call void [[OFFLOAD_FUN:@.+]](i{{[0-9]+}} {{.+}}, [2 x i{{[0-9]+}}]* {{.+}}, [2 x [[S_FLOAT_TY]]]* {{.+}}, [[S_FLOAT_TY]]* {{.+}}, i{{[0-9]+}} {{.+}})
// CHECK: ret

// CHECK: define{{.+}} [[OFFLOAD_FUN]](i{{[0-9]+}} {{.+}}, [2 x i{{[0-9]+}}]*{{.+}} {{.+}}, [2 x [[S_FLOAT_TY]]]*{{.+}} {{.+}}, [[S_FLOAT_TY]]*{{.+}} {{.+}}, i{{[0-9]+}} {{.+}})
// CHECK: call void (%{{.+}}*, i{{[0-9]+}}, void (i{{[0-9]+}}*, i{{[0-9]+}}*, ...)*, ...) @__kmpc_fork_teams(
// CHECK: ret
//
// CHECK: define internal void [[OMP_OUTLINED:@.+]](i{{[0-9]+}}* noalias [[GTID_ADDR:%.+]], i{{[0-9]+}}* noalias %{{.+}}, i{{[0-9]+}}*{{.+}} [[T_VAR_IN:%.+]], [2 x i{{[0-9]+}}]*{{.+}} [[VEC_IN:%.+]], [2 x [[S_FLOAT_TY]]]*{{.+}} [[S_ARR_IN:%.+]], [[S_FLOAT_TY]]*{{.+}} [[VAR_IN:%.+]], i{{[0-9]+}}*{{.*}} [[S_VAR_IN:%.+]])
// CHECK: {{.+}} = alloca i{{[0-9]+}}*,
// CHECK: {{.+}} = alloca i{{[0-9]+}}*,
// CHECK: [[T_VAR_ADDR:%.+]] = alloca i{{[0-9]+}}*,
// CHECK: [[VEC_ADDR:%.+]] = alloca [2 x i{{[0-9]+}}]*,
// CHECK: [[S_ARR_ADDR:%.+]] = alloca [2 x [[S_FLOAT_TY]]]*,
// CHECK: [[VAR_ADDR:%.+]] = alloca [[S_FLOAT_TY]]*,
// CHECK: [[SVAR_ADDR:%.+]] = alloca i{{[0-9]+}}*,
// CHECK: [[TMP:%.*]] = alloca [[S_FLOAT_TY]]*,
// skip loop variables
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: [[OMP_IS_LAST:%.+]] = alloca i{{[0-9]+}},
// CHECK: [[T_VAR_PRIV:%.+]] = alloca i{{[0-9]+}},
// CHECK: [[VEC_PRIV:%.+]] = alloca [2 x i{{[0-9]+}}],
// CHECK: [[S_ARR_PRIV:%.+]] = alloca [2 x [[S_FLOAT_TY]]],
// CHECK: [[VAR_PRIV:%.+]] = alloca [[S_FLOAT_TY]],
// CHECK: [[TMP_PRIV:%.+]] = alloca [[S_FLOAT_TY]]*,
// CHECK: [[S_VAR_PRIV:%.+]] = alloca i{{[0-9]+}},

// copy from parameters to local address variables
// CHECK: store i{{[0-9]+}}* [[T_VAR_IN]], i{{[0-9]+}}** [[T_VAR_ADDR]],
// CHECK: store [2 x i{{[0-9]+}}]* [[VEC_IN]], [2 x i{{[0-9]+}}]** [[VEC_ADDR]],
// CHECK: store [2 x [[S_FLOAT_TY]]]* [[S_ARR_IN]], [2 x [[S_FLOAT_TY]]]** [[S_ARR_ADDR]],
// CHECK: store [[S_FLOAT_TY]]* [[VAR_IN]], [[S_FLOAT_TY]]** [[VAR_ADDR]],
// CHECK: store i{{[0-9]+}}* [[S_VAR_IN]], i{{[0-9]+}}** [[SVAR_ADDR]],

// load content of local address variables
// CHECK: [[T_VAR_ADDR_REF:%.+]] = load i{{[0-9]+}}*, i{{[0-9]+}}** [[T_VAR_ADDR]],
// CHECK: [[VEC_ADDR_REF:%.+]] = load [2 x i{{[0-9]+}}]*, [2 x i{{[0-9]+}}]** [[VEC_ADDR]],
// CHECK: [[S_ARR_ADDR_REF:%.+]] = load [2 x [[S_FLOAT_TY]]]*, [2 x [[S_FLOAT_TY]]]** [[S_ARR_ADDR]],
// CHECK: [[SVAR_ADDR_REF:%.+]] = load i{{[0-9]+}}*, i{{[0-9]+}}** [[SVAR_ADDR]],
// CHECK: [[VAR_ADDR_REF:%.+]] = load [[S_FLOAT_TY]]*, [[S_FLOAT_TY]]** [[VAR_ADDR]],
// CHECK: store [[S_FLOAT_TY]]* [[VAR_ADDR_REF]], [[S_FLOAT_TY]]** [[TMP]],
// CHECK: store i{{[0-9]+}} 0, i{{[0-9]+}}* [[OMP_IS_LAST]],

// call constructor for s_arr
// CHECK: [[S_ARR_BGN:%.+]] = getelementptr{{.+}} [2 x [[S_FLOAT_TY]]], [2 x [[S_FLOAT_TY]]]* [[S_ARR_PRIV]],
// CHECK: [[S_ARR_END:%.+]] = getelementptr {{.+}} [[S_FLOAT_TY]], [[S_FLOAT_TY]]* [[S_ARR_BGN]],
// CHECK: br label %[[S_ARR_CST_LOOP:.+]]
// CHECK: [[S_ARR_CST_LOOP]]:
// CHECK: [[S_ARR_CTOR:%.+]] = phi {{.+}}
// CHECK: call void [[S_FLOAT_TY_DEF_CONSTR]]([[S_FLOAT_TY]]* [[S_ARR_CTOR]])
// CHECK: [[S_ARR_NEXT:%.+]] = getelementptr {{.+}} [[S_ARR_CTOR]],
// CHECK: [[S_ARR_DONE:%.+]] = icmp {{.+}} [[S_ARR_NEXT]], [[S_ARR_END]]
// CHECK: br i1 [[S_ARR_DONE]], label %[[S_ARR_CST_END:.+]], label %[[S_ARR_CST_LOOP]]
// CHECK: [[S_ARR_CST_END]]:
// CHECK: [[TMP_REF:%.+]] = load [[S_FLOAT_TY]]*, [[S_FLOAT_TY]]** [[TMP]],
// CHECK: call void [[S_FLOAT_TY_DEF_CONSTR]]([[S_FLOAT_TY]]* [[VAR_PRIV]])
// CHECK: store [[S_FLOAT_TY]]* [[VAR_PRIV]], [[S_FLOAT_TY]]** [[TMP_PRIV]],

// the distribute loop
// CHECK: call void @__kmpc_for_static_init_4(
// CHECK: [[TMP_PRIV_VAL:%.+]] = load {{.+}}, {{.+}} [[TMP_PRIV]],
// CHECK-64: call{{.+}} @__kmpc_fork_call({{.+}}, {{.+}}, {{.+}}[[OMP_PARFOR_OUTLINED:@.+]] to void ({{.+}})*), {{.+}}, {{.+}}, {{.+}} [[VEC_PRIV]], {{.+}} [[T_VAR_PRIV]], {{.+}} [[S_ARR_PRIV]], {{.+}} [[TMP_PRIV_VAL]], {{.+}} [[S_VAR_PRIV]])
// CHECK-32: call{{.+}} @__kmpc_fork_call({{.+}}, {{.+}}, {{.+}}[[OMP_PARFOR_OUTLINED:@.+]] to void ({{.+}})*), {{.+}}, {{.+}}, {{.+}} [[VEC_PRIV]], {{.+}} [[T_VAR_PRIV]], {{.+}} [[S_ARR_PRIV]], {{.+}} [[TMP_PRIV_VAL]], {{.+}} [[S_VAR_PRIV]])

// CHECK: call void @__kmpc_for_static_fini(

// lastprivates
// CHECK: [[OMP_IS_LAST_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[OMP_IS_LAST]],
// CHECK: [[IS_LAST_IT:%.+]] = icmp ne i{{[0-9]+}} [[OMP_IS_LAST_VAL]], 0
// CHECK: br i1 [[IS_LAST_IT]], label %[[OMP_LASTPRIV_BLOCK:.+]], label %[[OMP_LASTPRIV_DONE:.+]]

// CHECK: [[OMP_LASTPRIV_BLOCK]]:
// CHECK: [[T_VAR_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[T_VAR_PRIV]],
// CHECK: store i{{[0-9]+}} [[T_VAR_VAL]], i{{[0-9]+}}* [[T_VAR_ADDR_REF]],
// CHECK: [[BCAST_VEC_ADDR_REF:%.+]] = bitcast [2 x i{{[0-9]+}}]* [[VEC_ADDR_REF]] to i8*
// CHECK: [[BCAST_VEC_PRIV:%.+]] = bitcast [2 x i{{[0-9]+}}]* [[VEC_PRIV]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[BCAST_VEC_ADDR_REF]], i8* [[BCAST_VEC_PRIV]],
// CHECK: [[S_ARR_BEGIN:%.+]] = getelementptr inbounds [2 x [[S_FLOAT_TY]]], [2 x [[S_FLOAT_TY]]]* [[S_ARR_ADDR_REF]], i{{[0-9]+}} 0, i{{[0-9]+}} 0
// CHECK: [[S_ARR_PRIV_BCAST:%.+]] = bitcast [2 x [[S_FLOAT_TY]]]* [[S_ARR_PRIV]] to [[S_FLOAT_TY]]*
// CHECK: [[S_ARR_BEGIN_GEP:%.+]] = getelementptr [[S_FLOAT_TY]], [[S_FLOAT_TY]]* [[S_ARR_BEGIN]], i{{[0-9]+}} 2
// CHECK: [[S_ARR_IS_EMPTY:%.+]] = icmp eq [[S_FLOAT_TY]]* [[S_ARR_BEGIN]], [[S_ARR_BEGIN_GEP]]
// CHECK: br i1 [[S_ARR_IS_EMPTY]], label %[[S_ARR_COPY_DONE:.+]], label %[[S_ARR_COPY_BLOCK:.+]]
// CHECK: [[S_ARR_COPY_BLOCK]]:
// CHECK: [[S_ARR_SRC_EL:%.+]] = phi [[S_FLOAT_TY]]*{{.+}}
// CHECK: [[S_ARR_DST_EL:%.+]] = phi [[S_FLOAT_TY]]*{{.+}}
// CHECK: [[S_ARR_DST_BCAST:%.+]] = bitcast [[S_FLOAT_TY]]* [[S_ARR_DST_EL]] to i8*
// CHECK: [[S_ARR_SRC_BCAST:%.+]] = bitcast [[S_FLOAT_TY]]* [[S_ARR_SRC_EL]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[S_ARR_DST_BCAST]], i8* [[S_ARR_SRC_BCAST]]{{.+}})
// CHECK: [[S_ARR_DST_NEXT:%.+]] = getelementptr [[S_FLOAT_TY]], [[S_FLOAT_TY]]* [[S_ARR_DST_EL]], i{{[0-9]+}} 1
// CHECK: [[S_ARR_SRC_NEXT:%.+]] = getelementptr{{.+}}
// CHECK: [[CPY_IS_FINISHED:%.+]] = icmp eq [[S_FLOAT_TY]]* [[S_ARR_DST_NEXT]], [[S_ARR_BEGIN_GEP]]
// CHECK: br i1 [[CPY_IS_FINISHED]], label %[[S_ARR_COPY_DONE]], label %[[S_ARR_COPY_BLOCK]]
// CHECK: [[S_ARR_COPY_DONE]]:
// CHECK: [[TMP_VAL1:%.+]] = load [[S_FLOAT_TY]]*, [[S_FLOAT_TY]]** [[TMP_PRIV]],
// CHECK: [[VAR_ADDR_REF_BCAST:%.+]] = bitcast [[S_FLOAT_TY]]* [[TMP_REF]] to i8*
// CHECK: [[TMP_VAL1_BCAST:%.+]] = bitcast [[S_FLOAT_TY]]* [[TMP_VAL1]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[VAR_ADDR_REF_BCAST]], i8* [[TMP_VAL1_BCAST]],{{.+}})
// CHECK: [[SVAR_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[S_VAR_PRIV]],
// CHECK: store i{{[0-9]+}} [[SVAR_VAL]], i{{[0-9]+}}* [[SVAR_ADDR_REF]],
// CHECK: ret void

// outlined function for 'parallel for'
// CHECK-64: define{{.+}} void [[OMP_PARFOR_OUTLINED]](i32* noalias %{{.+}}, i32* noalias %{{.+}}, {{.+}}, {{.+}}, {{.+}} [[VEC_IN:%.+]], {{.+}} [[T_VAR_IN:%.+]], {{.+}} [[S_ARR_IN:%.+]], {{.+}} [[VAR_IN:%.+]], {{.+}} [[SVAR_IN:%.+]])
// CHECK-32: define{{.+}} void [[OMP_PARFOR_OUTLINED]](i32* noalias %{{.+}}, i32* noalias %{{.+}}, {{.+}}, {{.+}}, {{.+}} [[VEC_IN:%.+]], {{.+}} [[T_VAR_IN:%.+]], {{.+}} [[S_ARR_IN:%.+]], {{.+}} [[VAR_IN:%.+]], {{.+}} [[SVAR_IN:%.+]])

// CHECK: {{.+}} = alloca i{{[0-9]+}}*,
// CHECK: {{.+}} = alloca i{{[0-9]+}}*,
// CHECK: [[VEC_ADDR:%.+]] = alloca [2 x i{{[0-9]+}}]*,
// CHECK: [[T_VAR_ADDR:%.+]] = alloca i{{[0-9]+}}*,
// CHECK: [[S_ARR_ADDR:%.+]] = alloca [2 x [[S_FLOAT_TY]]]*,
// CHECK: [[VAR_ADDR:%.+]] = alloca [[S_FLOAT_TY]]*,
// CHECK: [[SVAR_ADDR:%.+]] = alloca i{{[0-9]+}}*,
// skip loop variables
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: [[OMP_IS_LAST:%.+]] = alloca i{{[0-9]+}},
// CHECK: [[T_VAR_PRIV:%.+]] = alloca i{{[0-9]+}},
// CHECK: [[VEC_PRIV:%.+]] = alloca [2 x i{{[0-9]+}}],
// CHECK: [[S_ARR_PRIV:%.+]] = alloca [2 x [[S_FLOAT_TY]]],
// CHECK: [[VAR_PRIV:%.+]] = alloca [[S_FLOAT_TY]],
// CHECK: [[TMP_PRIV:%.+]] = alloca [[S_FLOAT_TY]]*,
// CHECK: [[S_VAR_PRIV:%.+]] = alloca i{{[0-9]+}},

// copy from parameters to local address variables
// CHECK: store [2 x i{{[0-9]+}}]* [[VEC_IN]], [2 x i{{[0-9]+}}]** [[VEC_ADDR]],
// CHECK: store i{{[0-9]+}}* [[T_VAR_IN]], i{{[0-9]+}}** [[T_VAR_ADDR]],
// CHECK: store [2 x [[S_FLOAT_TY]]]* [[S_ARR_IN]], [2 x [[S_FLOAT_TY]]]** [[S_ARR_ADDR]],
// CHECK: store [[S_FLOAT_TY]]* [[VAR_IN]], [[S_FLOAT_TY]]** [[VAR_ADDR]],
// CHECK: store i{{[0-9]+}}* [[S_VAR_IN]], i{{[0-9]+}}** [[SVAR_ADDR]],

// load content of local address variables
// CHECK: [[VEC_ADDR_REF:%.+]] = load [2 x i{{[0-9]+}}]*, [2 x i{{[0-9]+}}]** [[VEC_ADDR]],
// CHECK: [[T_VAR_ADDR_REF:%.+]] = load i{{[0-9]+}}*, i{{[0-9]+}}** [[T_VAR_ADDR]],
// CHECK: [[S_ARR_ADDR_REF:%.+]] = load [2 x [[S_FLOAT_TY]]]*, [2 x [[S_FLOAT_TY]]]** [[S_ARR_ADDR]],
// CHECK: [[SVAR_ADDR_REF:%.+]] = load i{{[0-9]+}}*, i{{[0-9]+}}** [[SVAR_ADDR]],
// CHECK: store i{{[0-9]+}} 0, i{{[0-9]+}}* [[OMP_IS_LAST]],

// call constructor for s_arr
// CHECK: [[S_ARR_BGN:%.+]] = getelementptr{{.+}} [2 x [[S_FLOAT_TY]]], [2 x [[S_FLOAT_TY]]]* [[S_ARR_PRIV]],
// CHECK: [[S_ARR_END:%.+]] = getelementptr {{.+}} [[S_FLOAT_TY]], [[S_FLOAT_TY]]* [[S_ARR_BGN]],
// CHECK: br label %[[S_ARR_CST_LOOP:.+]]
// CHECK: [[S_ARR_CST_LOOP]]:
// CHECK: [[S_ARR_CTOR:%.+]] = phi {{.+}}
// CHECK: call void [[S_FLOAT_TY_DEF_CONSTR]]([[S_FLOAT_TY]]* [[S_ARR_CTOR]])
// CHECK: [[S_ARR_NEXT:%.+]] = getelementptr {{.+}} [[S_ARR_CTOR]],
// CHECK: [[S_ARR_DONE:%.+]] = icmp {{.+}} [[S_ARR_NEXT]], [[S_ARR_END]]
// CHECK: br i1 [[S_ARR_DONE]], label %[[S_ARR_CST_END:.+]], label %[[S_ARR_CST_LOOP]]
// CHECK: [[S_ARR_CST_END]]:
// CHECK: [[VAR_ADDR_REF:%.+]] = load [[S_FLOAT_TY]]*, [[S_FLOAT_TY]]** [[VAR_ADDR]],
// CHECK: call void [[S_FLOAT_TY_DEF_CONSTR]]([[S_FLOAT_TY]]* [[VAR_PRIV]])
// CHECK: store [[S_FLOAT_TY]]* [[VAR_PRIV]], [[S_FLOAT_TY]]** [[TMP_PRIV]],

// CHECK: call void @__kmpc_for_static_init_4(

// loop body
// assignment: vec[i] = t_var;
// CHECK: [[T_VAR_PRIV_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[T_VAR_PRIV]],
// CHECK: [[VEC_PTR:%.+]] = getelementptr inbounds [2 x i{{[0-9]+}}], [2 x i{{[0-9]+}}]* [[VEC_PRIV]], i{{[0-9]+}} 0, i{{[0-9]+}} {{.+}}
// CHECK:  store i{{[0-9]+}} [[T_VAR_PRIV_VAL]], i{{[0-9]+}}* [[VEC_PTR]],

// assignment: s_arr[i] = var;
// CHECK-DAG: [[S_ARR_PTR:%.+]] = getelementptr inbounds [2 x [[S_FLOAT_TY]]], [2 x [[S_FLOAT_TY]]]* [[S_ARR_PRIV]],
// CHECK-DAG: [[TMP_VAL:%.+]] = load [[S_FLOAT_TY]]*, [[S_FLOAT_TY]]** [[TMP_PRIV]],
// CHECK-DAG: [[S_ARR_PTR_BCAST:%.+]] = bitcast [[S_FLOAT_TY]]* [[S_ARR_PTR]] to i8*
// CHECK-DAG: [[TMP_VAL_BCAST:%.+]] = bitcast [[S_FLOAT_TY]]* [[TMP_VAL]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[S_ARR_PTR_BCAST]], i8* [[TMP_VAL_BCAST]],

// CHECK: call void @__kmpc_for_static_fini(

// lastprivates
// CHECK: [[OMP_IS_LAST_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[OMP_IS_LAST]],
// CHECK: [[IS_LAST_IT:%.+]] = icmp ne i{{[0-9]+}} [[OMP_IS_LAST_VAL]], 0
// CHECK: br i1 [[IS_LAST_IT]], label %[[OMP_LASTPRIV_BLOCK:.+]], label %[[OMP_LASTPRIV_DONE:.+]]

// CHECK: [[OMP_LASTPRIV_BLOCK]]:
// CHECK: [[T_VAR_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[T_VAR_PRIV]],
// CHECK: store i{{[0-9]+}} [[T_VAR_VAL]], i{{[0-9]+}}* [[T_VAR_ADDR_REF]],
// CHECK: [[BCAST_VEC_ADDR_REF:%.+]] = bitcast [2 x i{{[0-9]+}}]* [[VEC_ADDR_REF]] to i8*
// CHECK: [[BCAST_VEC_PRIV:%.+]] = bitcast [2 x i{{[0-9]+}}]* [[VEC_PRIV]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[BCAST_VEC_ADDR_REF]], i8* [[BCAST_VEC_PRIV]],
// CHECK: [[S_ARR_BEGIN:%.+]] = getelementptr inbounds [2 x [[S_FLOAT_TY]]], [2 x [[S_FLOAT_TY]]]* [[S_ARR_ADDR_REF]], i{{[0-9]+}} 0, i{{[0-9]+}} 0
// CHECK: [[S_ARR_PRIV_BCAST:%.+]] = bitcast [2 x [[S_FLOAT_TY]]]* [[S_ARR_PRIV]] to [[S_FLOAT_TY]]*
// CHECK: [[S_ARR_BEGIN_GEP:%.+]] = getelementptr [[S_FLOAT_TY]], [[S_FLOAT_TY]]* [[S_ARR_BEGIN]], i{{[0-9]+}} 2
// CHECK: [[S_ARR_IS_EMPTY:%.+]] = icmp eq [[S_FLOAT_TY]]* [[S_ARR_BEGIN]], [[S_ARR_BEGIN_GEP]]
// CHECK: br i1 [[S_ARR_IS_EMPTY]], label %[[S_ARR_COPY_DONE:.+]], label %[[S_ARR_COPY_BLOCK:.+]]
// CHECK: [[S_ARR_COPY_BLOCK]]:
// CHECK: [[S_ARR_SRC_EL:%.+]] = phi [[S_FLOAT_TY]]*{{.+}}
// CHECK: [[S_ARR_DST_EL:%.+]] = phi [[S_FLOAT_TY]]*{{.+}}
// CHECK: [[S_ARR_DST_BCAST:%.+]] = bitcast [[S_FLOAT_TY]]* [[S_ARR_DST_EL]] to i8*
// CHECK: [[S_ARR_SRC_BCAST:%.+]] = bitcast [[S_FLOAT_TY]]* [[S_ARR_SRC_EL]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[S_ARR_DST_BCAST]], i8* [[S_ARR_SRC_BCAST]]{{.+}})
// CHECK: [[S_ARR_DST_NEXT:%.+]] = getelementptr [[S_FLOAT_TY]], [[S_FLOAT_TY]]* [[S_ARR_DST_EL]], i{{[0-9]+}} 1
// CHECK: [[S_ARR_SRC_NEXT:%.+]] = getelementptr{{.+}}
// CHECK: [[CPY_IS_FINISHED:%.+]] = icmp eq [[S_FLOAT_TY]]* [[S_ARR_DST_NEXT]], [[S_ARR_BEGIN_GEP]]
// CHECK: br i1 [[CPY_IS_FINISHED]], label %[[S_ARR_COPY_DONE]], label %[[S_ARR_COPY_BLOCK]]
// CHECK: [[S_ARR_COPY_DONE]]:
// CHECK: [[TMP_VAL1:%.+]] = load [[S_FLOAT_TY]]*, [[S_FLOAT_TY]]** [[TMP_PRIV]],
// CHECK: [[VAR_ADDR_REF_BCAST:%.+]] = bitcast [[S_FLOAT_TY]]* [[VAR_ADDR_REF]] to i8*
// CHECK: [[TMP_VAL1_BCAST:%.+]] = bitcast [[S_FLOAT_TY]]* [[TMP_VAL1]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[VAR_ADDR_REF_BCAST]], i8* [[TMP_VAL1_BCAST]],{{.+}})
// CHECK: [[SVAR_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[S_VAR_PRIV]],
// CHECK: store i{{[0-9]+}} [[SVAR_VAL]], i{{[0-9]+}}* [[SVAR_ADDR_REF]],
// CHECK: ret void

// template tmain
// CHECK: define{{.*}} i{{[0-9]+}} [[TMAIN_INT:@.+]]()
// CHECK: [[TEST:%.+]] = alloca [[S_INT_TY]],
// CHECK: call {{.*}} [[S_INT_TY_DEF_CONSTR:@.+]]([[S_INT_TY]]* [[TEST]])
// CHECK: call i{{[0-9]+}} @__tgt_target_teams(
// CHECK: call void [[OFFLOAD_FUN_1:@.+]](i{{[0-9]+}} {{.+}}, [2 x i{{[0-9]+}}]* {{.+}}, [2 x [[S_INT_TY]]]* {{.+}}, [[S_INT_TY]]* {{.+}})
// CHECK: ret

// CHECK: define internal void [[OFFLOAD_FUN_1]](
// CHECK: call void (%{{.+}}*, i{{[0-9]+}}, void (i{{[0-9]+}}*, i{{[0-9]+}}*, ...)*, ...) @__kmpc_fork_teams(%{{.+}}* @{{.+}}, i{{[0-9]+}} 4,
// CHECK: ret

// CHECK: define internal void [[OMP_OUTLINED_1:@.+]](i{{[0-9]+}}* noalias [[GTID_ADDR:%.+]], i{{[0-9]+}}* noalias %{{.+}}, i{{[0-9]+}}*{{.+}} [[T_VAR_IN:%.+]], [2 x i{{[0-9]+}}]*{{.+}} [[VEC_IN:%.+]],  [2 x [[S_INT_TY]]]*{{.+}} [[S_ARR_IN:%.+]], [[S_INT_TY]]*{{.+}} [[VAR_IN:%.+]])
// skip alloca of global_tid and bound_tid
// CHECK: {{.+}} = alloca i{{[0-9]+}}*,
// CHECK: {{.+}} = alloca i{{[0-9]+}}*,
// CHECK: [[T_VAR_ADDR:%.+]] = alloca i{{[0-9]+}}*,
// CHECK: [[VEC_ADDR:%.+]] = alloca [2 x i{{[0-9]+}}]*,
// CHECK: [[S_ARR_ADDR:%.+]] = alloca [2 x [[S_INT_TY]]]*,
// CHECK: [[VAR_ADDR:%.+]] = alloca [[S_INT_TY]]*,
// CHECK: [[TMP:%.+]] = alloca [[S_INT_TY]]*,
// skip loop variables
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: [[OMP_IS_LAST:%.+]] = alloca i{{[0-9]+}},
// CHECK: [[T_VAR_PRIV:%.+]] = alloca i{{[0-9]+}},
// CHECK: [[VEC_PRIV:%.+]] = alloca [2 x i{{[0-9]+}}],
// CHECK: [[S_ARR_PRIV:%.+]] = alloca [2 x [[S_INT_TY]]],
// CHECK: [[VAR_PRIV:%.+]] = alloca [[S_INT_TY]],
// CHECK: [[TMP_PRIV:%.+]] = alloca [[S_INT_TY]]*,

// skip init of bound and global tid
// CHECK: store i{{[0-9]+}}* {{.*}},
// CHECK: store i{{[0-9]+}}* {{.*}},
// copy from parameters to local address variables
// CHECK: store i{{[0-9]+}}* [[T_VAR_IN]], i{{[0-9]+}}** [[T_VAR_ADDR]],
// CHECK: store [2 x i{{[0-9]+}}]* [[VEC_IN]], [2 x i{{[0-9]+}}]** [[VEC_ADDR]],
// CHECK: store [2 x [[S_INT_TY]]]* [[S_ARR_IN]], [2 x [[S_INT_TY]]]** [[S_ARR_ADDR]],
// CHECK: store [[S_INT_TY]]* [[VAR_IN]], [[S_INT_TY]]** [[VAR_ADDR]],

// load content of local address variables
// CHECK: [[T_VAR_ADDR_REF:%.+]] = load i{{[0-9]+}}*, i{{[0-9]+}}** [[T_VAR_ADDR]],
// CHECK: [[VEC_ADDR_REF:%.+]] = load [2 x i{{[0-9]+}}]*, [2 x i{{[0-9]+}}]** [[VEC_ADDR]],
// CHECK: [[S_ARR_ADDR_REF:%.+]] = load [2 x [[S_INT_TY]]]*, [2 x [[S_INT_TY]]]** [[S_ARR_ADDR]],
// CHECK: [[VAR_ADDR_REF:%.+]] = load [[S_INT_TY]]*, [[S_INT_TY]]** [[VAR_ADDR]],
// CHECK-DAG: store [[S_INT_TY]]* [[VAR_ADDR_REF]], [[S_INT_TY]]** [[TMP]],
// CHECK-DAG: store i{{[0-9]+}} 0, i{{[0-9]+}}* [[OMP_IS_LAST]],
// CHECK-DAG: [[TMP_REF:%.+]] = load [[S_INT_TY]]*, [[S_INT_TY]]** [[TMP]],

// CHECK: call void @__kmpc_for_static_init_4(
// CHECK: [[TMP_PRIV_VAL:%.+]] = load {{.+}}, {{.+}} [[TMP_PRIV]],
// CHECK-64: call{{.+}} @__kmpc_fork_call({{.+}}, {{.+}}, {{.+}}[[OMP_PARFOR_OUTLINED:@.+]] to void ({{.+}})*), {{.+}}, {{.+}}, {{.+}} [[VEC_PRIV]], {{.+}} [[T_VAR_PRIV]], {{.+}} [[S_ARR_PRIV]], {{.+}} [[TMP_PRIV_VAL]])
// CHECK-32: call{{.+}} @__kmpc_fork_call({{.+}}, {{.+}}, {{.+}}[[OMP_PARFOR_OUTLINED:@.+]] to void ({{.+}})*), {{.+}}, {{.+}}, {{.+}} [[VEC_PRIV]], {{.+}} [[T_VAR_PRIV]], {{.+}} [[S_ARR_PRIV]], {{.+}} [[TMP_PRIV_VAL]])

// CHECK: call void @__kmpc_for_static_fini(

// lastprivates
// CHECK: [[OMP_IS_LAST_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[OMP_IS_LAST]],
// CHECK: [[IS_LAST_IT:%.+]] = icmp ne i{{[0-9]+}} [[OMP_IS_LAST_VAL]], 0
// CHECK: br i1 [[IS_LAST_IT]], label %[[OMP_LASTPRIV_BLOCK:.+]], label %[[OMP_LASTPRIV_DONE:.+]]

// CHECK: [[OMP_LASTPRIV_BLOCK]]:
// CHECK: [[T_VAR_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[T_VAR_PRIV]],
// CHECK: store i{{[0-9]+}} [[T_VAR_VAL]], i{{[0-9]+}}* [[T_VAR_ADDR_REF]],
// CHECK: [[BCAST_VEC_ADDR_REF:%.+]] = bitcast [2 x i{{[0-9]+}}]* [[VEC_ADDR_REF]] to i8*
// CHECK: [[BCAST_VEC_PRIV:%.+]] = bitcast [2 x i{{[0-9]+}}]* [[VEC_PRIV]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[BCAST_VEC_ADDR_REF]], i8* [[BCAST_VEC_PRIV]],
// CHECK: [[S_ARR_BEGIN:%.+]] = getelementptr inbounds [2 x [[S_INT_TY]]], [2 x [[S_INT_TY]]]* [[S_ARR_ADDR_REF]], i{{[0-9]+}} 0, i{{[0-9]+}} 0
// CHECK: [[S_ARR_PRIV_BCAST:%.+]] = bitcast [2 x [[S_INT_TY]]]* [[S_ARR_PRIV]] to [[S_INT_TY]]*
// CHECK: [[S_ARR_BEGIN_GEP:%.+]] = getelementptr [[S_INT_TY]], [[S_INT_TY]]* [[S_ARR_BEGIN]], i{{[0-9]+}} 2
// CHECK: [[S_ARR_IS_EMPTY:%.+]] = icmp eq [[S_INT_TY]]* [[S_ARR_BEGIN]], [[S_ARR_BEGIN_GEP]]
// CHECK: br i1 [[S_ARR_IS_EMPTY]], label %[[S_ARR_COPY_DONE:.+]], label %[[S_ARR_COPY_BLOCK:.+]]
// CHECK: [[S_ARR_COPY_BLOCK]]:
// CHECK: [[S_ARR_SRC_EL:%.+]] = phi [[S_INT_TY]]*{{.+}}
// CHECK: [[S_ARR_DST_EL:%.+]] = phi [[S_INT_TY]]*{{.+}}
// CHECK: [[S_ARR_DST_BCAST:%.+]] = bitcast [[S_INT_TY]]* [[S_ARR_DST_EL]] to i8*
// CHECK: [[S_ARR_SRC_BCAST:%.+]] = bitcast [[S_INT_TY]]* [[S_ARR_SRC_EL]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[S_ARR_DST_BCAST]], i8* [[S_ARR_SRC_BCAST]]{{.+}})
// CHECK: [[S_ARR_DST_NEXT:%.+]] = getelementptr [[S_INT_TY]], [[S_INT_TY]]* [[S_ARR_DST_EL]], i{{[0-9]+}} 1
// CHECK: [[S_ARR_SRC_NEXT:%.+]] = getelementptr{{.+}}
// CHECK: [[CPY_IS_FINISHED:%.+]] = icmp eq [[S_INT_TY]]* [[S_ARR_DST_NEXT]], [[S_ARR_BEGIN_GEP]]
// CHECK: br i1 [[CPY_IS_FINISHED]], label %[[S_ARR_COPY_DONE]], label %[[S_ARR_COPY_BLOCK]]
// CHECK: [[S_ARR_COPY_DONE]]:
// CHECK: [[TMP_VAL:%.+]] = load [[S_INT_TY]]*, [[S_INT_TY]]** [[TMP_PRIV]],
// CHECK: [[VAR_ADDR_REF_BCAST:%.+]] = bitcast [[S_INT_TY]]* [[TMP_REF]] to i8*
// CHECK: [[TMP_VAL_BCAST:%.+]] = bitcast [[S_INT_TY]]* [[TMP_VAL]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[VAR_ADDR_REF_BCAST]], i8* [[TMP_VAL_BCAST]],{{.+}})
// CHECK: ret void

// outlined function for 'parallel for'
// CHECK-64: define{{.+}} void [[OMP_PARFOR_OUTLINED]](i32* noalias %{{.+}}, i32* noalias %{{.+}}, {{.+}}, {{.+}}, {{.+}} [[VEC_IN:%.+]], {{.+}} [[T_VAR_IN:%.+]], {{.+}} [[S_ARR_IN:%.+]], {{.+}} [[VAR_IN:%.+]])
// CHECK-32: define{{.+}} void [[OMP_PARFOR_OUTLINED]](i32* noalias %{{.+}}, i32* noalias %{{.+}}, {{.+}}, {{.+}}, {{.+}} [[VEC_IN:%.+]], {{.+}} [[T_VAR_IN:%.+]], {{.+}} [[S_ARR_IN:%.+]], {{.+}} [[VAR_IN:%.+]])

// CHECK: {{.+}} = alloca i{{[0-9]+}}*,
// CHECK: {{.+}} = alloca i{{[0-9]+}}*,
// CHECK: [[VEC_ADDR:%.+]] = alloca [2 x i{{[0-9]+}}]*,
// CHECK: [[T_VAR_ADDR:%.+]] = alloca i{{[0-9]+}}*,
// CHECK: [[S_ARR_ADDR:%.+]] = alloca [2 x [[S_INT_TY]]]*,
// CHECK: [[VAR_ADDR:%.+]] = alloca [[S_INT_TY]]*,
// skip loop variables
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: {{.+}} = alloca i{{[0-9]+}},
// CHECK: [[OMP_IS_LAST:%.+]] = alloca i{{[0-9]+}},
// CHECK: [[T_VAR_PRIV:%.+]] = alloca i{{[0-9]+}},
// CHECK: [[VEC_PRIV:%.+]] = alloca [2 x i{{[0-9]+}}],
// CHECK: [[S_ARR_PRIV:%.+]] = alloca [2 x [[S_INT_TY]]],
// CHECK: [[VAR_PRIV:%.+]] = alloca [[S_INT_TY]],
// CHECK: [[TMP_PRIV:%.+]] = alloca [[S_INT_TY]]*,

// copy from parameters to local address variables
// CHECK: store [2 x i{{[0-9]+}}]* [[VEC_IN]], [2 x i{{[0-9]+}}]** [[VEC_ADDR]],
// CHECK: store i{{[0-9]+}}* [[T_VAR_IN]], i{{[0-9]+}}** [[T_VAR_ADDR]],
// CHECK: store [2 x [[S_INT_TY]]]* [[S_ARR_IN]], [2 x [[S_INT_TY]]]** [[S_ARR_ADDR]],
// CHECK: store [[S_INT_TY]]* [[VAR_IN]], [[S_INT_TY]]** [[VAR_ADDR]],

// load content of local address variables
// CHECK: [[VEC_ADDR_REF:%.+]] = load [2 x i{{[0-9]+}}]*, [2 x i{{[0-9]+}}]** [[VEC_ADDR]],
// CHECK: [[T_VAR_ADDR_REF:%.+]] = load i{{[0-9]+}}*, i{{[0-9]+}}** [[T_VAR_ADDR]],
// CHECK: [[S_ARR_ADDR_REF:%.+]] = load [2 x [[S_INT_TY]]]*, [2 x [[S_INT_TY]]]** [[S_ARR_ADDR]],
// CHECK: store i{{[0-9]+}} 0, i{{[0-9]+}}* [[OMP_IS_LAST]],

// call constructor for s_arr
// CHECK: [[S_ARR_BGN:%.+]] = getelementptr{{.+}} [2 x [[S_INT_TY]]], [2 x [[S_INT_TY]]]* [[S_ARR_PRIV]],
// CHECK: [[S_ARR_END:%.+]] = getelementptr {{.+}} [[S_INT_TY]], [[S_INT_TY]]* [[S_ARR_BGN]],
// CHECK: br label %[[S_ARR_CST_LOOP:.+]]
// CHECK: [[S_ARR_CST_LOOP]]:
// CHECK: [[S_ARR_CTOR:%.+]] = phi {{.+}}
// CHECK: call void [[S_INT_TY_DEF_CONSTR]]([[S_INT_TY]]* [[S_ARR_CTOR]])
// CHECK: [[S_ARR_NEXT:%.+]] = getelementptr {{.+}} [[S_ARR_CTOR]],
// CHECK: [[S_ARR_DONE:%.+]] = icmp {{.+}} [[S_ARR_NEXT]], [[S_ARR_END]]
// CHECK: br i1 [[S_ARR_DONE]], label %[[S_ARR_CST_END:.+]], label %[[S_ARR_CST_LOOP]]
// CHECK: [[S_ARR_CST_END]]:
// CHECK: [[VAR_ADDR_REF:%.+]] = load [[S_INT_TY]]*, [[S_INT_TY]]** [[VAR_ADDR]],
// CHECK: call void [[S_INT_TY_DEF_CONSTR]]([[S_INT_TY]]* [[VAR_PRIV]])
// CHECK: store [[S_INT_TY]]* [[VAR_PRIV]], [[S_INT_TY]]** [[TMP_PRIV]],

// CHECK: call void @__kmpc_for_static_init_4(

// assignment: vec[i] = t_var;
// CHECK: [[IV_VAL:%.+]] =
// CHECK: [[T_VAR_PRIV_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[T_VAR_PRIV]],
// CHECK: [[VEC_PTR:%.+]] = getelementptr inbounds [2 x i{{[0-9]+}}], [2 x i{{[0-9]+}}]* [[VEC_PRIV]], i{{[0-9]+}} 0, i{{[0-9]+}} {{.+}}
// CHECK:  store i{{[0-9]+}} [[T_VAR_PRIV_VAL]], i{{[0-9]+}}* [[VEC_PTR]],

// assignment: s_arr[i] = var;
// CHECK-DAG: [[S_ARR_PTR:%.+]] = getelementptr inbounds [2 x [[S_INT_TY]]], [2 x [[S_INT_TY]]]* [[S_ARR_PRIV]],
// CHECK-DAG: [[TMP_VAL:%.+]] = load [[S_INT_TY]]*, [[S_INT_TY]]** [[TMP_PRIV]],
// CHECK-DAG: [[S_ARR_PTR_BCAST:%.+]] = bitcast [[S_INT_TY]]* [[S_ARR_PTR]] to i8*
// CHECK-DAG: [[TMP_VAL_BCAST:%.+]] = bitcast [[S_INT_TY]]* [[TMP_VAL]] to i8*
// CHECK-DAG: call void @llvm.memcpy.{{.+}}(i8* [[S_ARR_PTR_BCAST]], i8* [[TMP_VAL_BCAST]],

// CHECK: call void @__kmpc_for_static_fini(

// lastprivates
// CHECK: [[OMP_IS_LAST_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[OMP_IS_LAST]],
// CHECK: [[IS_LAST_IT:%.+]] = icmp ne i{{[0-9]+}} [[OMP_IS_LAST_VAL]], 0
// CHECK: br i1 [[IS_LAST_IT]], label %[[OMP_LASTPRIV_BLOCK:.+]], label %[[OMP_LASTPRIV_DONE:.+]]

// CHECK: [[OMP_LASTPRIV_BLOCK]]:
// CHECK: [[T_VAR_VAL:%.+]] = load i{{[0-9]+}}, i{{[0-9]+}}* [[T_VAR_PRIV]],
// CHECK: store i{{[0-9]+}} [[T_VAR_VAL]], i{{[0-9]+}}* [[T_VAR_ADDR_REF]],
// CHECK: [[BCAST_VEC_ADDR_REF:%.+]] = bitcast [2 x i{{[0-9]+}}]* [[VEC_ADDR_REF]] to i8*
// CHECK: [[BCAST_VEC_PRIV:%.+]] = bitcast [2 x i{{[0-9]+}}]* [[VEC_PRIV]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[BCAST_VEC_ADDR_REF]], i8* [[BCAST_VEC_PRIV]],
// CHECK: [[S_ARR_BEGIN:%.+]] = getelementptr inbounds [2 x [[S_INT_TY]]], [2 x [[S_INT_TY]]]* [[S_ARR_ADDR_REF]], i{{[0-9]+}} 0, i{{[0-9]+}} 0
// CHECK: [[S_ARR_PRIV_BCAST:%.+]] = bitcast [2 x [[S_INT_TY]]]* [[S_ARR_PRIV]] to [[S_INT_TY]]*
// CHECK: [[S_ARR_BEGIN_GEP:%.+]] = getelementptr [[S_INT_TY]], [[S_INT_TY]]* [[S_ARR_BEGIN]], i{{[0-9]+}} 2
// CHECK: [[S_ARR_IS_EMPTY:%.+]] = icmp eq [[S_INT_TY]]* [[S_ARR_BEGIN]], [[S_ARR_BEGIN_GEP]]
// CHECK: br i1 [[S_ARR_IS_EMPTY]], label %[[S_ARR_COPY_DONE:.+]], label %[[S_ARR_COPY_BLOCK:.+]]
// CHECK: [[S_ARR_COPY_BLOCK]]:
// CHECK: [[S_ARR_SRC_EL:%.+]] = phi [[S_INT_TY]]*{{.+}}
// CHECK: [[S_ARR_DST_EL:%.+]] = phi [[S_INT_TY]]*{{.+}}
// CHECK: [[S_ARR_DST_BCAST:%.+]] = bitcast [[S_INT_TY]]* [[S_ARR_DST_EL]] to i8*
// CHECK: [[S_ARR_SRC_BCAST:%.+]] = bitcast [[S_INT_TY]]* [[S_ARR_SRC_EL]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[S_ARR_DST_BCAST]], i8* [[S_ARR_SRC_BCAST]]{{.+}})
// CHECK: [[S_ARR_DST_NEXT:%.+]] = getelementptr [[S_INT_TY]], [[S_INT_TY]]* [[S_ARR_DST_EL]], i{{[0-9]+}} 1
// CHECK: [[S_ARR_SRC_NEXT:%.+]] = getelementptr{{.+}}
// CHECK: [[CPY_IS_FINISHED:%.+]] = icmp eq [[S_INT_TY]]* [[S_ARR_DST_NEXT]], [[S_ARR_BEGIN_GEP]]
// CHECK: br i1 [[CPY_IS_FINISHED]], label %[[S_ARR_COPY_DONE]], label %[[S_ARR_COPY_BLOCK]]
// CHECK: [[S_ARR_COPY_DONE]]:
// CHECK: [[TMP_VAL1:%.+]] = load [[S_INT_TY]]*, [[S_INT_TY]]** [[TMP_PRIV]],
// CHECK: [[VAR_ADDR_REF_BCAST:%.+]] = bitcast [[S_INT_TY]]* [[VAR_ADDR_REF]] to i8*
// CHECK: [[TMP_VAL1_BCAST:%.+]] = bitcast [[S_INT_TY]]* [[TMP_VAL1]] to i8*
// CHECK: call void @llvm.memcpy.{{.+}}(i8* [[VAR_ADDR_REF_BCAST]], i8* [[TMP_VAL1_BCAST]],{{.+}})
// CHECK: ret void

// CHECK: !{!"llvm.loop.vectorize.enable", i1 true}
#endif

