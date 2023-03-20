#!/bin/sh -e
[ -f "$REPO_ROOT/.fetched" ] && exit 0

echo
echo '>>> fetching'
echo

curl "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$KERN_VER.tar.xz" -o $SOURCES/linux-$KERN_VER.tar.xz
curl "https://musl.libc.org/releases/musl-$MUSL_VER.tar.gz" -o $SOURCES/musl-$MUSL_VER.tar.gz
curl -L "https://github.com/llvm/llvm-project/releases/download/llvmorg-$LLVM_VER/llvm-project-$LLVM_VER.src.tar.xz" -o $SOURCES/llvm-$LLVM_VER.tar.xz

tar -xf $SOURCES/linux-$KERN_VER.tar.xz -C $SOURCES
tar -xf $SOURCES/musl-$MUSL_VER.tar.gz -C $SOURCES
tar -xf $SOURCES/llvm-$LLVM_VER.tar.xz -C $SOURCES
mv $SOURCES/llvm-project-$LLVM_VER.src $SOURCES/llvm-$LLVM_VER

touch $REPO_ROOT/.fetched
