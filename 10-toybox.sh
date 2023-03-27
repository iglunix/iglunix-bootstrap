#!/bin/sh -e
[ -f "$REPO_ROOT/.toybox" ] && exit 0

export TARGET=""

cd $SOURCES/toybox-$TOYBOX_VER

$MAKE defconfig
$MAKE -j1
$MAKE PREFIX=$SYSROOT install

# Provided by NetBSD Curses
rm $SYSROOT/usr/bin/clear
rm $SYSROOT/usr/bin/reset

# Provided by LLVM
rm $SYSROOT/usr/bin/readelf

touch $REPO_ROOT/.toybox
