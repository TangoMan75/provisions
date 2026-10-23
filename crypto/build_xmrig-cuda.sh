#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## build_xmrig-cuda
##
## cryptocurrency miner
##
## @category crypto
## @link     https://github.com/xmrig/xmrig-cuda
## @link     https://xmrig.com/docs/miner/build/ubuntu

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

REPOSITORY=xmrig/xmrig-cuda
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=6.15.1
fi

_alert_primary "Build xmrig-cuda v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v unzip)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires unzip, try: 'sudo apt-get install -y unzip'\n"
    exit 1
fi

for app in \
    build-essential \
    cmake \
    automake \
    libtool \
    autoconf \
; do
    _echo_info "sudo apt-get install -y ${app}\n"
    sudo apt-get install -y ${app}
done

# download source from github
_echo_info "wget -qO \"xmrig-cuda.zip https://github.com/xmrig/xmrig-cuda/archive/refs/tags/v${VERSION}.zip\"\n"
wget -qO "xmrig-cuda.zip https://github.com/xmrig/xmrig-cuda/archive/refs/tags/v${VERSION}.zip"

# unzip in current directory
_echo_info "unzip xmrig-cuda.zip\n"
unzip xmrig-cuda.zip

# create build directory
_echo_info "mkdir -p \"./xmrig-cuda-${VERSION}/build\"\n"
mkdir -p "./xmrig-cuda-${VERSION}/build"

_echo_info "cd \"./xmrig-cuda-${VERSION}/build\" || exit\n"
cd "./xmrig-cuda-${VERSION}/build" || exit

# build
_echo_info 'cmake .. -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda\n'
cmake .. -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda

_echo_info "make -j\"$(nproc)\"\n"
make -j"$(nproc)"

_echo_info "mkdir -p  ~/.xmrig\n"
mkdir -p  ~/.xmrig

_echo_info "cp -vf \"./xmrig-cuda-${VERSION}/build/libxmrig-cuda.so\" ~/.xmrig\n"
cp -vf "./xmrig-cuda-${VERSION}/build/libxmrig-cuda.so" ~/.xmrig

_echo_info "rm -rf \"xmrig-cuda-${VERSION}\"\n"
rm -rf "xmrig-cuda-${VERSION}"

_echo_info "rm -f xmrig-cuda.zip\n"
rm -f xmrig-cuda.zip

