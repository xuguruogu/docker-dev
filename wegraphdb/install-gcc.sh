#!/bin/bash
set -ex

GCC_VERSION=gcc-11.3.0

mkdir -p /tmp/gcc/build
cd /tmp/gcc/build
curl -o "/tmp/gcc/${GCC_VERSION}.tar.xz" --insecure --retry 12 --retry-max-time 0 -C - -SL "http://mirrors.tencent.com/gnu/gcc/${GCC_VERSION}/${GCC_VERSION}.tar.xz"
tar -xf "/tmp/gcc/${GCC_VERSION}.tar.xz" -C /tmp/gcc/
"/tmp/gcc/${GCC_VERSION}/configure" \
    --enable-languages=c,c++ \
    --disable-libquadmath \
    --disable-libquadmath-support \
    --disable-bootstrap \
    --disable-werror \
    --enable-gold \
    --disable-multilib

make -j "$(nproc)"
make install
ln -sf /usr/local/bin/gcc /usr/local/bin/cc
ln -sf /usr/local/bin/g++ /usr/local/bin/c++
rm -rf /tmp/gcc

echo '/usr/local/lib64' > /etc/ld.so.conf.d/${GCC_VERSION}-local-lib64.conf
rm -f /usr/local/lib64/libstdc++.so.6.0*.py
ldconfig
