#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove visual studio code
##
## @category ide

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

_alert_danger 'Uninstall Visual Studio Code'

# remove code with snap
_echo_info 'sudo snap remove code\n'
sudo snap remove code

# remove desktop link
_echo_info "rm \"$(xdg-user-dir DESKTOP)\"/code_code.desktop\n"
rm "$(xdg-user-dir DESKTOP)"/code_code.desktop

# remove config
_echo_info 'sudo rm -rf ~/.config/Code\n'
sudo rm -rf ~/.config/Code

# remove extensions
_echo_info 'sudo rm -rf ~/.vscode\n'
sudo rm -rf ~/.vscode

# remove old snaps
LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
while read -r SNAPNAME revision; do
    snap remove "${SNAPNAME}" --revision="${revision}"
done

# list upgradable snaps
_echo_info 'sudo snap refresh --list\n'
sudo snap refresh --list
