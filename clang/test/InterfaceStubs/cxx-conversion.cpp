// RUN: %clang -c -o - -emit-interface-stubs %s | FileCheck %s

// CHECK:      --- !experimental-ifs-v1
// CHECK-NEXT: IfsVersion: 1.0
// CHECK-NEXT: Triple: x86_64-unknown-linux-gnu
// CHECK-NEXT: ObjectFileFormat: ELF
// CHECK-NEXT: Symbols:
// CHECK-NEXT: ...

template<typename T> class C1 {
    long a;
    operator long() const { return a; }
};