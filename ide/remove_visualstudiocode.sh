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
# * remove visual studio code
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

# remove code with snap
echo_info 'sudo snap remove code\n'
sudo snap remove code

# remove desktop link
echo_info "rm \"$(xdg-user-dir DESKTOP)\"/code_code.desktop\n"
rm "$(xdg-user-dir DESKTOP)"/code_code.desktop

# remove config
echo_info 'sudo rm -rf ~/.config/Code\n'
sudo rm -rf ~/.config/Code

# remove extensions
echo_info 'sudo rm -rf ~/.vscode\n'
sudo rm -rf ~/.vscode

# remove old snaps
LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
while read -r SNAPNAME revision; do
    snap remove "${SNAPNAME}" --revision="${revision}"
done

# list upgradable snaps
echo_info 'sudo snap refresh --list\n'
sudo snap refresh --list
