#!/bin/sh -e
[ -f "$REPO_ROOT/.linux-headers" ] && exit 0

echo
echo '>>> linux-headers'
echo


cd $SOURCES/linux-$KERN_VER

$MAKE defconfig CC=cc HOSTCC=cc YACC=yacc
$MAKE headers CC=cc HOSTCC=cc YACC=yacc

find usr -name '.*' -exec rm {} \;
rm -f usr/include/Makefile
cp -r usr/include $SYSROOT

touch "$REPO_ROOT/.linux-headers"
