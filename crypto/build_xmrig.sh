#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## build_xmrig
##
## cryptocurrency miner
##
## @category crypto
## @link     https://github.com/xmrig/xmrig
## @link     https://xmrig.com/docs/miner/build/ubuntu

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

REPOSITORY=xmrig/xmrig
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=6.15.3
fi

_alert_primary "Build xmrig v${VERSION}"

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
    libuv1-dev \
    libssl-dev \
    libhwloc-dev \
; do
    _echo_info "sudo apt-get install -y ${app}\n"
    sudo apt-get install -y ${app}
done

# download source from github
_echo_info "wget -qO \"xmrig.zip https://github.com/xmrig/xmrig/archive/refs/tags/v${VERSION}.zip\"\n"
wget -qO "xmrig.zip https://github.com/xmrig/xmrig/archive/refs/tags/v${VERSION}.zip"

# unzip in current directory
_echo_info "unzip xmrig.zip\n"
unzip xmrig.zip

# remove donation
_echo_info "sed -i -E 's/= 1;$/= 0;/' \"./xmrig-${VERSION}/src/donate.h\"\n"
sed -i -E 's/= 1;$/= 0;/' "./xmrig-${VERSION}/src/donate.h"

# create build directory
_echo_info "mkdir -p \"./xmrig-${VERSION}/build\"\n"
mkdir -p "./xmrig-${VERSION}/build"

_echo_info "cd \"./xmrig-${VERSION}/build\" || exit\n"
cd "./xmrig-${VERSION}/build" || exit

# build
_echo_info 'cmake ..\n'
cmake ..

_echo_info "make -j\"$(nproc)\"\n"
make -j"$(nproc)"

_echo_info "mkdir -p  ~/.xmrig\n"
mkdir -p  ~/.xmrig

_echo_info "cp -vf \"./xmrig-${VERSION}/build/xmrig\" ~/.xmrig\n"
cp -vf "./xmrig-${VERSION}/build/xmrig" ~/.xmrig

_echo_info "cp -vf ./config.json ~/.xmrig\n"
cp -vf ./config.json ~/.xmrig

_echo_info "rm -rf \"xmrig-${VERSION}\"\n"
rm -rf "xmrig-${VERSION}"

_echo_info "rm -f xmrig.zip\n"
rm -f xmrig.zip

