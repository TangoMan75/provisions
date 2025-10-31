#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## video driver fix freezing on boot (ubuntu 16)
##
## @deprecated
## @license    MIT
## @author     "Matthias Morin" <mat@tangoman.io>
## @category   drivers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

OPTIND=0
while getopts :h OPTION; do
    case "${OPTION}" in
        h) echo_success 'description:' 2 14; echo_primary "$(basename "${0}"): disable grub splash screen to avoid freeze on boot\n"
            echo_success 'usage:' 2 14; echo_primary "$(basename "${0}") -h (help)\n"
            exit 0;;
        \?) echo_danger "error: invalid option \"${OPTARG}\"\n"
            exit 1;;
    esac
done

# NOTE: sed -E allows to use the `\w` tag in newer linux versions
echo_info "sudo sed -i -E s/'^GRUB_CMDLINE_LINUX_DEFAULT\s?=\s?\"?\w+\"?$'/'GRUB_CMDLINE_LINUX_DEFAULT=\"quiet\"'/g /etc/default/grub\n"
sudo sed -i -E s/'^GRUB_CMDLINE_LINUX_DEFAULT\s?=\s?"?\w+"?$'/'GRUB_CMDLINE_LINUX_DEFAULT="quiet"'/g /etc/default/grub

echo_info 'sudo update-grub\n'
sudo update-grub

