#!/bin/sh -e
SYSROOT=$(realpath $(dirname $0))/sysroot/
clang++ --sysroot=$SYSROOT --target=riscv64-linux-musl \
-nostdinc++ \
-rtlib=compiler-rt -stdlib=libc++ -unwindlib=libunwind \
-Wno-unused-command-line-argument -fuse-ld=lld \
"$@"
