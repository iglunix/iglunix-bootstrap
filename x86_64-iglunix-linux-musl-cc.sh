#!/bin/sh -e
SYSROOT=$(realpath $(dirname $0))/sysroot/
clang --sysroot=$SYSROOT --target=x86_64-linux-musl \
-Wl,--verbose -v $@
