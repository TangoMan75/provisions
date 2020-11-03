#!/bin/bash

#/**
# * remove php
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes php-common'
sudo apt-get purge --assume-yes php-common

echo_info 'sudo rm -rf /etc/php'
sudo rm -rf /etc/php

echo_info 'sudo rm -rf /var/lib/php'
sudo rm -rf /var/lib/php

echo_info 'sudo rm -rf /usr/lib/php'
sudo rm -rf /usr/lib/php

echo_info 'sudo apt-get purge --assume-yes php-xdebug'
sudo apt-get purge --assume-yes php-xdebug

echo_info 'sudo apt-get purge --assume-yes blackfire-php'
sudo apt-get purge --assume-yes blackfire-php

echo_info 'sudo apt-get purge --assume-yes blackfire-agent'
sudo apt-get purge --assume-yes blackfire-agent

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

