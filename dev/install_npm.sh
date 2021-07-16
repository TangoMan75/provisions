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
# * npm
# * javascript package manager
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get install --assume-yes npm'
sudo apt-get install --assume-yes npm

# security fix
# ------------
# 
# avoids npm runnig arbitrary postinstall scripts
# 
# package.json
#```json
# "scripts": {
#     "postinstall": "virus.js"
# }
#```

echo_info 'npm config set ignore-scripts true'
npm config set ignore-scripts true
