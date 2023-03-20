export ARCH=$(uname -m)
export TARGET=$ARCH-linux-musl

export REPO_ROOT=$(pwd)
export CHROOT=$REPO_ROOT/chroot
export SOURCES=$REPO_ROOT/sources
export BUILD=$REPO_ROOT/build

export GMAKE=make
export NINJA=samu

export JOBS=$(nproc)

export KERN_VER=5.13.6
export MUSL_VER=1.2.2
export LLVM_VER=12.0.1

