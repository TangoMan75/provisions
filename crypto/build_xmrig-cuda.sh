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
# * build_xmrig-cuda
# *
# * cryptocurrency miner
# *
# * @category crypto
# * @link     https://github.com/xmrig/xmrig-cuda
# * @link     https://xmrig.com/docs/miner/build/ubuntu
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

REPOSITORY=xmrig/xmrig-cuda
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=6.15.1
fi

alert_primary "Build xmrig-cuda v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

if [ ! -x "$(command -v unzip)" ]; then
    echo_error "\"$(basename "${0}")\" requires unzip, try: 'sudo apt-get install -y unzip'"
    exit 1
fi

for app in \
    build-essential \
    cmake \
    automake \
    libtool \
    autoconf \
; do
    echo_info "sudo apt-get install -y ${app}"
    sudo apt-get install -y ${app}
done

# download source from github
echo_info "wget -qO \"xmrig-cuda.zip https://github.com/xmrig/xmrig-cuda/archive/refs/tags/v${VERSION}.zip\""
wget -qO "xmrig-cuda.zip https://github.com/xmrig/xmrig-cuda/archive/refs/tags/v${VERSION}.zip"

# unzip in current directory
echo_info "unzip xmrig-cuda.zip"
unzip xmrig-cuda.zip

# create build directory
echo_info "mkdir \"./xmrig-cuda-${VERSION}/build\""
mkdir "./xmrig-cuda-${VERSION}/build"

echo_info "cd \"./xmrig-cuda-${VERSION}/build\" || exit"
cd "./xmrig-cuda-${VERSION}/build" || exit

# build
echo_info 'cmake .. -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda'
cmake .. -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda

echo_info "make -j\"$(nproc)\""
make -j"$(nproc)"

echo_info "mkdir  ~/.xmrig"
mkdir  ~/.xmrig

echo_info "cp -vf \"./xmrig-cuda-${VERSION}/build/libxmrig-cuda.so\" ~/.xmrig"
cp -vf "./xmrig-cuda-${VERSION}/build/libxmrig-cuda.so" ~/.xmrig

echo_info "rm -rf \"xmrig-cuda-${VERSION}\""
rm -rf "xmrig-cuda-${VERSION}"

echo_info "rm -f xmrig-cuda.zip"
rm -f xmrig-cuda.zip

