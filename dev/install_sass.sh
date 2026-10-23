#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## sass
##
## Sass standalone
##
## @category dev
## @link     https://sass-lang.com/install

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ] && [ ! -x "$(command -v yarn)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires yarm, try: 'sudo apt-get install -y yarm'\n"
    exit 1
fi

if [ -x "$(command -v yarn)" ]; then
    _echo_info 'sudo yarn global add sass\n'
    sudo yarn global add sass

    _echo_info 'yarn global list\n'
    yarn global list

    _echo_info 'sass --version\n'
    sass --version

    exit 0
fi

if [ -x "$(command -v npm)" ]; then
    _echo_info 'sudo npm install sass -g\n'
    sudo npm install sass -g

    _echo_info 'sass --version\n'
    sass --version

    exit 0
fi

