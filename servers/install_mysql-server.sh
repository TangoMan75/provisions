#!/bin/bash

#/**
# * mysql-server
# * database server
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

if [ "${#}" -gt 1 ]; then
    echo_error "too many arguments (${#})"
    echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
    exit 1
fi

OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE='false';;
        h) echo_label 'description'; echo_primary "`basename ${0}`"
            echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

if [ "${UPDATE}" != 'false' ]; then
    echo_info "sudo add-apt-repository -y \"deb http://repo.mysql.com/apt/`lsb_release -is | tr '[:upper:]' '[:lower:]'`/ `lsb_release -cs` mysql-5.7\""
    sudo add-apt-repository -y "deb http://repo.mysql.com/apt/`lsb_release -is | tr '[:upper:]' '[:lower:]'`/ `lsb_release -cs` mysql-5.7"

    # echo_info "sudo add-apt-repository -y \"deb http://repo.mysql.com/apt/`lsb_release -is | tr '[:upper:]' '[:lower:]'`/ `lsb_release -cs` mysql-8.0\""
    # sudo add-apt-repository -y "deb http://repo.mysql.com/apt/`lsb_release -is | tr '[:upper:]' '[:lower:]'`/ `lsb_release -cs` mysql-8.0"

    echo_info "sudo add-apt-repository -y \"deb http://repo.mysql.com/apt/`lsb_release -is | tr '[:upper:]' '[:lower:]'`/ `lsb_release -cs` mysql-tools\""
    sudo add-apt-repository -y "deb http://repo.mysql.com/apt/`lsb_release -is | tr '[:upper:]' '[:lower:]'`/ `lsb_release -cs` mysql-tools"

    echo_info "sudo apt-get update"
    sudo apt-get update
fi

# create config file when not found
test -f /etc/mysql/mysql.cnf || sudo touch /etc/mysql/mysql.cnf

echo_info 'sudo apt-get install --assume-yes --allow-unauthenticated mysql-server'
sudo apt-get install --assume-yes --allow-unauthenticated mysql-server

# set mysql default password (root)
echo_info "sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'

echo_info "sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# check mysql installed version
echo_info 'mysql --version'
mysql --version

# check status
sudo systemctl status mysql

# config mysql
sudo chown -R $USER:$USER /etc/mysql/mysql.conf.d/mysqld.cnf
echo 'port = 3306'>>/etc/mysql/mysql.conf.d/mysqld.cnf
echo 'sql_mode = "STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"'>>/etc/mysql/mysql.conf.d/mysqld.cnf

# for dev only
#sudo mysql -u root --execute="CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin'; GRANT ALL PRIVILEGES ON *.* to 'admin'@'localhost'; FLUSH PRIVILEGES;"
#sudo mysql -u root --execute="CREATE DATABASE prestashop;"
#sudo mysql -u root --execute="USE prestashop;"

# firewall allows remote access
echo_info 'sudo ufw allow mysql'
sudo ufw allow mysql

# start the mysql service
echo_info 'sudo systemctl start mysql'
sudo systemctl start mysql

# launch at reboot
echo_info 'sudo systemctl enable mysql'
sudo systemctl enable mysql
