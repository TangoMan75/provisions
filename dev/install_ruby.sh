#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## ruby
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VERSION=latest

OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) _echo_success 'description:' 2 14; _echo_primary 'Install ruby\n'
            _echo_success 'usage:' 2 14; _echo_primary "${0} -v [version] -h (help)\n"
            exit 0;;
        :) _echo_danger "error: \"${OPTARG}\" requires value\n"
            exit 1;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n"
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
    _echo_danger "error: Cannot install \"ruby${VERSION}\", invalid version\n"

    exit 1
fi

if [ "${VERSION}" = 'latest' ]; then
    _echo_info 'sudo apt-get install --assume-yes ruby-full\n'
    sudo apt-get install --assume-yes ruby-full

    exit 0
fi

if [ "${VERSION}" = 'dev' ]; then
    _echo_info 'sudo apt-get install --assume-yes ruby ruby-dev\n'
    sudo apt-get install --assume-yes ruby ruby-dev

    exit 0
fi

if [ ! -x "$(command -v rvm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires rvm, try: 'sudo apt-get install -y rvm'\n"
    exit 1
fi

_echo_info "rvm install \"ruby-${VERSION}\"\n"
rvm install "ruby-${VERSION}"

