#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * config php-xdebug
# *
# * php debug module
# *
# * @category dev
# * @link     https://xdebug.org/docs/install
# * @link     https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html#updatingPhpIni
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_secondary 'TangoMan Config XDebug'

VERSION="$(php --version | grep -o -m1 "[0-9]\.[0.9]")"

function get_php_version() {
    # grep -o : only matching pattern
    # grep -m1 : stop after first match
    php --version | grep -o -m1 "[0-9]\.[0.9]"
}

function backup() {
    if [ "$#" -lt 1 ]; then
        echo_error 'some mandatory argument is missing'
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [path]"

        return 1
    fi

    if [ "$#" -gt 1 ]; then
        echo_error "too many arguments (${#})"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [path]"

        return 1
    fi

    if [ ! -e "$1" ]; then
        echo_error "invalid path ($1)"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [path]"

        return 1
    fi

    # requires BASEDIR global variable
    if [ ! -d "${CURDIR}" ]; then
        echo_error "\"${CURDIR}\" folder does not exist"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [path]"

        return 1
    fi

    # generate path with current date and current script name
    local BACKUP_DIR
    BACKUP_DIR="${CURDIR}/../backups/$(date '+%Y-%m-%d')/$(basename "$0" .sh)"

    if [ ! -d "${BACKUP_DIR}" ]; then
        echo_info "mkdir -p \"${BACKUP_DIR}\""
        mkdir -p "${BACKUP_DIR}"
    fi

    if [ -d "$1" ]; then
        # copy whole directory
        echo_info "cp -rf \"$1\" \"${BACKUP_DIR}\""
        cp -rf "$1" "${BACKUP_DIR}"
    else
        # copy file
        echo_info "cp -f \"$1\" \"${BACKUP_DIR}\""
        cp -f "$1" "${BACKUP_DIR}"
    fi
}

function remove_xdebug_config() {
    if [ ! -f "$1" ]; then
        echo_error "\"$1\" file does not exist"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [file_path]"

        return 1
    fi

    echo_info "sudo sed -i -r '/^\[xdebug\]$/d' \"$1\""
    sudo sed -i -r '/^\[xdebug\]$/d' "$1"

    echo_info "sudo sed -i -r '/zend_extension\s?=.*xdebug/d' \"$1\""
    sudo sed -i -r '/zend_extension\s?=.*xdebug/d' "$1"

    echo_info "sudo sed -i -r '/xdebug.+=.+/d' \"$1\""
    sudo sed -i -r '/xdebug.+=.+/d' "$1"
}

function create_xdebug_config() {
    if [ ! -f "$1" ]; then
        echo_error "\"$1\" file does not exist"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [file_path]"

        return 1
    fi

    if < "$1" grep -q -E 'zend_extension\s?=\s?.*xdebug'; then
        echo_warning "xdebug settings already presents in \"$1\""
        remove_xdebug_config "$1"
    fi

    echo_info "cat >> \"$1\" <<EOF
[xdebug]
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.client_host=127.0.0.1
xdebug.client_port=9003
xdebug.max_nesting_level=256
;xdebug.remote_autostart=1
;xdebug.remote_enable=1
;xdebug.remote_handler=dbgp
;xdebug.remote_log=/tmp/xdebug_remote.log
EOF"

    sudo bash -c "cat >> \"$1\" <<EOF
[xdebug]
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.client_host=127.0.0.1
xdebug.client_port=9003
xdebug.max_nesting_level=256
;xdebug.remote_autostart=1
;xdebug.remote_enable=1
;xdebug.remote_handler=dbgp
;xdebug.remote_log=/tmp/xdebug_remote.log
EOF"
}

function default_settings() {
    if [ ! -f "$1" ]; then
        echo_error "\"$1\" file does not exist"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [file_path]"

        return 1
    fi

    set_parameter "zend_extension=xdebug.so"     "$1"
    set_parameter "xdebug.client_host=localhost" "$1"
    set_parameter "xdebug.client_port=9003"      "$1"
    set_parameter "xdebug.max_nesting_level=256" "$1"
    set_parameter "xdebug.mode=develop"          "$1"

    unset_parameter "xdebug.remote_autostart" "$1"
    unset_parameter "xdebug.remote_enable"    "$1"
    unset_parameter "xdebug.remote_handler"   "$1"
    unset_parameter "xdebug.remote_log"       "$1"
}

function custom_settings() {
    if [ ! -f "$1" ]; then
        echo_error "\"$1\" file does not exist"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [file_path]"

        return 1
    fi

    set_parameter "zend_extension=xdebug.so"     "$1"
    set_parameter "xdebug.client_host=127.0.0.1" "$1"
    set_parameter "xdebug.client_port=9003"      "$1"
    set_parameter "xdebug.max_nesting_level=512" "$1"
    set_parameter "xdebug.mode=debug"            "$1"
    set_parameter "xdebug.remote_autostart=1"    "$1"
    set_parameter "xdebug.remote_enable=1"       "$1"
    set_parameter "xdebug.remote_handler=dbgp"   "$1"
    set_parameter "xdebug.remote_log=/tmp/xdebug_remote.log" "$1"
}

