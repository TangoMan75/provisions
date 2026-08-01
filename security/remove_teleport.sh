#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## teleport
##
## @category security
## @link     https://goteleport.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=teleport

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get remove --assume-yes \"${APP_NAME}\"\n"
sudo apt-get remove --assume-yes "${APP_NAME}"

#--------------------------------------------------

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

# remove sources list file
_echo_info "sudo rm /etc/apt/sources.list.d/${APP_NAME}.list\n"
sudo rm /etc/apt/sources.list.d/${APP_NAME}.list

#--------------------------------------------------

# remove gpg keyring
_echo_info "sudo rm /etc/apt/keyrings/${APP_NAME}.gpg\n"
sudo rm /etc/apt/keyrings/${APP_NAME}.gpg

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

# remove config files
_echo_info "rm -rf \"${HOME}/.config/${APP_NAME}\"\n"
rm -rf "${HOME}/.config/${APP_NAME}"

#--------------------------------------------------

# remove desktop shortcut
_echo_info "rm -f \"$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop\"\n"
rm -f "$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop"
