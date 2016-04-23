#!/usr/bin/env bash

docker run -d --name sagetv-server \
  -v /home/seans/docker/sagetv-server/MEDIA:/var/media \
  -v /home/seans/docker/sagetv-server/MEDIAEXT:/var/mediaext \
  -v /home/seans/docker/sagetv-server/SAGETV/:/opt/sagetv \
  -p 42024:42024 -p 7818:7818 -p 8270:8270/udp -p 31100:31100/udp -p 31099:31099 \
  -p 16867:16867/udp -p 16869:16869/udp -p 16881:16881/udp \
  --net host \
  -t -i sagetv-server "$@"