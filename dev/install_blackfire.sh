#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## blackfire
## php performance test profiler
##
## @link     https://www.blackfire.io
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info 'wget -qO - https://packagecloud.io/gpg.key | sudo apt-key add -\n'
wget -qO - https://packagecloud.io/gpg.key | sudo apt-key add -

_echo_info 'echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list\n'
echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes blackfire-agent\n'
sudo apt-get install --assume-yes blackfire-agent

_echo_info 'sudo apt-get install --assume-yes blackfire-php\n'
sudo apt-get install --assume-yes blackfire-php

_echo_info 'sudo blackfire-agent -register\n'
sudo blackfire-agent -register

_echo_info 'blackfire-agent -d\n'
blackfire-agent -d
