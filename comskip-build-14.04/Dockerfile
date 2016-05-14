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

ENV APP_NAME="SageTV Comskip Builder"
ENV DEBIAN_FRONTEND noninteractive

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Install dependencies
RUN set -x
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:mc3man/trusty-media
RUN apt-get update

RUN apt-get install -y \
        build-essential \
        git \
        libargtable2-dev libsdl1.2-dev \
        ffmpeg libva-dev libsoxr-dev libvorbis-dev libbz2-dev zlib1g-dev \
        libxvidcore-dev libvpx-dev libx264-dev libx265-dev libspeex-dev \
        libfdk-aac-dev libvorbisenc2 libopus-dev libmp3lame-dev \
        libdca-dev libfaac-dev libopencore-amrnb-dev libvo-aacenc-dev libopencore-amrwb-dev \
        libavcodec54 libavutil52 \
        autoconf automake libtool

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /build
ADD buildcomskip.sh /usr/bin/

# need to passed on the command line as the place to fetch and build the source
# -v full_path_to_local_empty_dir_where_sources_will_be_built:/build
VOLUME ["/build"]

WORKDIR /build

CMD buildcomskip.sh
