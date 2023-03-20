#!/bin/sh -e
SYSROOT=$(realpath $(dirname $0))/sysroot/
clang++ --sysroot=$SYSROOT --target=x86_64-linux-musl \
-nostdinc++ -isystem $SYSROOT/usr/include/c++/v1 \
-rtlib=compiler-rt -stdlib=libc++ -unwindlib=libunwind \
-Wno-unused-command-line-argument -fuse-ld=lld \
"$@"
