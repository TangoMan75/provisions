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
# * config php modules
# *
# * @category dev
# * @link     https://xdebug.org/docs/install
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

PHP_INI_PATH=$(php -i 2>/dev/null | sed -E -n 's/Loaded Configuration File => (.+php.ini)/\1/p')
PRODUCTION=false

VALID_VERSIONS=(3.0 4.0 4.1 4.2 4.3 4.4 5.0 5.1 5.2 5.3 5.4 5.5 5.6 7.1 7.2 7.3 7.4 8.0 8.1 8.2)
DEFAULT_VERSION="$(php --version | grep -o -m1 "[0-9]\.[0-9]" | head -n1)"

if [ "$#" -gt 3 ]; then
    echo_danger "error: too many arguments (${#})\n" 2
    echo_success 'usage:' 2 7; echo_primary "$(basename "${0}") -v [version] -d (development) -p (production) -h (help)\n"
    exit 1
fi
OPTIND=0
while getopts :dpv:h OPTION; do
    case "${OPTION}" in
        d) PRODUCTION=false;;
        p) PRODUCTION=true;;
        v) VERSION="${OPTARG}";;
        h) echo_success 'description:' 2 14; echo_primary 'Install php\n'
            echo_success 'usage:' 2 14; echo_primary "${0} -v [version] -d (development) -p (production) -h (help)\n"
            exit 0;;
        :) echo_danger "error: \"${OPTARG}\" requires value\n" 2
            exit 1;;
        \?) echo_danger "error: invalid option \"${OPTARG}\"\n" 2
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

alert_secondary "TangoMan PHP${VERSION} Configurator"

if [ "${INSTALL}" != true ]; then
    echo_danger "error: Cannot config \"php${VERSION}\", invalid version\n" 2
    exit 1
fi

function get_xdebug_path() {
    find /usr/lib/php/ -name 'xdebug.so' | grep xdebug.so
}

function production_settings() {
    echo_primary 'disable remote urls for file handling functions (default: On)\n'
    set_configuration 'allow_url_fopen=Off'

    echo_primary 'disable error message (default: Off)\n'
    set_configuration 'display_errors=Off'

    echo_primary 'hiding the presence of php (default: On)\n'
    set_configuration 'expose_php=Off'

    echo_primary 'enable logging (default: On)\n'
    set_configuration 'log_errors=Off'

    echo_primary 'max script execution time (default: 30)\n'
    set_configuration 'max_execution_time=30'

    echo_primary 'max time spent parsing input (default: 60)\n'
    set_configuration 'max_input_time=60'

    echo_primary 'max memory used by one script (default: 128)\n'
    set_configuration 'memory_limit=16M'

    echo_primary 'enable opcache (default: 1)\n'
    set_configuration 'opcache.enable=1'

    echo_primary 'maximum number of files that can be stored in the cache (default: 10000)\n'
    set_configuration 'opcache.max_accelerated_files=20000'

    echo_primary 'maximum memory that OPcache can use to store compiled PHP files (default: 128)\n'
    set_configuration 'opcache.memory_consumption=256'

    echo_primary "Don't Check PHP Files Timestamps (default: 1)\n"
    set_configuration 'opcache.validate_timestamps=0'

    echo_primary 'max post size (default: 8M))\n'
    set_configuration 'post_max_size=8M'

    echo_primary 'maximum memory allocated to store the results (default: 4096k)\n'
    set_configuration 'realpath_cache_size=4096k'

    echo_primary 'save the results for 10 minutes (600 seconds) (default: 120)\n'
    set_configuration 'realpath_cache_ttl=600'

    echo_primary 'max upload file size (default: 2M)\n'
    set_configuration 'upload_max_filesize=2M'

    echo_primary 'disable xdebug\n'
    set_configuration 'zend_extension=xdebug.so'

    # echo_primary "restricting what php can read & write\n"
    # set_configuration 'open_basedir=/var/www'

    # echo_primary "disable register global\n"
    # set_configuration 'register_globals=Off'

    # echo_primary "advanced safe mode setting\n"
    # set_configuration 'safe_mode=Off'
    # set_configuration 'safe_mode_allowed_env_vars=PHP_'
    # set_configuration 'safe_mode_exec_dir=/var/www/binaries'
    # set_configuration 'safe_mode_gid=On'
}

function development_settings() {
    echo_primary 'show the presence of php (default: On)\n'
    set_configuration 'expose_php=On'

    echo_primary 'enable logging (default: On)\n'
    set_configuration 'log_errors=On'

    echo_primary 'unlimited execution time (default: 30)\n'
    set_configuration 'max_execution_time=-1'

    echo_primary 'allow maximum memory usage (default: 128)\n'
    set_configuration 'memory_limit=-1'

    echo_primary 'unlimited upload file size (default: 2M)\n'
    set_configuration 'upload_max_filesize=-1'
}

