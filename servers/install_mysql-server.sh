#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## mysql-server
## database server
##
## @category servers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info "sudo add-apt-repository --yes \"deb http://repo.mysql.com/apt/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/ $(lsb_release -cs) mysql-5.7\"\n"
sudo add-apt-repository --yes "deb http://repo.mysql.com/apt/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/ $(lsb_release -cs) mysql-5.7"

# _echo_info "sudo add-apt-repository --yes \"deb http://repo.mysql.com/apt/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/ $(lsb_release -cs) mysql-8.0\"\n"
# sudo add-apt-repository --yes "deb http://repo.mysql.com/apt/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/ $(lsb_release -cs) mysql-8.0"

_echo_info "sudo add-apt-repository --yes \"deb http://repo.mysql.com/apt/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/ $(lsb_release -cs) mysql-tools\"\n"
sudo add-apt-repository --yes "deb http://repo.mysql.com/apt/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/ $(lsb_release -cs) mysql-tools"

_echo_info "sudo apt-get update\n"
sudo apt-get update

# create config file when not found
test -f /etc/mysql/mysql.cnf || sudo touch /etc/mysql/mysql.cnf

_echo_info 'sudo apt-get install --assume-yes --allow-unauthenticated mysql-server\n'
sudo apt-get install --assume-yes --allow-unauthenticated mysql-server

# set mysql default password (root)
_echo_info "sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'\n"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'

_echo_info "sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'\n"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# check mysql installed version
_echo_info 'mysql --version\n'
mysql --version

# check status
sudo systemctl status mysql

# config mysql
sudo chown -R "${USER}:${USER}" /etc/mysql/mysql.conf.d/mysqld.cnf
echo 'port = 3306'>>/etc/mysql/mysql.conf.d/mysqld.cnf
echo 'sql_mode = "STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"'>>/etc/mysql/mysql.conf.d/mysqld.cnf

# for dev only
#sudo mysql -u root --execute="CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin'; GRANT ALL PRIVILEGES ON *.* to 'admin'@'localhost'; FLUSH PRIVILEGES;"
#sudo mysql -u root --execute="CREATE DATABASE prestashop;"
#sudo mysql -u root --execute="USE prestashop;"

# firewall allows remote access
_echo_info 'sudo ufw allow mysql\n'
sudo ufw allow mysql

# start the mysql service
_echo_info 'sudo systemctl start mysql\n'
sudo systemctl start mysql

# launch at reboot
_echo_info 'sudo systemctl enable mysql\n'
sudo systemctl enable mysql
