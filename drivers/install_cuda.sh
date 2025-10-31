#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
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

alert_primary 'Install cuda'

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

echo_info 'wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin\n'
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin

echo_info 'sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600\n'
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600

echo_info 'sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub\n'
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub

echo_info 'sudo add-apt-repository --yes "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"\n'
sudo add-apt-repository --yes "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"

echo_info 'sudo apt-get update\n'
sudo apt-get update

echo_info 'sudo apt-get -y install cuda\n'
sudo apt-get -y install cuda

