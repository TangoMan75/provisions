#!/bin/bash

#/**
# * php-xdebug
# * php debug module
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

VERSION='7.3'

OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_label 'description'; echo_primary 'Config php-modules'
            echo_label 'usage'; echo_primary "${0} -v [version] -r (restore default) -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

# check valid version
for VALID_VERSION in 5.6 7.0 7.1 7.2 7.3; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL='true'
    fi
done

if [ "${INSTALL}" != 'true' ]; then
    echo_error "Cannot install xdebug for \"php$VERSION\", invalid version"
    exit 1
fi

echo_info 'sudo apt-get install --assume-yes php-xdebug'
sudo apt-get install --assume-yes php-xdebug

# config xdebug
echo_info "sudo bash -c \"cat > /etc/php/${VERSION}/mods-available/xdebug.ini <<EOF ... EOF\""

sudo bash -c "cat > /etc/php/${VERSION}/mods-available/xdebug.ini <<EOF
zend_extension=xdebug.so
xdebug.remote_autostart = 1
xdebug.remote_enable = 1
xdebug.remote_handler = dbgp
xdebug.remote_host = 127.0.0.1
xdebug.remote_log = /tmp/xdebug_remote.log
xdebug.remote_mode = req
xdebug.remote_port = 9005 #if you want to change the port you can change
EOF"

# restart php service
echo_info "sudo systemctl restart php${VERSION}-fpm"
sudo systemctl restart php${VERSION}-fpm
