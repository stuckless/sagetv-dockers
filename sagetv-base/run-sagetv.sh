#!/usr/bin/env bash

# setup the users
sagetv-adduser.sh

# install or upgrade sagetv
install-sagetv.sh

# setup the permissions
sagetv-setperms.sh

# start the server
cd /opt/sagetv/server/

if [ -x /opt/sagetv/server/sagetv-user-script.sh ] ; then
    sudo -s sagetv /opt/sagetv/server/sagetv-user-script.sh
fi

sudo -u sagetv /opt/sagetv/server/startsage

sleep infinity