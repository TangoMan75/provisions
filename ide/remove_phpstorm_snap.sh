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
# * remove phpstorm
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v snap)" ]; then
    echo_error "\"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'"
    exit 1
fi

# remove phpstorm with snap
echo_info 'sudo snap remove phpstorm'
sudo snap remove phpstorm

# clear snap cache
echo_info 'sudo rm -f /var/lib/snapd/cache/*'
sudo rm -f /var/lib/snapd/cache/*

# remove phpstorm from profiles
echo_info 'sudo rm -f /var/lib/snapd/apparmor/profiles/*.phpstorm'
sudo rm -f /var/lib/snapd/apparmor/profiles/*.phpstorm

# remove phpstorm from applications
echo_info 'sudo rm -f /var/lib/snapd/desktop/applications/phpstorm*'
sudo rm -f /var/lib/snapd/desktop/applications/phpstorm*

# remove phpstorm from snap
echo_info 'sudo rm -f /var/lib/snapd/sequence/phpstorm*'
sudo rm -f /var/lib/snapd/sequence/phpstorm*

# remove phpstorm from snap
echo_info 'sudo rm -f /var/lib/snapd/snap/phpstorm*'
sudo rm -f /var/lib/snapd/snap/phpstorm*

# remove all accounts from snap
echo_info 'sudo rm -rf /var/lib/snapd/assertions/asserts-v0/account/*'
sudo rm -rf /var/lib/snapd/assertions/asserts-v0/account/*

echo_info 'sudo rm -rf /var/lib/snapd/assertions/asserts-v0/snap-declaration/*'
sudo rm -rf /var/lib/snapd/assertions/asserts-v0/snap-declaration/*

# remove snapshots
echo_info 'sudo rm -f /var/lib/snapd/snapshots/*'
sudo rm -f /var/lib/snapd/snapshots/*

# remove old snaps
LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
while read -r SNAPNAME revision; do
    snap remove "${SNAPNAME}" --revision="${revision}"
done

# list upgradable snaps
echo_info 'sudo snap refresh --list'
sudo snap refresh --list

