#!/bin/bash

BUILD_DIR=${BUILD_DIR:-/build}
SAGETV_REPO=${SAGETV_REPO:-https://github.com/google/sagetv.git}
PGID=${PGID:-1000}
PUID=${PUID:-1000}

cd $BUILD_DIR
rm -rf sagetv
git clone $SAGETV_REPO

if [ -e './build-pre.sh' ] ; then
   . ./build-pre.sh || exit 1
fi

cd sagetv/build
./buildall.sh

cd ../../

if [ -e './build-post.sh' ] ; then
   . ./build-post.sh
fi

echo "Setting persmissions..."
chown -R $PUID:$PGID sagetv