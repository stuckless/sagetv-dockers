# BUILDING
# docker build -t stuckless/sagetv-server-java8:latest .

FROM stuckless/sagetv-base:latest

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

RUN set -x

RUN mkdir -p /usr/lib/jvm && \
    cd /usr/lib/jvm/ && \
    wget https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz && \
    tar -zxvf openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz && \
    rm -f openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME=/usr/lib/jvm/java-se-8u41-ri \
    PATH=/usr/lib/jvm/java-se-8u41-ri/bin:${PATH}

