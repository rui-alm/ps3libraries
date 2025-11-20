#!/bin/sh -e
# zlib-1.2.11.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
wget --continue https://codeberg.org/ps3dev/zlib/archive/v1.2.11.tar.gz -O zlib-1.2.11.tar.gz

## Unpack the source code.
rm -Rf zlib && tar xfvz zlib-1.2.11.tar.gz && cd zlib

## Patch the source code.
cat ../../patches/zlib-1.2.11-PPU.patch | patch -p1

## Configure the build.
AR="powerpc64-ps3-elf-ar" CC="powerpc64-ps3-elf-gcc" RANLIB="powerpc64-ps3-elf-ranlib" \
./configure --prefix="$PS3DEV/portlibs/ppu" --static

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
