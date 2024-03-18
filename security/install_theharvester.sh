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
# * theHarvester
# *
# * ```
# * cd ~/theHarvester && python3 theHarvester.py -d kali.org -l 500 -b google
# * ```
# *
# * @category security
# * @link     https://github.com/laramies/theHarvester
# * @link     https://tools.kali.org/information-gathering/theharvester
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"


if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

if [ ! -x "$(command -v python3)" ]; then
    echo_error "\"$(basename "${0}")\" requires python, try: 'sudo apt-get install -y python3'"
    exit 1
fi

if [ ! -x "$(command -v pip3)" ]; then
    echo_error "\"$(basename "${0}")\" requires pip3, try: 'sudo apt-get install -y pip3'"
    exit 1
fi

VERSION=$(get_latest_release laramies/theHarvester)
if [ -z "${VERSION}" ]; then
    VERSION=3.2.4
fi

alert_primary "Install theHarvester v${VERSION}"

echo_info "wget https://github.com/laramies/theHarvester/archive/${VERSION}.tar.gz"
wget https://github.com/laramies/theHarvester/archive/${VERSION}.tar.gz

echo_info "tar xvzf ${VERSION}.tar.gz"
tar xvzf ${VERSION}.tar.gz

echo_info "mv ./theHarvester-${VERSION} ~/.theHarvester"
mv ./theHarvester-${VERSION} ~/.theHarvester

echo_info "rm -rf ${VERSION}.tar.gz"
rm -rf ${VERSION}.tar.gz

echo_info 'pip3 install --user -r ~/.theHarvester/requirements.txt'
pip3 install --user -r ~/.theHarvester/requirements.txt