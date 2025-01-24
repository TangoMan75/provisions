#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * install pinta
# * simple picture editor
# *
# * @category graphics
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install pinta'

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap, try: 'sudo apt-get install -y snap'\n"
    exit 1
fi

echo_info 'sudo snap install pinta --classic\n'
sudo snap install pinta --classic

# --------------------------------------------------

# create shortcut on desktop for snap app
echo_info "cp -p /var/lib/snapd/desktop/applications/pinta_pinta.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /var/lib/snapd/desktop/applications/pinta_pinta.desktop "$(xdg-user-dir DESKTOP)"

