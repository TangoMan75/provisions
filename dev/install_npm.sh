#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## npm
## javascript package manager
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install npm'

if [ ! -x "$(command -v node)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires node, try: 'sudo apt-get install -y nodejs'\n"
    exit 1
fi

_echo_info 'sudo npm install -g npm\n'
sudo npm install -g npm

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

_echo_info 'npm config set ignore-scripts true\n'
npm config set ignore-scripts true
