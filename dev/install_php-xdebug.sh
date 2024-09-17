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
# * install php-xdebug
# * php debugger
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VALID_VERSIONS=(7.3 7.4 8.0 8.1 8.2)
VERSION=''

#--------------------------------------------------

if [ "$#" -gt 2 ]; then
    echo_error "too many arguments (${#})"
    echo_label 3 'usage'; echo_primary "$(basename "${0}") -v [version] -h (help)"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_label 12 'description'; echo_primary 'Install php-xdebug'
            echo_label 12 'usage'; echo_primary "$(basename "${0}") -v [version] -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

#--------------------------------------------------

function is_valid_version() {
    local _version

    if [ "${#VALID_VERSIONS[@]}" -eq 0 ]; then
        echo_error '"VALID_VERSIONS" array cannot be empty\n'
        return 1
    fi

    if [ -z "$1" ]; then
        echo false
        return 0
    fi

    for _version in "${VALID_VERSIONS[@]}"; do
        if [ "$1" = "${_version}" ]; then
            echo true
            return 0
        fi
    done

    echo false
}

#--------------------------------------------------

function get_php_version() {
    # grep -o : only matching pattern
    # grep -m1 : stop after first match
    # head -n1 : print first result
    php --version | grep -o -m1 "[0-9]\.[0-9]" | head -n1
}

#--------------------------------------------------

function install_xdebug() {
    if [ -z "$1" ]; then
        echo_error 'some mandatory argument is missing\n'
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [version]"
        return 1
    fi

    echo_info "sudo apt-get install --assume-yes \"php$1-xdebug\""
    sudo apt-get install --assume-yes "php$1-xdebug"
}

#--------------------------------------------------

if [ -z "${VERSION}" ]; then
    VERSION="$(get_php_version)"
fi

if [ "$(is_valid_version "${VERSION}")" != true ]; then
    echo_error "\"$(basename "${0}")\" invalid version \"${VERSION}\""
    exit 1
fi

alert_primary "Install PHP-Xdebug v${VERSION}"

install_xdebug "${VERSION}"

