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
# * update repositories
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

## Initialise git submodules
if [ -f ./.gitmodules ] && [ ! -f ./tools/.git ]; then
    git submodule update --init --recursive
fi

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}"/tools/src/colors/colors.sh

alert_secondary 'Update'

# update repositories
echo_info 'sudo apt-get update'
sudo apt-get update
