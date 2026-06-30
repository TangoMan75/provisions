#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove rclone
##
## @category network
## @link     https://rclone.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

{
    _echo_info 'sudo apt-get remove --assume-yes --autoremove rclone\n'
    sudo apt-get remove --assume-yes --autoremove rclone
} || {
    # binary
    _echo_info 'sudo rm -f /usr/bin/rclone\n'
    sudo rm -f /usr/bin/rclone

    # manuals
    _echo_info 'sudo rm -f /usr/local/share/man/man1/rclone.1\n'
    sudo rm -f /usr/local/share/man/man1/rclone.1
}
