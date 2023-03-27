#!/bin/sh -e

if [ -z "$1" ]; then
	export ARCH=$(uname -m)
else
	export ARCH=$1
fi

export LLVM_VER=16.0.0
export MUSL_VER=1.2.3
export KERN_VER=6.2.7
export MKSH_VER=R59c
export BUSYBOX_VER=1.36.0
export TOYBOX_VER=0.8.9

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

mkdir -p "$SYSROOT/usr/bin"
mkdir -p "$SYSROOT/usr/lib"
mkdir -p "$SYSROOT/bin"
mkdir -p "$SYSROOT/lib"

./00-fetch.sh

./01-linux-headers.sh

./02-musl-headers.sh

./03-compiler-rt.sh

sudo cp $SYSROOT/usr/lib/clang/16/lib/linux/* $(clang -print-resource-dir)/lib/linux

./04-musl.sh

# export COMMON_FLAGS="-O2 -pipe --sysroot=$SYSROOT -unwindlib=libunwind -v"

# export CFLAGS="${COMMON_FLAGS}"
# export CXXFLAGS="${COMMON_FLAGS} -stdlib=libc++"
# export LDFLAGS="-fuse-ld=lld -rtlib=compiler-rt -resource-dir=$SYSROOT"

./05-libunwind.sh

./06-libcxx.sh

./07-sanity.sh

export CC=$(pwd)/$ARCH-iglunix-linux-musl-cc.sh
export CXX=$(pwd)/$ARCH-iglunix-linux-musl-c++.sh

./08-mksh.sh

./09-busybox.sh

./10-toybox.sh

env -u CFLAGS -u CXXFLAGS -u LDFLAGS ./11-tblgen.sh

./12-llvm.sh
