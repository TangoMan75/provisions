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
# * remmina
# * remote desktop client
# *
# * @category network
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install remmina'

echo_info 'sudo apt-get install --assume-yes remmina'
sudo apt-get install --assume-yes remmina

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/org.remmina.Remmina.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/org.remmina.Remmina.desktop "$(xdg-user-dir DESKTOP)"
