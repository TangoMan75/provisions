#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## node-sass
##
## `yarn init`
## `yarn add --dev node-sass`
## `yarn build`
## `yarn watch`
##
## ```
## "scripts": {
##   "build": "node-sass --include-path scss ./scss/style.scss ./css/style.css",
##   "watch": "node-sass --watch ./scss/style.scss ./css/style.css"
## },
## ```
##
## @category dev
## @link     https://sass-lang.com/install

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Install node-sass'

if [ ! -x "$(command -v npm)" ] && [ ! -x "$(command -v yarn)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires yarm, try: 'sudo apt-get install -y yarm'\n"
    exit 1
fi

if [ -x "$(command -v yarn)" ]; then
    echo_info 'yarn global add node-sass\n'
    yarn global add node-sass

    echo_info 'yarn global list\n'
    yarn global list

    echo_info 'node-sass --version\n'
    node-sass --version

    exit 0
fi

if [ -x "$(command -v npm)" ]; then
    echo_info 'npm install node-sass -g\n'
    npm install node-sass -g

    echo_info 'node-sass --version\n'
    node-sass --version

    exit 0
fi

