#!/bin/bash

#/*
## This file is part of TangoMan Bash Tools package.
##
## Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## TangoMan Check Install
##
## This script is meant to quickly check for common apps installation
##
## @licence MIT
## @author  "Matthias Morin" <mat@tangoman.io>

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}"/../colors/colors.sh
# shellcheck source=/dev/null
. "${CURDIR}"/is_installed.sh

## Check version of some development tools
check_versions() {
    _alert_primary 'Check Versions'

    _echo_info 'ansible\n'
    if [ "$(is_installed 'ansible')" = true ]; then
        ansible --version | head -n 1
    else
        _echo_danger 'ansible is not installed on your system\n'
    fi

    _echo_info 'apache2\n'
    if [ "$(is_installed 'apache2')" = true ] && [ -n "$(apache2 --version 2>/dev/null)" ]; then
        apache2 --version 2>/dev/null
    else
        _echo_danger 'apache2 is not installed on your system\n'
    fi

    _echo_info 'aws\n'
    if [ "$(is_installed 'aws')" = true ]; then
        aws --version
    else
        _echo_danger 'aws is not installed on your system\n'
    fi

    _echo_info 'bundle\n'
    if [ "$(is_installed 'bundle')" = true ]; then
        bundle --version
    else
        _echo_danger 'bundle is not installed on your system\n'
    fi

    _echo_info 'chef\n'
    if [ "$(is_installed 'chef')" = true ]; then
        chef --version
    else
        _echo_danger 'chef is not installed on your system\n'
    fi

    _echo_info 'composer\n'
    if [ "$(is_installed 'php')" = true ]; then
        if [ -n "$(command -v composer)" ]; then
            $(command -v composer) --version
        else
            _echo_danger 'composer is not installed on your system\n'
        fi
    else
        _echo_danger 'unable to show composer version, php not installed\n'
    fi

    _echo_info 'curl\n'
    if [ "$(is_installed 'curl')" = true ]; then
        curl --version | head -n1
    else
        _echo_danger 'curl is not installed on your system\n'
    fi

    _echo_info 'docker\n'
    if [ "$(is_installed 'docker')" = true ]; then
        docker --version
    else
        _echo_danger 'docker is not installed on your system\n'
    fi

    _echo_info 'docker-compose\n'
    if [ "$(is_installed 'compose')" = true ]; then
        docker-compose --version
    else
        _echo_danger 'docker-compose is not installed on your system\n'
    fi

    _echo_info 'gem\n'
    if [ "$(is_installed 'gem')" = true ]; then
        gem --version
    else
        _echo_danger 'gem is not installed on your system\n'
    fi

    _echo_info 'git\n'
    if [ "$(is_installed 'git')" = true ]; then
        git --version
    else
        _echo_danger 'git is not installed on your system\n'
    fi

    _echo_info 'iptables\n'
    if [ "$(is_installed 'iptables')" = true ]; then
        iptables --version
    else
        _echo_danger 'iptables is not installed on your system\n'
    fi

    _echo_info 'make\n'
    if [ "$(is_installed 'make')" = true ]; then
        make --version | head -n1
    else
        _echo_danger 'make is not installed on your system\n'
    fi

    _echo_info 'mysql\n'
    if [ "$(is_installed 'mysql')" = true ]; then
        mysql --version
    else
        _echo_danger 'mysql is not installed on your system\n'
    fi

    _echo_info 'nfs-common\n'
    if [ "$(is_installed 'nfs-common')" = true ]; then
        dpkg -la | grep 'nfs-common'
    else
        _echo_danger 'nfs-common is not installed on your system\n'
    fi

    _echo_info 'nfs-kernel-server\n'
    if [ "$(is_installed 'nfs-kernel-server')" = true ]; then
        dpkg -la | grep 'nfs-kernel-server'
    else
        _echo_danger 'nfs-kernel-server is not installed on your system\n'
    fi

    _echo_info 'netstat\n'
    if [ "$(is_installed 'netstat')" = true ]; then
        netstat --version | head -n1
    else
        _echo_danger 'netstat is not installed on your system\n'
    fi

    _echo_info 'nginx\n'
    if [ "$(is_installed 'nginx')" = true ]; then
        nginx --version
    else
        _echo_danger 'nginx is not installed on your system\n'
    fi

    _echo_info 'node\n'
    if [ "$(is_installed 'node')" = true ]; then
        node --version
    else
        _echo_danger 'node is not installed on your system\n'
    fi

    _echo_info 'npm\n'
    if [ "$(is_installed 'npm')" = true ]; then
        npm --version
    else
        _echo_danger 'npm is not installed on your system\n'
    fi

    _echo_info 'perl\n'
    if [ "$(is_installed 'perl')" = true ]; then
        perl --version | head -n2 | tail -n1
    else
        _echo_danger 'perl is not installed on your system\n'
    fi

    _echo_info 'openssl\n'
    if [ "$(is_installed 'openssl')" = true ]; then
        openssl version
    else
        _echo_danger 'openssl is not installed on your system\n'
    fi

    _echo_info 'php\n'
    if [ "$(is_installed 'php')" = true ]; then
        php --version
    else
        _echo_danger 'php is not installed on your system\n'
    fi

    _echo_info 'php-modules\n'
    if [ "$(is_installed 'php')" = true ]; then
        php -m
    else
        _echo_danger 'unable to show php-modules, php not installed\n'
    fi

    _echo_info 'pip\n'
    if [ "$(is_installed 'pip')" = true ]; then
        pip --version
    else
        _echo_danger 'pip is not installed on your system\n'
    fi

    _echo_info 'pip3\n'
    if [ "$(is_installed 'pip3')" = true ]; then
        pip3 --version
    else
        _echo_danger 'pip3 is not installed on your system\n'
    fi

    _echo_info 'psql\n'
    if [ "$(is_installed 'psql')" = true ]; then
        psql --version
    else
        _echo_danger 'PostgreSQL is not installed on your system\n'
    fi

    _echo_info 'python\n'
    if [ "$(is_installed 'python')" = true ]; then
        python --version
    else
        _echo_danger 'python is not installed on your system\n'
    fi

    _echo_info 'python3\n'
    if [ "$(is_installed 'python3')" = true ]; then
        python3 --version
    else
        _echo_danger 'python3 is not installed on your system\n'
    fi

    _echo_info 'ruby\n'
    if [ "$(is_installed 'ruby')" = true ]; then
        ruby --version
    else
        _echo_danger 'ruby is not installed on your system\n'
    fi

    _echo_info 'rvm\n'
    if [ "$(is_installed 'rvm')" = true ]; then
        rvm version
    else
        _echo_danger 'rvm is not installed on your system\n'
    fi

    _echo_info 'shellcheck\n'
    if [ "$(is_installed 'shellcheck')" = true ]; then
        shellcheck --version | head -2 | tail -1
    else
        _echo_danger 'shellcheck is not installed on your system\n'
    fi

    _echo_info 'sqlite3\n'
    if [ "$(is_installed 'sqlite3')" = true ]; then
        sqlite3 --version
    else
        _echo_danger 'sqlite3 is not installed on your system\n'
    fi

    _echo_info 'ufw\n'
    if [ "$(is_installed 'ufw')" = true ]; then
        ufw --version | head -n1
    else
        _echo_danger 'ufw is not installed on your system\n'
    fi

    _echo_info 'vagrant\n'
    if [ "$(is_installed 'vagrant')" = true ]; then
        vagrant --version
    else
        _echo_danger 'vagrant is not installed on your system\n'
    fi

    _echo_info 'virtual box\n'
    if [ "$(is_installed 'VBoxManage')" = true ]; then
        VBoxManage --version
    else
        _echo_danger 'virtual box is not installed on your system\n'
    fi

    _echo_info 'wget\n'
    if [ "$(is_installed 'wget')" = true ]; then
        wget --version | head -n1
    else
        _echo_danger 'wget is not installed on your system\n'
    fi

    _echo_info 'wine\n'
    if [ "$(is_installed 'wine')" = true ]; then
        wine --version
    else
        _echo_danger 'wine is not installed on your system\n'
    fi

    _echo_info 'yarn\n'
    if [ "$(is_installed 'yarn')" = true ]; then
        yarn --version
    else
        _echo_danger 'yarn is not installed on your system\n'
    fi

    _echo_info 'zsh\n'
    if [ "$(is_installed 'zsh')" = true ]; then
        zsh --version
    else
        _echo_danger 'zsh is not installed on your system\n'
    fi
}
