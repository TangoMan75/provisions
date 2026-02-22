#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## cursor
##
## AI-powered code completion tool
##
## @category ide
## @link     https://cursor.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

URL="https://api2.cursor.sh/updates/download/golden/linux-x64-deb/cursor/latest"
BINARY=cursor-latest.deb
DESKTOP=cursor.desktop

#--------------------------------------------------

_alert_primary "Install Cursor"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(wget dpkg)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

# Download release to temporary directory
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

# Fix missing dependencies if any
_echo_info 'sudo apt-get install -f -y\n'
sudo apt-get install -f -y

#--------------------------------------------------

# Clean up
_echo_warning "Cleaning up temporary files\n"

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

