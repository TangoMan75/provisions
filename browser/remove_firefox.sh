#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove firefox
##
## @category browser

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

alert_warning 'Uninstall firefox'

# remove firefox with snap
echo_info 'sudo snap remove firefox\n'
sudo snap remove firefox

# remove desktop link
echo_info "rm \"$(xdg-user-dir DESKTOP)\"/firefox_firefox.desktop\n"
rm "$(xdg-user-dir DESKTOP)"/firefox_firefox.desktop

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

