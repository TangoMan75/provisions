#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## openssh-server
## secure shell protocol
##
## Start ssh server
## sudo systemctl start ssh
## 
## Stop ssh server
## sudo systemctl stop ssh
## 
## Restart ssh server
## sudo systemctl restart ssh
##
## @category servers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=openssh-server

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

# create autostart shortcut
cat > ~/.config/autostart/openssh-server.desktop<<EOF
[Desktop Entry]
Name=Open SSH Server
Comment=Open SSH Server
Exec=sudo systemctl start ssh
Type=Application
Terminal=false
Hidden=false
EOF
