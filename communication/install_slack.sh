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
# * Slack
# *
# * @category communication
# * @link     https://slack.com/downloads/linux
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

APP_NAME=slack
VERSION=4.29.149
FILENAME=slack-desktop-${VERSION}-amd64.deb
URL=https://downloads.slack-edge.com/releases/linux/${VERSION}/prod/x64/${FILENAME}

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

