# Iglunix Bootstrap Scripts
These scripts build an LLVM/Musl sysroot from a GNU host.

## Building

```sh
./boot.sh 
```

this will create a sysroot in `./sysroot`

## Running
We provide compiler wrapper scripts to use the
sysroot.

```
./x86_64-iglunix-linux-musl-c++.sh sanity.cpp
```

## Deps
 - clang
 - compiler-rt
 - lld
 - cmake
 - GNU make
 - python
