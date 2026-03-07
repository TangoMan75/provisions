#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## k9s
##
## @category devops
## @link     https://github.com/derailed/k9s

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

## install k9s and kubectl
install_k9s() {
    if [ "$(uname)" = Darwin ]; then
        _echo_danger 'error: sorry, MacOS not supported\n';
        return 1;
    fi

    if [ ! -x "$(command -v curl)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
        exit 1
    fi

    # Check gcloud installation
    if [ ! -x "$(command -v gcloud)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires gcloud, try: 'sudo apt-get install -y google-cloud-sdk'\n"
        return 1
    fi

    # Check k9s installation
    if [ ! -x "$(command -v k9s)" ]; then
        _alert_primary 'Install k9s'

        _echo_info 'curl -sS https://webinstall.dev/k9s | bash\n'
        curl -sS https://webinstall.dev/k9s | bash
    fi

    # Check kubectl installation
    if [ ! -x "$(command -v kubectl)" ]; then
        _alert_primary 'Install Kubectl'

        _echo_info 'sudo apt-get install --assume-yes apt-transport-https\n'
        sudo apt-get install --assume-yes apt-transport-https

        _echo_info 'sudo apt-get install --assume-yes ca-certificates gnupg\n'
        sudo apt-get install --assume-yes ca-certificates gnupg

        if [ ! -f /etc/apt/sources.list.d/google-cloud-sdk.list ]; then
            # Install repository
            _echo_info 'echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\n'
            echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

            _echo_info 'sudo apt-get update\n'
            sudo apt-get update
        fi

        if [ ! -f /usr/share/keyrings/cloud.google.gpg ]; then
            # Install key
            _echo_info 'curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -\n'
            curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
        fi

        _echo_info 'sudo apt-get install --assume-yes kubectl\n'
        sudo apt-get install --assume-yes kubectl
    fi

    _echo_info 'sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin\n'
    sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

    _echo_info 'gcloud container clusters get-credentials staging-lemonde --region europe-west1\n'
    gcloud container clusters get-credentials staging-lemonde --region europe-west1
}

install_k9s

