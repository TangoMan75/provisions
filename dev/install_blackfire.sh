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
# * blackfire
# * php performance test profiler
# *
# * @link     https://www.blackfire.io
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info 'wget -qO - https://packagecloud.io/gpg.key | sudo apt-key add -'
wget -qO - https://packagecloud.io/gpg.key | sudo apt-key add -

echo_info 'echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list'
echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes blackfire-agent'
sudo apt-get install --assume-yes blackfire-agent

echo_info 'sudo apt-get install --assume-yes blackfire-php'
sudo apt-get install --assume-yes blackfire-php

echo_info 'sudo blackfire-agent -register'
sudo blackfire-agent -register

echo_info 'blackfire-agent -d'
blackfire-agent -d
