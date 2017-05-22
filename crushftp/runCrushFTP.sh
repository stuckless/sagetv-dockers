#!/bin/bash

# NOTE this is script that shows how to run the crushftp server in a docker container.

CONTAINER=${CONTAINER:-crushftp}

docker stop $CONTAINER
docker rm -f $CONTAINER

if [ "$1" = "stop" ] || [ "$2" = "stop" ] ; then
    exit 0;
fi

docker run -d --name $CONTAINER \
  -v /home/seans/unRAID/mnt/user/apps/crushftp:/var/opt/CrushFTP8_PC/ \
  -v /home/seans/unRAID/mnt/user/files:/files/ \
  --net bridge \
  --env PUID=1000 \
  --env PGID=1000 \
  --privileged \
  -p 9090:9090 \
  -p 9091:8080 \
  -p 9021:9021 \
  -t -i "stuckless/${CONTAINER}" $1
