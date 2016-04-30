#!/bin/bash

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
  -v /var/media:/var/media \
  -v /home/seans/docker/tmpdata/MEDIAEXT:/var/mediaext \
  -v /home/seans/docker/tmpdata/SAGETV/:/opt/sagetv \
  -v /home/seans/docker/tmpdata/UNRAID/:/unraid \
  --net host \
  --env OPT_GENTUNER=Y \
  --env OPT_COMMANDIR=Y \
  --env OPT_COMSKIP=Y \
  --env OPT_PLEX=Y \
  -t -i "$1" $2
