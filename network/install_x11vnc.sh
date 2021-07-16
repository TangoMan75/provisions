#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * x11vnc
# * remote desktop server
# *
# * check server started:
# * ```
# * ps -edf | grep x11vnc
# * ```
# * check listenig ports:
# * ```
# * netstat -lptun | grep vnc
# * ```
# *
# * @category network
# * @link http://doc.ubuntu-fr.org/x11vnc
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install x11vnc'

echo_info 'sudo apt-get install --assume-yes x11vnc'
sudo apt-get install --assume-yes x11vnc

echo_info 'x11vnc -storepasswd tangoman ~/.vnc/passwd'
x11vnc -storepasswd tangoman ~/.vnc/passwd

echo_info 'x11vnc -usepw -bg -forever'
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
