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
# * config jetbrains gitignore
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_secondary 'Config Jetbrain global gitignore'

if [ ! -x "$(command -v git)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
    exit 1
fi

# create gitignore file
echo_info 'echo "/.idea/" > ~/.gitignore_global\n'
echo "/.idea/" > ~/.gitignore_global

# exclude some temp files
echo_info 'echo "/.attach_pid*" >> ~/.gitignore_global\n'
echo "/.attach_pid*" >> ~/.gitignore_global

# config global gitignore
echo_info 'git config --global core.excludesfile ~/.gitignore_global\n'
git config --global core.excludesfile ~/.gitignore_global

