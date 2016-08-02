#!/usr/bin/env bash

cd /build
mkdir -p /build/comskipbuild
rm -rf /build/binaries/
mkdir -p /build/binaries/static/bin
mkdir -p /build/binaries/static/etc
mkdir -p /build/binaries/dynamic/bin
mkdir -p /build/binaries/dynamic/etc


pushd /build/

FFMPEG=ffmpeg-3.1
if [ ! -e ${FFMPEG}.tar.bz2 ] ; then
    wget http://ffmpeg.org/releases/${FFMPEG}.tar.bz2
fi

if [ ! -e ${FFMPEG} ] ; then
    tar xf ${FFMPEG}.tar.bz2
fi

popd
pushd /build/${FFMPEG}
./configure --prefix=/build/comskipbuild/install --disable-programs
make
make install
popd

# build static
rm -rf Comskip
git clone https://github.com/erikkaashoek/Comskip.git
pushd /build/Comskip
./autogen.sh
PKG_CONFIG_PATH=/build/comskipbuild/install/lib/pkgconfig ./configure --sysconfdir=/build/binaries/static/etc --bindir=/build/binaries/static/bin --enable-static
make
make install
popd

# build dynamic
#rm -rf Comskip
#git clone https://github.com/erikkaashoek/Comskip.git
#pushd /build/Comskip
#./autogen.sh
#./configure --sysconfdir=/build/binaries/dynamic/etc --bindir=/build/binaries/dynamic/bin
#make
#make install
