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
# * webstorm
# * Python IDE
# *
# * @category ide
# * @link     https://www.jetbrains.com/webstorm/features
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

echo_info 'sudo snap install webstorm --classic\n'
sudo snap install webstorm --classic

# create desktop shortcut
echo_info "ln -s /var/lib/snapd/desktop/applications/webstorm_webstorm.desktop \"$(xdg-user-dir DESKTOP)\"\n"
ln -s /var/lib/snapd/desktop/applications/webstorm_webstorm.desktop "$(xdg-user-dir DESKTOP)"
