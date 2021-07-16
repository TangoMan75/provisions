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
# * install fonts-powerline
# *
# * @category fonts
# * @license  MIT
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

{
    echo_info 'sudo apt-get install --assume-yes fonts-powerline'
    sudo apt-get install --assume-yes fonts-powerline
} || {
    echo_error 'could not install fonts-powerline from apt-get'

    echo_info 'mkdir ~/.fonts-powerline'
    mkdir ~/.fonts-powerline

    echo_info 'git clone https://github.com/powerline/fonts.git ~/.fonts-powerline'
    git clone https://github.com/powerline/fonts.git ~/.fonts-powerline

    echo_info 'bash  ~/.fonts-powerline/install.sh'
    bash  ~/.fonts-powerline/install.sh

    echo_info 'rm -rf ~/.fonts-powerline'
    rm -rf ~/.fonts-powerline
}

