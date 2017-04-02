# BUILDING
# docker build -t stuckless/sagetv-base:latest .

# Ubuntu 16.04
FROM phusion/baseimage:0.9.19

CMD ["/sbin/my_init"]

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

# The docker container version, not SageTV version
ENV SAGETV_CONTAINER_VERSION="1.0.2"

ENV APP_NAME="SageTV Media Server"
ENV DEBIAN_FRONTEND=noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# add sagetv user and group
RUN useradd -u 911 -U -d /opt/sagetv -s /bin/bash -G video sagetv

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# sagetv stuff
RUN set -x \
  && apt-get update \
  && apt-get install -y wget curl libfaad2 net-tools file \
    less vim software-properties-common unzip cifs-utils lirc dos2unix

# comskip stuff
RUN add-apt-repository -y universe && apt-get update && apt-get install -y libargtable2-0 ffmpeg sudo

# java 8 stuff
#RUN \
#  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
#  add-apt-repository -y ppa:webupd8team/java && \
#  apt-get update && \
#  apt-get install -y oracle-java8-installer && \
#  rm -rf /var/lib/apt/lists/* && \
#  rm -rf /var/cache/oracle-jdk8-installer
#
#ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD init.d/10-adduser /etc/my_init.d/10-adduser
RUN chmod 755 /etc/my_init.d/10-adduser

ADD init.d/20-upgrade-sagetv /etc/my_init.d/20-upgrade-sagetv
RUN chmod 755 /etc/my_init.d/20-upgrade-sagetv

ADD init.d/25-upgrade-commandir /etc/my_init.d/25-upgrade-commandir
RUN chmod 755 /etc/my_init.d/25-upgrade-commandir

ADD init.d/25-upgrade-comskip /etc/my_init.d/25-upgrade-comskip
RUN chmod 755 /etc/my_init.d/25-upgrade-comskip

ADD init.d/25-upgrade-gentuner /etc/my_init.d/25-upgrade-gentuner
RUN chmod 755 /etc/my_init.d/25-upgrade-gentuner

ADD init.d/25-add-license /etc/my_init.d/25-add-license
RUN chmod 755 /etc/my_init.d/25-add-license

ADD init.d/25-update-memory /etc/my_init.d/25-update-memory
RUN chmod 755 /etc/my_init.d/25-update-memory

ADD init.d/30-setperms /etc/my_init.d/30-setperms
RUN chmod 755 /etc/my_init.d/30-setperms

ADD init.d/40-lirc /etc/my_init.d/40-lirc
RUN chmod 755 /etc/my_init.d/40-lirc

ADD init.d/85-user-script /etc/my_init.d/85-user-script
RUN chmod 755 /etc/my_init.d/85-user-script

ADD init.d/90-sagetv /etc/my_init.d/90-sagetv
RUN chmod 755 /etc/my_init.d/90-sagetv

ADD init.d/95-jstatd /etc/my_init.d/95-jstatd
RUN chmod 755 /etc/my_init.d/95-jstatd

ADD init.d/99-zmessage /etc/my_init.d/99-zmessage
RUN chmod 755 /etc/my_init.d/99-zmessage

# how to add a service...
#RUN mkdir /etc/service/complete
#ADD services.d/99-complete /etc/service/complete/run
#RUN chmod 755 /etc/service/complete/run

ADD etc.d/sagetv-sudo /etc/sudoers.d/
RUN chmod 440 /etc/sudoers.d/sagetv-sudo

# wine hack, wine is not installed, so this just is a pass-through
ADD wine.d/wine /usr/bin/
RUN chmod 755 /usr/bin/wine

RUN mkdir -p /sagetv_files/comskip
# assumes you've built it, if not, it will fail
ADD comskip.d/comskip /sagetv_files/comskip
ADD comskip.d/comskip.ini /sagetv_files/comskip

VOLUME ["/var/media", "/var/mediaext", "/opt/sagetv"]

# Client (TCP 42024 for connecting, TCP 7818 for streaming, UDP 8270 for finding servers)
EXPOSE 42024 7818 8270

# All extenders (UDP 31100 for discovery, TCP 31099 for connections?)
EXPOSE 31100 31099

# Hauppage extender (all UDP)
EXPOSE 16867 16869 16881

# Web Server
EXPOSE 8080
