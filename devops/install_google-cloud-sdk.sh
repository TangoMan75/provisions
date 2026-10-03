#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install google-cloud-sdk
##
## @category devops
## @link     https://docs.gcloud.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install google-cloud-sdk'

if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gpg, try: 'sudo apt-get install -y gpg'\n"
    exit 1
fi

#--------------------------------------------------

if [ ! -f /usr/share/keyrings/cloud.google.gpg ]; then
    # Install key in a dedicated keyring (apt-key is gone since Debian 12 / Ubuntu 24.04)
    _echo_info 'curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/cloud.google.gpg\n'
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/cloud.google.gpg
fi

if [ ! -f /etc/apt/sources.list.d/google-cloud-sdk.list ]; then
    # Install repository
    _echo_info 'echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\n'
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
fi

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes apt-transport-https\n'
sudo apt-get install --assume-yes apt-transport-https

_echo_info 'sudo apt-get install --assume-yes ca-certificates gnupg\n'
sudo apt-get install --assume-yes ca-certificates gnupg

_echo_info 'sudo apt-get install --assume-yes google-cloud-sdk\n'
sudo apt-get install --assume-yes google-cloud-sdk

#--------------------------------------------------
# optional
#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-gke-gcloud-auth-plugin\n'
sudo apt-get install --assume-yes google-cloud-sdk-gke-gcloud-auth-plugin

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-app-engine-python\n'
# sudo apt-get install --assume-yes google-cloud-sdk-app-engine-python

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-app-engine-python-extras\n'
# sudo apt-get install --assume-yes google-cloud-sdk-app-engine-python-extras

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-app-engine-java\n'
# sudo apt-get install --assume-yes google-cloud-sdk-app-engine-java

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-app-engine-go\n'
# sudo apt-get install --assume-yes google-cloud-sdk-app-engine-go

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-bigtable-emulator\n'
# sudo apt-get install --assume-yes google-cloud-sdk-bigtable-emulator

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-cbt\n'
# sudo apt-get install --assume-yes google-cloud-sdk-cbt

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-cloud-build-local\n'
# sudo apt-get install --assume-yes google-cloud-sdk-cloud-build-local

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-datalab\n'
# sudo apt-get install --assume-yes google-cloud-sdk-datalab

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-datastore-emulator\n'
# sudo apt-get install --assume-yes google-cloud-sdk-datastore-emulator

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-firestore-emulator\n'
# sudo apt-get install --assume-yes google-cloud-sdk-firestore-emulator

# _echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-pubsub-emulator\n'
# sudo apt-get install --assume-yes google-cloud-sdk-pubsub-emulator

# _echo_info 'sudo apt-get install --assume-yes kubectl\n'
# sudo apt-get install --assume-yes kubectl
