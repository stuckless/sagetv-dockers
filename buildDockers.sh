#!/usr/bin/env bash

if [ "$1" = "" ] ; then
    # if rebuilding comskip
    # docker build -t stuckless/comskip-build:latest comskip-build/
    # cp /tmp/Comskip/comskip ./sagetv-base/
    # chmod 775 sagetv-base/comskip
    # stop if any fail
    docker build -t stuckless/sagetv-base:latest sagetv-base/ && \
    docker build -t stuckless/sagetv-server-java8:latest sagetv-server-java8/ && \
    docker build -t stuckless/sagetv-server-java11:latest sagetv-server-java11/ && \
    docker build -t stuckless/sagetv-server-java16:latest sagetv-server-java16/
    # canot be built
    # docker build -t stuckless/sagetv-server-java7:latest sagetv-server-java7/ && \
    # docker build -t stuckless/sagetv-server-java9:latest sagetv-server-java9/ && \
    echo "Dockers are built"
else
    DOCKERDIR=`basename $1`
    docker build -t stuckless/${DOCKERDIR}:latest $1/
fi