function set_parameter() {
    if [ "$#" -lt 2 ]; then
        echo_error 'some mandatory argument is missing'
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]"

        return 1
    fi

    if [ "$#" -gt 2 ]; then
        echo_error "too many arguments (${#})"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]"

        return 1
    fi

    if [ ! -f "$2" ]; then
        echo_error "\"$2\" file does not exist"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]"

        return 1
    fi

    # escaping slashes
    PARAMETER=$(echo "$1" | cut -d= -f1| sed 's/\//\\\//g')
    VALUE=$(echo "$1" | cut -d= -f2 | sed 's/\//\\\//g')

    echo_secondary "setting \"${PARAMETER}=${VALUE}\""

    # sed -i => edit files in place
    # sed -E => regexp extended
    echo_info "sudo sed -i -E s/\"^;?${PARAMETER}\s?=.*$/${PARAMETER}=${VALUE}\"/g \"$2\""
    sudo sed -i -E s/"^;?${PARAMETER}\s?=.*$/${PARAMETER}=${VALUE}"/g "$2"
}

function unset_parameter() {
    if [ "$#" -lt 2 ]; then
        echo_error 'some mandatory argument is missing'
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]"

        return 1
    fi

    if [ "$#" -gt 2 ]; then
        echo_error "too many arguments (${#})"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]"

        return 1
    fi

    if [ ! -f "$2" ]; then
        echo_error "\"$2\" file does not exist"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]"

        return 1
    fi

    # escaping slashes
    PARAMETER=$(echo "$1" | cut -d= -f1| sed 's/\//\\\//g')

    echo_secondary "unset \"${PARAMETER}\""

    # sed -i => edit files in place
    # sed -E => regexp extended
    echo_info "sudo sed -i -E s/\"(^${PARAMETER}\s?=.*$)/;\1\"/g \"$2\""
    sudo sed -i -E s/"(^${PARAMETER}\s?=.*$)/;\1"/g "$2"
}

function get_php_ini_path() {
    php -i 2>/dev/null | grep -E "Loaded Configuration File => .+php.ini" | sed 's/Loaded Configuration File => //'
}

function get_xdebug_ini_path() {
    local XDEBUG_INI_PATH

    find /etc/php/ -type f -name 'xdebug.ini' | while read -r XDEBUG_INI_PATH
    do
        echo "${XDEBUG_INI_PATH}"
    done
}

function get_xdebug_bin_path() {
    local XDEBUG_BIN_PATH

    XDEBUG_BIN_PATH=$(find /usr/lib/php/ -name 'xdebug.so' | grep xdebug.so)

    echo "${XDEBUG_BIN_PATH}"
}

function restart_php_service() {
    if [ "$#" -lt 1 ]; then
        echo_error 'some mandatory argument is missing'
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [version]"

        return 1
    fi

    if [ "$#" -gt 1 ]; then
        echo_error "too many arguments (${#})"
        echo_label 3 'usage'; echo_primary "${FUNCNAME[0]} [version]"

        return 1
    fi

    echo_info "sudo systemctl restart \"php$1-fpm\""
    sudo systemctl restart "php$1-fpm"
}

function open_in_sublime_text() {
    PHP_INI_PATH=$(get_php_ini_path)
    find /etc/php/ -type f -name 'xdebug.ini' | while read -r XDEBUG_INI_PATH
    do
        sudo subl "${XDEBUG_INI_PATH}"
    done
    sudo subl "${PHP_INI_PATH}"
}

function print_infos() {
    local VERSION
    VERSION=$(get_php_version)

    echo_info 'php -v'
    php -v

    echo_info "php-fpm${VERSION} -v"
    php-fpm"${VERSION}" -v

    echo_info 'php --ini | grep xdebug'
    php --ini | grep xdebug

    # list installed modules
    echo_info 'php -m | grep xdebug'
    php -m | grep xdebug

    echo_label 3 'xdebug ini path'
    get_xdebug_ini_path

    echo_label 3 'xdebug bin path'
    get_xdebug_bin_path

    echo_label 3 'php ini path'
    get_php_ini_path

}

function main() {
    find /etc/php/ -type f -name 'xdebug.ini' | while read -r XDEBUG_INI_PATH
    do
        backup "${XDEBUG_INI_PATH}"
        remove_xdebug_config "${XDEBUG_INI_PATH}"
        create_xdebug_config "${XDEBUG_INI_PATH}"
        custom_settings "${XDEBUG_INI_PATH}"
    done

    # PHP_INI_PATH=$(get_php_ini_path)
    # backup "${PHP_INI_PATH}"
    # remove_xdebug_config "${PHP_INI_PATH}"
    # create_xdebug_config "${PHP_INI_PATH}"
    # custom_settings "${PHP_INI_PATH}"

    restart_php_service "${VERSION}"
    print_infos
}

# open_in_sublime_text
main
# print_infos
