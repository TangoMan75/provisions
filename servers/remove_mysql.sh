#!/bin/bash

#/**
# * remove mysql-server
# *
# * @category servers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes mysql-server'
sudo apt-get purge --assume-yes mysql-server

echo_info 'sudo apt-get purge --assume-yes libmysqlclient20'
sudo apt-get purge --assume-yes libmysqlclient20

echo_info 'sudo apt-get purge --assume-yes libmysqlcppconn7v5'
sudo apt-get purge --assume-yes libmysqlcppconn7v5

echo_info 'sudo apt-get purge --assume-yes mysql-client-5.7'
sudo apt-get purge --assume-yes mysql-client-5.7

echo_info 'sudo apt-get purge --assume-yes mysql-client-core-5.7'
sudo apt-get purge --assume-yes mysql-client-core-5.7

echo_info 'sudo apt-get purge --assume-yes mysql-common'
sudo apt-get purge --assume-yes mysql-common

echo_info 'sudo apt-get purge --assume-yes mysql-server-5.7'
sudo apt-get purge --assume-yes mysql-server-5.7

echo_info 'sudo apt-get purge --assume-yes mysql-server-core-5.7'
sudo apt-get purge --assume-yes mysql-server-core-5.7

echo_info 'sudo apt-get purge --assume-yes mysql-utilities'
sudo apt-get purge --assume-yes mysql-utilities

for VERSION in '' 5.6 7.0 7.1 7.2 7.3; do
    echo_info "sudo apt-get purge --assume-yes php${VERSION}-mysql"
    sudo apt-get purge --assume-yes php${VERSION}-mysql
done

echo_info 'sudo rm -rf /etc/mysql'
sudo rm -rf /etc/mysql

echo_info 'sudo rm -rf /var/lib/mysql'
sudo rm -rf /var/lib/mysql

echo_info 'sudo rm -rf /var/lib/mysql-files'
sudo rm -rf /var/lib/mysql-files

echo_info 'sudo rm -rf /var/lib/mysql-keyring'
sudo rm -rf /var/lib/mysql-keyring

echo_info 'sudo rm -rf /var/lib/mysql-upgrade'
sudo rm -rf /var/lib/mysql-upgrade

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

