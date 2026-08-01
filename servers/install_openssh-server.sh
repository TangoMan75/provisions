#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install openssh-server
##
## secure shell protocol
##
## Start ssh server
## ```bash
## sudo systemctl start ssh
## ```
##
## Stop ssh server
## ```bash
## sudo systemctl stop ssh
## ```
##
## Restart ssh server
## ```bash
## sudo systemctl restart ssh
## ```
##
## Print local IP address
## ```bash
## ip addr show | grep inet
## hostname -I
## ```
##
## Connect to remote server
## ```bash
## ssh username@IP_ADDRESS
## ```
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

_echo_warning 'Enable and start the service\n'

_echo_info 'sudo systemctl enable --now ssh\n'
sudo systemctl enable --now ssh

#--------------------------------------------------

_echo_info 'sudo systemctl status ssh\n'
sudo systemctl status ssh

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
