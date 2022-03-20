#!/bin/sh -e

export LLVM_VER=13.0.1
export MUSL_VER=1.2.2
export KERN_VER=5.16.16

export REPO_ROOT=$(realpath $(dirname $0))
export SOURCES="$REPO_ROOT/src"
export BUILD="$REPO_ROOT/build"
export SYSROOT="$REPO_ROOT/sysroot"

[ -z "$MAKE" ] && export MAKE=make

mkdir -p "$SOURCES"
mkdir -p "$BUILD"
mkdir -p "$SYSROOT"

./0-fetch.sh

./1-linux-headers.sh

./2-musl-headers.sh

./3-compiler-rt.sh

./4-musl.sh

./5-libunwind.sh

./6-libcxx.sh
