#!/usr/bin/env bash

chown -Rv sagetv:sagetv /var/media
chown -Rv sagetv:sagetv /opt/sagetv
chown -v root:sagetv /var/run
chown -v root:sagetv /run
chomd 775 /var/run/
chomd 775 /run/

# if commandir is installed, the fix it to run as root, since it needs to run as root in order to change channels
if [ -e /opt/sagetv/commandir/bin ] ; then
    chown -Rv root:sagetv /opt/sagetv/commandir/bin
    chmod u+s /opt/sagetv/commandir/bin/commandir*
fi