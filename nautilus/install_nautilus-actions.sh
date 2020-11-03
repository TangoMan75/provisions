#!/bin/bash

#/**
# * nautilus-actions
# * add custom actions to file manager context menus
# *
# * @category nautilus
# * @link     http://www.nautilus-actions.org
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
    echo_info 'sudo apt-get install --assume-yes nautilus-actions'
    sudo apt-get install --assume-yes nautilus-actions
else
    echo_error 'wrong system'
fi
