#!/bin/bash

# NOTE this is script that shows how to run the sagetv server in a docker container.
# the sagetv-webapi volumn mapping shows how to map a folder in the webroot to a dev area for testing

if [ "$1" = "" ] ; then
    echo "Need to pass docker name (ie something like stuckless/sagetv-server-java7)"
    exit 1
fi

docker stop sagetv-server
docker rm -f sagetv-server

if [ "$1" = "stop" ] || [ "$2" = "stop" ] ; then
    exit 0;
fi

docker run -d --name sagetv-server \
  -v /home/seans/unRAID/mnt/user/sagemedia:/var/media \
  -v /home/seans/unRAID/mnt/user/mediaext:/var/mediaext \
  -v /home/seans/unRAID/mnt/user/apps/sagetv:/opt/sagetv \
  -v /home/seans/unRAID:/unraid \
  -v /home/seans/git/sagetv-webapi/app:/opt/sagetv/server/userdata/webserver/wwwroot/sage \
  --net host \
  --env OPT_GENTUNER=Y \
  --env OPT_COMMANDIR=Y \
  --env OPT_COMSKIP=Y \
  --env LICENCE_DATA=AAABBB \
  --env JAVA_MEM_MB=512 \
  --privileged \
  -t -i "$1" $2
