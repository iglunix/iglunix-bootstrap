export ARCH=$(uname -m)

export REPO_ROOT=$(pwd)
export CHROOT=$REPO_ROOT/chroot
export SOURCES=$REPO_ROOT/sources
export BUILD=$REPO_ROOT/build

export GMAKE=make
export NINJA=samu

export JOBS=$(nproc)

export LLVM_VER=15.0.2
export MUSL_VER=1.2.3
export KERN_VER=5.19.14
