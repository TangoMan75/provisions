#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## vue-cli
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

alert_primary 'Install vue-cli'

if [ ! -x "$(command -v npm)" ] && [ ! -x "$(command -v yarn)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires yarm, try: 'sudo apt-get install -y yarm'\n"
    exit 1
fi

if [ -x "$(command -v yarn)" ]; then
    echo_info 'sudo yarn global add @vue/cli\n'
    sudo yarn global add @vue/cli

    echo_info 'sudo yarn global add @vue/cli-init\n'
    sudo yarn global add @vue/cli-init

    exit 0
fi

if [ -x "$(command -v npm)" ]; then
    echo_info 'sudo npm install -g @vuecli\n'
    sudo npm install -g @vuecli

    exit 0
fi

