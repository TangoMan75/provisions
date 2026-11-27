#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove Signal Desktop
##
## @category communication
## @link     https://signal.org/download/linux/
## @link     https://support.signal.org/hc/articles/360008216551-Installing-Signal

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=signal-desktop
DESKTOP="${APP_NAME}.desktop"

#--------------------------------------------------

KEYRING="${APP_NAME}-keyring.gpg"
KEYRING_PATH="/usr/share/keyrings/${KEYRING}"

#--------------------------------------------------

SOURCES="${APP_NAME}.sources"
SOURCES_FILE="/etc/apt/sources.list.d/${SOURCES}"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get remove --assume-yes \"${APP_NAME}\"\n"
sudo apt-get remove --assume-yes "${APP_NAME}"

#--------------------------------------------------

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

_echo_warning 'Remove Signal APT repository\n'

_echo_info "sudo rm -f \"${SOURCES_FILE}\"\n"
sudo rm -f "${SOURCES_FILE}"

_echo_info "sudo rm -f \"${KEYRING_PATH}\"\n"
sudo rm -f "${KEYRING_PATH}"

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

# remove desktop shortcut
if [ -x "$(command -v xdg-user-dir)" ]; then
    _echo_info "rm -f \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
    rm -f "$(xdg-user-dir DESKTOP)"/"${DESKTOP}"
fi

#--------------------------------------------------

_echo_warning "User data was kept in \"${HOME}/.config/Signal\"\n"
_echo_info 'Remove it manually if you want to delete your local Signal messages and database.\n'
