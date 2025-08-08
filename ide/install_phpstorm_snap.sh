#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## phpstorm
## PHP IDE
##
## @category ide
## @link     https://www.jetbrains.com/phpstorm/features
## @note     You will need php installed on local machine in order to use debugger

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

APP_NAME=phpstorm
DESKTOP=phpstorm_phpstorm.desktop

alert_primary "Install ${APP_NAME}"

# --------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

# --------------------------------------------------

# if snap showing "snap-confine has elevated permissions and is not confined but should be. Refusing to continue to avoid permission escalation attacks"
# sudo snap refresh core --beta

echo_info "sudo snap install \"${APP_NAME}\" --classic\n"
sudo snap install "${APP_NAME}" --classic

# --------------------------------------------------

# create desktop shortcut
echo_info "ln -s \"/var/lib/snapd/desktop/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
ln -s "/var/lib/snapd/desktop/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

