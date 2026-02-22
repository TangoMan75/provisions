#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## flameshot
##
## Powerful yet simple to use screenshot software
##
## @category graphics
## @link     https://github.com/flameshot-org/flameshot
## @link     https://flameshot.org/docs/guide/key-bindings/#on-ubuntu-and-other-gnome-based-distros
## @note     create a keyboard shortcut to `/usr/bin/flameshot gui`

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_secondary 'Config flameshot'

if [ ! -x "$(command -v jq)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires jq, try: 'sudo apt-get install -y jq'\n"
    exit 1
fi

if [ ! -x "$(command -v gsettings)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gsettings, try: 'sudo apt-get install -y gsettings'\n"
    exit 1
fi

function gsettingsAppend() {
    current_bindings="$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings | tr "'" '"')"
    new_bindings="$(echo "${current_bindings}" | jq ". + [\"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$1/\"]")"

    _echo_info "gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \"${new_bindings}\"\n"
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "${new_bindings}"

    _echo_info "gsettings set \"org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$1/\" name \"$2\"\n"
    gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$1/" name "$2"

    _echo_info "gsettings set \"org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$1/\" command \"$3\"\n"
    gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$1/" command "$3"

    _echo_info "gsettings set \"org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$1/\" binding \"$4\"\n"
    gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$1/" binding "$4"
}

gsettingsAppend 'flameshot0' 'flameshot' '/usr/bin/flameshot gui' 'Print'
# gsettingsAppend 'terminal0' 'terminal' '/usr/bin/gnome-terminal' '<Primary><shift><Alt>t'
