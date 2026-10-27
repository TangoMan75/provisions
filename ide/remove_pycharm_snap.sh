#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove pycharm-community
##
## @category ide

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=pycharm-community
DESKTOP=pycharm-community_pycharm-community.desktop

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

#--------------------------------------------------

# remove desktop link
_echo_info "rm -f \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
rm -f "$(xdg-user-dir DESKTOP)/${DESKTOP}"

#--------------------------------------------------

# remove pycharm-community with snap
_echo_info "sudo snap remove \"${APP_NAME}\"\n"
sudo snap remove "${APP_NAME}"

#--------------------------------------------------

# remove pycharm config
_echo_info "rm -rf ~/.config/JetBrains/PyCharm*\n"
rm -rf ~/.config/JetBrains/PyCharm*

_echo_info 'rm -rf ~/.local/share/JetBrains/Toolbox/apps/PyCharm\n'
rm -rf ~/.local/share/JetBrains/Toolbox/apps/PyCharm

_echo_info 'sudo rm -f /etc/sysctl.d/idea.conf\n'
sudo rm -f /etc/sysctl.d/idea.conf

#--------------------------------------------------

# clear snap cache
_echo_info 'sudo rm -f /var/lib/snapd/cache/*\n'
sudo rm -f /var/lib/snapd/cache/*

# remove pycharm from profiles
_echo_info 'sudo rm -f /var/lib/snapd/apparmor/profiles/*.pycharm\n'
sudo rm -f /var/lib/snapd/apparmor/profiles/*.pycharm

# remove pycharm from applications
_echo_info 'sudo rm -f /var/lib/snapd/desktop/applications/pycharm*\n'
sudo rm -f /var/lib/snapd/desktop/applications/pycharm*

# remove pycharm from snap
_echo_info 'sudo rm -f /var/lib/snapd/sequence/pycharm*\n'
sudo rm -f /var/lib/snapd/sequence/pycharm*

# remove pycharm from snap
_echo_info 'sudo rm -f /var/lib/snapd/snap/pycharm*\n'
sudo rm -f /var/lib/snapd/snap/pycharm*

# remove all accounts from snap
_echo_info 'sudo rm -rf /var/lib/snapd/assertions/asserts-v0/account/*\n'
sudo rm -rf /var/lib/snapd/assertions/asserts-v0/account/*

_echo_info 'sudo rm -rf /var/lib/snapd/assertions/asserts-v0/snap-declaration/*\n'
sudo rm -rf /var/lib/snapd/assertions/asserts-v0/snap-declaration/*

# remove snapshots
_echo_info 'sudo rm -f /var/lib/snapd/snapshots/*\n'
sudo rm -f /var/lib/snapd/snapshots/*

# remove old snaps
LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
while read -r SNAPNAME revision; do
    snap remove "${SNAPNAME}" --revision="${revision}"
done

# list upgradable snaps
_echo_info 'sudo snap refresh --list\n'
sudo snap refresh --list

