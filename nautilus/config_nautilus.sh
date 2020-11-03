#!/bin/bash

#/**
# * config nautilus
# *
# * @category nautilus
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

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
    echo_info "gsettings set org.gnome.nautilus.preferences default-sort-order 'type'"
    gsettings set org.gnome.nautilus.preferences default-sort-order 'type'
else
    echo_error 'wrong system'
fi
