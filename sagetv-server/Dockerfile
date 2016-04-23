# BUILDING
# docker build -t sagetv-server .

# RUNNING
# docker run -d --name sagetv-server \
#  -v /home/seans/docker/sagetv-server/MEDIA:/var/media \
#  -v /home/seans/docker/sagetv-server/SAGETV/:/opt/sagetv \
#  -p 42024:42024 -p 7818:7818 -p 8270:8270/udp -p 31100:31100/udp -p 31099:31099 \
#  -p 16867:16867/udp -p 16869:16869/udp -p 16881:16881/udp \
#  --net host \
#  -t -i sagetv-server "$@"

# STOPPING
# docker rm -f --force sagetv-server

# CONNECTING to the conntainer while it is running
# docker exec -i -t sagetv-server bash

FROM ubuntu:16.04

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

ENV APP_NAME="SageTV Media Server"

ENV DEBIAN_FRONTEND=noninteractive

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Create dir to keep things tidy
RUN mkdir /files

RUN set -x \
  && apt-get update \
  && apt-get install -y openjdk-8-jdk wget curl libfaad2 less net-tools

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /

ADD install-sagetv.sh /usr/bin/
ADD run-sagetv.sh /usr/bin/

VOLUME ["/var/media", "/var/mediaext", "/opt/sagetv"]

# Client (TCP 42024 for connecting, TCP 7818 for streaming, UDP 8270 for finding servers)
EXPOSE 42024 7818 8270

# All extenders (UDP 31100 for discovery, TCP 31099 for connections?)
EXPOSE 31100 31099

# Hauppage extender (all UDP)
EXPOSE 16867 16869 16881

CMD run-sagetv.sh