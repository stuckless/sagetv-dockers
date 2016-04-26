#!/usr/bin/env bash

if [ "$1" = "" ] ; then
    docker build -t stuckless/sagetv-base:latest sagetv-base/
    #docker build -t stuckless/sagetv-server-java7:latest sagetv-server-java7/
    #docker build -t stuckless/sagetv-server-java7-wine:latest sagetv-server-java7-wine/
    docker build -t stuckless/sagetv-server-java8:latest sagetv-server-java8/
    docker build -t stuckless/sagetv-server-java8-wine:latest sagetv-server-java8-wine/
else
    DOCKERDIR=`basename $1`
    docker build -t stuckless/${DOCKERDIR}:latest $1/
fi