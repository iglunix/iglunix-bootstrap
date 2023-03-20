#!/bin/sh -e

if [ -z "$1" ]; then
	export ARCH=$(uname -m)
else
	export ARCH=$1
fi

export LLVM_VER=16.0.0
export MUSL_VER=1.2.3
export KERN_VER=6.2.7

export TARGET=$ARCH-linux-musl

export REPO_ROOT=$(realpath $(dirname $0))
export SOURCES="$REPO_ROOT/src"
export BUILD="$REPO_ROOT/build"
export SYSROOT="$REPO_ROOT/sysroot"

export COMMON_FLAGS="-O2 -pipe --sysroot=$SYSROOT -unwindlib=libunwind"

# because ubuntu uses old llvm (14) we need to pass -mno-relax still
if [ "$ARCH" = "riscv64" ]; then
	export COMMON_FLAGS="$COMMON_FLAGS -mno-relax"
fi

export CFLAGS="${COMMON_FLAGS}"
export CXXFLAGS="${COMMON_FLAGS} -stdlib=libc++"
export LDFLAGS="-fuse-ld=lld -rtlib=compiler-rt"

export CC=clang
export CXX=clang++

export AR=llvm-ar
export RANLIB=llvm-ranlib

[ -z "$MAKE" ] && export MAKE=make

mkdir -p "$SOURCES"
mkdir -p "$BUILD"
mkdir -p "$SYSROOT"

./0-fetch.sh

./1-linux-headers.sh

./2-musl-headers.sh

./3-compiler-rt.sh

sudo cp $SYSROOT/lib/linux/* $(clang -print-resource-dir)/lib/linux

./4-musl.sh

# export COMMON_FLAGS="-O2 -pipe --sysroot=$SYSROOT -unwindlib=libunwind -v"

# export CFLAGS="${COMMON_FLAGS}"
# export CXXFLAGS="${COMMON_FLAGS} -stdlib=libc++"
# export LDFLAGS="-fuse-ld=lld -rtlib=compiler-rt -resource-dir=$SYSROOT"

./5-libunwind.sh

./6-libcxx.sh

./7-sanity.sh
