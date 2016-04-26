#!/usr/bin/env bash

docker login --username=stuckless --email=sean.stuckless@gmail.com

docker push stuckless/sagetv-base
docker push stuckless/sagetv-server-java7
docker push stuckless/sagetv-server-java7-wine
docker push stuckless/sagetv-server-java8
docker push stuckless/sagetv-server-java8-wine