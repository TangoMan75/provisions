#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## jetbrains-toolbox
##
## @category ide
## @link     https://www.jetbrains.com/toolbox-app
## @link     https://www.jetbrains.com/help/phpstorm/installation-guide.html

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=jetbrains-toolbox
VERSION=1.27.3.14493
FILENAME=${APP_NAME}-${VERSION}
URL=https://download-cdn.jetbrains.com/toolbox/${FILENAME}.tar.gz

_alert_primary "Install ${APP_NAME} v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info 'sudo apt-get update --assume-yes\n'
sudo apt-get update --assume-yes

_echo_info 'sudo apt-get install --assume-yes libfuse2\n'
sudo apt-get install --assume-yes libfuse2

_echo_info "wget \"${URL}\"\n"
wget "${URL}"

# extract archive
_echo_info "tar xvzf ${FILENAME}.tar.gz\n"
tar xvzf ${FILENAME}.tar.gz

# install binary globally
_echo_info "sudo mv -fv ${FILENAME}/${APP_NAME} /usr/local/bin/${APP_NAME}\n"
sudo mv -fv ${FILENAME}/${APP_NAME} /usr/local/bin/${APP_NAME}

_echo_info "rm -rf \"${FILENAME}\"\n"
rm -rf "${FILENAME}"

_echo_info "rm -f \"${FILENAME}.tar.gz\"\n"
rm -f "${FILENAME}.tar.gz"

# # create desktop shortcut
# _echo_info 'ln -s ~/.local/share/applications/jetbrains-toolbox.desktop "$(xdg-user-dir DESKTOP)"/\n'
# ln -s ~/.local/share/applications/jetbrains-toolbox.desktop "$(xdg-user-dir DESKTOP)"/

# # create desktop shortcut
# cat > "$(xdg-user-dir DESKTOP)"/jetbrains-toolbox.desktop<<EOF
# [Desktop Entry]
# Name=Toolbox
# Comment=JetBrains Toolbox
# Exec=/usr/local/bin/jetbrains-toolbox
# Terminal=false
# Type=Application
# Icon=/usr/local/bin/jetbrains-toolbox
# Categories=System;
# EOF

