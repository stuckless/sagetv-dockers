# BUILDING
# docker build -t comskip-build .
#
# RUNNING
# docker run -t -i -v /tmp:/build comskip-build
#
# DESCRIPTION
# Simple
FROM ubuntu:14.04

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

ENV APP_NAME="SageTV Comskip Test Runner"
ENV DEBIAN_FRONTEND noninteractive

ADD comskip /usr/bin

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Install dependencies
RUN set -x
RUN apt-get update
RUN apt-get install -y software-properties-common
#RUN add-apt-repository -y ppa:mc3man/trusty-media
#RUN apt-get update
RUN add-apt-repository -y universe && apt-get update && apt-get install -y libargtable2-0
RUN apt-get install -y libavcodec-dev libavformat-dev libavutil-dev


RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


CMD /usr/bin/comskip
