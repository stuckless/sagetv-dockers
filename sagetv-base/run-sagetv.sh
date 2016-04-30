#!/usr/bin/env bash

# install or upgrade sagetv
install-sagetv.sh

# start the server
cd /opt/sagetv/server/
/opt/sagetv/server/startsage && sleep infinity