function default_settings() {
    echo_primary 'disable remote urls for file handling functions (default: On)\n'
    set_configuration 'allow_url_fopen=On'

    echo_primary 'disable error message (default: Off)\n'
    set_configuration 'display_errors=Off'

    echo_primary 'show the presence of php (default: On)\n'
    set_configuration 'expose_php=On'

    echo_primary 'enable logging (default: On)\n'
    set_configuration 'log_errors=On'

    echo_primary 'max script execution time (default: 30)\n'
    set_configuration 'max_execution_time=30'

    echo_primary 'max time spent parsing input (default: 60)\n'
    set_configuration 'max_input_time=60'

    echo_primary 'max memory used by one script (default: 128)\n'
    set_configuration 'memory_limit=128'

    echo_primary 'enable opcache (default: 1)\n'
    set_configuration 'opcache.enable=1'

    echo_primary 'maximum number of files that can be stored in the cache (default: 10000)\n'
    set_configuration 'opcache.max_accelerated_files=10000'

    echo_primary 'maximum memory that OPcache can use to store compiled PHP files (default: 128)\n'
    set_configuration 'opcache.memory_consumption=128'

    echo_primary "Don't Check PHP Files Timestamps (default: 1)\n"
    set_configuration 'opcache.validate_timestamps=0'

    echo_primary 'max post size (default: 8M))\n'
    set_configuration 'post_max_size=8M'

    echo_primary 'maximum memory allocated to store the results (default: 4096k)\n'
    set_configuration 'realpath_cache_size=4096k'

    echo_primary 'save the results for 10 minutes (600 seconds) (default: 120)\n'
    set_configuration 'realpath_cache_ttl=120'

    echo_primary 'max upload file size (default: 2M)\n'
    set_configuration 'upload_max_filesize=2M'
}

function allow_alternative_php_versions() {
    # allows to configure alternative php versions
    echo_info 'sudo update-alternatives --config php\n'
    sudo update-alternatives --config php
}

function backup_php_ini() {
    echo_info "cp \"${PHP_INI_PATH}\" .\n"
    cp "${PHP_INI_PATH}" .
}

function set_configuration() {
    PARAMETER=$(echo "$1" | cut -d= -f1)
    VALUE=$(echo "$1" | cut -d= -f2)

    echo_secondary "${PARAMETER}=${VALUE}"

    # sed -i => edit files in place
    # sed -E => regexp extended
    echo_info "sudo sed -i -E s/\"^;?${PARAMETER}\s?=.*$/${PARAMETER} = ${VALUE}\"/g \"${PHP_INI_PATH}\"\n"
    sudo sed -i -E s/"^;?${PARAMETER}\s?=.*$/${PARAMETER}=${VALUE}"/g "${PHP_INI_PATH}"
}

function enable_extensions() {
    EXTENSIONS=(curl exif fileinfo gd2 intl mbstring openssl pdo_mysql pdo_pgsql pdo_sqlite soap sqlite3)

    for EXTENSION in "${EXTENSIONS[@]}"; do
        enable_extension "${EXTENSION}"
    done
}

function disable_extensions() {
    EXTENSIONS=(curl exif fileinfo gd2 intl mbstring openssl pdo_mysql pdo_pgsql pdo_sqlite soap sqlite3)

    for EXTENSION in "${EXTENSIONS[@]}"; do
        disable_extension "${EXTENSION}"
    done
}

function enable_parameter() {
    echo_info "sudo sed -i -E s/\"^;($1\s?=.*)/\1\"/g \"${PHP_INI_PATH}\"\n"
    sudo sed -i -E s/"^;($1\s?=.*)/\1"/g "${PHP_INI_PATH}"
}

function disable_parameter() {
    echo_info "sudo sed -i -E s/\"^($1\s?=.*)/;\1\"/g \"${PHP_INI_PATH}\"\n"
    sudo sed -i -E s/"^($1\s?=.*)/;\1"/g "${PHP_INI_PATH}"
}

function enable_extension() {
    echo_info "sudo sed -i -E s/\"^;extension=$1\s?.*/extension=$1\"/g \"${PHP_INI_PATH}\"\n"
    sudo sed -i -E s/"^;extension=$1\s?.*/extension=$1"/g "${PHP_INI_PATH}"
}

function disable_extension() {
    echo_info "sudo sed -i -E s/\"^extension=$1.*/;extension=$1\"/g \"${PHP_INI_PATH}\"\n"
    sudo sed -i -E s/"^extension=$1.*/;extension=$1"/g "${PHP_INI_PATH}"
}

function open_in_sublime_text() {
    echo_info "sudo subl \"${PHP_INI_PATH}\"\n"
    sudo subl "${PHP_INI_PATH}"
}

function restart_php_service() {
    # restart php-fpm service
    echo_info "sudo systemctl restart \"php${VERSION}-fpm\"\n"
    sudo systemctl restart "php${VERSION}-fpm"
}

function print_infos() {
    echo_info 'php -v\n'
    php -v

    echo_info "\"php-fpm${VERSION}\" -v\n"
    "php-fpm${VERSION}" -v

    echo_info 'php --ini\n'
    php --ini

    # list installed modules
    echo_info 'php -m\n'
    php -m
}

function main() {
    if [ -z "${PHP_INI_PATH}" ]; then
        echo_danger 'error: php is not installed\n' 2
        return 1
    fi

    echo_info "${PHP_INI_PATH}\n"

    # backup_php_ini
    # open_in_sublime_text

    default_settings

    if [ "${PRODUCTION}" = true ]; then
        production_settings
    else
        development_settings
    fi

    # enable_extensions
    # disable_extensions

    restart_php_service
    print_infos
}

main
