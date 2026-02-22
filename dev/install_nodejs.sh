#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## nodejs
## javascript backend engine
##
## @link     https://github.com/nodesource/distributions
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VALID_VERSIONS=(20 21 22 23 24)
DEFAULT_VERSION=22
if [ "$#" -gt 2 ]; then
    _echo_danger "error: too many arguments (${#})\n" 2
    _echo_success 'usage:' 2 7; _echo_primary "$(basename "${0}") -v [version] -h (help)\n"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) _echo_success 'description:' 2 14; _echo_primary 'Install Node.js\n'
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -v [version] -h (help)\n"
            exit 0;;
        :) _echo_danger "error: \"${OPTARG}\" requires value\n" 2
            exit 1;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n" 2
            exit 1;;
    esac
done
if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi
# check valid version
INSTALL=false
for VALID_VERSION in "${VALID_VERSIONS[@]}"; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL=true
    fi
done
if [ "${INSTALL}" != true ]; then
    _echo_danger "error: \"$(basename "${0}")\" invalid version \"${VERSION}\"\n" 2
    exit 1
fi

_alert_primary "Install Node.js v${VERSION}"

if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n" 2
    exit 1
fi

_echo_info 'sudo apt-get install -y ca-certificates gnupg\n'
sudo apt-get install -y ca-certificates gnupg

_echo_info 'sudo mkdir -p /etc/apt/keyrings\n'
sudo mkdir -p /etc/apt/keyrings

_echo_info 'curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg\n'
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

_echo_info "echo \"deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${VERSION}.x nodistro main\" | sudo tee /etc/apt/sources.list.d/nodesource.list\n"
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${VERSION}.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes nodejs\n'
sudo apt-get install --assume-yes nodejs

_echo_info 'node --version\n'
node --version
