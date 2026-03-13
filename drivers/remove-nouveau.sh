#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove-nouveau
##
## @category drivers
## @license  MIT
## @link     https://docs.kali.org/general-use/install-nvidia-drivers-on-kali-linux

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# disable nouveau
_echo_info 'echo -e "blacklist nouveau\noptions nouveau modeset=0\nalias nouveau off" > /etc/modprobe.d/blacklist-nouveau.conf\n'
echo -e "blacklist nouveau\noptions nouveau modeset=0\nalias nouveau off" > /etc/modprobe.d/blacklist-nouveau.conf

# update-initramfs
_echo_info 'update-initramfs -u\n'
update-initramfs -u

# check nouveau is disabled
_echo_info 'lsmod | grep -i nouveau\n'
lsmod | grep -i nouveau
