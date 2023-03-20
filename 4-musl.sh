#!/bin/sh -e
[ -f "$REPO_ROOT/.musl" ] && exit 0

cd $SOURCES/musl-$MUSL_VER

$MAKE distclean

CFLAGS="$CFLAGS --target=$TARGET" ./configure --prefix=/ --target=$TARGET LIBCC=$SYSROOT/lib/linux/libclang_rt.builtins-$ARCH.a

CFLAGS="$CFLAGS --target=$TARGET" $MAKE
CFLAGS="$CFLAGS --target=$TARGET" DESTDIR=$SYSROOT $MAKE install

touch $REPO_ROOT/.musl
