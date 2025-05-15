#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove mysql-server
##
## @category servers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

alert_danger "Remove mysql"

# --------------------------------------------------

echo_info 'sudo apt-get purge --assume-yes mysql-server\n'
sudo apt-get purge --assume-yes mysql-server

echo_info 'sudo apt-get purge --assume-yes libmysqlclient20\n'
sudo apt-get purge --assume-yes libmysqlclient20

echo_info 'sudo apt-get purge --assume-yes libmysqlcppconn7v5\n'
sudo apt-get purge --assume-yes libmysqlcppconn7v5

echo_info 'sudo apt-get purge --assume-yes mysql-client-5.7\n'
sudo apt-get purge --assume-yes mysql-client-5.7

echo_info 'sudo apt-get purge --assume-yes mysql-client-core-5.7\n'
sudo apt-get purge --assume-yes mysql-client-core-5.7

echo_info 'sudo apt-get purge --assume-yes mysql-common\n'
sudo apt-get purge --assume-yes mysql-common

echo_info 'sudo apt-get purge --assume-yes mysql-server-5.7\n'
sudo apt-get purge --assume-yes mysql-server-5.7

echo_info 'sudo apt-get purge --assume-yes mysql-server-core-5.7\n'
sudo apt-get purge --assume-yes mysql-server-core-5.7

echo_info 'sudo apt-get purge --assume-yes mysql-utilities\n'
sudo apt-get purge --assume-yes mysql-utilities

for VERSION in '' 5.6 7.0 7.1 7.2 7.3; do
    echo_info "sudo apt-get purge --assume-yes php${VERSION}-mysql\n"
    sudo apt-get purge --assume-yes php${VERSION}-mysql
done

echo_info 'sudo rm -rf /etc/mysql\n'
sudo rm -rf /etc/mysql

echo_info 'sudo rm -rf /var/lib/mysql\n'
sudo rm -rf /var/lib/mysql

echo_info 'sudo rm -rf /var/lib/mysql-files\n'
sudo rm -rf /var/lib/mysql-files

echo_info 'sudo rm -rf /var/lib/mysql-keyring\n'
sudo rm -rf /var/lib/mysql-keyring

echo_info 'sudo rm -rf /var/lib/mysql-upgrade\n'
sudo rm -rf /var/lib/mysql-upgrade

echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

