# BUILDING
# docker build -t stuckless/sagetv-server-java7:latest .

FROM stuckless/sagetv-base

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

RUN set -x
RUN add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y openjdk-7-jdk

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD run-sagetv.sh
