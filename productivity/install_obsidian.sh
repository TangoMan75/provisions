#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## obsidian
##
## A knowledge base that works on local Markdown files.
##
## Suggested extensions :
##
## - Beautitab
## - Excalidraw
## - Full Calendar
## - Kanban
##
## @category productivity
## @link     https://obsidian.md
## @link     https://obsidian.md/plugins


CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

#--------------------------------------------------

APP_NAME=obsidian
VERSION=1.8.9

#--------------------------------------------------

# create temp folder
TEMP="$(mktemp -d)"
FILE=${APP_NAME}_${VERSION}_amd64.deb
DOWNLOAD_PATH="${TEMP}/${FILE}"

#--------------------------------------------------

# Download url
URL=https://github.com/obsidianmd/obsidian-releases/releases/download/v${VERSION}/${FILE}

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    _echo_info "curl -L \"${URL}\" -o \"${DOWNLOAD_PATH}\"\n"
    curl -L "${URL}" -o "${DOWNLOAD_PATH}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    _echo_info "wget -nv \"${URL}\" -O \"${DOWNLOAD_PATH}\"\n"
    wget -nv "${URL}" -O "${DOWNLOAD_PATH}"

else
    _echo_danger "error: \"$(basename "${0}")\" requires \"wget\", or \"curl\" try: \"sudo apt-get install -y wget\" or \"sudo apt-get install -y curl\"\n"
    exit 1
fi

#--------------------------------------------------

# install package
_echo_info "sudo dpkg --install \"${DOWNLOAD_PATH}\"\n"
sudo dpkg --install "${DOWNLOAD_PATH}"

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/${APP_NAME}.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/${APP_NAME}.desktop "$(xdg-user-dir DESKTOP)"

