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
# * remove pycharm-community
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

alert_primary 'Uninstall pycharm-community'

# remove pycharm-community with snap
echo_info 'sudo snap remove pycharm-community\n'
sudo snap remove pycharm-community

# remove pycharm config
echo_info "rm -rf ~/.config/JetBrains/PyCharm*\n"
rm -rf ~/.config/JetBrains/PyCharm*

echo_info 'rm -rf ~/.local/share/JetBrains/Toolbox/apps/PyCharm\n'
rm -rf ~/.local/share/JetBrains/Toolbox/apps/PyCharm

echo_info 'sudo rm -f /etc/sysctl.d/idea.conf\n'
sudo rm -f /etc/sysctl.d/idea.conf

#--------------------------------------------------

# remove desktop link
echo_info "rm \"$(xdg-user-dir DESKTOP)\"/pycharm-community_pycharm-community.desktop\n"
rm "$(xdg-user-dir DESKTOP)"/pycharm-community_pycharm-community.desktop

# clear snap cache
echo_info 'sudo rm -f /var/lib/snapd/cache/*\n'
sudo rm -f /var/lib/snapd/cache/*

# remove pycharm from profiles
echo_info 'sudo rm -f /var/lib/snapd/apparmor/profiles/*.pycharm\n'
sudo rm -f /var/lib/snapd/apparmor/profiles/*.pycharm

# remove pycharm from applications
echo_info 'sudo rm -f /var/lib/snapd/desktop/applications/pycharm*\n'
sudo rm -f /var/lib/snapd/desktop/applications/pycharm*

# remove pycharm from snap
echo_info 'sudo rm -f /var/lib/snapd/sequence/pycharm*\n'
sudo rm -f /var/lib/snapd/sequence/pycharm*

# remove pycharm from snap
echo_info 'sudo rm -f /var/lib/snapd/snap/pycharm*\n'
sudo rm -f /var/lib/snapd/snap/pycharm*

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

