#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * jetbrains-toolbox
# *
# * @category ide
# * @link     https://www.jetbrains.com/toolbox-app
# * @link     https://www.jetbrains.com/help/phpstorm/installation-guide.html
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

APP_NAME=jetbrains-toolbox
VERSION=1.27.3.14493
FILENAME=${APP_NAME}-${VERSION}
URL=https://download-cdn.jetbrains.com/toolbox/${FILENAME}.tar.gz

alert_primary "Install ${APP_NAME} v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info 'sudo apt-get update --assume-yes'
sudo apt-get update --assume-yes

echo_info 'sudo apt-get install --assume-yes libfuse2'
sudo apt-get install --assume-yes libfuse2

echo_info "wget \"${URL}\""
wget "${URL}"

# extract archive
echo_info "tar xvzf ${FILENAME}.tar.gz"
tar xvzf ${FILENAME}.tar.gz

# install binary globally
echo_info "sudo mv -fv ${FILENAME}/${APP_NAME} /usr/local/bin/${APP_NAME}"
sudo mv -fv ${FILENAME}/${APP_NAME} /usr/local/bin/${APP_NAME}

echo_info "rm -rf \"${FILENAME}\""
rm -rf "${FILENAME}"

echo_info "rm -f \"${FILENAME}.tar.gz\""
rm -f "${FILENAME}.tar.gz"

# # create desktop shortcut
# echo_info 'ln -s ~/.local/share/applications/jetbrains-toolbox.desktop "$(xdg-user-dir DESKTOP)"/'
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

