#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## DevToys
##
## @category   communication
## @link       https://devtoys.app
## @link       https://github.com/DevToys/DevToys-app

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=devtoys
VERSION=2.0.8.0
FILENAME=devtoys_linux_x64.deb
URL=https://github.com/DevToys-app/DevToys/releases/download/v${VERSION}/${FILENAME}

#--------------------------------------------------

_alert_primary "Install ${PROJECT} v${VERSION}"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "wget \"${URL}\"\n"
wget "${URL}"

_echo_info "sudo dpkg --install \"${FILENAME}\"\n"
sudo dpkg --install "${FILENAME}"

_echo_info "rm -f \"${FILENAME}\"\n"
rm -f "${FILENAME}"

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/${APP_NAME}.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/${APP_NAME}.desktop "$(xdg-user-dir DESKTOP)"

