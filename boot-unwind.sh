#!/bin/sh

stat $REPO_ROOT/.boot-libunwind >/dev/null 2>/dev/null \
&& exit 0

mkdir -p $BUILD/libunwind-$LLVM_VER

cd $BUILD/libunwind-$LLVM_VER

cmake -G Ninja $SOURCES/llvm-$LLVM_VER/libunwind \
-DCMAKE_C_COMPILER=clang \
-DCMAKE_CXX_COMPILER=clang++ \
-DCMAKE_INSTALL_PREFIX=/usr \
-DCMAKE_SYSROOT=$CHROOT \
-DLIBUNWIND_ENABLE_SHARED=ON \
-DLIBUNWIND_ENABLE_STATIC=ON \
-DLIBUNWIND_INSTALL_LIBRARY=ON \
-DLIBUNWIND_USE_COMPILER_RT=ON



$NINJA

DESTDIR=$CHROOT $NINJA install

cd $REPO_ROOT
touch .boot-libunwind
