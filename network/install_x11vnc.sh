#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## x11vnc
## remote desktop server
##
## check server started:
## ```
## ps -edf | grep x11vnc
## ```
## check listenig ports (5901):
## ```
## netstat -lptun | grep vnc
## ```
##
## @category network
## @link http://doc.ubuntu-fr.org/x11vnc

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install x11vnc'

_echo_info 'sudo apt-get install --assume-yes x11vnc\n'
sudo apt-get install --assume-yes x11vnc

_echo_info 'x11vnc -storepasswd tangoman ~/.vnc/passwd\n'
x11vnc -storepasswd tangoman ~/.vnc/passwd

_echo_info 'x11vnc -usepw -bg -forever\n'
x11vnc -usepw -bg -forever

# create autostart shortcut
cat > ~/.config/autostart/vnc-server.desktop<<EOF
[Desktop Entry]
Name=VNC Server
Comment=VNC Server
Exec=x11vnc -usepw -bg -forever
Type=Application
Terminal=false
Hidden=false
EOF
