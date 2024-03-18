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
# * ruby
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

VERSION=latest

OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_label 12 'description'; echo_primary 'Install ruby'
            echo_label 12 'usage'; echo_primary "${0} -v [version] -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

# check valid version
for VALID_VERSION in '2.4.9' '2.5.1' '2.5.7' '2.6.5' '2.7.0' 'dev' 'latest'; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL=true
    fi
done

if [ "${INSTALL}" != true ]; then
    echo_error "Cannot install \"ruby${VERSION}\", invalid version"

    exit 1
fi

if [ "${VERSION}" = 'latest' ]; then
    echo_info 'sudo apt-get install --assume-yes ruby-full'
    sudo apt-get install --assume-yes ruby-full

    exit 0
fi

if [ "${VERSION}" = 'dev' ]; then
    echo_info 'sudo apt-get install --assume-yes ruby ruby-dev'
    sudo apt-get install --assume-yes ruby ruby-dev

    exit 0
fi

if [ ! -x "$(command -v rvm)" ]; then
    echo_error "\"$(basename "${0}")\" requires rvm, try: 'sudo apt-get install -y rvm'"
    exit 1
fi

echo_info "rvm install \"ruby-${VERSION}\""
rvm install "ruby-${VERSION}"

