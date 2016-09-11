#!/usr/bin/env bash

cd /build
mkdir -p /build/comskipbuild
mkdir -p /build/bin
mkdir -p /build/etc
pushd /build/
if [ ! -e ffmpeg-2.2.tar.bz2 ] ; then
    wget http://www.xilka.com/xilka/source/comskip-0.93i.tar.xz
fi
if [ ! -e comskip-0.93i.tar.xz ] ; then
    wget http://ffmpeg.org/releases/ffmpeg-2.2.tar.bz2
fi

tar xf ffmpeg-2.2.tar.bz2
tar xf comskip-0.93i.tar.xz

popd
pushd /build/ffmpeg-2.2
./configure --prefix=/build/comskipbuild/install --disable-programs
make
make install
popd

pushd /sources/argtable2-13
./configure --prefix=/build/comskipbuild/install --disable-shared
make
make install
popd

pushd /build/comskip-0.93i
PKG_CONFIG_PATH=/build/comskipbuild/install/lib/pkgconfig ./configure --sysconfdir=/build/etc --bindir=/build/bin
make
make install