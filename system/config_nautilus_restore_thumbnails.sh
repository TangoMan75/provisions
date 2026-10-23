#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config_nautilus_restore_thumbnails
##
## Restore thumbnails generation in Nautilus after 24.04 LTS update
##
## @link     https://www.reddit.com/r/Ubuntu/comments/1sij087/after_todays_update_to_2404_lts_thumbnails_no/
## @category system

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_secondary 'config restore thumbnails'

#--------------------------------------------------

_echo_warning 'Relaxing AppArmor unprivileged user namespace restrictions...\n'

_echo_info 'sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0\n'
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0

_echo_warning 'Clearing failed thumbnail cache...\n'

_echo_info 'rm -rf ~/.cache/thumbnails/fail/*\n'
rm -rf ~/.cache/thumbnails/fail/*

_echo_warning 'Restarting Nautilus...\n'

_echo_info 'nautilus -q\n'
nautilus -q

_echo_warning 'Done! Nautilus has been restarted and should attempt to regenerate thumbnails.\n'
