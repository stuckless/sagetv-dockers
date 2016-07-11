#!/bin/bash

# NOTE this is script that shows how to run the sagetv server in a docker container.
# the sagetv-webapi volume mapping shows how to map a folder in the webroot to a dev area for testing

CONTAINER=${CONTAINER:-sagetv-server-java8}

docker stop sagetv-server
docker rm -f sagetv-server

if [ "$1" = "stop" ] || [ "$2" = "stop" ] ; then
    exit 0;
fi

docker run -d --name sagetv-server \
  -v /home/seans/unRAID/mnt/user/sagemedia:/var/media \
  -v /home/seans/unRAID/mnt/user/mediaext:/var/mediaext \
  -v /home/seans/unRAID/mnt/user/apps/sagetv2:/opt/sagetv \
  -v /home/seans/unRAID:/unraid \
  --net host \
  --env PUID=1000 \
  --env PGID=1000 \
  --env VIDEO_GUID=19 \
  --env OPT_GENTUNER=Y \
  --env OPT_COMMANDIR=Y \
  --env OPT_COMSKIP=Y \
  --env JAVA_MEM_MB=768 \
  --privileged \
  -t -i "stuckless/${CONTAINER}" $1
