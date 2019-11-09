// RUN: %clang -c -o - -emit-interface-stubs %s | FileCheck %s

// CHECK:      --- !experimental-ifs-v1
// CHECK-NEXT: IfsVersion: 1.0
// CHECK-NEXT: Triple: x86_64-unknown-linux-gnu
// CHECK-NEXT: ObjectFileFormat: ELF
// CHECK-NEXT: Symbols:
// CHECK-NEXT: ...

template<typename T> struct S2 { static unsigned f(); };
template<typename T> struct S3  { using S2<T>::f; };

typedef struct {} S4;
using ::S4;

template<typename T, T t> struct C3{};
template<bool b> using U1 = C3<bool, b>;