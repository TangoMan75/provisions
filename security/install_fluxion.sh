#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## fluxion
##
## Fake accces point generator MITM WPA attacks
##
## @category security
## @link     https://github.com/FluxionNetwork/fluxion

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Install fluxion'

if [ ! -x "$(command -v git)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
    exit 1
fi

# clone project
echo_info 'git clone --depth 1 https://github.com/FluxionNetwork/fluxion ~/.fluxion\n'
git clone --depth 1 https://github.com/FluxionNetwork/fluxion ~/.fluxion

# Install requirements from within the .fluxion folder
(
    echo_info 'cd ~/.fluxion || exit 1\n'
    cd ~/.fluxion || exit 1

    # cleaning git cache
    echo_info 'rm -rf .git\n'
    rm -rf .git

    echo_info 'sudo ./fluxion.sh -i\n'
    sudo ./fluxion.sh -i
)

