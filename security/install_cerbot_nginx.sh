#!/bin/bash

#/**
# * certbot let's encrypt
# *
# * @category security
# * @link     https://certbot.eff.org
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes software-properties-common'
sudo apt-get install --assume-yes software-properties-common

echo_info 'sudo add-apt-repository -y universe'
sudo add-apt-repository -y universe

echo_info 'sudo add-apt-repository -y ppa:certbot/certbot'
sudo add-apt-repository -y ppa:certbot/certbot

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes certbot python-certbot-nginx '
sudo apt-get install --assume-yes certbot python-certbot-nginx

echo_info 'sudo certbot --nginx'
sudo certbot --nginx

# echo_info 'sudo certbot --nginx certonly'
# sudo certbot --nginx certonly

echo_info 'sudo certbot renew --dry-run'
sudo certbot renew --dry-run
