# Iglunix Bootstrap Scripts
Theses scripts bootstrap Iglunix from a GNU/Linux host.

```sh
git clone --depth=1 "https://github.com/iglunix/iglunix-bootstrap"
./boot.sh

# use sudo or doas to chroot into the new system
doas ./chroot.sh
```

## Notes
 - These scripts are currently WIP and have only been tested on Arch Linux.
 - These sciprts do not intend to produce a fully functioning Iglunix
   installation but instead are just enough to build a chroot with a working
   LLVM/Musl toolchain that can be used to build Iglunix directly from git or
   any other LLVM/Musl distro.
