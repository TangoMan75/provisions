#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

##/**
# * recipe essentials
# *
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @license MIT
# * @link    https://ohmyz.sh
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

# shellcheck source=/dev/null
. "${CURDIR}"/tools/src/colors/colors.sh

UPDATE=true
OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE=false;;
        h) echo_warning "$(basename "${0}")";
            echo_label 14 '  description:'; echo_primary 'Install Oh-My-ZSH'
            echo_label 14 '  usage:'; echo_primary "$(basename "${0}") -n (no-update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done
if [ "${UPDATE}" = true ]; then
    ./update.sh
    ./upgrade.sh
fi

#/**
# * Oh my zsh
# */

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

