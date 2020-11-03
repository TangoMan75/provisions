#!/bin/bash

#/**
# * php
# * php language
# *
# * @category dev
# * @link     http://www.ansoncheunghk.info/article/8-essential-checks-securing-php
# * @link     https://www.php.net/supported-versions.php
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# default settings
PRODUCTION='false'
UPDATE='true'
VERSION=7.4

OPTIND=0
while getopts :ndpv:h OPTION; do
    case "${OPTION}" in
        d) PRODUCTION='false';;
        p) PRODUCTION='true';;
        n) UPDATE='false';;
        v) VERSION="${OPTARG}";;
        h) echo_label 'description'; echo_primary 'Install php'
            echo_label 'usage'; echo_primary "${0} -v [version] -d (development) -p (production) -n (no update) -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

# check valid version
for VALID_VERSION in 7.2 7.3 7.4; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL='true'
    fi
done

if [ "${INSTALL}" != 'true' ]; then
    echo_error "Cannot install \"php${VERSION}\", invalid version"
    exit 1
fi

if [ "${UPDATE}" != 'false' ]; then
    echo_info 'sudo add-apt-repository -y ppa:ondrej/php'
    sudo add-apt-repository -y ppa:ondrej/php

    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

# note: following modules are installed by default (even with --no-install-recommends)
# "phpx.x-pdo" is included in "phpx.x-common"
# libapache2-mod-phpx.x
# php-common
# phpx.x
# phpx.x-cli
# phpx.x-common
# phpx.x-json
# phpx.x-opcache
# phpx.x-readline
echo_info "sudo apt-get install --assume-yes --no-install-recommends php${VERSION}"
sudo apt-get install --assume-yes --no-install-recommends php${VERSION}

echo_info "sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-fpm"
sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-fpm

# required by symfony applications
echo_info "sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-gd"
sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-gd

echo_info "sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-curl"
sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-curl

echo_info "sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-xml"
sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-xml

echo_info "sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-intl"
sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-intl

echo_info "sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-mysql"
sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-mysql

echo_info "sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-pgsql"
sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-pgsql

echo_info "sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-sqlite3"
sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-sqlite3

echo_info "sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-mbstring"
sudo apt-get install --assume-yes --no-install-recommends php${VERSION}-mbstring

# NOTE: sed -r allows to use the `\w` tag in newer linux versions

# development settings
if [ -f /etc/php/${VERSION}/cli/php.ini ] && [ "${PRODUCTION}" = 'false' ]; then
    # unlimited execution time (default: 30)
    echo_info 'sudo sed -i -r s/"^;?max_execution_time\s?=\s?\-?\d+$"/"max_execution_time = -1"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?max_execution_time\s?=\s?\-?\d+$"/"max_execution_time = -1"/g /etc/php/${VERSION}/cli/php.ini
    # allow maximum memory usage (default: 128)
    echo_info 'sudo sed -i -r s/"^;?memory_limit\s?=\s?\-?[\d\w]+$"/"memory_limit = -1"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?memory_limit\s?=\s?\-?[\d\w]+$"/"memory_limit = -1"/g /etc/php/${VERSION}/cli/php.ini
    # unlimited upload file size (default: 2M)
    echo_info 'sudo sed -i -r s/"^;?upload_max_filesize\s?=\s?\-?[\d\w]+$"/"upload_max_filesize = -1"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?upload_max_filesize\s?=\s?\-?[\d\w]+$"/"upload_max_filesize = -1"/g /etc/php/${VERSION}/cli/php.ini
    # enable logging (default: On)
    echo_info 'sudo sed -i -r s/"^;?log_errors\s?=\s?\w+$"/"log_errors = On"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?log_errors\s?=\s?\w+$"/"log_errors = On"/g /etc/php/${VERSION}/cli/php.ini
    # show the presence of php (default: On)
    echo_info 'sudo sed -i -r s/"^;?expose_php\s?=\s?\w+$"/"expose_php = On"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?expose_php\s?=\s?\w+$"/"expose_php = On"/g /etc/php/${VERSION}/cli/php.ini

    # allows to configure alternative php versions
    # echo_info 'sudo update-alternatives --config php'
    # sudo update-alternatives --config php
fi

