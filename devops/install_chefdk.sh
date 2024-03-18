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
# * chefdk
# * architecture as a code development kit
# *
# * @category devops
# * @link     https://downloads.chef.io/chefdk
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

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
        echo_error 'unsupported system, try installing manually: https://downloads.chef.io/chefdk'
        exit 1
    fi
fi

exit 0

if [ -n "${UBUNTU}" ]; then

    if [ ! -x "$(command -v wget)" ]; then
        echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
        exit 1
    fi

    echo_info "wget \"https://packages.chef.io/files/stable/chefdk/${VERSION}/ubuntu/${UBUNTU}/chefdk_${VERSION}-1_amd64.deb\""
    wget "https://packages.chef.io/files/stable/chefdk/${VERSION}/ubuntu/${UBUNTU}/chefdk_${VERSION}-1_amd64.deb"

    echo_info "sudo dpkg -i chefdk_${VERSION}-1_amd64.deb"
    sudo dpkg -i chefdk_${VERSION}-1_amd64.deb

    echo_info "rm chefdk_${VERSION}-1_amd64.deb"
    rm chefdk_${VERSION}-1_amd64.deb
fi

if [ -n "${DARWIN}" ]; then

    if [ ! -x "$(command -v curl)" ]; then
        echo_error "\"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'"
        exit 1
    fi

    echo_info "curl \"https://packages.chef.io/files/stable/chefdk/${VERSION}/mac_os_x/${DARWIN}/chefdk-${VERSION}-1.dmg\" --output \"chefdk-${VERSION}-1.dmg\""
    curl "https://packages.chef.io/files/stable/chefdk/${VERSION}/mac_os_x/${DARWIN}/chefdk-${VERSION}-1.dmg" --output "chefdk-${VERSION}-1.dmg"

    echo_info "sudo dpkg -i chefdk_${VERSION}-1.dmg"
    sudo dpkg -i chefdk_${VERSION}-1.dmg

    echo_info "rm chefdk_${VERSION}-1.dmg"
    rm chefdk_${VERSION}-1.dmg
fi
