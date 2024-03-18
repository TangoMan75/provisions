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
# * kubectl
# *
# * @category devops
# * @link     https://cloud.google.com/sdk/docs/install
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

if [ ! -x "$(command -v curl)" ]; then
    echo_error "\"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

alert_primary 'Install Kubectl'

echo_info 'sudo apt-get install --assume-yes apt-transport-https'
sudo apt-get install --assume-yes apt-transport-https

echo_info 'sudo apt-get install --assume-yes ca-certificates gnupg'
sudo apt-get install --assume-yes ca-certificates gnupg

if [ ! -f /etc/apt/sources.list.d/google-cloud-sdk.list ]; then
    # Install repository
    echo_info 'echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list'
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

if [ ! -f /usr/share/keyrings/cloud.google.gpg ]; then
    # Install key
    echo_info 'curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -'
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
fi

echo_info 'sudo apt-get install --assume-yes kubectl'
sudo apt-get install --assume-yes kubectl

