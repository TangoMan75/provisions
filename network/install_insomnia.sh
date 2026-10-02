#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## insomnia
##
## API Rest client alternative to postman
##
## @category network
## @link     https://insomnia.rest

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

REPOSITORY=Kong/insomnia
RELEASE=core@13.0.2
VERSION=13.0.2
APP_NAME=Insomnia.Core
BINARY=${APP_NAME}-${VERSION}.deb
DESKTOP=insomnia.desktop

#--------------------------------------------------

_alert_primary "Install Insomnia v${VERSION}"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(dpkg)
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

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -Lf \"https://github.com/${REPOSITORY}/releases/download/${RELEASE}/${BINARY}\" -o \"${TEMP_DIR}/${BINARY}\"\n"
    curl -Lf "https://github.com/${REPOSITORY}/releases/download/${RELEASE}/${BINARY}" -o "${TEMP_DIR}/${BINARY}"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -q \"https://github.com/${REPOSITORY}/releases/download/${RELEASE}/${BINARY}\" -O \"${TEMP_DIR}/${BINARY}\"\n"
    wget -q "https://github.com/${REPOSITORY}/releases/download/${RELEASE}/${BINARY}" -O "${TEMP_DIR}/${BINARY}"

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

_echo_warning "Cleaning up temporary files\n"

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"
