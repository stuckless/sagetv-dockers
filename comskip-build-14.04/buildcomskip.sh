#!/usr/bin/env bash

cd /build

rm -rf dcadec
git clone https://github.com/foo86/dcadec
cd dcadec
make install
cd ..

rm -rf Comskip
git clone git://github.com/erikkaashoek/Comskip
cd Comskip
./autogen.sh
echo "configure static"
./configure --enable-static
make