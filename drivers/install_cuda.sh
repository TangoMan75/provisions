#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_cuda
##
## nvidia driver
##
## @category drivers
## @link     https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_network

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install cuda'

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gpg, try: 'sudo apt-get install -y gpg'\n"
    exit 1
fi

#--------------------------------------------------

KEYRING_URL=https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
KEYRING=cuda-ubuntu2004.gpg

#--------------------------------------------------

_echo_info 'wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin\n'
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin

_echo_info 'sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600\n'
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600

# install the gpg key in a dedicated keyring (apt-key is gone since Debian 12 / Ubuntu 24.04)
_echo_info 'sudo mkdir -p -m 755 /etc/apt/keyrings\n'
sudo mkdir -p -m 755 /etc/apt/keyrings

_echo_info "wget -q \"${KEYRING_URL}\" -O- | sudo gpg --batch --yes --dearmor -o \"/etc/apt/keyrings/${KEYRING}\"\n"
wget -q "${KEYRING_URL}" -O- | sudo gpg --batch --yes --dearmor -o "/etc/apt/keyrings/${KEYRING}"

_echo_info "echo \"deb [signed-by=/etc/apt/keyrings/${KEYRING}] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /\" | sudo tee /etc/apt/sources.list.d/cuda-ubuntu2004.list > /dev/null\n"
echo "deb [signed-by=/etc/apt/keyrings/${KEYRING}] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" | sudo tee /etc/apt/sources.list.d/cuda-ubuntu2004.list > /dev/null

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get -y install cuda\n'
sudo apt-get -y install cuda

