#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## php
## php language
##
## @category dev
## @link     http://www.ansoncheunghk.info/article/8-essential-checks-securing-php
## @link     https://www.php.net/supported-versions.php

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PPA=ppa:ondrej/php
VALID_VERSIONS=(8.2 8.3 8.4 8.5)
DEFAULT_VERSION=8.5

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

if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

if [ "$(is_valid_version "${VERSION}")" != true ]; then
    _echo_danger "error: \"$(basename "${0}")\" invalid version \"${VERSION}\"\n" 2
    exit 1
fi

_alert_primary "Install PHP ${VERSION}"

#--------------------------------------------------

# add-apt-repository always uses the current Ubuntu codename. The PPA does not
# publish packages for every release, and an unsupported suite makes apt fail
# with "does not have a Release file".
if [ -r /etc/os-release ]; then
    # shellcheck source=/dev/null
    . /etc/os-release
fi
CODENAME="${UBUNTU_CODENAME:-${VERSION_CODENAME}}"

PPA_SUPPORTED=true
if [ -n "${CODENAME}" ]; then
    PPA_RELEASE_URL="https://ppa.launchpadcontent.net/ondrej/php/ubuntu/dists/${CODENAME}/Release"

    if [ -x "$(command -v curl)" ]; then
        curl -fsI "${PPA_RELEASE_URL}" &> /dev/null || PPA_SUPPORTED=false
    elif [ -x "$(command -v wget)" ]; then
        wget -q --spider "${PPA_RELEASE_URL}" &> /dev/null || PPA_SUPPORTED=false
    fi
else
    PPA_SUPPORTED=false
fi

if [ -n "${PPA}" ] && [ "${PPA_SUPPORTED}" = true ]; then
    _echo_info "sudo add-apt-repository --yes \"${PPA}\"\n"
    sudo add-apt-repository --yes "${PPA}"

    _echo_info 'sudo apt-get update\n'
    sudo apt-get update
else
    _echo_warning "The ${PPA} PPA has no packages for ${CODENAME:-this Ubuntu release}; using the distribution PHP packages instead.\n"

    # Remove a stale source file added on an unsupported release, otherwise
    # apt-get update keeps failing on it.
    for SOURCE in "/etc/apt/sources.list.d/ondrej-ubuntu-php-${CODENAME}.sources" "/etc/apt/sources.list.d/ondrej-php-${CODENAME}.list"; do
        if [ -f "${SOURCE}" ]; then
            _echo_info "sudo rm -f \"${SOURCE}\"\n"
            sudo rm -f "${SOURCE}"
        fi
    done

    _echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi

#--------------------------------------------------

if ! apt-cache show "php${VERSION}" &> /dev/null; then
    _echo_danger "error: PHP ${VERSION} is not available from the configured repositories\n"
    exit 1
fi

#--------------------------------------------------

# note: following modules are installed by default (even with --no-install-recommends)
# "phpx.x-pdo" is included in "phpx.x-common"
# libapache2-mod-phpx.x
# php-common
# phpx.x
# phpx.x-calendar
# phpx.x-cli
# phpx.x-ctype
# phpx.x-exif
# phpx.x-ffi
# phpx.x-fileinfo
# phpx.x-ftp
# phpx.x-gettext
# phpx.x-iconv
# phpx.x-json
# phpx.x-opcache
# phpx.x-pdo
# phpx.x-phar
# phpx.x-posix
# phpx.x-readline
# phpx.x-shmop
# phpx.x-sockets
# phpx.x-sysvmsg
# phpx.x-sysvsem
# phpx.x-sysvshm
# phpx.x-tokenizer

_echo_info "sudo apt-get install --assume-yes --no-install-recommends \"php${VERSION}\"\n"
sudo apt-get install --assume-yes --no-install-recommends "php${VERSION}"

_echo_info "sudo apt-get install --assume-yes --no-install-recommends \"php${VERSION}-fpm\"\n"
sudo apt-get install --assume-yes --no-install-recommends "php${VERSION}-fpm"

