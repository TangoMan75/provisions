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
# * Ferdium
# *
# * @category   communication
# * @link       https://ferdium.org/download
# * @link       https://github.com/ferdium/ferdium-app
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

APP_NAME=ferdium
REPOSITORY=ferdium/ferdium-app
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=6.2.3
fi
FILENAME=Ferdium-linux-${VERSION}-amd64.deb
URL=https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}

alert_primary "Install ${APP_NAME} v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

echo_info "wget \"${URL}\"\n"
wget "${URL}"

echo_info "sudo dpkg --install \"${FILENAME}\"\n"
sudo dpkg --install "${FILENAME}"

echo_info "rm -f \"${FILENAME}\"\n"
rm -f "${FILENAME}"

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/${APP_NAME}.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/${APP_NAME}.desktop "$(xdg-user-dir DESKTOP)"

