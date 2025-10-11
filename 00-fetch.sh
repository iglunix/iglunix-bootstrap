#!/bin/sh -e
[ -f "$REPO_ROOT/.fetched" ] && exit 0

echo
echo '>>> fetching'
echo

curl "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$KERN_VER.tar.xz" -o $SOURCES/linux-$KERN_VER.tar.xz
curl "https://musl.libc.org/releases/musl-$MUSL_VER.tar.gz" -o $SOURCES/musl-$MUSL_VER.tar.gz
curl -L "https://github.com/llvm/llvm-project/releases/download/llvmorg-$LLVM_VER/llvm-project-$LLVM_VER.src.tar.xz" -o $SOURCES/llvm-$LLVM_VER.tar.xz
curl -L "https://mbsd.evolvis.org/MirOS/dist/mir/mksh/mksh-$MKSH_VER.tgz" -o $SOURCES/mksh-$MKSH_VER.tgz
curl -L "http://landley.net/toybox/downloads/toybox-$TOYBOX_VER.tar.gz" -o $SOURCES/toybox-$TOYBOX_VER.tar.gz
curl -L "https://busybox.net/downloads/busybox-$BUSYBOX_VER.tar.bz2" -o $SOURCES/busybox-$BUSYBOX_VER.tar.bz2

tar -xf $SOURCES/linux-$KERN_VER.tar.xz -C $SOURCES
tar -xf $SOURCES/musl-$MUSL_VER.tar.gz -C $SOURCES
tar -xf $SOURCES/llvm-$LLVM_VER.tar.xz -C $SOURCES
mv $SOURCES/llvm-project-$LLVM_VER.src $SOURCES/llvm-$LLVM_VER
sed -i 's|set(LLVM_USE_HOST_TOOLS ON)|set(LLVM_USE_HOST_TOOLS OFF)|g' $SOURCES/llvm-$LLVM_VER/llvm/CMakeLists.txt
tar -xf $SOURCES/toybox-$TOYBOX_VER.tar.gz -C $SOURCES
tar -xf $SOURCES/busybox-$BUSYBOX_VER.tar.bz2 -C $SOURCES

tar -xf $SOURCES/mksh-$MKSH_VER.tgz -C $SOURCES
mv $SOURCES/mksh $SOURCES/mksh-$MKSH_VER

touch $REPO_ROOT/.fetched
