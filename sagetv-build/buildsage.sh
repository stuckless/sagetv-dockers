#!/bin/bash

BUILD_DIR=${BUILD_DIR:-/build}
SAGETV_REPO=${SAGETV_REPO:-https://github.com/google/sagetv.git}

# If the /build mount is an actual sagetv sources, the just use it
# otherwise we fetch and build
USE_EXISTING_SOURCES="N"
if [ -e "${BUILD_DIR}/build/buildall.sh" ] ; then
    USE_EXISTING_SOURCES="Y"
fi

PGID=${PGID:-1000}
PUID=${PUID:-1000}

cd $BUILD_DIR

if [ "$USE_EXISTING_SOURCES" == "Y" ]; then
    if [ -e './build-pre.sh' ] ; then
       . ./build-pre.sh || exit 1
    fi

    cd ./build
    ./buildall.sh
    cd ../

    if [ -e './build-post.sh' ] ; then
       . ./build-post.sh
    fi

    echo "Setting persmissions..."
    chown -Rc --from=root $PUID:$PGID build
else
    rm -rf sagetv
    git clone "$SAGETV_REPO"

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
fi

