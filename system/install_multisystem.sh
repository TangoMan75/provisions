#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## multisystem
##
## create bootable usb drives
##
## @deprecated use woeusb instead
## @category   system
## @link       https://doc.ubuntu-fr.org/multisystem

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=multisystem
DESKTOP=multisystem.desktop
APT_REPOSITORY='deb http://liveusb.info/multisystem/depot all main'
APT_KEY=http://liveusb.info/multisystem/depot/multisystem.asc

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -n "${APT_REPOSITORY}" ] && [ -n "${APT_KEY}" ]; then
    if [ ! -x "$(command -v wget)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
        exit 1
    fi

    _echo_info "sudo apt-add-repository -y \"${APT_REPOSITORY}\"\n"
    sudo apt-add-repository -y "${APT_REPOSITORY}"

    _echo_info "wget -q \"${APT_KEY}\" -O- | sudo apt-key add -\n"
    wget -q "${APT_KEY}" -O- | sudo apt-key add -

    _echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

