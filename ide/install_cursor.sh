#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## cursor
## AI IDE
##
## @category ide
## @link     https://www.cursor.com
## @link     https://downloader.cursor.sh/linux/appImage/x64

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

FILENAME='cursor.AppImage'
INSTALL_DIRECTORY="${HOME}/.cursor"
URL='https://downloader.cursor.sh/linux/appImage/x64'
#create temp directory
TEMP="$(mktemp -d)"

#--------------------------------------------------

alert_primary "Install Cursor"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    echo_info "curl -L \"${URL}\" -o \"${TEMP}/${FILENAME}\"\n"
    curl -L "${URL}" -o "${TEMP}/${FILENAME}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    echo_info "wget -nv \"${URL}\" -O \"${TEMP}/${FILENAME}\"\n"
    wget -nv "${URL}" -O "${TEMP}/${FILENAME}"

else
    echo_danger "error: \"$(basename "${0}")\" requires curl or wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

#--------------------------------------------------

if [ ! -d "${INSTALL_DIRECTORY}" ]; then
    echo_info "mkdir -p \"${INSTALL_DIRECTORY}\"\n"
    mkdir -p "${INSTALL_DIRECTORY}"
fi

echo_info "mv \"${TEMP}/${FILENAME}\" \"${INSTALL_DIRECTORY}\"\n"
mv "${TEMP}/${FILENAME}" "${INSTALL_DIRECTORY}"

#--------------------------------------------------

echo_info "chmod +x \"${INSTALL_DIRECTORY}/${FILENAME}\"\n"
chmod +x "${INSTALL_DIRECTORY}/${FILENAME}"

