# BUILDING
# docker build -t stuckless/sagetv-server-java8:latest .

FROM stuckless/sagetv-base:latest

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

RUN set -x

RUN \
  apt-get update && \
  apt-get install -y openjdk-8-jdk && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/*


# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

