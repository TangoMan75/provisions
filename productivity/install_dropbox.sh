#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * dropbox
# * personal cloud
# *
# * @category productivity
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Dropbox'

#echo_info 'sudo apt-get install --assume-yes python-gpgme'
#sudo apt-get install --assume-yes python-gpgme

# check system uses gnome
GNOME=false
RELEASE="$(lsb_release -cs)"
for CODENAME in bionic cosmic disco eoan focal kali
do
    if [ "${RELEASE}" = "${CODENAME}" ]; then
        GNOME=true
    fi
done

if [ "${GNOME}" = true ]; then
    echo_info 'sudo apt-get install --assume-yes nautilus-dropbox'
    sudo apt-get install --assume-yes nautilus-dropbox
else
    echo_info 'sudo apt-get install --assume-yes thunar-dropbox-plugin'
    sudo apt-get install --assume-yes thunar-dropbox-plugin
fi

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/dropbox.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/dropbox.desktop "$(xdg-user-dir DESKTOP)"

