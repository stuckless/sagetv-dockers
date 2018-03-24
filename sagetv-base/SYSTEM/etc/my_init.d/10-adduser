#!/usr/bin/env bash

PUID=${PUID:-99}
PGID=${PGID:-100}
VIDEO_GUID=${VIDEO_GUID:-18}

if [ ! "$(id -u sagetv)" -eq "$PUID" ]; then usermod -o -u "$PUID" sagetv ; fi
if [ ! "$(id -g sagetv)" -eq "$PGID" ]; then groupmod -o -g "$PGID" sagetv ; fi

groupmod -o -g "${VIDEO_GUID}" video
