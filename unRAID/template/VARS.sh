#!/usr/bin/env bash

export BETA=True
export CATEGORY="MediaApp:Video MediaApp:Music MediaApp:Photos MediaServer:Video MediaServer:Music MediaServer:Photos"
export OWNER="stuckless"
export CONTAINER="sagetv-server"
export CONTAINER_POSTFIX="java7"
export CONTAINER_VERSION="latest"
read -r -d '' DESCRIPTION <<- EOM
        SageTV is an Open Source PVR and Media Player[br][br]
        [b][u][span style='color: #E80000;']Configuration[/span][/u][/b][br]
        [b]/opt/sagetv[/b] This is the base directory for the server and other sagetv related files.  Under this location there can be a 'server' directory and if the existing 'server' directory exists it will be upgraded.[br]
        [b]/var/media[/b] Path for sagetv recordings and videos.  Under this directory there should be (or will be created) a 'tv' directory where SageTV recordings will get recorded.[br]
        [b]/var/mediaext[/b] Path for extra media files.  This can be whatever you want, but you will configure SageTV to look for videos, music, pictures, etc from this location.[br]
        [b][u][span style='color: #E80000;']Notes[/span][/u][/b][br]
        [b]*[/b] SageTV will need to use 'host' networking, so while the ports are defined, they are not required to be edited.  Without 'host' sagetv will think your network clients are connecting as remote placeshifters, and present the placeshifter login.  Because it is running in host mode, make sure you don't have other docker containers that are using port 8080.  If you do, then EITHER change SageTV Jetty Port (in plugin configuration) after install, or, update the other docker containers to NOT use port 8080.[br]
        [b]*[/b] On every Docker start, it will check for a new version of SageTV and install it, if it exists.[br]
        [b]*[/b] If you want to use comskip, then make sure you are using the container that has 'wine' support.[br]
        [b]*[/b] There are Java 7 and Java 8 version of these containers.  Java 8 will be the default moving forward, but it currently has issues with the version of Jetty that installed with the SageTV plugins.  If you need Jetty support (ie, BMT, SageTV Web UI, etc) then install the 'java7' version of this container[br]
EOM
export DESCRIPTION
read -r -d '' OVERVIEW <<- EOM
    SageTV is an Open Source PVR and Media Player
EOM
export OVERVIEW
export SUPPORT="http://forums.sagetv.com/forums/"
export GITHUB="https://github.com/stuckless/sagetv-dockers/tree/master/unRAID/stuckless-sagetv/"