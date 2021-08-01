#!/bin/sh

function insane() {
	echo "Insane!"
	exit 1
}

clang++ sanity.cpp \
--target=$ARCH-unknown-linux-musl \
--sysroot=$CHROOT \
--unwindlib=libunwind \
--stdlib=libc++ \
--rtlib=compiler-rt \
-nostdinc \
-nostdinc++ \
-I$CHROOT/usr/include/c++/v1 \
-I$CHROOT/usr/include/ \
-I$CHROOT/usr/lib/clang/12.0.1/include \
-o sanity || insane

LD_LIBRARY_PATH=$CHROOT/usr/lib ./sanity || insane
