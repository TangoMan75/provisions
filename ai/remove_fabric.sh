#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * remove fabric
# *
# * @category ai
# * @link     https://github.com/danielmiessler/fabric
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v pipx)" ]; then
    echo_error "\"$(basename "${0}")\" requires pipx, try: 'sudo apt-get install -y pipx'"
    exit 1
fi

alert_primary "Uninstall fabric"

echo_info 'pipx uninstall fabric'
pipx uninstall fabric

echo_info 'pipx uninstall fabric-api'
pipx uninstall fabric-api

echo_info 'pipx uninstall fabric-webui'
pipx uninstall fabric-webui

echo_info 'pipx uninstall save'
pipx uninstall save

echo_info 'pipx uninstall ts'
pipx uninstall ts

echo_info 'pipx uninstall yt'
pipx uninstall yt

echo_info 'rm -rf ~/.fabric'
rm -rf ~/.fabric
