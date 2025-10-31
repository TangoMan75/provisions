#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Blanket
##
## @category multimedia
## @link     https://apps.gnome.org/Blanket
## @link     https://flathub.org/apps/com.rafaelmardojai.Blanket

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=blanket
DESKTOP=com.rafaelmardojai.Blanket.desktop
PPA=ppa:apandada1/blanket

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -n "${PPA}" ]; then
    echo_info "sudo add-apt-repository --yes \"${PPA}\"\n"
    sudo add-apt-repository --yes "${PPA}"

    echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi

#--------------------------------------------------

echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

# create shortcut on desktop
echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

