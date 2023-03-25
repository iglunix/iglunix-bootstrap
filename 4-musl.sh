#!/bin/sh -e
[ -f "$REPO_ROOT/.musl" ] && exit 0

cd $SOURCES/musl-$MUSL_VER

$MAKE distclean

CFLAGS="$CFLAGS --target=$TARGET" ./configure --prefix=/usr --disable-wrapper --target=$TARGET LIBCC=$SYSROOT/usr/lib/clang/16/lib/linux/libclang_rt.builtins-$ARCH.a

CFLAGS="$CFLAGS --target=$TARGET" $MAKE
CFLAGS="$CFLAGS --target=$TARGET" DESTDIR=$SYSROOT $MAKE install

mv $SYSROOT/usr/lib/libc.so $SYSROOT/lib/ld-musl-$ARCH.so.1
ln -s ../../lib/ld-musl-$ARCH.so.1 $SYSROOT/usr/lib/libc.so
ln -s ../../lib/ld-musl-$ARCH.so.1 $SYSROOT/usr/bin/ldd


touch $REPO_ROOT/.musl
