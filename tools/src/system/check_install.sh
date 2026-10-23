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

## Check availability of some development tools
check_install() {
    _alert_primary 'Check Install'

    _echo_success 'ansible' 1 18
    is_installed 'ansible'

    _echo_success 'apache2' 1 18
    is_installed 'apache2'

    _echo_success 'aws' 1 18
    is_installed 'aws'

    _echo_success 'bundle' 1 18
    is_installed 'bundle'

    _echo_success 'chef' 1 18
    is_installed 'chef'

    _echo_success 'curl' 1 18
    is_installed 'curl'

    _echo_success 'docker' 1 18
    is_installed 'docker'

    _echo_success 'docker-compose' 1 18
    is_installed 'docker-compose'

    _echo_success 'gawk' 1 18
    is_installed 'gawk'

    _echo_success 'gem' 1 18
    is_installed 'gem'

    _echo_success 'git' 1 18
    is_installed 'git'

    _echo_success 'iptables' 1 18
    is_installed 'iptables'

    _echo_success 'make' 1 18
    is_installed 'make'

    _echo_success 'mokutil' 1 18
    is_installed 'mokutil'

    _echo_success 'mysql' 1 18
    is_installed 'mysql'

    _echo_success 'nfs-common' 1 18
    is_installed 'nfs-common'

    _echo_success 'nfs-kernel-server' 1 18
    is_installed 'nfs-kernel-server'

    _echo_success 'netstat' 1 18
    is_installed 'netstat'

    _echo_success 'nginx' 1 18
    is_installed 'nginx'

    _echo_success 'nmap' 1 18
    is_installed 'nmap'

    _echo_success 'nodejs' 1 18
    is_installed 'nodejs'

    _echo_success 'npm' 1 18
    is_installed 'npm'

    _echo_success 'openssl' 1 18
    is_installed 'openssl'

    _echo_success 'perl' 1 18
    is_installed 'perl'

    _echo_success 'psql' 1 18
    is_installed 'psql'

    _echo_success 'php' 1 18
    is_installed 'php'

    _echo_success 'pip' 1 18
    is_installed 'pip'

    _echo_success 'pip3' 1 18
    is_installed 'pip3'

    _echo_success 'python' 1 18
    is_installed 'python'

    _echo_success 'python3' 1 18
    is_installed 'python3'

    _echo_success 'ruby' 1 18
    is_installed 'ruby'

    _echo_success 'rvm' 1 18
    is_installed 'rvm'

    _echo_success 'shellcheck' 1 18
    is_installed 'shellcheck'

    _echo_success 'sqlite3' 1 18
    is_installed 'sqlite3'

    _echo_success 'ufw' 1 18
    is_installed 'ufw'

    _echo_success 'vagrant' 1 18
    is_installed 'vagrant'

    _echo_success 'vboxmanage' 1 18
    is_installed 'vboxmanage'

    _echo_success 'wine' 1 18
    is_installed 'wine'

    _echo_success 'wget' 1 18
    is_installed 'wget'

    _echo_success 'yarn' 1 18
    is_installed 'yarn'

    _echo_success 'zsh' 1 18
    is_installed 'zsh'
}
