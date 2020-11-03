#!/bin/bash

#/**
# * postman
# *
# * API Rest client
# *
# * @category dev
# * @link     https://www.getpostman.com
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo snap install postman'
sudo snap install postman
