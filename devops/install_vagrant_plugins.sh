#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Install Vagrant plugins
##
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Install Vagrant Plugins'

# install vagrant-disksize
echo_info 'vagrant plugin install vagrant-disksize\n'
vagrant plugin install vagrant-disksize

# install virtualbox guest additions
# https://www.vagrantup.com/docs/virtualbox/boxes.html
echo_info 'vagrant plugin install vagrant-vbguest\n'
vagrant plugin install vagrant-vbguest

# install docker-compose plugin
echo_info 'vagrant plugin install vagrant-docker-compose\n'
vagrant plugin install vagrant-docker-compose

#echo_info 'vagrant plugin install vagrant-berkshelf\n'
#vagrant plugin install vagrant-berkshelf

# # does not work for some reason
# echo_info 'vagrant plugin install vagrant-hostmanager\n'
# vagrant plugin install vagrant-hostmanager
