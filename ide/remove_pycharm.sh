#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * remove pycharm-community
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

VERSION=2021.2

# remove pycharm-community with snap
echo_info 'sudo snap remove pycharm-community'
sudo snap remove pycharm-community

# remove desktop link
echo_info 'rm ~/Desktop/pycharm-community_pycharm-community.desktop'
rm ~/Desktop/pycharm-community_pycharm-community.desktop

# clear snap cache
echo_info 'sudo rm -f /var/lib/snapd/cache/*'
sudo rm -f /var/lib/snapd/cache/*

# remove pycharm from profiles
echo_info 'sudo rm -f /var/lib/snapd/apparmor/profiles/*.pycharm'
sudo rm -f /var/lib/snapd/apparmor/profiles/*.pycharm

# remove all accounts from snap
echo_info 'sudo rm -rf /var/lib/snapd/assertions/asserts-v0/account/*'
sudo rm -rf /var/lib/snapd/assertions/asserts-v0/account/*

echo_info 'sudo rm -rf /var/lib/snapd/assertions/asserts-v0/snap-declaration/*'
sudo rm -rf /var/lib/snapd/assertions/asserts-v0/snap-declaration/*

# remove pycharm from applications
echo_info 'sudo rm -f /var/lib/snapd/desktop/applications/pycharm*'
sudo rm -f /var/lib/snapd/desktop/applications/pycharm*

# remove pycharm from snap
echo_info 'sudo rm -f /var/lib/snapd/sequence/pycharm*'
sudo rm -f /var/lib/snapd/sequence/pycharm*

# remove pycharm from snap
echo_info 'sudo rm -f /var/lib/snapd/snap/pycharm*'
sudo rm -f /var/lib/snapd/snap/pycharm*

# remove snapshots
echo_info 'sudo rm -f /var/lib/snapd/snapshots/*'
sudo rm -f /var/lib/snapd/snapshots/*

# echo_info "rm -f ~/.config/JetBrains/PyCharm${VERSION}/eval/*"
# rm -f ~/.config/JetBrains/PyCharm${VERSION}/eval/*

# remove pycharm config
echo_info "rm -rf ~/.config/JetBrains/PyCharm${VERSION}"
rm -rf ~/.config/JetBrains/PyCharm${VERSION}

echo_info 'rm -rf ~/.local/share/JetBrains'
rm -rf ~/.local/share/JetBrains

echo_info 'sudo rm -f /etc/sysctl.d/idea.conf'
sudo rm -f /etc/sysctl.d/idea.conf

# remove old snaps
LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
while read -r SNAPNAME revision; do
    snap remove "${SNAPNAME}" --revision="${revision}"
done

