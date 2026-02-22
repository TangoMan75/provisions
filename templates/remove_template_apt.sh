#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove template
##
## @category template
## @link     https://github.com/TangoMan75/template

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=template

#--------------------------------------------------

PPA=ppa:tangoman75/template.ppa # optional

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get remove -y \"${APP_NAME}\"\n"
sudo apt-get remove -y "${APP_NAME}"

#--------------------------------------------------

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

_echo_info "sudo add-apt-repository --remove --yes \"${PPA}\"\n"
sudo add-apt-repository --remove --yes "${PPA}"

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

# remove desktop shortcut
_echo_info "rm \"$(xdg-user-dir DESKTOP)\"/\"${APP_NAME}\".desktop\n"
rm "$(xdg-user-dir DESKTOP)"/"${APP_NAME}".desktop

#--------------------------------------------------

# this is only useful when installing cli tools
_echo_warning 'Update system\n'

_echo_info 'sync\n'
sync
