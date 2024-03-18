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
# * remove phpstorm
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary "Remove PHPStorm"

# remove desktop link
echo_info "rm \"$(xdg-user-dir DESKTOP)\"/phpstorm_phpstorm.desktop"
rm "$(xdg-user-dir DESKTOP)"/phpstorm_phpstorm.desktop

# remove phpstorm config
echo_info "rm -rf ~/.config/JetBrains/PhpStorm*"
rm -rf ~/.config/JetBrains/PhpStorm*

echo_info 'rm -rf ~/.local/share/JetBrains/Toolbox/apps/PhpStorm'
rm -rf ~/.local/share/JetBrains/Toolbox/apps/PhpStorm

echo_info 'sudo rm -f /etc/sysctl.d/idea.conf'
sudo rm -f /etc/sysctl.d/idea.conf

# remove user id
echo_info 'rm ~/.java/.userPrefs/prefs.xml'
rm ~/.java/.userPrefs/prefs.xml

# remove java prefs
echo_info 'rm -rf ~/.java/.userPrefs/jetbrains'
rm -rf ~/.java/.userPrefs/jetbrains

# remove .profile configuration if any
echo_info "sed -i \"/^PATH=.*PhpStorm.*/d\" ~/.profile"
sed -i "/^PATH=.*PhpStorm.*/d" ~/.profile

# remove global install if any
echo_info 'sudo rm -f /usr/bin/phpstorm'
sudo rm -f /usr/bin/phpstorm
