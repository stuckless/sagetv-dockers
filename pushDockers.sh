#!/usr/bin/env bash

docker login --username=stuckless

docker push stuckless/sagetv-base
docker push stuckless/sagetv-server-java8
docker push stuckless/sagetv-server-java11
docker push stuckless/sagetv-server-java16
