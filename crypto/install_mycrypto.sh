#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## mycrypto
##
## ethereum wallet
##
## @category crypto
## @link     https://app.mycrypto.com
## @link     https://www.mycrypto.com
## @link     https://github.com/MyCryptoHQ/MyCrypto

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VERSION=1.7.17

_alert_primary "Install MyCrypto v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info 'mkdir -p ~/.mycrypto\n'
mkdir -p ~/.mycrypto

# -O,  --output-document=FILE      write documents to FILE
_echo_info "wget -qO ~/.mycrypto/mycrypto.AppImage https://github.com/MycryptoHQ/MyCrypto/releases/download/${VERSION}/linux-x86-64_${VERSION}_MyCrypto.AppImage\n"
wget -qO ~/.mycrypto/mycrypto.AppImage https://github.com/MycryptoHQ/MyCrypto/releases/download/${VERSION}/linux-x86-64_${VERSION}_MyCrypto.AppImage

_echo_info 'chmod a+x ~/.mycrypto/mycrypto.AppImage\n'
chmod a+x ~/.mycrypto/mycrypto.AppImage

_echo_info 'cp -fv mycrypto.png ~/.mycrypto\n'
cp -fv mycrypto.png ~/.mycrypto

# create desktop shortcut
cat > "$(xdg-user-dir DESKTOP)"/mycrypto.desktop<<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=/home/${USER}/.mycrypto/mycrypto.png
Exec=/home/${USER}/.mycrypto/mycrypto.AppImage
Name=mycrypto
Comment=mycrypto
EOF
