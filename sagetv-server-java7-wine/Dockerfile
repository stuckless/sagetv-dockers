# BUILDING
# docker build -t stuckless/sagetv-server-java7-wine:latest .

FROM stuckless/sagetv-server-java7:latest

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

RUN set -x
RUN add-apt-repository -y ppa:ubuntu-wine/ppa
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y wine1.8 winetricks

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wineboot --init

CMD run-sagetv.sh
