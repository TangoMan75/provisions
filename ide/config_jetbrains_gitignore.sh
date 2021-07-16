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
# * config jetbrains gitignore
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v git)" ]; then
    echo_error "\"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

# create gitignore file
echo_info 'echo "/.idea/" > ~/.gitignore_global'
echo "/.idea/" > ~/.gitignore_global

# config global gitignore
echo_info 'git config --global core.excludesfile ~/.gitignore_global'
git config --global core.excludesfile ~/.gitignore_global

