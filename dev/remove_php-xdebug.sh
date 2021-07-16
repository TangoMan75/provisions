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
# * remove php-xdebug
# * php debug plugin
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

function get_php_version() {
    # grep -o : only matching pattern
    # grep -m1 : stop after first match
    php --version | grep -o -m1 "[0-9]\.[0.9]"
}

function get_php_ini_path() {
    php -i 2>/dev/null | grep -E "Loaded Configuration File => .+php.ini" | sed 's/Loaded Configuration File => //'
}

function uninstall_xdebug() {
    local VERSION
    VERSION="$(get_php_version)"

    echo_info "sudo apt-get purge --assume-yes \"php${VERSION}-xdebug\""
    sudo apt-get purge --assume-yes "php${VERSION}-xdebug"

    echo_info 'sudo pecl uninstall xdebug'
    sudo pecl uninstall xdebug

    echo_info 'sudo apt-get --assume-yes autoremove'
    sudo apt-get --assume-yes autoremove
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

function delete_xdebug_ini() {
    echo_info "sudo find /etc/php/ -type f -name 'xdebug.ini' -delete"
    sudo find /etc/php/ -type f -name 'xdebug.ini' -delete
}

function restart_php_service() {
    local VERSION
    VERSION="$(get_php_version)"

    echo_info "sudo systemctl restart \"php${VERSION}-fpm\""
    sudo systemctl restart "php${VERSION}-fpm"
}

function main() {
    uninstall_xdebug
    remove_xdebug_config "$(get_php_ini_path)"
    delete_xdebug_ini
    restart_php_service
}

main
