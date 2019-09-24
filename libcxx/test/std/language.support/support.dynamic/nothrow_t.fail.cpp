//===----------------------------------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++98, c++03

// Before GCC 6, aggregate initialization kicks in.
// See https://stackoverflow.com/q/41799015/627587.
// UNSUPPORTED: gcc-4, gcc-5

// struct nothrow_t {
//   explicit nothrow_t() = default;
// };
// extern const nothrow_t nothrow;

// This test checks for LWG 2510.

#include <new>


std::nothrow_t f() { return {}; } // expected-error 1 {{chosen constructor is explicit in copy-initialization}}

int main(int, char**) {
    return 0;
}
