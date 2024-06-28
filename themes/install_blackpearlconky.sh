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
# * blackpearlconky theme
# * widget gnome system monitor
# *
# * @category themes
# * @license  MIT
# * @link     http://www.linuxandubuntu.com/home/5-best-linux-conky-themes
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v git)" ]; then
    echo_error "\"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

echo_info 'mkdir ~/.conky'
mkdir ~/.conky

echo_info 'git clone --depth 1 https://github.com/bchretien/BlackPearlConky ~/.conky'
git clone --depth 1 https://github.com/bchretien/BlackPearlConky ~/.conky

(
    echo_info 'cd ~/.conky || exit 1'
    cd ~/.conky || exit 1

    echo_info 'rm -rf .git'
    rm -rf .git
)
