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
## @link     https://snapcraft.io/template

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=template
# snap desktop entries are named "<snap>_<desktop>.desktop"
DESKTOP="${APP_NAME}_${APP_NAME}.desktop"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires snap, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

#--------------------------------------------------

# remove desktop shortcut
_echo_info "rm -f \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
rm -f "$(xdg-user-dir DESKTOP)/${DESKTOP}"

#--------------------------------------------------

# remove template with snap
_echo_info "sudo snap remove \"${APP_NAME}\"\n"
sudo snap remove "${APP_NAME}"

#--------------------------------------------------

# clear snap cache
_echo_info 'sudo rm -f /var/lib/snapd/cache/*\n'
sudo rm -f /var/lib/snapd/cache/*

# remove template from apparmor profiles
_echo_info "sudo rm -f /var/lib/snapd/apparmor/profiles/*.${APP_NAME}\n"
sudo rm -f "/var/lib/snapd/apparmor/profiles/*.${APP_NAME}"

# remove template desktop entries from snapd
_echo_info "sudo rm -f /var/lib/snapd/desktop/applications/${APP_NAME}*\n"
sudo rm -f "/var/lib/snapd/desktop/applications/${APP_NAME}"*

# remove template sequence data
_echo_info "sudo rm -f /var/lib/snapd/sequence/${APP_NAME}*\n"
sudo rm -f "/var/lib/snapd/sequence/${APP_NAME}"*

# remove template snap mount
_echo_info "sudo rm -f /var/lib/snapd/snap/${APP_NAME}*\n"
sudo rm -f "/var/lib/snapd/snap/${APP_NAME}"*

#--------------------------------------------------
# optional global snap cleanup (uncomment if needed)
# These steps affect every snap on the machine, not just ${APP_NAME}.
#--------------------------------------------------

# # remove snap assertions
# _echo_info 'sudo rm -rf /var/lib/snapd/assertions/asserts-v0/account/*\n'
# sudo rm -rf /var/lib/snapd/assertions/asserts-v0/account/*
#
# _echo_info 'sudo rm -rf /var/lib/snapd/assertions/asserts-v0/snap-declaration/*\n'
# sudo rm -rf /var/lib/snapd/assertions/asserts-v0/snap-declaration/*
#
# # remove snapshots
# _echo_info 'sudo rm -f /var/lib/snapd/snapshots/*\n'
# sudo rm -f /var/lib/snapd/snapshots/*
#
# # remove old disabled snaps
# LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
# while read -r SNAPNAME revision; do
#     snap remove "${SNAPNAME}" --revision="${revision}"
# done
#
# # list upgradable snaps
# _echo_info 'sudo snap refresh --list\n'
# sudo snap refresh --list
