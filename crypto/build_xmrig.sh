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
# * build_xmrig
# *
# * cryptocurrency miner
# *
# * @category crypto
# * @link     https://github.com/xmrig/xmrig
# * @link     https://xmrig.com/docs/miner/build/ubuntu
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

REPOSITORY=xmrig/xmrig
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=6.15.3
fi

alert_primary "Build xmrig v${VERSION}"

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
    libuv1-dev \
    libssl-dev \
    libhwloc-dev \
; do
    echo_info "sudo apt-get install -y ${app}"
    sudo apt-get install -y ${app}
done

# download source from github
echo_info "wget -qO \"xmrig.zip https://github.com/xmrig/xmrig/archive/refs/tags/v${VERSION}.zip\""
wget -qO "xmrig.zip https://github.com/xmrig/xmrig/archive/refs/tags/v${VERSION}.zip"

# unzip in current directory
echo_info "unzip xmrig.zip"
unzip xmrig.zip

# remove donation
echo_info "sed -i -E 's/= 1;$/= 0;/' \"./xmrig-${VERSION}/src/donate.h\""
sed -i -E 's/= 1;$/= 0;/' "./xmrig-${VERSION}/src/donate.h"

# create build directory
echo_info "mkdir \"./xmrig-${VERSION}/build\""
mkdir "./xmrig-${VERSION}/build"

echo_info "cd \"./xmrig-${VERSION}/build\" || exit"
cd "./xmrig-${VERSION}/build" || exit

# build
echo_info 'cmake ..'
cmake ..

echo_info "make -j\"$(nproc)\""
make -j"$(nproc)"

echo_info "mkdir  ~/.xmrig"
mkdir  ~/.xmrig

echo_info "cp -vf \"./xmrig-${VERSION}/build/xmrig\" ~/.xmrig"
cp -vf "./xmrig-${VERSION}/build/xmrig" ~/.xmrig

echo_info "cp -vf ./config.json ~/.xmrig"
cp -vf ./config.json ~/.xmrig

echo_info "rm -rf \"xmrig-${VERSION}\""
rm -rf "xmrig-${VERSION}"

echo_info "rm -f xmrig.zip"
rm -f xmrig.zip

