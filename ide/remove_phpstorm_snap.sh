#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove phpstorm
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

_alert_danger 'Remove PHPStorm with snap'

# remove phpstorm with snap
_echo_info 'sudo snap remove phpstorm\n'
sudo snap remove phpstorm

# clear snap cache
_echo_info 'sudo rm -f /var/lib/snapd/cache/*\n'
sudo rm -f /var/lib/snapd/cache/*

# remove phpstorm from profiles
_echo_info 'sudo rm -f /var/lib/snapd/apparmor/profiles/*.phpstorm\n'
sudo rm -f /var/lib/snapd/apparmor/profiles/*.phpstorm

# remove phpstorm from applications
_echo_info 'sudo rm -f /var/lib/snapd/desktop/applications/phpstorm*\n'
sudo rm -f /var/lib/snapd/desktop/applications/phpstorm*

# remove phpstorm from snap
_echo_info 'sudo rm -f /var/lib/snapd/sequence/phpstorm*\n'
sudo rm -f /var/lib/snapd/sequence/phpstorm*

# remove phpstorm from snap
_echo_info 'sudo rm -f /var/lib/snapd/snap/phpstorm*\n'
sudo rm -f /var/lib/snapd/snap/phpstorm*

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

