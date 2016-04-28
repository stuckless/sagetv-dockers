#!/usr/bin/env bash

if [ "$1" = "" ] ; then
    # if rebuilding comskip
    # docker build -t stuckless/comskip-build:latest comskip-build/
    # cp /tmp/Comskip/comskip ./sagetv-base/
    # chmod 775 sagetv-base/comskip
    docker build -t stuckless/sagetv-base:latest sagetv-base/
    docker build -t stuckless/sagetv-server-java7:latest sagetv-server-java7/
    docker build -t stuckless/sagetv-server-java8:latest sagetv-server-java8/
else
    DOCKERDIR=`basename $1`
    docker build -t stuckless/${DOCKERDIR}:latest $1/
fi