#!/bin/bash
set -ex

CLANG_VERSION=15.0.5

mkdir -p /tmp/llvm/build
cd /tmp/llvm/build
curl -o "/tmp/llvm/llvm-project-${CLANG_VERSION}.src.tar.xz" --insecure --retry 12 --retry-max-time 0 -C - -SL "https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANG_VERSION}/llvm-project-${CLANG_VERSION}.src.tar.xz"
tar -xf "/tmp/llvm/llvm-project-${CLANG_VERSION}.src.tar.xz" -C /tmp/llvm/
cmake -G Ninja -DCMAKE_BUILD_TYPE=MinSizeRel -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libc;libcxx;libcxxabi;libunwind;openmp" -DLLVM_ENABLE_RTTI="ON" "../llvm-project-${CLANG_VERSION}.src/llvm"
ninja -j "$(nproc)"
ninja install
rm -rf /tmp/llvm

echo '/usr/local/lib64' > /etc/ld.so.conf.d/clang-${CLANG_VERSION}-local-lib64.conf
ldconfig
