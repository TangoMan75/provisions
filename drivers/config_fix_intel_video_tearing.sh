#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## intel fix video tearing
##
## @deprecated
## @category   drivers
## @license    MIT
## @author     "Matthias Morin" <mat@tangoman.io>
## @link       https://askubuntu.com/questions/1066722/intel-screen-tearing-ubuntu-18-04

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

OPTIND=0
while getopts :h OPTION; do
    case "${OPTION}" in
        h) _echo_success 'description:' 2 14; _echo_primary "$(basename "${0}")\n"
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -h (help)\n"
            exit 0;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n"
            exit 1;;
    esac
done

_echo_info 'sudo mkdir -p /etc/X11/xorg.conf.d\n'
sudo mkdir -p /etc/X11/xorg.conf.d

cat > /etc/X11/xorg.conf.d/20-intel.conf <<EOL
Section "Device"
   Identifier  "Intel Graphics"
   Driver      "intel"
   Option      "TearFree"    "true"
EndSection
EOL
