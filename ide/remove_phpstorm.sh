#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove phpstorm
##
## @category ide

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=phpstorm
DESKTOP=phpstorm_phpstorm.desktop

alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

# remove desktop link
echo_info "rm -f \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
rm -f "$(xdg-user-dir DESKTOP)/${DESKTOP}"

#--------------------------------------------------

# remove phpstorm config
echo_info "rm -rf ~/.config/JetBrains/PhpStorm*\n"
rm -rf ~/.config/JetBrains/PhpStorm*

echo_info 'rm -rf ~/.local/share/JetBrains/Toolbox/apps/PhpStorm\n'
rm -rf ~/.local/share/JetBrains/Toolbox/apps/PhpStorm

echo_info 'sudo rm -f /etc/sysctl.d/idea.conf\n'
sudo rm -f /etc/sysctl.d/idea.conf

# remove user id
echo_info 'rm ~/.java/.userPrefs/prefs.xml\n'
rm ~/.java/.userPrefs/prefs.xml

# remove java prefs
echo_info 'rm -rf ~/.java/.userPrefs/jetbrains\n'
rm -rf ~/.java/.userPrefs/jetbrains

# remove .profile configuration if any
echo_info "sed -i \"/^PATH=.*PhpStorm.*/d\" ~/.profile\n"
sed -i "/^PATH=.*PhpStorm.*/d" ~/.profile

# remove global install if any
echo_info 'sudo rm -f /usr/bin/phpstorm\n'
sudo rm -f /usr/bin/phpstorm

