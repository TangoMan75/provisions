#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove sublime-text
##
## @category ide

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_danger 'Uninstall sublime-text'

# remove sublime-text
_echo_info 'sudo apt-get remove --assume-yes sublime-text\n'
sudo apt-get remove --assume-yes sublime-text

# remove config
_echo_info 'rm -rf ~/.config/sublime-text-3\n'
rm -rf ~/.config/sublime-text-3

# remove desktop shortcut
_echo_info "rm \"$(xdg-user-dir DESKTOP)\"/sublime_text.desktop\n"
rm "$(xdg-user-dir DESKTOP)"/sublime_text.desktop

