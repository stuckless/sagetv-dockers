#!/usr/bin/env bash

. ./VARS.sh

export CONTAINER="sagetv-server"
export CONTAINER_POSTFIX="java7"
cat sagetv-server.xml.hbs | ./mo > ../stuckless-sagetv/${CONTAINER}-${CONTAINER_POSTFIX}.xml

export CONTAINER_POSTFIX="java8"
cat sagetv-server.xml.hbs | ./mo > ../stuckless-sagetv/${CONTAINER}-${CONTAINER_POSTFIX}.xml
