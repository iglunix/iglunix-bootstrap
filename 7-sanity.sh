#!/bin/sh -e

insane() {
	echo "Insane!"
	exit 1
}

./x86_64-iglunix-linux-musl-c++.sh \
sanity.cpp -o sanity || insane

LD_LIBRARY_PATH=$(pwd)/sysroot/lib ./sanity || insane
