#!/bin/sh -e

insane() {
	[ -f sanity ] && objdump -p sanity
	echo "Insane!"
	exit 1
}

./$ARCH-iglunix-linux-musl-c++.sh \
sanity.cpp -o sanity || insane

LD_LIBRARY_PATH=$(pwd)/sysroot/lib qemu-$ARCH ./sysroot/lib/libc.so ./sanity || insane
