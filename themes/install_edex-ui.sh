#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## edex-ui
##
## @category themes
## @license  MIT
## @link     https://github.com/GitSquared/edex-ui/releases

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

REPOSITORY=GitSquared/edex-ui
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=2.2.8
fi
FILENAME=eDEX-UI-Linux-x86_64.AppImage

_alert_primary "Install eDEX-UI v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info 'mkdir -p ~/.edex-ui\n'
mkdir -p ~/.edex-ui

_echo_info "wget -qO ~/.edex-ui/edex-ui.AppImage \"https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}\"\n"
wget -qO ~/.edex-ui/edex-ui.AppImage "https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}"

_echo_info 'chmod a+x ~/.edex-ui/edex-ui.AppImage\n'
chmod a+x ~/.edex-ui/edex-ui.AppImage

# create desktop shortcut
cat > "$(xdg-user-dir DESKTOP)"/edex-ui.desktop<<EOF
[Desktop Entry]
Name=eDEX-UI
Comment=eDEX-UI sci-fi interface
Exec="/home/${USER}/.edex-ui/edex-ui.AppImage" %U
Terminal=false
Type=Application
Icon=appimagekit-edex-ui
Categories=System;
TryExec=/home/${USER}/.edex-ui/edex-ui.AppImage
EOF
