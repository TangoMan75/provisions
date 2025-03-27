#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## repair snap
##
## @category system

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Repair snap'

# if snap showing "snap-confine has elevated permissions and is not confined but should be. Refusing to continue to avoid permission escalation attacks"
# sudo snap refresh core --beta

# remove snap
echo_info 'sudo apt-get remove --assume-yes snapd\n'
sudo apt-get remove --assume-yes snapd

echo_info 'sudo apt-get purge --assume-yes snapd snap-confine\n'
sudo apt-get purge --assume-yes snapd snap-confine

# clear snap cache
echo_info 'sudo rm -f /var/lib/snapd/cache/*\n'
sudo rm -f /var/lib/snapd/cache/*

# remove all accounts from snap
echo_info 'sudo rm -rf /var/lib/snapd/assertions/asserts-v0/account/*\n'
sudo rm -rf /var/lib/snapd/assertions/asserts-v0/account/*

echo_info 'sudo rm -rf /var/lib/snapd/assertions/asserts-v0/snap-declaration/*\n'
sudo rm -rf /var/lib/snapd/assertions/asserts-v0/snap-declaration/*

# remove snapshots
echo_info 'sudo rm -f /var/lib/snapd/snapshots/*\n'
sudo rm -f /var/lib/snapd/snapshots/*

# remove old snaps
LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
while read -r SNAPNAME revision; do
    snap remove "${SNAPNAME}" --revision="${revision}"
done

# list upgradable snaps
echo_info 'sudo snap refresh --list\n'
sudo snap refresh --list

# list installed apps
# sudo snap list
