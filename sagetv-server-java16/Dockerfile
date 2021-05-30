# BUILDING
# docker build -t stuckless/sagetv-server-java16:latest .

FROM stuckless/sagetv-base:latest

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

RUN set -x

RUN mkdir -p /usr/lib/jvm && \
    cd /usr/lib/jvm/ && \
    wget https://download.java.net/openjdk/jdk16/ri/openjdk-16+36_linux-x64_bin.tar.gz && \
    tar -zxvf openjdk-16+36_linux-x64_bin.tar.gz && \
    rm -f openjdk-16+36_linux-x64_bin.tar.gz

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME=/usr/lib/jvm/jdk-16 \
    PATH=/usr/lib/jvm/jdk-16/bin:${PATH}

# NOTE: jssecerts is a schedules direct cerificate imported via
# https://stackoverflow.com/questions/21076179/pkix-path-building-failed-and-unable-to-find-valid-certification-path-to-requ
# into $JAVA_HOME/lib/security/
COPY SYSTEM/ /

RUN echo "PATH=${PATH}" > /etc/profile.d/sagetv.sh && \
    JAVA_HOME=/usr/lib/jvm/jdk-16 >> /etc/profile.d/sagetv.sh && \
    chmod 755 /etc/profile.d/sagetv.sh


