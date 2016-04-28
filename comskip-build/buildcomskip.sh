#!/usr/bin/env bash

cd /build
rm -rf Comskip
git clone git://github.com/erikkaashoek/Comskip
cd Comskip
./autogen.sh
./configure
make