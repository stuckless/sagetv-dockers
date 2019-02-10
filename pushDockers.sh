#!/usr/bin/env bash

docker login --username=stuckless --email=sean.stuckless@gmail.com

#docker push stuckless/sagetv-base
#docker push stuckless/sagetv-server-java7
#docker push stuckless/sagetv-server-java8
#docker push stuckless/sagetv-server-java9
#docker push stuckless/sagetv-server-java10
docker push stuckless/sagetv-server-java11
#docker push stuckless/sagetv-server-beta
