#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## nerd-font
##
## Install the JetBrains Mono Nerd Font as the Termux terminal font.
##
## Downloads the "Mono" variant without ligatures from the official Nerd Fonts
## repository and saves it as "~/.termux/font.ttf", then reloads Termux.
##
## ```
## # usage
## ./termux/install_nerd-font.sh
## ```
##
## @category termux
## @link     https://github.com/ryanoasis/nerd-fonts
## @link     https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono
## @link     https://wiki.termux.com/wiki/Fonts

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=nerd-fonts
AUTHOR=ryanoasis
REPOSITORY=${AUTHOR}/${APP_NAME}

# Termux expects the terminal font to be named "font.ttf"
URL="https://github.com/${REPOSITORY}/blob/master/patched-fonts/Meslo/M/MesloLGMNerdFont-Regular.ttf"
DESTINATION="${HOME}/.termux"
DESTINATION_FILE="${DESTINATION}/font.ttf"


#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

# This font is meant for Termux only
if [ "${OSTYPE}" != 'linux-android' ] && [ "${OSTYPE}" != 'linux-androideabi' ]; then
    _echo_danger "error: \"$(basename "${0}")\" must be run inside Termux\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "mkdir -p \"${DESTINATION}\"\n"
mkdir -p "${DESTINATION}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fLo \"${DESTINATION_FILE}\" \"${URL}\"\n"
    curl -fLo "${DESTINATION_FILE}" "${URL}"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -q \"${URL}\" -O \"${DESTINATION_FILE}\"\n"
    wget -q "${URL}" -O "${DESTINATION_FILE}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

# Make sure the font was downloaded and is not an error page
if [ ! -s "${DESTINATION_FILE}" ] || head -n 1 "${DESTINATION_FILE}" | grep -q '<!DOCTYPE html>'; then
    _echo_danger 'error: Downloaded file is invalid or not found.\n'
    rm -f "${DESTINATION_FILE}"
    exit 1
fi

#--------------------------------------------------

# Apply the new font without closing the current session
if [ -x "$(command -v termux-reload-settings)" ]; then
    _echo_info 'termux-reload-settings\n'
    termux-reload-settings
else
    _echo_warning 'termux-reload-settings not found, restart Termux to apply the new font.\n'
fi
