#!/usr/bin/env bash

# Options
OPT_GENTUNER=${OPT_GENTUNER:-Y}
OPT_COMMANDIR=${OPT_COMMANDIR:-Y}
OPT_COMSKIP=${OPT_COMSKIP:-Y}
OPT_PLEX=${OPT_PLEX:-N}
PLEX_SAGETV_HOST=${PLEX_SAGETV_HOST:-localhost}
PLEX_SAGETV_PORT=${PLEX_SAGETV_PORT:-8080}
PLEX_SAGETV_USERNAME=
PLEX_SAGETV_PASSWORD=
PLEX_APP=${PLEX_LIBRARY:-/unraid/appdata/plex/}


# SageTV Version
SAGE_VERSION=`curl https://dl.bintray.com/opensagetv/sagetv/sagetv/ | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*$/\1/' | egrep -e '9\.[0-9]+' | sort | tail -1`
SAGE_VERSION_BASE=`echo "${SAGE_VERSION}" | sed 's/\.[^.]*$//'`
SAGE_SERVER_TGZ_URL="https://bintray.com/artifact/download/opensagetv/sagetv/sagetv/${SAGE_VERSION}/sagetv-server_${SAGE_VERSION_BASE}_amd64.tar.gz"
SAGE_SERVER_TGZ="sagetvserver-${SAGE_VERSION}.tgz"
SAGE_CUR_VERSION_FILE=".SAGE_CUR_VERSION"

# start command
SAGE_START=startsage

# set default sagetv home
SAGE_HOME=${SAGE_HOME:-/opt/sagetv/server}

mkdir -p ${SAGE_HOME}
cd ${SAGE_HOME}
if [ $? -eq 0 ]; then
    echo "SageTV Home: ${SAGE_HOME}"
else
    echo "Cannot Change to ${SAGE_HOME}.  Likely Missing directory and/or permissions issue";
    exit 1
fi

SAGE_CUR_VERSION=0
if [ -e ${SAGE_CUR_VERSION_FILE} ] ; then
    SAGE_CUR_VERSION=`cat ${SAGE_CUR_VERSION_FILE}`
fi

# check if new install
if [ ! -e ${SAGE_START} ] || [ ! "${SAGE_VERSION}" = "${SAGE_CUR_VERSION}" ] || file libSage.so|grep '32-bit' ; then
    echo "Installing/Upgrading SageTV to ${SAGE_VERSION}"
    wget -O ${SAGE_SERVER_TGZ} ${SAGE_SERVER_TGZ_URL}
    tar -zxvf ${SAGE_SERVER_TGZ}
    if [ ! $? -eq 0 ]; then
        echo "Failed to download Server!!! URL: ${SAGE_SERVER_TGZ_URL}";
        exit 2
    fi
    rm -f ${SAGE_SERVER_TGZ}
    echo "${SAGE_VERSION}" > ${SAGE_CUR_VERSION_FILE}
    SAGE_CUR_VERSION=${SAGE_VERSION}

    if [ "Y" = "${OPT_GENTUNER}" ] ; then
        wget -O gentuner.tgz https://bintray.com/artifact/download/opensagetv/sagetv-plugins/GenericTunerPluginLinux/gentuner-1.0.1.tgz
        tar -zxvf gentuner.tgz
        rm -f gentuner.tgz
    fi

    if [ "Y" = "${OPT_COMMANDIR}" ] ; then
        wget -O commandir.tgz https://bintray.com/artifact/download/opensagetv/sagetv-plugins/CommandIR-AMD64/commandir-1.0.3.1-amd64.tgz
        tar -zxvf commandir.tgz -C ../../../
        rm -f commandir.tgz
    fi
else
    echo "SageTV Already At Version: ${SAGE_VERSION}"
fi

# if configuring comskip, then setup the comskip values
if [ "Y" = "${OPT_COMSKIP}" ] ; then
    echo "Configuring Comskip"

    mkdir -p /opt/sagetv/comskip/
    cp -v /sagetv_files/comskip/comskip /opt/sagetv/comskip/
    if [ ! -e /opt/sagetv/comskip/comskip.ini ] ; then
        cp -v /sagetv_files/comskip/comskip.ini /opt/sagetv/comskip/
    fi

    SAGE_PROPS=Sage.properties
    SAGE_PROPS_TMP=Sage.properties.tmp
    if [ -e ${SAGE_PROPS} ] ; then
        CSEXE="cd/comskip_location="
        CSINI="cd/ini_location="
        cat ${SAGE_PROPS} | grep -v "cd/running_as_root=" | grep -v "cd/server_is=" | grep -v "cd/wine_home=" | grep -v "cd/wine_user=" | grep -v "${CSEXE}" | grep -v "${CSINI}" > ${SAGE_PROPS_TMP}
    fi
    echo "cd/running_as_root=true" >> ${SAGE_PROPS_TMP}
    echo "cd/server_is=linux" >> ${SAGE_PROPS_TMP}
    echo "cd/wine_home=" >> ${SAGE_PROPS_TMP}
    echo "cd/wine_user=root" >> ${SAGE_PROPS_TMP}
    echo "cd/comskip_location=/opt/sagetv/comskip/comskip" >> ${SAGE_PROPS_TMP}
    echo "cd/ini_location=/opt/sagetv/comskip/comskip.ini" >> ${SAGE_PROPS_TMP}
    cat ${SAGE_PROPS_TMP} | sort | uniq > ${SAGE_PROPS}
    rm ${SAGE_PROPS_TMP}
fi

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
	export PLEX_SAGETV_HOST PLEX_SAGETV_PORT PLEX_SAGETV_USERNAME PLEX_SAGETV_PASSWORD PLEX_APP
	cat /usr/local/share/plex/config/sageplex_cfg.json | /usr/bin/mo.sh > "${AGENT_DIR}/../sageplex_cfg.json"

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

cd ${SAGE_HOME}
echo "Sage Install Complete"

