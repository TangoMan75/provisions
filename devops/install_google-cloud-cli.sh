#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install google-cloud-cli
##
## ```
## gcloud init
## ```
##
## @category devops
## @link     https://docs.gcloud.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install google-cloud-cli'

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl gpg)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes apt-transport-https\n'
sudo apt-get install --assume-yes apt-transport-https

_echo_info 'sudo apt-get install --assume-yes ca-certificates gnupg\n'
sudo apt-get install --assume-yes ca-certificates gnupg

#--------------------------------------------------

if [ ! -f /usr/share/keyrings/cloud.google.gpg ]; then
    # Install key in a dedicated keyring (apt-key is gone since Debian 12 / Ubuntu 24.04)
    _echo_info 'curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/cloud.google.gpg\n'
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/cloud.google.gpg
fi

if [ ! -f /etc/apt/sources.list.d/google-cloud-cli.list ]; then
    # Install repository
    _echo_info 'echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\n'
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
fi

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes google-cloud-cli\n'
sudo apt-get install --assume-yes google-cloud-cli

#--------------------------------------------------
# optional
#--------------------------------------------------

# _echo_info 'sudo apt-get install --assume-yes google-cloud-cli-app-engine-java\n'
# sudo apt-get install --assume-yes google-cloud-cli-app-engine-java

# _echo_info 'sudo apt-get install --assume-yes google-cloud-cli-app-engine-python\n'
# sudo apt-get install --assume-yes google-cloud-cli-app-engine-python

# _echo_info 'sudo apt-get install --assume-yes google-cloud-cli-pubsub-emulator\n'
# sudo apt-get install --assume-yes google-cloud-cli-pubsub-emulator

# _echo_info 'sudo apt-get install --assume-yes google-cloud-cli-bigtable-emulator\n'
# sudo apt-get install --assume-yes google-cloud-cli-bigtable-emulator

# _echo_info 'sudo apt-get install --assume-yes google-cloud-cli-datastore-emulator\n'
# sudo apt-get install --assume-yes google-cloud-cli-datastore-emulator

# _echo_info 'sudo apt-get install --assume-yes kubectl\n'
# sudo apt-get install --assume-yes kubectl

