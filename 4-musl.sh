#!/bin/sh -e
[ -f "$REPO_ROOT/.musl" ] && exit 0

cd $SOURCES/musl-$MUSL_VER

$MAKE distclean

./configure --prefix=/ --target=$TARGET LIBCC=$SYSROOT/lib/linux/libclang_rt.builtins-$ARCH.a

$MAKE
DESTDIR=$SYSROOT $MAKE install

touch $REPO_ROOT/.musl
