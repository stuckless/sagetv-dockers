# BUILDING
# docker build -t stuckless/sagetv-base:latest .

FROM ubuntu:16.04

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

ENV APP_NAME="SageTV Media Server"

ENV DEBIAN_FRONTEND=noninteractive

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

RUN set -x \
  && apt-get update \
  && apt-get install -y wget curl libfaad2 net-tools file less vim software-properties-common

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD install-sagetv.sh /usr/bin/
ADD run-sagetv.sh /usr/bin/

VOLUME ["/var/media", "/var/mediaext", "/opt/sagetv"]

# Client (TCP 42024 for connecting, TCP 7818 for streaming, UDP 8270 for finding servers)
EXPOSE 42024 7818 8270

# All extenders (UDP 31100 for discovery, TCP 31099 for connections?)
EXPOSE 31100 31099

# Hauppage extender (all UDP)
EXPOSE 16867 16869 16881

# Web Server
EXPOSE 8080

CMD install-sagetv.sh