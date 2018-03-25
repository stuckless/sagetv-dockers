#!/usr/bin/env bash

TEMPLATE_SRC=unRAID/template/
TEMPLATE_OUT=unRAID/stuckless-sagetv/
. ${TEMPLATE_SRC}/./VARS.sh

export CONTAINER="sagetv-server"
export CONTAINER_POSTFIX="java7"
cat ${TEMPLATE_SRC}/sagetv-server.xml.hbs | ${TEMPLATE_SRC}/mo > ${TEMPLATE_OUT}/${CONTAINER}-${CONTAINER_POSTFIX}.xml

export CONTAINER_POSTFIX="java8"
cat ${TEMPLATE_SRC}/sagetv-server.xml.hbs | ${TEMPLATE_SRC}/mo > ${TEMPLATE_OUT}/${CONTAINER}-${CONTAINER_POSTFIX}.xml

export CONTAINER_POSTFIX="java9"
cat ${TEMPLATE_SRC}/sagetv-server.xml.hbs | ${TEMPLATE_SRC}/mo > ${TEMPLATE_OUT}/${CONTAINER}-${CONTAINER_POSTFIX}.xml

export CONTAINER_POSTFIX="java10"
cat ${TEMPLATE_SRC}/sagetv-server.xml.hbs | ${TEMPLATE_SRC}/mo > ${TEMPLATE_OUT}/${CONTAINER}-${CONTAINER_POSTFIX}.xml