# production settings
if [ -f /etc/php/${VERSION}/cli/php.ini ] && [ "${PRODUCTION}" = 'true' ]; then
    # disable remote urls for file handling functions
    echo_info 'sudo sed -i -r s/"^;?allow_url_fopen\s?=\s?\w+$"/"allow_url_fopen = Off"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?allow_url_fopen\s?=\s?\w+$"/"allow_url_fopen = Off"/g /etc/php/${VERSION}/cli/php.ini
    # disable register global
    echo_info 'sudo sed -i -r s/"^;?register_globals\s?=\s?\w+$"/"register_globals = Off"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?register_globals\s?=\s?\w+$"/"register_globals = Off"/g /etc/php/${VERSION}/cli/php.ini
    # restricting what php can read & write
    # sudo sed -i -r s/"^;?open_basedir\s?=.+$"/"open_basedir = /var/www/htdocs/files"/g /etc/php/${VERSION}/cli/php.ini

    # max script execution time (default: 30)
    echo_info 'sudo sed -i -r s/"^;?max_execution_time\s?=\s?\-?/d+$"/"max_execution_time = 30"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?max_execution_time\s?=\s?\-?/d+$"/"max_execution_time = 30"/g /etc/php/${VERSION}/cli/php.ini
    # max time spent parsing input (default: 60)
    echo_info 'sudo sed -i -r s/"^;?max_input_time\s?=\s?\-?/d+$"/"max_input_time = 60"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?max_input_time\s?=\s?\-?/d+$"/"max_input_time = 60"/g /etc/php/${VERSION}/cli/php.ini
    # max memory used by one script (default: 128)
    echo_info 'sudo sed -i -r s/"^;?memory_limit\s?=\s?\-?[\d\w]+$"/"memory_limit = 16M"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?memory_limit\s?=\s?\-?[\d\w]+$"/"memory_limit = 16M"/g /etc/php/${VERSION}/cli/php.ini
    # max upload file size (default: 2M)
    echo_info 'sudo sed -i -r s/"^;?upload_max_filesize\s?=\s?\-?[\d\w]+$"/"upload_max_filesize = 2M"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?upload_max_filesize\s?=\s?\-?[\d\w]+$"/"upload_max_filesize = 2M"/g /etc/php/${VERSION}/cli/php.ini
    # max post size (default: 8M))
    echo_info 'sudo sed -i -r s/"^;?post_max_size\s?=\s?\-?[\d\w]+$"/"post_max_size = 8M"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?post_max_size\s?=\s?\-?[\d\w]+$"/"post_max_size = 8M"/g /etc/php/${VERSION}/cli/php.ini

    # disable error message (default: Off)
    echo_info 'sudo sed -i -r s/"^;?display_errors\s?=\s?\w+$"/"display_errors = Off"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?display_errors\s?=\s?\w+$"/"display_errors = Off"/g /etc/php/${VERSION}/cli/php.ini
    # enable logging (default: On)
    echo_info 'sudo sed -i -r s/"^;?log_errors\s?=\s?\w+$"/"log_errors = Off"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?log_errors\s?=\s?\w+$"/"log_errors = Off"/g /etc/php/${VERSION}/cli/php.ini
    # hiding the presence of php (default: On)
    echo_info 'sudo sed -i -r s/"^;?expose_php\s?=\s?\w+$"/"expose_php = Off"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?expose_php\s?=\s?\w+$"/"expose_php = Off"/g /etc/php/${VERSION}/cli/php.ini

    # advanced safe mode setting
    # sudo sed -i -r s/"^;?safe_mode\s?=\s?\w+$"/"safe_mode = Off"/g /etc/php/${VERSION}/cli/php.ini
    # sudo sed -i -r s/"^;?safe_mode_gid\s?=\s?\w+$"/"safe_mode_gid = On"/g /etc/php/${VERSION}/cli/php.ini
    # sudo sed -i -r s/"^;?safe_mode_exec_dir\s?=\s?\w+$"/"safe_mode_exec_dir = /var/www/binaries"/g /etc/php/${VERSION}/cli/php.ini
    # sudo sed -i -r s/"^;?safe_mode_allowed_env_vars\s?=.+$"/"safe_mode_allowed_env_vars = PHP_"/g /etc/php/${VERSION}/cli/php.ini

    # enable opcache (default: 1)
    echo_info 'sudo sed -i -r s/"^;?opcache.enable\s?=\s?\d+$"/"opcache.enable=1"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?opcache.enable\s?=\s?\d+$"/"opcache.enable=1"/g /etc/php/${VERSION}/cli/php.ini
    # maximum memory that OPcache can use to store compiled PHP files (default: 128)
    echo_info 'sudo sed -i -r s/"^;?opcache.memory_consumption\s?=\s?[\d\w]+$"/"opcache.memory_consumption=256"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?opcache.memory_consumption\s?=\s?[\d\w]+$"/"opcache.memory_consumption=256"/g /etc/php/${VERSION}/cli/php.ini
    # maximum number of files that can be stored in the cache (default: 10000)
    echo_info 'sudo sed -i -r s/"^;?opcache.max_accelerated_files\s?=\s?\d+$"/"opcache.max_accelerated_files=20000"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?opcache.max_accelerated_files\s?=\s?\d+$"/"opcache.max_accelerated_files=20000"/g /etc/php/${VERSION}/cli/php.ini
    # Don't Check PHP Files Timestamps (default: 1)
    echo_info 'sudo sed -i -r s/"^;?opcache.validate_timestamps\s?=\s?\d+$"/"opcache.validate_timestamps=0"/g /etc/php/${VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?opcache.validate_timestamps\s?=\s?\d+$"/"opcache.validate_timestamps=0"/g /etc/php/${VERSION}/cli/php.ini
    # maximum memory allocated to store the results (default: 4096k)
    echo_info 'sudo sed -i -r s/"^;?realpath_cache_size\s?=\s?[\d\w]+$"/"realpath_cache_size=4096k"/g /etc/php/${PHP_VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?realpath_cache_size\s?=\s?[\d\w]+$"/"realpath_cache_size=4096k"/g /etc/php/${PHP_VERSION}/cli/php.ini
    # save the results for 10 minutes (600 seconds) (default: 120)
    echo_info 'sudo sed -i -r s/"^;?realpath_cache_ttl\s?=\s?\d+$"/"realpath_cache_ttl=600"/g /etc/php/${PHP_VERSION}/cli/php.ini'
    sudo sed -i -r s/"^;?realpath_cache_ttl\s?=\s?\d+$"/"realpath_cache_ttl=600"/g /etc/php/${PHP_VERSION}/cli/php.ini

    # disable xdebug (findind path using `php -i | grep xdebug.ini | tr -d ','`)
    echo_info 'sudo sed -i -r s/"^;?zend_extension\s?=\s?xdebug.so$"/";zend_extension=xdebug.so"/g `php -i | grep xdebug.ini | tr -d ','`'
    sudo sed -i -r s/"^;?zend_extension\s?=\s?xdebug.so$"/";zend_extension=xdebug.so"/g `php -i | grep xdebug.ini | tr -d ','`
