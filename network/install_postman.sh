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
# * postman
# *
# * API Rest client
# *
# * @category network
# * @link     https://www.getpostman.com
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Postman'

echo_info 'sudo snap install postman'
sudo snap install postman

# create shortcut on desktop
echo_info "cp -p /var/lib/snapd/desktop/applications/postman_postman.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /var/lib/snapd/desktop/applications/postman_postman.desktop "$(xdg-user-dir DESKTOP)"

