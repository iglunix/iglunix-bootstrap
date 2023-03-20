#!/bin/sh -e
[ -f "$REPO_ROOT/.musl-headers" ] && exit 0

cd $SOURCES/musl-$MUSL_VER

./configure --prefix=/usr

$MAKE DESTDIR=$SYSROOT install-headers

touch $REPO_ROOT/.musl-headers
