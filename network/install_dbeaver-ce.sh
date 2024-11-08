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
# * dbeaver-ce
# *
# * universal client database manager
# *
# * @category network
# * @link     https://dbeaver.io
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

FILENAME=dbeaver-ce_latest_amd64.deb

alert_primary "Install DBeaver Community"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info "wget \"https://dbeaver.io/files/${FILENAME}\""
wget "https://dbeaver.io/files/${FILENAME}"

echo_info "sudo dpkg -i \"${FILENAME}\""
sudo dpkg -i "${FILENAME}"

echo_info "rm -f \"${FILENAME}\""
rm -f "${FILENAME}"

# create desktop shortcut
echo_info "cp -p /usr/share/applications/dbeaver-ce.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/dbeaver-ce.desktop "$(xdg-user-dir DESKTOP)"
