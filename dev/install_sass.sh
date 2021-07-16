#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * sass
# *
# * Sass standalone
# *
# * @category dev
# * @link     https://sass-lang.com/install
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v npm)" ] && [ ! -x "$(command -v yarn)" ]; then
    echo_error "\"$(basename "${0}")\" requires yarm, try: 'sudo apt-get install -y yarm'"
    exit 1
fi

if [ -x "$(command -v yarn)" ]; then
    echo_info 'sudo yarn global add sass'
    sudo yarn global add sass

    echo_info 'yarn global list'
    yarn global list

    echo_info 'sass --version'
    sass --version

    exit 0
fi

if [ -x "$(command -v npm)" ]; then
    echo_info 'sudo npm install sass -g'
    sudo npm install sass -g

    echo_info 'sass --version'
    sass --version

    exit 0
fi

