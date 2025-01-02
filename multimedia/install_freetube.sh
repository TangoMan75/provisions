#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * freetube
# *
# * @category multimedia
# * @link     https://freetubeapp.io/#download
# * @link     https://github.com/FreeTubeApp/FreeTube/releases
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

APPNAME=freetube
REPOSITORY=FreeTubeApp/FreeTube
# VERSION=0.22.0
VERSION=0.21.3
REMOTE_FILE=${APPNAME}_${VERSION}_amd64.deb

# --------------------------------------------------

# create temp folder
TEMP="$(mktemp -d)"
FILE=${APPNAME}_${VERSION}_amd64.deb
DOWNLOAD_PATH="${TEMP}/${FILE}"

# --------------------------------------------------

alert_primary "Install ${APPNAME} ${VERSION}"

# --------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

# --------------------------------------------------

# Download url
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}-beta/${REMOTE_FILE}"

# --------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    # download latest version from github with curl
    echo_info "curl -L \"${URL}\" -o \"${DOWNLOAD_PATH}\"\n"
    curl -L "${URL}" -o "${DOWNLOAD_PATH}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version from github with wget
    echo_info "wget -nv \"${URL}\" -O \"${DOWNLOAD_PATH}\"\n"
    wget -nv "${URL}" -O "${DOWNLOAD_PATH}"
fi

# --------------------------------------------------

# install package
echo_info "sudo dpkg --install \"${DOWNLOAD_PATH}\"\n"
sudo dpkg --install "${DOWNLOAD_PATH}"

# --------------------------------------------------

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/${APPNAME}.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/${APPNAME}.desktop "$(xdg-user-dir DESKTOP)"

