#!/bin/bash

mkdir build

CONTAINER=${CONTAINER:-comskip}
NAME=comskip
docker stop ${NAME}
docker rm -f ${NAME}

if [ "$1" = "stop" ] || [ "$2" = "stop" ] ; then
    exit 0;
fi

docker run -d --name ${NAME} \
  -v ${PWD}/build:/build \
  -t -i "stuckless/${CONTAINER}" $1
