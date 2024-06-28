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
# * nodejs
# * javascript backend engine
# *
# * @link     https://github.com/nodesource/distributions
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

VALID_VERSIONS=(16 18 20)
DEFAULT_VERSION=18
if [ "$#" -gt 2 ]; then
    echo_error "too many arguments (${#})"
    echo_label 3 'usage'; echo_primary "$(basename "${0}") -v [version] -h (help)"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_label 12 'description'; echo_primary 'Install Node.js'
            echo_label 12 'usage'; echo_primary "$(basename "${0}") -v [version] -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
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
    echo_error "\"$(basename "${0}")\" invalid version \"${VERSION}\""
    exit 1
fi

alert_primary "Install Node.js v${VERSION}"

if [ ! -x "$(command -v curl)" ]; then
    echo_error "\"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

echo_info 'sudo apt-get install -y ca-certificates gnupg'
sudo apt-get install -y ca-certificates gnupg

echo_info 'sudo mkdir -p /etc/apt/keyrings'
sudo mkdir -p /etc/apt/keyrings

echo_info 'curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg'
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

echo_info "echo \"deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${VERSION}.x nodistro main\" | sudo tee /etc/apt/sources.list.d/nodesource.list"
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${VERSION}.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes nodejs'
sudo apt-get install --assume-yes nodejs

echo_info 'node --version'
node --version
