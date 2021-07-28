#!/bin/sh
. ./cfg.sh

mkdir -p $CHROOT
mkdir -p $SOURCES
mkdir -p $BUILD

./fetch.sh

./boot-kern-headers.sh
./boot-compiler-rt.sh
./boot-musl.sh
./boot-unwind.sh
./boot-libcxxabi.sh
./boot-libcxx.sh
./boot-clang.sh

./sanity.sh
