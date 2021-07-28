#!/bin/sh
. ./cfg.sh

mkdir -p $CHROOT
mkdir -p $SOURCES
mkdir -p $BUILD

./boot-kern-headers.sh
./boot-compiler-rt.sh
./boot-musl.sh
./boot-libcxx.sh

./fetch.sh
