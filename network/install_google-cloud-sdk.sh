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
# * google-cloud-sdk
# *
# * @category network
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info "echo \"deb http://packages.cloud.google.com/apt $(lsb_release -cs) main\" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list"
echo "deb http://packages.cloud.google.com/apt $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

echo_info "curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -"
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes google-cloud-sdk'
sudo apt-get install --assume-yes google-cloud-sdk
