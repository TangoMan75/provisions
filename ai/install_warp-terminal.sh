#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## warp-terminal
##
## Install Warp Terminal, a modern terminal with AI capabilities.
##
## @category ai
## @link     https://warp.dev
## @link     https://www.warp.dev/download
## @link     https://docs.warp.dev/getting-started/readme/installation-and-setup

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=warp-terminal
BINARY=warp-terminal_0.2025.10.29.08.12.stable.04_amd64.deb
URL="https://releases.warp.dev/stable/v0.2025.10.29.08.12.stable_04/${BINARY}"
DESKTOP=dev.warp.Warp.desktop

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

# Check for required commands
if [ ! -x "$(command -v dpkg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires dpkg, try: 'sudo apt-get install -y dpkg'\n"
    exit 1
fi

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -L \"${URL}\" -o \"${TEMP_DIR}/${BINARY}\"\n"
    curl -L "${URL}" -o "${TEMP_DIR}/${BINARY}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -nv \"${URL}\" -O \"${TEMP_DIR}/${BINARY}\"\n"
    wget -nv "${URL}" -O "${TEMP_DIR}/${BINARY}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

_echo_info "sudo dpkg -i \"${TEMP_DIR}/${BINARY}\"\n"
sudo dpkg -i "${TEMP_DIR}/${BINARY}"

#--------------------------------------------------

_echo_warning 'Fix missing dependencies if any\n'

_echo_info 'sudo apt-get install -f -y\n'
sudo apt-get install -f -y

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

