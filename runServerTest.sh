#!/bin/bash

# NOTE this is script that shows how to run the sagetv server in a docker container.
# the sagetv-webapi volume mapping shows how to map a folder in the webroot to a dev area for testing

if [ "$1" = "" ] ; then
    echo "Need to pass docker name (ie something like stuckless/sagetv-server-java7)"
    exit 1
fi

docker stop sagetv-server
docker rm -f sagetv-server

if [ "$1" = "stop" ] || [ "$2" = "stop" ] ; then
    exit 0;
fi

UNRAID=/home/sls/unRAID/
mkdir -p ${UNRAID}/mnt/user/sagemedia
mkdir -p ${UNRAID}/mnt/user/mediaext
mkdir -p ${UNRAID}/mnt/user/apps/sagetv

docker run -d --name sagetv-server \
  -v ${UNRAID}/mnt/user/sagemedia:/var/media \
  -v ${UNRAID}/mnt/user/mediaext:/var/mediaext \
  -v ${UNRAID}/mnt/user/apps/sagetv:/opt/sagetv \
  -v ${UNRAID}:/unraid \
  -v ${UNRAID}/git/sagetv-webapi/app:/opt/sagetv/server/userdata/webserver/wwwroot/sage \
  --net host \
  --env OPT_GENTUNER=Y \
  --env OPT_COMMANDIR=Y \
  --env OPT_COMSKIP=Y \
  --env PUID=1000 \
  --env PGID=1000 \
  --env VIDEO_GUID=44 \
  --env LICENCE_DATA=AAABBB \
  --env JAVA_MEM_MB=984 \
  --privileged \
  -t -i "$1" $2
