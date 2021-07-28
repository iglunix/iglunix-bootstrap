#!/bin/sh

stat $REPO_ROOT/.boot-clang >/dev/null 2>/dev/null \
&& exit 0

mkdir -p $BUILD/clang-$LLVM_VER
cd $BUILD/clang-$LLVM_VER

cmake -G Ninja $SOURCES/llvm-$LLVM_VER/clang \
-DCMAKE_INSTALL_PREFIX=/usr

$NINJA clang-resource-headers
DESTDIR=$CHROOT $NINJA install-clang-resource-headers

cd $REPO_ROOT
touch .boot-clang
