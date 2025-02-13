#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## flameshot
##
## Powerful yet simple to use screenshot software
##
## @category graphics
## @link     https://github.com/flameshot-org/flameshot
## @note     create a keyboard shortcut to `/usr/bin/flameshot gui`

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Flameshot'

echo_info 'sudo apt-get install --assume-yes flameshot\n'
sudo apt-get install --assume-yes flameshot

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/org.flameshot.Flameshot.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/org.flameshot.Flameshot.desktop "$(xdg-user-dir DESKTOP)"

# Config flameshot as default
# gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'flameshot'
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command '/usr/bin/flameshot gui'
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'Print'
