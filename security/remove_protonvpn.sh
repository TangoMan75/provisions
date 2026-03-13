#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## protonvpn
##
## @category security

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=protonvpn
PPA='deb https://repo.protonvpn.com/debian unstable main'
DESKTOP=protonvpn-app.desktop

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

# disable kill switch
_echo_info 'protonvpn-cli ks --off\n'
protonvpn-cli ks --off

#--------------------------------------------------

_echo_info "sudo apt-get autoremove --assume-yes \"${APP_NAME}\"\n"
sudo apt-get autoremove --assume-yes "${APP_NAME}"

#--------------------------------------------------

# clear cache
_echo_info 'rm -rf ~/.cache/protonvpn\n'
rm -rf ~/.cache/protonvpn

# remove config files
_echo_info 'rm -rf ~/.config/protonvpn\n'
rm -rf ~/.config/protonvpn

#--------------------------------------------------

if [ -n "${PPA}" ]; then
    _echo_info "sudo add-apt-repository --remove --yes \"${PPA}\"\n"
    sudo add-apt-repository --remove --yes "${PPA}"

    _echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi

#--------------------------------------------------

# Remove desktop shortcut if it exists
_echo_info "rm -f \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
rm -f "$(xdg-user-dir DESKTOP)/${DESKTOP}"

