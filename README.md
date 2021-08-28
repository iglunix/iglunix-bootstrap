# Iglunix Bootstrap Scripts
Theses scripts bootstrap an LLVM/Musl toolchain from a GNU/Linux host primarily
for future use in
[iglunix-autobuild](https://github.com/iglunix/iglunix-autobuild) which aims to
build an Iglunix disk image from a GNU/Linux host.

You will need LLVM, Clang, libc++, libc++abi, etc installed
on your host machine as these scripts don't do the first step
of building LLVM against GNU libs.

```sh
git clone --depth=1 "https://github.com/iglunix/iglunix-bootstrap"
./boot.sh
```

## Notes
 - These scripts have only been tested on Arch Linux.
 - These sciprts do not intend to produce a fully functioning Iglunix
   installation but instead are just enough to build a chroot with a working
   LLVM/Musl toolchain that can be used to build Iglunix directly from git or
   any other LLVM/Musl distro.
