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
# * fabric
# *
# * @category ai
# * @link     https://github.com/danielmiessler/fabric
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v go)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires go, try: 'sudo apt-get install -y golang-go'\n"
    exit 1
fi

# --------------------------------------------------

# Install Fabric directly from the repo
echo_info 'go install github.com/danielmiessler/fabric@latest\n'
go install github.com/danielmiessler/fabric@latest

# --------------------------------------------------

# Run the setup to set up your directories and keys
echo_info 'fabric --setup\n'
fabric --setup

