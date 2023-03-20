#!/bin/sh -e
[ -f "$REPO_ROOT/.linux-headers" ] && exit 0

echo
echo '>>> linux-headers'
echo

case $ARCH in
	"aarch64")
    		LARCH=arm64
    		;;
	"riscv64")
    		LARCH=riscv
    		;;
	*)
    		LARCH=$ARCH
    		;;
esac

cd $SOURCES/linux-$KERN_VER

$MAKE defconfig CC=cc HOSTCC=cc YACC=yacc ARCH=$LARCH
$MAKE headers CC=cc HOSTCC=cc YACC=yacc ARCH=$LARCH

find usr -name '.*' -exec rm {} \;
rm -f usr/include/Makefile
cp -r usr/include $SYSROOT

touch "$REPO_ROOT/.linux-headers"
