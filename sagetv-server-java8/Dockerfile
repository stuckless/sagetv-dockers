# BUILDING
# docker build -t stuckless/sagetv-server-java8:latest .

FROM stuckless/sagetv-base:latest

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

RUN set -x
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD run-sagetv.sh
