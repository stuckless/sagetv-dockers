# BUILDING
# docker build -t stuckless/sagetv-server-java7:latest .

FROM stuckless/sagetv-base

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

RUN set -x

# Install Java.
RUN \
  add-apt-repository ppa:openjdk-r/ppa  && \  
  apt-get update && \
  apt-get install -y openjdk-7-jdk && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/*


# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

