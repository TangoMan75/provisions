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

alert_primary 'Install PHPStorm'

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

echo_info 'sudo snap install phpstorm --classic\n'
sudo snap install phpstorm --classic

# if snap showing "snap-confine has elevated permissions and is not confined but should be. Refusing to continue to avoid permission escalation attacks"
# sudo snap refresh core --beta

# create desktop shortcut
echo_info "ln -s /var/lib/snapd/desktop/applications/phpstorm_phpstorm.desktop \"$(xdg-user-dir DESKTOP)\"\n"
ln -s /var/lib/snapd/desktop/applications/phpstorm_phpstorm.desktop "$(xdg-user-dir DESKTOP)"

