#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Install Vagrant
##
## Vagrant 2.1.2 is compatible with VirtualBox versions 4.0, 4.1, 4.2, 4.3, 5.0, 5.1 and 5.2
## Vagrant 2.2.6 is compatible with above VirtualBox versions and version 6.0
##
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n" 2
    exit 1
fi

VERSION=2.2.10

OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) _echo_success 'description:' 2 14; _echo_primary 'Install vagrant\n'
            _echo_success 'usage:' 2 14; _echo_primary "${0} -v [version] -h (help)\n"
            exit 0;;
        :) _echo_danger "error: \"${OPTARG}\" requires value\n" 2
            exit 1;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n" 2
            exit 1;;
    esac
done

# check valid version
for VALID_VERSION in 2.1.2 2.2.6 2.2.10; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL=true
    fi
done

if [ "${INSTALL}" != true ]; then
    _echo_danger "error: Cannot install \"vagrant${VERSION}\", invalid version\n" 2
    exit 1
fi

if [ ! -x "$(command -v vagrant)" ]; then
    _echo_info "wget \"https://releases.hashicorp.com/vagrant/${VERSION}/vagrant_${VERSION}_x86_64.deb\"\n"
    wget "https://releases.hashicorp.com/vagrant/${VERSION}/vagrant_${VERSION}_x86_64.deb"

    _echo_info "sudo dpkg --install \"vagrant_${VERSION}_x86_64.deb\"\n"
    sudo dpkg --install "vagrant_${VERSION}_x86_64.deb"

    _echo_info "rm \"vagrant_${VERSION}_x86_64.deb\"\n"
    rm "vagrant_${VERSION}_x86_64.deb"
else
    _echo_warning 'vagrant already installed\n'
fi
