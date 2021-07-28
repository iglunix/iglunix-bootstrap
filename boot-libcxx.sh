#!/bin/sh

stat $REPO_ROOT/.boot-libcxx >/dev/null 2>/dev/null \
&& exit 0

mkdir -p $BUILD/libcxx-$LLVM_VER

cd $BUILD/libcxx-$LLVM_VER

cmake -G Ninja $SOURCES/llvm-$LLVM_VER/libcxx \
-DCMAKE_C_COMPILER=clang \
-DCMAKE_CXX_COMPILER=clang++ \
-DCMAKE_INSTALL_PREFIX=/usr \
-DCMAKE_SYSROOT=$CHROOT \
-DLIBCXX_HAS_MUSL_LIBC=ON \
-DLIBCXX_USE_COMPILER_RT=ON \
-DLIBCXX_HAS_ATOMIC_LIB=OFF \
-DLIBCXX_ENABLE_FILESYSTEM=ON \
-DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=ON \
-DLIBCXX_ENABLE_STATIC=OFF \
-DLIBCXX_STATICALLY_LINK_ABI_IN_SHARED_LIBRARY=ON \
-DLIBCXX_STATICALLY_LINK_ABI_IN_STATIC_LIBRARY=ON \
-DLIBCXX_ABI_LIBRARY_PATH=$CHROOT/usr/lib \
-DLIBCXX_CXX_ABI=libcxxabi \
-DLIBCXXABI_USE_LLVM_UNWINDER=ON
-DLIBCXXABI_USE_STATIC_UNWINDER=ON

#-DLIBCXX_ENABLE_LOCALIZATION=OFF

$NINJA

DESTDIR=$CHROOT $NINJA install

cd $REPO_ROOT
touch .boot-libcxx
