#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## slack
##
## @category communication

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap, try: 'sudo apt-get install -y snap'\n"
    exit 1
fi

alert_primary 'Uninstall Slack'

# remove slack with snap
echo_info 'sudo snap remove slack\n'
sudo snap remove slack

# remove desktop link
echo_info "rm \"$(xdg-user-dir DESKTOP)\"/slack_slack.desktop\n"
rm "$(xdg-user-dir DESKTOP)"/slack_slack.desktop

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
