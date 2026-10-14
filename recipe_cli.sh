#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## recipe dev bash
##
## @license MIT
## @author  "Matthias Morin" <mat@tangoman.io>

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/tools/src/colors/colors.sh"

UPDATE=true
OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE=false;;
        h) _echo_warning "$(basename "${0}")";
            _echo_success 'description:' 2 14; _echo_primary 'Recipe to provision bash dev environment\n'
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -n (no-update) -h (help)\n"
            exit 0;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n"
            exit 1;;
    esac
done
if [ "${UPDATE}" = true ]; then
    _echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi

./cli/install_tmux.sh
./cli/config_tmux.sh

./cli/install_chafa.sh
./cli/install_eza.sh
./cli/install_fd.sh
./cli/install_fzf.sh
./cli/install_gws.sh
./cli/install_htop.sh
./cli/install_lshw.sh
./cli/install_ncdu.sh
./cli/install_poppler.sh
./cli/install_resvg.sh
./cli/install_ripgrep.sh
./cli/install_tree.sh
./cli/install_xsel.sh
./cli/install_yazi.sh
./cli/install_zoxide.sh
