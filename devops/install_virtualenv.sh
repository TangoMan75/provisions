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
# * virtualenv
# * python virtual env
# *
# * @category devops
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v pip)" ]; then
    echo_error 'virtualenv requires python-pip to install'
    exit 1
fi

echo_info 'sudo -H pip3 install virtualenv'
sudo -H pip3 install virtualenv
