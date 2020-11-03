#!/bin/bash

#/**
# * dconf-editor
# * allows gnome advanced configuration
# *
# * @category gnome
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh


# check system uses gnome
GNOME='false'
RELEASE="`lsb_release -cs 2>/dev/null`"
for CODENAME in bionic cosmic disco eoan focal kali
do
    if [ "${RELEASE}" = "${CODENAME}" ]; then
        GNOME='true'
    fi
done

if [ "${GNOME}" = 'true' ]; then
    echo_info 'sudo apt-get install --assume-yes dconf-editor'
    sudo apt-get install --assume-yes dconf-editor
else
    echo_error "${RELEASE} not supported"
fi
