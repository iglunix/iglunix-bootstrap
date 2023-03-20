#!/bin/sh -e
SYSROOT=$(realpath $(dirname $0))/sysroot/
clang --sysroot=$SYSROOT --target=riscv64-linux-musl \
-rtlib=compiler-rt -unwindlib=libunwind -stdlib=libc++ \
-Wno-unused-command-line-argument -fuse-ld=lld \
"$@"
