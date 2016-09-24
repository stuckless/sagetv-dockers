#!/usr/bin/env bash

# Options
OPT_GENTUNER=${OPT_GENTUNER:-Y}
OPT_COMMANDIR=${OPT_COMMANDIR:-Y}
OPT_COMSKIP=${OPT_COMSKIP:-Y}
VERSION=${VERSION:-latest}

# SageTV Version
SAGE_VERSION=""
if [ "${VERSION}" = "latest" ] ; then
    SAGE_VERSION=`curl https://dl.bintray.com/opensagetv/sagetv/sagetv/ | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*$/\1/' | egrep -e '9\.[0-9]+' | sort | tail -1`
else
    SAGE_VERSION=${VERSION}
fi

SAGE_VERSION_BASE=`echo "${SAGE_VERSION}" | sed 's/\.[^.]*$//'`
SAGE_SERVER_TGZ_URL="https://bintray.com/artifact/download/opensagetv/sagetv/sagetv/${SAGE_VERSION}/sagetv-server_${SAGE_VERSION_BASE}_amd64.tar.gz"
SAGE_SERVER_TGZ="sagetvserver-${SAGE_VERSION}.tgz"
SAGE_CUR_VERSION_FILE=".SAGE_CUR_VERSION"

compareVersions () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

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

UPGRADE="N"

# user asked for a specific version
compareVersions "${SAGE_CUR_VERSION}" "${SAGE_VERSION}"
case $? in
    0) UPGRADE='N';; # ==
    1) UPGRADE='Y';; # > CURRENT is newer
    2) UPGRADE='Y';; # < CURRENT is older
esac

# check if new install
if [ ! -e ${SAGE_START} ] || [ "${UPGRADE}" = "Y" ] || file libSage.so|grep '32-bit' ; then
    echo "Backing up Wiz.bin, Sage.properties and Sage.jar before upgrade"
    DATESUFFIX=$(date +"%Y%m%d_%H%M%S")
    BDIR="backups/${DATESUFFIX}"
    mkdir -p "${BDIR}"
    cp -pv Wiz.bin "${BDIR}"
    cp -pv Sage.properties "${BDIR}"
    cp -pv Sage.jar "${BDIR}"

    echo "Installing/Upgrading SageTV to ${SAGE_VERSION}"
    wget -O ${SAGE_SERVER_TGZ} ${SAGE_SERVER_TGZ_URL}
    tar -zxvf ${SAGE_SERVER_TGZ}
    if [ ! $? -eq 0 ]; then
        echo "Failed to download Server!!! URL: ${SAGE_SERVER_TGZ_URL}";
        rm -rf "${BDIR}"
        exit 2
    fi
    rm -f ${SAGE_SERVER_TGZ}
    echo "${SAGE_VERSION}" > ${SAGE_CUR_VERSION_FILE}
    SAGE_CUR_VERSION=${SAGE_VERSION}

    # force setting permissions after install
    export OPT_SETPERMS=Y


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

    # if configuring comskip, then setup the comskip values
    if [ "Y" = "${OPT_COMSKIP}" ] ; then
        echo "Configuring Comskip"

        mkdir -p /opt/sagetv/comskip/
        cp -v /sagetv_files/comskip/comskip /opt/sagetv/comskip/
        cp -v /sagetv_files/comskip/comskip.xilka /opt/sagetv/comskip/
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
        echo "cd/running_as_root=false" >> ${SAGE_PROPS_TMP}
        echo "cd/server_is=linux" >> ${SAGE_PROPS_TMP}
        echo "cd/wine_home=" >> ${SAGE_PROPS_TMP}
        echo "cd/wine_user=sagetv" >> ${SAGE_PROPS_TMP}
        echo "cd/comskip_location=/opt/sagetv/comskip/comskip" >> ${SAGE_PROPS_TMP}
        echo "cd/ini_location=/opt/sagetv/comskip/comskip.ini" >> ${SAGE_PROPS_TMP}
        cat ${SAGE_PROPS_TMP} | sort | uniq > ${SAGE_PROPS}
        rm ${SAGE_PROPS_TMP}
    fi
else
    echo "SageTV Already At Version: ${SAGE_VERSION}, exiting..."
    exit 0
fi


cd ${SAGE_HOME}

# install the license key
if [ "${LICENCE_DATA}" != "" ] ; then
    KEYDATA="$(echo "${LICENCE_DATA}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    if [ ! -e ${SAGE_HOME}/activkey.old ] ; then
        if [ -e ${SAGE_HOME}/activkey ] ; then
            cp ${SAGE_HOME}/activkey ${SAGE_HOME}/activkey.old
        fi
    fi
    if [ "${KEYDATA}" != "" ] ; then
        echo "Updating License"
        echo -n "${KEYDATA}" > ${SAGE_HOME}/activkey
    fi
fi

# set java memory
if [ "${JAVA_MEM_MB}" != "" ] ; then
    echo "Updating Java Mem"
    if [ ! -e ${SAGE_HOME}/sagesettings.old ]; then
        if [ -e ${SAGE_HOME}/sagesettings ] ; then
            cp ${SAGE_HOME}/sagesettings ${SAGE_HOME}/sagesettings.old
        fi
    fi
    # JAVAMEM=-Xmx768m
    echo "export JAVAMEM=-Xmx${JAVA_MEM_MB}m" > ${SAGE_HOME}/sagesettings
    chmod 755 ${SAGE_HOME}/sagesettings
fi

echo "Sage Install Complete"

