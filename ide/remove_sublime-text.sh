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
# * remove sublime-text
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# remove sublime-text
echo_info 'sudo apt-get remove --assume-yes sublime-text'
sudo apt-get remove --assume-yes sublime-text

# remove config
echo_info 'rm -rf ~/.config/sublime-text-3'
rm -rf ~/.config/sublime-text-3

# remove desktop shortcut
echo_info "rm \"$(xdg-user-dir DESKTOP)\"/sublime_text.desktop"
rm "$(xdg-user-dir DESKTOP)"/sublime_text.desktop

