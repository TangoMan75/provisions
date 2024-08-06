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

    echo_label 17 'ansible'
    is_installed 'ansible'

    echo_label 17 'apache2'
    is_installed 'apache2'

    echo_label 17 'aws'
    is_installed 'aws'

    echo_label 17 'bundle'
    is_installed 'bundle'

    echo_label 17 'chef'
    is_installed 'chef'

    echo_label 17 'curl'
    is_installed 'curl'

    echo_label 17 'docker'
    is_installed 'docker'

    echo_label 17 'docker-compose'
    is_installed 'docker-compose'

    echo_label 17 'gawk'
    is_installed 'gawk'

    echo_label 17 'gem'
    is_installed 'gem'

    echo_label 17 'git'
    is_installed 'git'

    echo_label 17 'iptables'
    is_installed 'iptables'

    echo_label 17 'make'
    is_installed 'make'

    echo_label 17 'mokutil'
    is_installed 'mokutil'

    echo_label 17 'mysql'
    is_installed 'mysql'

    echo_label 17 'nfs-common'
    is_installed 'nfs-common'

    echo_label 17 'nfs-kernel-server'
    is_installed 'nfs-kernel-server'

    echo_label 17 'netstat'
    is_installed 'netstat'

    echo_label 17 'nginx'
    is_installed 'nginx'

    echo_label 17 'nmap'
    is_installed 'nmap'

    echo_label 17 'nodejs'
    is_installed 'nodejs'

    echo_label 17 'npm'
    is_installed 'npm'

    echo_label 17 'openssl'
    is_installed 'openssl'

    echo_label 17 'perl'
    is_installed 'perl'

    echo_label 17 'psql'
    is_installed 'psql'

    echo_label 17 'php'
    is_installed 'php'

    echo_label 17 'pip'
    is_installed 'pip'

    echo_label 17 'pip3'
    is_installed 'pip3'

    echo_label 17 'python'
    is_installed 'python'

    echo_label 17 'python3'
    is_installed 'python3'

    echo_label 17 'ruby'
    is_installed 'ruby'

    echo_label 17 'rvm'
    is_installed 'rvm'

    echo_label 17 'shellcheck'
    is_installed 'shellcheck'

    echo_label 17 'sqlite3'
    is_installed 'sqlite3'

    echo_label 17 'ufw'
    is_installed 'ufw'

    echo_label 17 'vagrant'
    is_installed 'vagrant'

    echo_label 17 'vboxmanage'
    is_installed 'vboxmanage'

    echo_label 17 'wine'
    is_installed 'wine'

    echo_label 17 'wget'
    is_installed 'wget'

    echo_label 17 'yarn'
    is_installed 'yarn'

    echo_label 17 'zsh'
    is_installed 'zsh'
}
