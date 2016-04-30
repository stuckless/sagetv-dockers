#!/usr/bin/env bash

OPT_PLEX=${OPT_PLEX:-N}
PLEX_SAGETV_HOST=${PLEX_SAGETV_HOST:-localhost}
PLEX_SAGETV_PORT=${PLEX_SAGETV_PORT:-8080}
#PLEX_SAGETV_USERNAME=
#PLEX_SAGETV_PASSWORD=
PLEX_APP=${PLEX_LIBRARY:-/unraid/appdata/plex/}

if [ "Y" = "${OPT_PLEX}" ] ; then
    if [ ! -e ${PLEX_APP} ] ; then
        echo "Not a plex app location: ${PLEX_APP}"
        exit 3
    fi

    rm -rf /plexfiles
    mkdir /plexfiles
    cd /plexfiles
    wget https://github.com/ai7/sagetv-for-plexmediacenter/archive/master.zip -O sageplex.zip
    unzip sageplex.zip
    cd sagetv-for-plexmediacenter-master
    # install sagex part
    mkdir -p "${SAGE_HOME}/sagex/services/"
    cp -v src/sagetv/sagex-services/plex.js "${SAGE_HOME}/sagex/services/"
    # install the plex part
    SCANNER_TV="${PLEX_APP}/Library/Application Support/Plex Media Server/Scanners/Series"
    SCANNER_MOVIE="${PLEX_APP}/Library/Application Support/Plex Media Server/Scanners/Movies"
    AGENT_DIR="${PLEX_APP}/Library/Application Support/Plex Media Server/Plug-ins"
	mkdir -p "${SCANNER_TV}/sageplex"
	mkdir -p "${SCANNER_MOVIE}/sageplex"
	# copy main scanner
	cp "src/plex/scanner/SageTV Scanner.py" "${SCANNER_TV}"
	cp "src/plex/scanner/SageTV Movie Scanner.py" "${SCANNER_MOVIE}"
	# copy library to each scanner's sub folder
	cp -r src/plex/common/sageplex "${SCANNER_TV}"
	cp -r src/plex/common/sageplex "${SCANNER_MOVIE}"
	# copy config file
	# need to exported for mo.sh to work
	if [ ! -e "${AGENT_DIR}/../sageplex_cfg.json" ] ; then
        export PLEX_SAGETV_HOST PLEX_SAGETV_PORT PLEX_SAGETV_USERNAME PLEX_SAGETV_PASSWORD PLEX_APP
        cat /usr/local/share/plex/config/sageplex_cfg.json | /usr/bin/mo.sh > "${AGENT_DIR}/../sageplex_cfg.json"
	fi

    # copy the agent
	mkdir -p "${AGENT_DIR}"
	# copy main agent folder
	cp -r src/plex/agent/BMTAgentTVShows.bundle "${AGENT_DIR}"
	# copy common code individually (skip __init__.py)
	AGENT_COMMON=(plexlog.py config.py sagex.py plexapi.py spvideo.py)
	for f in ${AGENT_COMMON[@]}; do
	  cp src/plex/common/sageplex/${f} "${AGENT_DIR}/BMTAgentTVShows.bundle/Contents/Code";
    done
    cd ${SAGE_HOME}
    rm -rf /plexfiles
fi
