#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## dbeaver-ce
##
## universal client database manager
##
## @category network
## @link     https://dbeaver.io

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

FILENAME=dbeaver-ce_latest_amd64.deb

_alert_primary "Install DBeaver Community"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info "wget \"https://dbeaver.io/files/${FILENAME}\"\n"
wget "https://dbeaver.io/files/${FILENAME}"

_echo_info "sudo dpkg --install \"${FILENAME}\"\n"
sudo dpkg --install "${FILENAME}"

_echo_info "rm -f \"${FILENAME}\"\n"
rm -f "${FILENAME}"

# create desktop shortcut
_echo_info "cp -p /usr/share/applications/dbeaver-ce.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/dbeaver-ce.desktop "$(xdg-user-dir DESKTOP)"
