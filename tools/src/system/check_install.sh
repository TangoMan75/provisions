#!/bin/bash

#/*
# * This file is part of TangoMan Bash Tools package.
# *
# * Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * TangoMan Check Install
# *
# * This script is meant to quickly check for common apps installation
# *
# * @licence MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}"/../colors/colors.sh
# shellcheck source=/dev/null
. "${CURDIR}"/is_installed.sh

## Check availability of some development tools
check_install() {
    alert_primary 'Check Install'

    echo_success 'ansible' 1 18
    is_installed 'ansible'

    echo_success 'apache2' 1 18
    is_installed 'apache2'

    echo_success 'aws' 1 18
    is_installed 'aws'

    echo_success 'bundle' 1 18
    is_installed 'bundle'

    echo_success 'chef' 1 18
    is_installed 'chef'

    echo_success 'curl' 1 18
    is_installed 'curl'

    echo_success 'docker' 1 18
    is_installed 'docker'

    echo_success 'docker-compose' 1 18
    is_installed 'docker-compose'

    echo_success 'gawk' 1 18
    is_installed 'gawk'

    echo_success 'gem' 1 18
    is_installed 'gem'

    echo_success 'git' 1 18
    is_installed 'git'

    echo_success 'iptables' 1 18
    is_installed 'iptables'

    echo_success 'make' 1 18
    is_installed 'make'

    echo_success 'mokutil' 1 18
    is_installed 'mokutil'

    echo_success 'mysql' 1 18
    is_installed 'mysql'

    echo_success 'nfs-common' 1 18
    is_installed 'nfs-common'

    echo_success 'nfs-kernel-server' 1 18
    is_installed 'nfs-kernel-server'

    echo_success 'netstat' 1 18
    is_installed 'netstat'

    echo_success 'nginx' 1 18
    is_installed 'nginx'

    echo_success 'nmap' 1 18
    is_installed 'nmap'

    echo_success 'nodejs' 1 18
    is_installed 'nodejs'

    echo_success 'npm' 1 18
    is_installed 'npm'

    echo_success 'openssl' 1 18
    is_installed 'openssl'

    echo_success 'perl' 1 18
    is_installed 'perl'

    echo_success 'psql' 1 18
    is_installed 'psql'

    echo_success 'php' 1 18
    is_installed 'php'

    echo_success 'pip' 1 18
    is_installed 'pip'

    echo_success 'pip3' 1 18
    is_installed 'pip3'

    echo_success 'python' 1 18
    is_installed 'python'

    echo_success 'python3' 1 18
    is_installed 'python3'

    echo_success 'ruby' 1 18
    is_installed 'ruby'

    echo_success 'rvm' 1 18
    is_installed 'rvm'

    echo_success 'shellcheck' 1 18
    is_installed 'shellcheck'

    echo_success 'sqlite3' 1 18
    is_installed 'sqlite3'

    echo_success 'ufw' 1 18
    is_installed 'ufw'

    echo_success 'vagrant' 1 18
    is_installed 'vagrant'

    echo_success 'vboxmanage' 1 18
    is_installed 'vboxmanage'

    echo_success 'wine' 1 18
    is_installed 'wine'

    echo_success 'wget' 1 18
    is_installed 'wget'

    echo_success 'yarn' 1 18
    is_installed 'yarn'

    echo_success 'zsh' 1 18
    is_installed 'zsh'
}
