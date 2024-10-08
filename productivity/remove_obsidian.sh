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
# * obsidian
# *
# * @category productivity
# * @link     https://obsidian.md
# * @link     https://obsidian.md/plugins
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

APP_NAME=obsidian

alert_primary "Remove ${APP_NAME}"

echo_info "sudo dpkg --purge \"${APP_NAME}\""
sudo dpkg --purge "${APP_NAME}"

# remove desktop shortcut
echo_info "rm \"$(xdg-user-dir DESKTOP)\"/\"${APP_NAME}\".desktop"
rm "$(xdg-user-dir DESKTOP)"/"${APP_NAME}".desktop
