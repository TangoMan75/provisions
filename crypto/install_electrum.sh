#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## electrum
##
## bitcoin wallet
##
## @category crypto
## @link     https://electrum.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VERSION=4.1.5

_alert_primary "Install electrum v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info 'mkdir -p ~/.electrum\n'
mkdir -p ~/.electrum

_echo_info "wget -qO ~/.electrum/electrum.AppImage https://download.electrum.org/${VERSION}/electrum-${VERSION}-x86_64.AppImage\n"
wget -qO ~/.electrum/electrum.AppImage https://download.electrum.org/${VERSION}/electrum-${VERSION}-x86_64.AppImage

_echo_info 'chmod a+x ~/.electrum/electrum.AppImage\n'
chmod a+x ~/.electrum/electrum.AppImage

_echo_info 'cp -fv electrum.png ~/.electrum\n'
cp -fv electrum.png ~/.electrum

# create desktop shortcut
cat > "$(xdg-user-dir DESKTOP)"/electrum.desktop<<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=/home/${USER}/.electrum/electrum.png
Exec=/home/${USER}/.electrum/electrum.AppImage
Name=electrum
Comment=electrum
EOF
