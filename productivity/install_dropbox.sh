#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## dropbox
## personal cloud
##
## @category productivity

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install Dropbox'

#_echo_info 'sudo apt-get install --assume-yes python-gpgme\n'
#sudo apt-get install --assume-yes python-gpgme

# check system uses gnome
if [ "${XDG_CURRENT_DESKTOP}" = 'ubuntu:GNOME' ]; then
    _echo_info 'sudo apt-get install --assume-yes nautilus-dropbox\n'
    sudo apt-get install --assume-yes nautilus-dropbox
else
    _echo_info 'sudo apt-get install --assume-yes thunar-dropbox-plugin\n'
    sudo apt-get install --assume-yes thunar-dropbox-plugin
fi

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/dropbox.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/dropbox.desktop "$(xdg-user-dir DESKTOP)"

