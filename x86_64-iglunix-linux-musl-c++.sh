#!/bin/sh -e
SYSROOT=$(realpath $(dirname $0))/sysroot/
clang++ --sysroot=$SYSROOT --target=x86_64-linux-musl \
-nostdinc++ -isystem $SYSROOT/include/c++/v1 \
-Wl,--verbose -v $@