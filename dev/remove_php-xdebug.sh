#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove php-xdebug
## php debug plugin
##
## @category dev
## @link     https://www.php.net/supported-versions.php

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VALID_VERSIONS=(7.3 7.4 8.0 8.1 8.2 8.3 8.4)
VERSION=''

#--------------------------------------------------

if [ "$#" -gt 2 ]; then
    _echo_danger "error: too many arguments (${#})\n" 2
    _echo_success 'usage:' 2 7; _echo_primary "$(basename "${0}") -v [version] -h (help)\n"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) _echo_success 'description:' 2 14; _echo_primary 'Install php\n'
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -v [version] -h (help)\n"
            exit 0;;
        :) _echo_danger "error: \"${OPTARG}\" requires value\n" 2
            exit 1;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n" 2
            exit 1;;
    esac
done

#--------------------------------------------------

function is_valid_version() {
    local _version

    if [ "${#VALID_VERSIONS[@]}" -eq 0 ]; then
        _echo_danger 'error: "VALID_VERSIONS" array cannot be empty\n' 2
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

function uninstall_xdebug() {
    if [ -z "$1" ]; then
        _echo_danger 'error: some mandatory argument is missing\n' 2
        _echo_success 'usage:' 2 7; _echo_primary "${FUNCNAME[0]} [version]\n"
        return 1
    fi

    _echo_info "sudo apt-get purge --assume-yes \"php$1-xdebug\"\n"
    sudo apt-get purge --assume-yes "php$1-xdebug"

    _echo_info 'sudo pecl uninstall xdebug\n'
    sudo pecl uninstall xdebug

    _echo_info 'sudo apt-get --assume-yes autoremove\n'
    sudo apt-get --assume-yes autoremove
}

#--------------------------------------------------

function get_php_ini_path() {
    php -i 2>/dev/null | grep -E "Loaded Configuration File => .+php.ini" | sed 's/Loaded Configuration File => //'
}

#--------------------------------------------------

function remove_xdebug_config() {
    if [ ! -f "$1" ]; then
        _echo_danger "error: \"$1\" file does not exist\n" 2
        _echo_success 'usage:' 2 7; _echo_primary "${FUNCNAME[0]} [file_path]\n"

        return 1
    fi

    _echo_info "sudo sed -i -E '/^\[xdebug\]$/d' \"$1\"\n"
    sudo sed -i -E '/^\[xdebug\]$/d' "$1"

    _echo_info "sudo sed -i -E '/zend_extension\s?=.*xdebug/d' \"$1\"\n"
    sudo sed -i -E '/zend_extension\s?=.*xdebug/d' "$1"

    _echo_info "sudo sed -i -E '/xdebug.+=.+/d' \"$1\"\n"
    sudo sed -i -E '/xdebug.+=.+/d' "$1"
}

#--------------------------------------------------

function delete_xdebug_ini() {
    _echo_info "sudo find /etc/php/ -type f -name 'xdebug.ini' -delete\n"
    sudo find /etc/php/ -type f -name 'xdebug.ini' -delete
}

#--------------------------------------------------

function restart_php_service() {
    if [ -z "$1" ]; then
        _echo_danger 'error: some mandatory argument is missing\n' 2
        _echo_success 'usage:' 2 7; _echo_primary "${FUNCNAME[0]} [version]\n"
        return 1
    fi

    _echo_info "sudo systemctl restart \"php$1-fpm\"\n"
    sudo systemctl restart "php$1-fpm"
}

#--------------------------------------------------

if [ -z "${VERSION}" ]; then
    VERSION="$(get_php_version)"
fi

if [ "$(is_valid_version "${VERSION}")" != true ]; then
    _echo_danger "error: \"$(basename "${0}")\" invalid version \"${VERSION}\"" 2
    exit 1
fi

_alert_primary "Remove PHP-Xdebug v${VERSION}"

uninstall_xdebug "${VERSION}"
remove_xdebug_config "$(get_php_ini_path)"
delete_xdebug_ini
restart_php_service "${VERSION}"

