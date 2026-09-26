#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Vocalinux
##
## Free, open-source, 100% offline voice dictation for Linux.
## Speak and type anywhere via whisper.cpp, Whisper & VOSK engines,
## GPU-accelerated, works on X11 + Wayland.
##
## @category productivity
## @link     https://github.com/VocaHQ/vocalinux
## @link     https://vocalinux.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=vocalinux
AUTHOR=VocaHQ
DESKTOP="${APP_NAME}.desktop"
REPOSITORY=${AUTHOR}/${APP_NAME}
INSTALLER_URL="https://raw.githubusercontent.com/${REPOSITORY}/main/install.sh"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL \"${INSTALLER_URL}\" -o /tmp/${APP_NAME}-install.sh\n"
    curl -fsSL "${INSTALLER_URL}" -o "/tmp/${APP_NAME}-install.sh"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -q \"${INSTALLER_URL}\" -O /tmp/${APP_NAME}-install.sh\n"
    wget -q "${INSTALLER_URL}" -O "/tmp/${APP_NAME}-install.sh"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

if [ ! -s "/tmp/${APP_NAME}-install.sh" ] || head -n 1 "/tmp/${APP_NAME}-install.sh" | grep -q '<!DOCTYPE html>'; then
    _echo_danger "error: Downloaded file is invalid or not found.\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "bash /tmp/${APP_NAME}-install.sh $*\n"
bash "/tmp/${APP_NAME}-install.sh" "$@"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p \"$HOME/.local/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "$HOME/.local/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

