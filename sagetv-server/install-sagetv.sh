#!/usr/bin/env bash

# Options
OPT_GENTUNER=Y
OPT_COMMANDIR=Y

# SageTV Version
SAGE_VERSION=`curl https://dl.bintray.com/opensagetv/sagetv/sagetv/ | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*$/\1/' | egrep -e '9\.[0-9]+' | sort | tail -1`
SAGE_VERSION_BASE=`echo "${SAGE_VERSION}" | sed 's/\.[^.]*$//'`
SAGE_SERVER_TGZ_URL="https://bintray.com/artifact/download/opensagetv/sagetv/sagetv/${SAGE_VERSION}/sagetv-server_${SAGE_VERSION_BASE}_amd64.tar.gz"
SAGE_SERVER_TGZ="sagetvserver-${SAGE_VERSION}.tgz"
SAGE_CUR_VERSION_FILE=".SAGE_CUR_VERSION"

# start command
SAGE_START=startsage

# set default sagetv home
# NOTE: It should always be this, except when testing
if [ "${SAGE_HOME}" = "" ] ; then
    SAGE_HOME=/opt/sagetv/server
fi

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
if [ ! -e ${SAGE_START} ] ; then
    wget -O ${SAGE_SERVER_TGZ} ${SAGE_SERVER_TGZ_URL}
    tar -zxvf ${SAGE_SERVER_TGZ}
    if [ ! $? -eq 0 ]; then
        echo "Failed to download Server!!! URL: ${SAGE_SERVER_TGZ_URL}";
        exit 2
    fi
    rm -f ${SAGE_SERVER_TGZ}
    echo "${SAGE_VERSION}" > ${SAGE_CUR_VERSION_FILE}
    SAGE_CUR_VERSION=${SAGE_VERSION}

    if [ "Y" = "$OPT_GENTUNER" ] ; then
        wget -O gentuner.tgz https://bintray.com/artifact/download/opensagetv/sagetv-plugins/GenericTunerPluginLinux/gentuner-1.0.1.tgz
        tar -zxvf gentuner.tgz
        rm -f gentuner.tgz
    fi

    if [ "Y" = "$OPT_COMMANDIR" ] ; then
        wget -O commandir.tgz https://bintray.com/artifact/download/opensagetv/sagetv-plugins/CommandIR-AMD64/commandir-1.0.3-amd64.tgz
        tar -zxvf commandir.tgz -C ../../../
        rm -f commandir.tgz
    fi
elif [ ! "${SAGE_VERSION}" = "${SAGE_CUR_VERSION}" ] ; then
    # Upgrade
    wget -O ${SAGE_SERVER_TGZ} ${SAGE_SERVER_TGZ_URL}
    tar -zxvf ${SAGE_SERVER_TGZ}
    if [ ! $? -eq 0 ]; then
        echo "Failed to download Server!!! URL: ${SAGE_SERVER_TGZ_URL}";
        exit 2
    fi
    rm -f ${SAGE_SERVER_TGZ}
    echo "${SAGE_VERSION}" > ${SAGE_CUR_VERSION_FILE}
    echo "Upgrading from ${SAGE_CUR_VERSION} to ${SAGE_VERSION}"
    SAGE_CUR_VERSION=${SAGE_VERSION}
else
    echo "SageTV Already At Version: ${SAGE_VERSION}"
fi

