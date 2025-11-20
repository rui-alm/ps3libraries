#!/bin/sh -e
# libzip-0.9.3.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
# wget --continue http://www.nih.at/libzip/libzip-0.9.3.tar.bz2
wget --continue https://libzip.org/download/libzip-1.1.2.tar.xz

## Download an up-to-date config.guess and config.sub
if [ ! -f config.guess ]; then wget --continue http://git.savannah.gnu.org/cgit/config.git/plain/config.guess; fi
if [ ! -f config.sub ]; then wget --continue http://git.savannah.gnu.org/cgit/config.git/plain/config.sub; fi

## Unpack the source code.
rm -Rf libzip-1.1.2 && tar xfv libzip-1.1.2.tar.xz && cd libzip-1.1.2

## Replace config.guess and config.sub
cp ../config.guess ../config.sub .

## Patch the source code.
cat ../../patches/libzip-1.1.2.patch | patch -p1

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
