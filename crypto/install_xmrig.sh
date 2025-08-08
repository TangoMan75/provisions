#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_xmrig
##
## cryptocurrency miner
##
## @category crypto
## @link     https://github.com/xmrig/xmrig

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

REPOSITORY=xmrig/xmrig
VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    VERSION=6.15.1
fi

alert_primary "Install xmrig v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v tar)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires tar, try: 'sudo apt-get install -y tar'\n"
    exit 1
fi

echo_info "wget -q \"https://github.com/xmrig/xmrig/releases/download/v${VERSION}/xmrig-${VERSION}-focal-x64.tar.gz\"\n"
wget -q "https://github.com/xmrig/xmrig/releases/download/v${VERSION}/xmrig-${VERSION}-focal-x64.tar.gz"

echo_info "tar -zxf \"xmrig-${VERSION}-focal-x64.tar.gz\"\n"
tar -zxf "xmrig-${VERSION}-focal-x64.tar.gz"

# remove previous version
echo_info "rm -rf ~/.xmrig\n"
rm -rf ~/.xmrig

echo_info "mv -f \"xmrig-${VERSION}\" ~/.xmrig\n"
mv -f "xmrig-${VERSION}" ~/.xmrig

echo_info "rm -f \"xmrig-${VERSION}-focal-x64.tar.gz\"\n"
rm -f "xmrig-${VERSION}-focal-x64.tar.gz"

