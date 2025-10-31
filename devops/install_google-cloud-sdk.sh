#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
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

alert_primary 'Install google-cloud-sdk'

if [ ! -f /etc/apt/sources.list.d/google-cloud-sdk.list ]; then
    # Install repository
    echo_info 'echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\n'
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
fi

if [ ! -f /usr/share/keyrings/cloud.google.gpg ]; then
    # Install key
    echo_info 'curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -\n'
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
fi

echo_info 'sudo apt-get update\n'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes apt-transport-https\n'
sudo apt-get install --assume-yes apt-transport-https

echo_info 'sudo apt-get install --assume-yes ca-certificates gnupg\n'
sudo apt-get install --assume-yes ca-certificates gnupg

echo_info 'sudo apt-get install --assume-yes google-cloud-sdk\n'
sudo apt-get install --assume-yes google-cloud-sdk

#--------------------------------------------------
# optional
#--------------------------------------------------

echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-gke-gcloud-auth-plugin\n'
sudo apt-get install --assume-yes google-cloud-sdk-gke-gcloud-auth-plugin

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-app-engine-python\n'
# sudo apt-get install --assume-yes google-cloud-sdk-app-engine-python

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-app-engine-python-extras\n'
# sudo apt-get install --assume-yes google-cloud-sdk-app-engine-python-extras

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-app-engine-java\n'
# sudo apt-get install --assume-yes google-cloud-sdk-app-engine-java

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-app-engine-go\n'
# sudo apt-get install --assume-yes google-cloud-sdk-app-engine-go

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-bigtable-emulator\n'
# sudo apt-get install --assume-yes google-cloud-sdk-bigtable-emulator

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-cbt\n'
# sudo apt-get install --assume-yes google-cloud-sdk-cbt

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-cloud-build-local\n'
# sudo apt-get install --assume-yes google-cloud-sdk-cloud-build-local

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-datalab\n'
# sudo apt-get install --assume-yes google-cloud-sdk-datalab

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-datastore-emulator\n'
# sudo apt-get install --assume-yes google-cloud-sdk-datastore-emulator

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-firestore-emulator\n'
# sudo apt-get install --assume-yes google-cloud-sdk-firestore-emulator

# echo_info 'sudo apt-get install --assume-yes google-cloud-sdk-pubsub-emulator\n'
# sudo apt-get install --assume-yes google-cloud-sdk-pubsub-emulator

# echo_info 'sudo apt-get install --assume-yes kubectl\n'
# sudo apt-get install --assume-yes kubectl
