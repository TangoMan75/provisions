#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * vlc-delete
# * lua addon to remove current playing file
# *
# * @category multimedia
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

# echo_info 'wget -q https://gist.githubusercontent.com/PAEz/d3a9be2471dbd39084136d974cdb9dd3/raw/0d580db34725b00b778a3078b890c6a7184e035e/vlc-delete.lua'
# wget -q https://gist.githubusercontent.com/PAEz/d3a9be2471dbd39084136d974cdb9dd3/raw/0d580db34725b00b778a3078b890c6a7184e035e/vlc-delete.lua

echo_info 'wget -q https://raw.githubusercontent.com/surrim/vlc-delete/master/vlc-delete.lua'
wget -q https://raw.githubusercontent.com/surrim/vlc-delete/master/vlc-delete.lua

echo_info 'mv ./vlc-delete.lua ~/.local/share/vlc/lua/extensions'
mv ./vlc-delete.lua ~/.local/share/vlc/lua/extensions

