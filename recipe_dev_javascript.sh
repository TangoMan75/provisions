#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## recipe dev javascript
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
            _echo_success 'description:' 2 14; _echo_primary 'Recipe to provision javascript dev environement\n'
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -n (no-update) -h (help)\n"
            exit 0;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n"
            exit 1;;
    esac
done
if [ "${UPDATE}" = true ]; then
    ./update_upgrade.sh
fi

./dev/install_nodejs.sh

# javascript esssentials
./dev/install_npm.sh
./dev/install_yarn.sh

