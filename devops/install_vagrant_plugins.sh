#!/bin/bash

#/**
# * Install Vagrant plugins
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_title 'Install Vagrant Plugins'

# install vagrant-disksize
echo_info 'vagrant plugin install vagrant-disksize'
vagrant plugin install vagrant-disksize

# install virtualbox guest additions
# https://www.vagrantup.com/docs/virtualbox/boxes.html
echo_info 'vagrant plugin install vagrant-vbguest'
vagrant plugin install vagrant-vbguest

# install docker-compose plugin
echo_info 'vagrant plugin install vagrant-docker-compose'
vagrant plugin install vagrant-docker-compose

#echo_info 'vagrant plugin install vagrant-berkshelf'
#vagrant plugin install vagrant-berkshelf

# # does not work for some reason
# echo_info 'vagrant plugin install vagrant-hostmanager'
# vagrant plugin install vagrant-hostmanager
