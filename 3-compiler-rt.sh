#!/bin/sh -e
[ -f "$REPO_ROOT/.compiler-rt" ] && exit 0

cd "$BUILD"
mkdir -p compiler-rt
cd compiler-rt

cmake -G Ninja "$SOURCES/llvm-$LLVM_VER/compiler-rt" \
-DCOMPILER_RT_BUILD_BUILTINS=ON \
-DCOMPILER_RT_INCLUDE_TESTS=OFF \
-DCOMPILER_RT_BUILD_CRT=ON \
-DCOMPILER_RT_BUILD_SANITIZERS=OFF \
-DCOMPILER_RT_BUILD_XRAY=OFF \
-DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
-DCOMPILER_RT_BUILD_PROFILE=OFF \
-DCOMPILER_RT_BUILD_MEMPROF=OFF \
-DCOMPILER_RT_BUILD_ORC=OFF \
-DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON \
-DCOMPILER_RT_INSTALL_PATH="/usr/lib/clang/16/" \
-DCMAKE_ASM_COMPILER=clang \
-DCMAKE_C_COMPILER=clang \
-DCMAKE_CXX_COMPILER=clang++ \
-DCMAKE_ASM_COMPILER_TARGET=$TARGET \
-DCMAKE_C_COMPILER_TARGET=$TARGET \
-DCMAKE_CXX_COMPILER_TARGET=$TARGET \
-DCMAKE_SYSROOT="$SYSROOT" \
-DCMAKE_INSTALL_PREFIX="/usr" \
-DCMAKE_C_COMPILER_WORKS=1 \
-DCMAKE_CXX_COMPILER_WORKS=1 \
-DCMAKE_SIZEOF_VOID_P=8

samu
DESTDIR=$SYSROOT samu install

touch $REPO_ROOT/.compiler-rt
