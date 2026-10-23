#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## OWASP ZAP
##
## @category security
## @link     https://www.zaproxy.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install OWASP ZAP'

VERSION=2.12.0
FOLDER_NAME=ZAP_${VERSION}
FILENAME=${FOLDER_NAME}_Linux.tar.gz
URL=https://github.com/zaproxy/zaproxy/releases/download/v${VERSION}/ZAP_${VERSION}_Linux.tar.gz
INSTALL_DIRECTORY=~/.local/share/OWASP/zap

_alert_primary "Install OWASP ZAP v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info "wget \"${URL}\"\n"
wget "${URL}"

# extract archive
_echo_info "tar xvzf ${FILENAME}\n"
tar xvzf ${FILENAME}

# create parent folder
_echo_info "mkdir -p \"$(dirname "${INSTALL_DIRECTORY}")\"\n"
mkdir -p "$(dirname "${INSTALL_DIRECTORY}")"

# move folder
_echo_info "mv -fv \"${FOLDER_NAME}\" \"${INSTALL_DIRECTORY}\"\n"
mv -fv "${FOLDER_NAME}" "${INSTALL_DIRECTORY}"

_echo_info "rm -f \"${FILENAME}\"\n"
rm -f "${FILENAME}"

# create desktop shortcut
cat > "$(xdg-user-dir DESKTOP)"/zap-zap.desktop<<EOF
[Desktop Entry]
Name=ZAP
Comment=OWASP ZAP
Exec=${INSTALL_DIRECTORY}/zap.sh
Terminal=false
Type=Application
Icon=${INSTALL_DIRECTORY}/zap.ico
Categories=System;
EOF
