#!/usr/bin/env bash

# setup the users
sagetv-adduser.sh

# install or upgrade sagetv
install-sagetv.sh

# setup the permissions
sagetv-setperms.sh

# start the server
cd /opt/sagetv/server/
sudo -u sagetv /opt/sagetv/server/startsage

sleep infinity