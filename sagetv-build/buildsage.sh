#!/bin/bash

cd /build
rm -rf sagetv
git clone $SAGETV_REPO
cd sagetv/build
./buildall.sh
