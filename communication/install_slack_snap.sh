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
# * Slack
# *
# * @category communication
# * @link     https://slack.com/downloads/linux
# * @note     NOT RECOMMENDED: install deb version instead
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap, try: 'sudo apt-get install -y snap'\n"
    exit 1
fi

alert_primary 'Install Slack'

echo_info 'sudo snap install slack --classic\n'
sudo snap install slack --classic

# create desktop shortcut
echo_info "ln -s /var/lib/snapd/desktop/applications/slack_slack.desktop \"$(xdg-user-dir DESKTOP)\"\n"
ln -s /var/lib/snapd/desktop/applications/slack_slack.desktop "$(xdg-user-dir DESKTOP)"
