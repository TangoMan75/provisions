#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## blackpearlconky theme
## widget gnome system monitor
##
## @category themes
## @license  MIT
## @link     http://www.linuxandubuntu.com/home/5-best-linux-conky-themes

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v git)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
    exit 1
fi

_echo_info 'mkdir -p ~/.conky\n'
mkdir -p ~/.conky

_echo_info 'git clone --depth 1 https://github.com/bchretien/BlackPearlConky ~/.conky\n'
git clone --depth 1 https://github.com/bchretien/BlackPearlConky ~/.conky

(
    _echo_info 'cd ~/.conky || exit 1\n'
    cd ~/.conky || exit 1

    _echo_info 'rm -rf .git\n'
    rm -rf .git
)
