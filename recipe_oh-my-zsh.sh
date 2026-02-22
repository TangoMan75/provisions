#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## recipe oh-my-zsh
##
## @author  "Matthias Morin" <mat@tangoman.io>
## @license MIT
## @link    https://ohmyz.sh

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/tools/src/colors/colors.sh"

UPDATE=true
OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE=false;;
        h) _echo_warning "$(basename "${0}")";
            _echo_success 'description:' 2 14; _echo_primary 'Install Oh-My-ZSH\n'
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -n (no-update) -h (help)\n"
            exit 0;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n"
            exit 1;;
    esac
done
if [ "${UPDATE}" = true ]; then
    ./update_upgrade.sh
fi

## Oh my zsh

# 1. install_zsh
./system/install_zsh.sh
# 2. install_fonts
./fonts/install_fonts-powerline.sh
./fonts/install_nerd-fonts.sh
# 3. install_ohmyzsh
./themes/install_ohmyzsh.sh
# 4. install_tangoman-theme
./themes/install_tangoman-theme.sh
# 5. config_zsh NOTE: Script will stop here !
./system/config_zsh.sh

