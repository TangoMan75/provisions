#!/bin/bash

#/**
# * config org_gnome
# *
# * @category gnome
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

CONFIG_DIR="${BASEDIR}/../config"

# check system uses gnome
GNOME='false'
RELEASE=`lsb_release -cs`
for CODENAME in bionic cosmic disco eoan focal kali
do
    if [ "${RELEASE}" = "${CODENAME}" ]; then
        GNOME='true'
    fi
done

if [ "${GNOME}" = 'true' ]; then
    echo_info "dconf load /org/gnome/ < ${CONFIG_DIR}/gnome/dconf/org_gnome.conf"
    dconf load /org/gnome/ < ${CONFIG_DIR}/gnome/dconf/org_gnome.conf
else
    echo_error "${RELEASE} not supported"
fi
