#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## crossftp
##
## aws glacier client
##
## @category network
## @link     https://www.crossftp.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

VERSION=1.99.9

alert_primary "Install crossftp ${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v java)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires java, try: 'sudo apt-get install -y openjdk-11-jdk'\n"
    exit 1
fi

echo_info "wget \"https://www.crossftp.com/crossftp_${VERSION}.deb\"\n"
wget "https://www.crossftp.com/crossftp_${VERSION}.deb"

echo_info "sudo dpkg --install \"crossftp_${VERSION}.deb\"\n"
sudo dpkg --install "crossftp_${VERSION}.deb"

echo_info "rm \"crossftp_${VERSION}.deb\"\n"
rm "crossftp_${VERSION}.deb"

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/crossftp.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/crossftp.desktop "$(xdg-user-dir DESKTOP)"

