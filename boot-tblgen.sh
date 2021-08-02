#!/bin/sh
# builds llvm-tblgen and clang-tblgen

stat $REPO_ROOT/.boot-tblgen >/dev/null 2>/dev/null \
&& exit 0

mkdir -p $BUILD/tblgen-$LLVM_VER
cd $BUILD/tblgen-$LLVM_VER

cmake -G Ninja -Wno-dev $SOURCES/llvm-$LLVM_VER/llvm \
-DLLVM_ENABLE_PROJECTS="llvm;clang"

samu llvm-tblgen clang-tblgen

cd $REPO_ROOT
touch $REPO_ROOT/.boot-tblgen
