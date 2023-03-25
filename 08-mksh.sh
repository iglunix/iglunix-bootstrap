#!/bin/sh -e
[ -f "$REPO_ROOT/.mksh" ] && exit 0

cd $SOURCES/mksh-$MKSH_VER

sh Build.sh

cp mksh $SYSROOT/bin
ln -s mksh $SYSROOT/bin/sh
ln -s mksh $SYSROOT/bin/bash

touch $REPO_ROOT/.mksh
