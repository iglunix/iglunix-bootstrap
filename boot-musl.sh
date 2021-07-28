#!/bin/sh

stat $REPO_ROOT/.boot-musl >/dev/null 2>/dev/null \
&& exit 0


cd $SOURCES/musl-$MUSL_VER
./configure --prefix=/usr \
--enable-wrapper=no

$GMAKE -j$JOBS

$GMAKE DESTDIR=$CHROOT install

rm $CHROOT/lib/ld-musl-$ARCH.so.1
mv $CHROOT/usr/lib/libc.so $CHROOT/lib/ld-musl-$ARCH.so.1
ln -sr $CHROOT/lib/ld-musl-$ARCH.so.1 $CHROOT/usr/lib/libc.so

cd $REPO_ROOT

touch .boot-musl
