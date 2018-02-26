; RUN: llc -march=hexagon < %s | FileCheck %s

; CHECK-LABEL: test_0000
; CHECK: vdelta
define <128 x i8> @test_0000(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 127, i32 127, i32 57, i32 57, i32 35, i32 35, i32 21, i32 21, i32 71, i32 71, i32 65, i32 65, i32 27, i32 27, i32 109, i32 109, i32 109, i32 109, i32 27, i32 27, i32 65, i32 65, i32 71, i32 71, i32 21, i32 21, i32 35, i32 35, i32 57, i32 57, i32 127, i32 127, i32 17, i32 17, i32 23, i32 23, i32 23, i32 23, i32 77, i32 77, i32 53, i32 53, i32 53, i32 53, i32 43, i32 43, i32 53, i32 53, i32 53, i32 53, i32 23, i32 23, i32 53, i32 53, i32 23, i32 23, i32 35, i32 35, i32 35, i32 35, i32 23, i32 23, i32 23, i32 23, i32 119, i32 119, i32 119, i32 119, i32 19, i32 19, i32 65, i32 65, i32 19, i32 19, i32 19, i32 19, i32 9, i32 9, i32 9, i32 9, i32 95, i32 95, i32 25, i32 25, i32 25, i32 25, i32 11, i32 11, i32 25, i32 25, i32 25, i32 25, i32 13, i32 13, i32 13, i32 13, i32 119, i32 119, i32 33, i32 33, i32 61, i32 61, i32 61, i32 61, i32 117, i32 117, i32 117, i32 117, i32 19, i32 19, i32 117, i32 117, i32 79, i32 79, i32 79, i32 79, i32 79, i32 79, i32 79, i32 79, i32 17, i32 17, i32 17, i32 17, i32 69, i32 69, i32 79, i32 79>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_0001
; CHECK: vdelta
define <128 x i8> @test_0001(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 5, i32 5, i32 75, i32 75, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 51, i32 51, i32 51, i32 51, i32 51, i32 51, i32 51, i32 51, i32 55, i32 55, i32 9, i32 9, i32 75, i32 75, i32 109, i32 109, i32 81, i32 81, i32 83, i32 83, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 81, i32 81, i32 75, i32 75, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 87, i32 87, i32 87, i32 87, i32 3, i32 3, i32 29, i32 29, i32 101, i32 101, i32 123, i32 123, i32 73, i32 73, i32 73, i32 73, i32 123, i32 123, i32 93, i32 93, i32 33, i32 33, i32 119, i32 119, i32 21, i32 21, i32 3, i32 3, i32 21, i32 21, i32 79, i32 79, i32 3, i32 3, i32 21, i32 21, i32 79, i32 79, i32 21, i32 21, i32 69, i32 69, i32 39, i32 39, i32 69, i32 69, i32 27, i32 27, i32 69, i32 69, i32 63, i32 63, i32 25, i32 25, i32 25, i32 25, i32 11, i32 11, i32 25, i32 25, i32 25, i32 25, i32 63, i32 63, i32 63, i32 63, i32 63, i32 63, i32 83, i32 83, i32 65, i32 65>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_0002
; CHECK: vdelta
define <128 x i8> @test_0002(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 95, i32 95, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 15, i32 15, i32 41, i32 41, i32 15, i32 15, i32 15, i32 15, i32 59, i32 59, i32 59, i32 59, i32 59, i32 59, i32 59, i32 59, i32 39, i32 39, i32 39, i32 39, i32 39, i32 39, i32 25, i32 25, i32 35, i32 35, i32 35, i32 35, i32 101, i32 101, i32 101, i32 101, i32 107, i32 107, i32 61, i32 61, i32 65, i32 65, i32 65, i32 65, i32 39, i32 39, i32 39, i32 39, i32 107, i32 107, i32 107, i32 107, i32 93, i32 93, i32 43, i32 43, i32 33, i32 33, i32 33, i32 33, i32 53, i32 53, i32 43, i32 43, i32 43, i32 43, i32 43, i32 43, i32 33, i32 33, i32 33, i32 33, i32 37, i32 37, i32 35, i32 35, i32 33, i32 33, i32 33, i32 33, i32 13, i32 13, i32 31, i32 31, i32 53, i32 53, i32 53, i32 53, i32 35, i32 35, i32 35, i32 35, i32 35, i32 35, i32 35, i32 35, i32 33, i32 33, i32 33, i32 33, i32 51, i32 51, i32 25, i32 25, i32 31, i32 31, i32 25, i32 25, i32 53, i32 53, i32 53, i32 53, i32 51, i32 51, i32 51, i32 51>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_0003
; CHECK: vdelta
define <128 x i8> @test_0003(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 89, i32 89, i32 89, i32 89, i32 109, i32 109, i32 7, i32 7, i32 99, i32 99, i32 99, i32 99, i32 109, i32 109, i32 31, i32 31, i32 111, i32 111, i32 111, i32 111, i32 99, i32 99, i32 5, i32 5, i32 9, i32 9, i32 99, i32 99, i32 99, i32 99, i32 5, i32 5, i32 59, i32 59, i32 21, i32 21, i32 59, i32 59, i32 59, i32 59, i32 17, i32 17, i32 15, i32 15, i32 99, i32 99, i32 17, i32 17, i32 99, i32 99, i32 99, i32 99, i32 9, i32 9, i32 9, i32 9, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 99, i32 99, i32 41, i32 41, i32 41, i32 41, i32 47, i32 47, i32 41, i32 41, i32 41, i32 41, i32 47, i32 47, i32 41, i32 41, i32 41, i32 41, i32 109, i32 109, i32 109, i32 109, i32 109, i32 109, i32 109, i32 109, i32 59, i32 59, i32 89, i32 89, i32 47, i32 47, i32 47, i32 47, i32 89, i32 89, i32 55, i32 55, i32 69, i32 69, i32 69, i32 69, i32 69, i32 69, i32 69, i32 69, i32 89, i32 89, i32 89, i32 89, i32 89, i32 89, i32 89, i32 89, i32 55, i32 55, i32 29, i32 29, i32 117, i32 117, i32 55, i32 55, i32 89, i32 89, i32 55, i32 55>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_0004
; CHECK: vdelta
define <128 x i8> @test_0004(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 27, i32 27, i32 69, i32 69, i32 27, i32 27, i32 27, i32 27, i32 79, i32 79, i32 93, i32 93, i32 79, i32 79, i32 79, i32 79, i32 99, i32 99, i32 105, i32 105, i32 99, i32 99, i32 99, i32 99, i32 85, i32 85, i32 39, i32 39, i32 85, i32 85, i32 27, i32 27, i32 69, i32 69, i32 69, i32 69, i32 55, i32 55, i32 55, i32 55, i32 55, i32 55, i32 55, i32 55, i32 55, i32 55, i32 55, i32 55, i32 57, i32 57, i32 57, i32 57, i32 51, i32 51, i32 13, i32 13, i32 107, i32 107, i32 107, i32 107, i32 85, i32 85, i32 85, i32 85, i32 87, i32 87, i32 87, i32 87, i32 11, i32 11, i32 49, i32 49, i32 13, i32 13, i32 13, i32 13, i32 13, i32 13, i32 13, i32 13, i32 49, i32 49, i32 95, i32 95, i32 49, i32 49, i32 95, i32 95, i32 51, i32 51, i32 53, i32 53, i32 95, i32 95, i32 95, i32 95, i32 51, i32 51, i32 51, i32 51, i32 25, i32 25, i32 51, i32 51, i32 25, i32 25, i32 25, i32 25, i32 87, i32 87, i32 87, i32 87, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 107, i32 107, i32 93, i32 93, i32 51, i32 51, i32 81, i32 81, i32 81, i32 81>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_0005
; CHECK: vdelta
define <128 x i8> @test_0005(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 29, i32 29, i32 29, i32 29, i32 79, i32 79, i32 79, i32 79, i32 9, i32 9, i32 27, i32 27, i32 79, i32 79, i32 29, i32 29, i32 31, i32 31, i32 69, i32 69, i32 9, i32 9, i32 31, i32 31, i32 9, i32 9, i32 31, i32 31, i32 31, i32 31, i32 9, i32 9, i32 57, i32 57, i32 57, i32 57, i32 51, i32 51, i32 109, i32 109, i32 79, i32 79, i32 79, i32 79, i32 79, i32 79, i32 21, i32 21, i32 27, i32 27, i32 21, i32 21, i32 27, i32 27, i32 27, i32 27, i32 31, i32 31, i32 105, i32 105, i32 31, i32 31, i32 31, i32 31, i32 21, i32 21, i32 79, i32 79, i32 79, i32 79, i32 79, i32 79, i32 49, i32 49, i32 119, i32 119, i32 119, i32 119, i32 21, i32 21, i32 107, i32 107, i32 107, i32 107, i32 21, i32 21, i32 71, i32 71, i32 71, i32 71, i32 71, i32 71, i32 21, i32 21, i32 21, i32 21, i32 119, i32 119, i32 119, i32 119, i32 67, i32 67, i32 37, i32 37, i32 37, i32 37, i32 37, i32 37, i32 67, i32 67, i32 41, i32 41, i32 81, i32 81, i32 81, i32 81, i32 71, i32 71, i32 71, i32 71, i32 71, i32 71, i32 71, i32 71, i32 81, i32 81, i32 81, i32 81>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_0006
; CHECK: vdelta
define <128 x i8> @test_0006(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 45, i32 45, i32 47, i32 47, i32 47, i32 47, i32 47, i32 47, i32 25, i32 25, i32 3, i32 3, i32 21, i32 21, i32 21, i32 21, i32 103, i32 103, i32 103, i32 103, i32 125, i32 125, i32 125, i32 125, i32 75, i32 75, i32 25, i32 25, i32 25, i32 25, i32 75, i32 75, i32 55, i32 55, i32 55, i32 55, i32 69, i32 69, i32 69, i32 69, i32 55, i32 55, i32 55, i32 55, i32 25, i32 25, i32 25, i32 25, i32 99, i32 99, i32 99, i32 99, i32 17, i32 17, i32 55, i32 55, i32 55, i32 55, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 41, i32 41, i32 41, i32 41, i32 103, i32 103, i32 93, i32 93, i32 83, i32 83, i32 83, i32 83, i32 93, i32 93, i32 93, i32 93, i32 43, i32 43, i32 43, i32 43, i32 25, i32 25, i32 25, i32 25, i32 25, i32 25, i32 43, i32 43, i32 103, i32 103, i32 25, i32 25, i32 91, i32 91, i32 33, i32 33, i32 91, i32 91, i32 13, i32 13, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 91, i32 91, i32 37, i32 37, i32 63, i32 63, i32 33, i32 33, i32 33, i32 33, i32 3, i32 3, i32 41, i32 41, i32 93, i32 93, i32 93, i32 93>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_0007
; CHECK: vdelta
define <128 x i8> @test_0007(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 85, i32 85, i32 11, i32 11, i32 119, i32 119, i32 119, i32 119, i32 81, i32 81, i32 11, i32 11, i32 111, i32 111, i32 81, i32 81, i32 13, i32 13, i32 111, i32 111, i32 27, i32 27, i32 81, i32 81, i32 27, i32 27, i32 13, i32 13, i32 27, i32 27, i32 13, i32 13, i32 39, i32 39, i32 39, i32 39, i32 81, i32 81, i32 27, i32 27, i32 85, i32 85, i32 35, i32 35, i32 85, i32 85, i32 85, i32 85, i32 39, i32 39, i32 13, i32 13, i32 39, i32 39, i32 39, i32 39, i32 83, i32 83, i32 83, i32 83, i32 83, i32 83, i32 83, i32 83, i32 21, i32 21, i32 103, i32 103, i32 21, i32 21, i32 103, i32 103, i32 19, i32 19, i32 19, i32 19, i32 19, i32 19, i32 19, i32 19, i32 29, i32 29, i32 29, i32 29, i32 1, i32 1, i32 1, i32 1, i32 29, i32 29, i32 29, i32 29, i32 73, i32 73, i32 73, i32 73, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 71, i32 71, i32 77, i32 77, i32 71, i32 71, i32 71, i32 71, i32 35, i32 35, i32 35, i32 35, i32 21, i32 21, i32 79, i32 79, i32 59, i32 59, i32 59, i32 59, i32 17, i32 17, i32 17, i32 17>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_0008
; CHECK: vdelta
define <128 x i8> @test_0008(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 99, i32 99, i32 53, i32 53, i32 111, i32 111, i32 65, i32 65, i32 71, i32 71, i32 71, i32 71, i32 71, i32 71, i32 71, i32 71, i32 95, i32 95, i32 95, i32 95, i32 25, i32 25, i32 95, i32 95, i32 25, i32 25, i32 71, i32 71, i32 77, i32 77, i32 77, i32 77, i32 25, i32 25, i32 25, i32 25, i32 87, i32 87, i32 25, i32 25, i32 115, i32 115, i32 65, i32 65, i32 115, i32 115, i32 115, i32 115, i32 45, i32 45, i32 45, i32 45, i32 99, i32 99, i32 99, i32 99, i32 71, i32 71, i32 71, i32 71, i32 11, i32 11, i32 11, i32 11, i32 67, i32 67, i32 45, i32 45, i32 45, i32 45, i32 45, i32 45, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 71, i32 71, i32 55, i32 55, i32 55, i32 55, i32 1, i32 1, i32 1, i32 1, i32 59, i32 59, i32 59, i32 59, i32 55, i32 55, i32 55, i32 55, i32 89, i32 89, i32 89, i32 89, i32 89, i32 89, i32 89, i32 89, i32 45, i32 45, i32 75, i32 75, i32 17, i32 17, i32 17, i32 17, i32 1, i32 1, i32 67, i32 67, i32 63, i32 63, i32 1, i32 1, i32 59, i32 59, i32 89, i32 89, i32 89, i32 89, i32 63, i32 63>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_0009
; CHECK: vdelta
define <128 x i8> @test_0009(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 57, i32 57, i32 59, i32 59, i32 59, i32 59, i32 57, i32 57, i32 93, i32 93, i32 93, i32 93, i32 57, i32 57, i32 95, i32 95, i32 55, i32 55, i32 105, i32 105, i32 105, i32 105, i32 105, i32 105, i32 21, i32 21, i32 21, i32 21, i32 67, i32 67, i32 67, i32 67, i32 61, i32 61, i32 59, i32 59, i32 33, i32 33, i32 33, i32 33, i32 115, i32 115, i32 115, i32 115, i32 33, i32 33, i32 33, i32 33, i32 67, i32 67, i32 67, i32 67, i32 67, i32 67, i32 67, i32 67, i32 33, i32 33, i32 67, i32 67, i32 61, i32 61, i32 61, i32 61, i32 79, i32 79, i32 45, i32 45, i32 33, i32 33, i32 79, i32 79, i32 41, i32 41, i32 91, i32 91, i32 79, i32 79, i32 45, i32 45, i32 107, i32 107, i32 61, i32 61, i32 107, i32 107, i32 107, i32 107, i32 55, i32 55, i32 5, i32 5, i32 107, i32 107, i32 107, i32 107, i32 39, i32 39, i32 39, i32 39, i32 5, i32 5, i32 5, i32 5, i32 51, i32 51, i32 45, i32 45, i32 45, i32 45, i32 45, i32 45, i32 47, i32 47, i32 47, i32 47, i32 45, i32 45, i32 45, i32 45, i32 5, i32 5, i32 11, i32 11, i32 5, i32 5, i32 11, i32 11>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_000a
; CHECK: vdelta
define <128 x i8> @test_000a(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 87, i32 87, i32 87, i32 87, i32 45, i32 45, i32 45, i32 45, i32 57, i32 57, i32 57, i32 57, i32 87, i32 87, i32 87, i32 87, i32 15, i32 15, i32 15, i32 15, i32 21, i32 21, i32 21, i32 21, i32 21, i32 21, i32 43, i32 43, i32 81, i32 81, i32 81, i32 81, i32 39, i32 39, i32 77, i32 77, i32 33, i32 33, i32 33, i32 33, i32 9, i32 9, i32 9, i32 9, i32 37, i32 37, i32 37, i32 37, i32 9, i32 9, i32 9, i32 9, i32 77, i32 77, i32 77, i32 77, i32 31, i32 31, i32 31, i32 31, i32 43, i32 43, i32 33, i32 33, i32 125, i32 125, i32 125, i32 125, i32 105, i32 105, i32 105, i32 105, i32 5, i32 5, i32 39, i32 39, i32 39, i32 39, i32 39, i32 39, i32 111, i32 111, i32 25, i32 25, i32 25, i32 25, i32 99, i32 99, i32 99, i32 99, i32 99, i32 99, i32 77, i32 77, i32 99, i32 99, i32 33, i32 33, i32 33, i32 33, i32 19, i32 19, i32 19, i32 19, i32 7, i32 7, i32 125, i32 125, i32 7, i32 7, i32 7, i32 7, i32 59, i32 59, i32 59, i32 59, i32 7, i32 7, i32 57, i32 57, i32 111, i32 111, i32 111, i32 111, i32 109, i32 109, i32 109, i32 109>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_000b
; CHECK: vdelta
define <128 x i8> @test_000b(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 7, i32 7, i32 7, i32 7, i32 41, i32 41, i32 7, i32 7, i32 41, i32 41, i32 41, i32 41, i32 7, i32 7, i32 41, i32 41, i32 41, i32 41, i32 35, i32 35, i32 35, i32 35, i32 35, i32 35, i32 15, i32 15, i32 113, i32 113, i32 123, i32 123, i32 113, i32 113, i32 35, i32 35, i32 73, i32 73, i32 73, i32 73, i32 35, i32 35, i32 73, i32 73, i32 63, i32 63, i32 69, i32 69, i32 35, i32 35, i32 11, i32 11, i32 11, i32 11, i32 11, i32 11, i32 21, i32 21, i32 77, i32 77, i32 77, i32 77, i32 77, i32 77, i32 77, i32 77, i32 51, i32 51, i32 51, i32 51, i32 89, i32 89, i32 89, i32 89, i32 103, i32 103, i32 103, i32 103, i32 97, i32 97, i32 123, i32 123, i32 31, i32 31, i32 21, i32 21, i32 21, i32 21, i32 21, i32 21, i32 21, i32 21, i32 21, i32 21, i32 21, i32 21, i32 51, i32 51, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 51, i32 51, i32 51, i32 51, i32 51, i32 51, i32 89, i32 89, i32 55, i32 55, i32 97, i32 97, i32 55, i32 55, i32 29, i32 29, i32 69, i32 69, i32 51, i32 51, i32 55, i32 55, i32 55, i32 55>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_000c
; CHECK: vdelta
define <128 x i8> @test_000c(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 101, i32 101, i32 31, i32 31, i32 97, i32 97, i32 31, i32 31, i32 19, i32 19, i32 19, i32 19, i32 19, i32 19, i32 19, i32 19, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 87, i32 87, i32 125, i32 125, i32 125, i32 125, i32 39, i32 39, i32 65, i32 65, i32 19, i32 19, i32 19, i32 19, i32 5, i32 5, i32 43, i32 43, i32 5, i32 5, i32 5, i32 5, i32 15, i32 15, i32 21, i32 21, i32 15, i32 15, i32 15, i32 15, i32 43, i32 43, i32 43, i32 43, i32 13, i32 13, i32 13, i32 13, i32 31, i32 31, i32 31, i32 31, i32 9, i32 9, i32 9, i32 9, i32 117, i32 117, i32 43, i32 43, i32 31, i32 31, i32 117, i32 117, i32 93, i32 93, i32 35, i32 35, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 59, i32 59, i32 93, i32 93, i32 125, i32 125, i32 43, i32 43, i32 43, i32 43, i32 43, i32 43, i32 43, i32 43, i32 43, i32 43, i32 49, i32 49, i32 49, i32 49, i32 23, i32 23, i32 5, i32 5, i32 57, i32 57, i32 57, i32 57, i32 23, i32 23, i32 23, i32 23, i32 23, i32 23, i32 5, i32 5>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_000d
; CHECK: vdelta
define <128 x i8> @test_000d(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 59, i32 59, i32 41, i32 41, i32 125, i32 125, i32 59, i32 59, i32 41, i32 41, i32 63, i32 63, i32 63, i32 63, i32 41, i32 41, i32 41, i32 41, i32 107, i32 107, i32 7, i32 7, i32 7, i32 7, i32 107, i32 107, i32 107, i32 107, i32 41, i32 41, i32 41, i32 41, i32 37, i32 37, i32 37, i32 37, i32 11, i32 11, i32 11, i32 11, i32 81, i32 81, i32 81, i32 81, i32 95, i32 95, i32 45, i32 45, i32 93, i32 93, i32 93, i32 93, i32 93, i32 93, i32 35, i32 35, i32 57, i32 57, i32 95, i32 95, i32 95, i32 95, i32 37, i32 37, i32 97, i32 97, i32 19, i32 19, i32 19, i32 19, i32 97, i32 97, i32 53, i32 53, i32 53, i32 53, i32 43, i32 43, i32 43, i32 43, i32 101, i32 101, i32 101, i32 101, i32 99, i32 99, i32 99, i32 99, i32 99, i32 99, i32 99, i32 99, i32 97, i32 97, i32 23, i32 23, i32 89, i32 89, i32 51, i32 51, i32 51, i32 51, i32 89, i32 89, i32 45, i32 45, i32 51, i32 51, i32 51, i32 51, i32 113, i32 113, i32 89, i32 89, i32 89, i32 89, i32 75, i32 75, i32 75, i32 75, i32 89, i32 89, i32 89, i32 89, i32 63, i32 63, i32 63, i32 63>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_000e
; CHECK: vdelta
define <128 x i8> @test_000e(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 63, i32 63, i32 63, i32 63, i32 35, i32 35, i32 13, i32 13, i32 35, i32 35, i32 25, i32 25, i32 13, i32 13, i32 13, i32 13, i32 53, i32 53, i32 53, i32 53, i32 7, i32 7, i32 7, i32 7, i32 13, i32 13, i32 13, i32 13, i32 13, i32 13, i32 51, i32 51, i32 125, i32 125, i32 125, i32 125, i32 25, i32 25, i32 25, i32 25, i32 59, i32 59, i32 37, i32 37, i32 37, i32 37, i32 37, i32 37, i32 41, i32 41, i32 41, i32 41, i32 19, i32 19, i32 53, i32 53, i32 53, i32 53, i32 53, i32 53, i32 53, i32 53, i32 53, i32 53, i32 51, i32 51, i32 69, i32 69, i32 113, i32 113, i32 31, i32 31, i32 31, i32 31, i32 31, i32 31, i32 73, i32 73, i32 51, i32 51, i32 3, i32 3, i32 3, i32 3, i32 121, i32 121, i32 3, i32 3, i32 121, i32 121, i32 3, i32 3, i32 121, i32 121, i32 31, i32 31, i32 41, i32 41, i32 55, i32 55, i32 51, i32 51, i32 51, i32 51, i32 51, i32 51, i32 51, i32 51, i32 31, i32 31, i32 117, i32 117, i32 41, i32 41, i32 41, i32 41, i32 69, i32 69, i32 69, i32 69, i32 31, i32 31, i32 31, i32 31, i32 51, i32 51, i32 109, i32 109>
  ret <128 x i8> %p
}

; CHECK-LABEL: test_000f
; CHECK: vdelta
define <128 x i8> @test_000f(<128 x i8> %v0) #0 {
  %p = shufflevector <128 x i8> %v0, <128 x i8> undef, <128 x i32><i32 119, i32 119, i32 119, i32 119, i32 123, i32 123, i32 123, i32 123, i32 119, i32 119, i32 61, i32 61, i32 61, i32 61, i32 61, i32 61, i32 19, i32 19, i32 19, i32 19, i32 73, i32 73, i32 19, i32 19, i32 109, i32 109, i32 109, i32 109, i32 63, i32 63, i32 63, i32 63, i32 53, i32 53, i32 53, i32 53, i32 51, i32 51, i32 51, i32 51, i32 65, i32 65, i32 65, i32 65, i32 87, i32 87, i32 87, i32 87, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 43, i32 43, i32 43, i32 43, i32 53, i32 53, i32 53, i32 53, i32 47, i32 47, i32 47, i32 47, i32 35, i32 35, i32 57, i32 57, i32 35, i32 35, i32 35, i32 35, i32 47, i32 47, i32 47, i32 47, i32 83, i32 83, i32 1, i32 1, i32 55, i32 55, i32 29, i32 29, i32 83, i32 83, i32 83, i32 83, i32 55, i32 55, i32 55, i32 55, i32 125, i32 125, i32 125, i32 125, i32 11, i32 11, i32 11, i32 11, i32 125, i32 125, i32 125, i32 125, i32 57, i32 57, i32 115, i32 115, i32 127, i32 127, i32 53, i32 53, i32 35, i32 35, i32 35, i32 35, i32 57, i32 57, i32 35, i32 35, i32 35, i32 35, i32 35, i32 35>
  ret <128 x i8> %p
}

attributes #0 = { nounwind readnone "target-cpu"="hexagonv60" "target-features"="+hvx,+hvx-length128b" }
