#!/bin/bash

#stop the containers
docker stop $(docker ps -a -q)

# https://techoverflow.net/blog/2013/10/22/docker-remove-all-images-and-containers/
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images except ubuntu base
# docker rmi --force $(docker images -q)
docker rmi --force $(docker images -q | grep -v "`docker images | grep 'ubuntu\|phusion' | awk -F \" \" '{print $3}'`")

