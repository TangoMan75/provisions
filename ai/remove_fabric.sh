#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove fabric
##
## @category ai
## @link     https://github.com/danielmiessler/fabric

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

if [ ! -x "$(command -v pipx)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires pipx, try: 'sudo apt-get install -y pipx'\n"
    exit 1
fi

alert_primary "Uninstall fabric"

echo_info 'pipx uninstall fabric\n'
pipx uninstall fabric

echo_info 'pipx uninstall fabric-api\n'
pipx uninstall fabric-api

echo_info 'pipx uninstall fabric-webui\n'
pipx uninstall fabric-webui

echo_info 'pipx uninstall save\n'
pipx uninstall save

echo_info 'pipx uninstall ts\n'
pipx uninstall ts

echo_info 'pipx uninstall yt\n'
pipx uninstall yt

echo_info 'rm -rf ~/.fabric\n'
rm -rf ~/.fabric