fi

# # enable extensions
# if [ -f /etc/php/${VERSION}/cli/php.ini ]; then
#     echo_info 'sudo sed -i -r s/"^;?extension\s?=\s?curl$"/"extension=curl"/g /etc/php/${VERSION}/cli/php.ini'
#     sudo sed -i -r s/"^;?extension\s?=\s?curl$"/"extension=curl"/g /etc/php/${VERSION}/cli/php.ini

#     echo_info 'sudo sed -i -r s/"^;?extension\s?=\s?gd2$"/"extension=gd2"/g /etc/php/${VERSION}/cli/php.ini'
#     sudo sed -i -r s/"^;?extension\s?=\s?gd2$"/"extension=gd2"/g /etc/php/${VERSION}/cli/php.ini

#     echo_info 'sudo sed -i -r s/"^;?extension\s?=\s?intl$"/"extension=intl"/g /etc/php/${VERSION}/cli/php.ini'
#     sudo sed -i -r s/"^;?extension\s?=\s?intl$"/"extension=intl"/g /etc/php/${VERSION}/cli/php.ini

#     echo_info 'sudo sed -i -r s/"^;?extension\s?=\s?pdo_mysql$"/"extension=pdo_mysql"/g /etc/php/${VERSION}/cli/php.ini'
#     sudo sed -i -r s/"^;?extension\s?=\s?pdo_mysql$"/"extension=pdo_mysql"/g /etc/php/${VERSION}/cli/php.ini

#     echo_info 'sudo sed -i -r s/"^;?extension\s?=\s?pdo_pgsql$"/"extension=pdo_pgsql"/g /etc/php/${VERSION}/cli/php.ini'
#     sudo sed -i -r s/"^;?extension\s?=\s?pdo_pgsql$"/"extension=pdo_pgsql"/g /etc/php/${VERSION}/cli/php.ini

#     echo_info 'sudo sed -i -r s/"^;?extension\s?=\s?pdo_sqlite$"/"extension=pdo_sqlite"/g /etc/php/${VERSION}/cli/php.ini'
#     sudo sed -i -r s/"^;?extension\s?=\s?pdo_sqlite$"/"extension=pdo_sqlite"/g /etc/php/${VERSION}/cli/php.ini
# fi

# restart php-fpm service
echo_info "sudo systemctl restart php${VERSION}-fpm"
sudo systemctl restart php${VERSION}-fpm

# restart apache
if [ ! -x "$(command -v apache2)" ]; then
    echo_info 'sudo service apache2 restart'
    sudo service apache2 restart
fi

# restart nginx
if [ ! -x "$(command -v nginx)" ]; then
    echo_info 'sudo service nginx restart'
    sudo service nginx restart
fi

# list installed modules
echo_info 'php -m'
php -m
