#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## chefdk
## architecture as a code development kit
##
## @category devops
## @link     https://downloads.chef.io/chefdk

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VERSION=3.8.14

UBUNTU=''
DARWIN=''

RELEASE="$(lsb_release -cs 2>/dev/null)"
for CODENAME in precise trusty xenial bionic cosmic disco eoan focal
do
    if [ "${RELEASE}" = "${CODENAME}" ]; then
        UBUNTU="$(lsb_release -ds)"
    fi
done

if [ -z "${UBUNTU}" ]; then
    if sw_vers -productVersion 2>/dev/null | grep -q '10.12'; then
        DARWIN='10.12'

    elif sw_vers -productVersion 2>/dev/null | grep -q '10.13'; then
        DARWIN='10.13'

    elif sw_vers -productVersion 2>/dev/null | grep -q '10.14'; then
        DARWIN='10.14'

    else
        _echo_danger 'error: unsupported system, try installing manually: https://downloads.chef.io/chefdk'
        exit 1
    fi
fi

if [ -n "${UBUNTU}" ]; then

    if [ ! -x "$(command -v wget)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
        exit 1
    fi

    _echo_info "wget \"https://packages.chef.io/files/stable/chefdk/${VERSION}/ubuntu/${UBUNTU}/chefdk_${VERSION}-1_amd64.deb\"\n"
    wget "https://packages.chef.io/files/stable/chefdk/${VERSION}/ubuntu/${UBUNTU}/chefdk_${VERSION}-1_amd64.deb"

    _echo_info "sudo dpkg --install \"chefdk_${VERSION}-1_amd64.deb\"\n"
    sudo dpkg --install "chefdk_${VERSION}-1_amd64.deb"

    _echo_info "rm \"chefdk_${VERSION}-1_amd64.deb\"\n"
    rm "chefdk_${VERSION}-1_amd64.deb"
fi

if [ -n "${DARWIN}" ]; then

    if [ ! -x "$(command -v curl)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
        exit 1
    fi

    _echo_info "curl \"https://packages.chef.io/files/stable/chefdk/${VERSION}/mac_os_x/${DARWIN}/chefdk-${VERSION}-1.dmg\" --output \"chefdk-${VERSION}-1.dmg\"\n"
    curl "https://packages.chef.io/files/stable/chefdk/${VERSION}/mac_os_x/${DARWIN}/chefdk-${VERSION}-1.dmg" --output "chefdk-${VERSION}-1.dmg"

    _echo_info "sudo dpkg --install \"chefdk_${VERSION}-1.dmg\"\n"
    sudo dpkg --install "chefdk_${VERSION}-1.dmg"

    _echo_info "rm \"chefdk_${VERSION}-1.dmg\"\n"
    rm "chefdk_${VERSION}-1.dmg"
fi
