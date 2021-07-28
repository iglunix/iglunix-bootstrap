#!/bin/sh

stat $REPO_ROOT/.boot-kern-headers >/dev/null 2>/dev/null \
&& exit 0

cd $SOURCES/linux-$KERN_VER

mkdir -p $CHROOT/usr

$GMAKE defconfig
$GMAKE headers
find -name '.*' -exec rm {} \;
rm usr/include/Makefile
cp -r usr/include $CHROOT/usr

cd $REPO_ROOT

touch .boot-kern-headers
