#!/usr/bin/env bash

# this assumes you downloaded it using docker pull
# docker pull stuckless/sagetv-server
docker run -d --name sagetv-server \
  -v /home/seans/docker/sagetv-server/MEDIA:/var/media \
  -v /home/seans/docker/sagetv-server/MEDIAEXT:/var/mediaext \
  -v /home/seans/docker/sagetv-server/SAGETV/:/opt/sagetv \
  -p 42024:42024 -p 7818:7818 -p 8270:8270/udp -p 31100:31100/udp -p 31099:31099 \
  -p 16867:16867/udp -p 16869:16869/udp -p 16881:16881/udp \
  --net host \
  --env OPT_GENTUNER=Y \
  --env OPT_COMMANDIR=Y \
  --env OPT_STUCKLESS=Y \
  --env OPT_JAVA_VER=8 \
  -t -i sagetv-server "$@"

# NOTE: if you built it yourself, then run without the stuckles/ prefix
#docker run -d --name sagetv-server \
#  -v /home/seans/docker/sagetv-server/MEDIA:/var/media \
#  -v /home/seans/docker/sagetv-server/MEDIAEXT:/var/mediaext \
#  -v /home/seans/docker/sagetv-server/SAGETV/:/opt/sagetv \
#  -p 42024:42024 -p 7818:7818 -p 8270:8270/udp -p 31100:31100/udp -p 31099:31099 \
#  -p 16867:16867/udp -p 16869:16869/udp -p 16881:16881/udp \
#  --net host \
#  -t -i sagetv-server "$@"