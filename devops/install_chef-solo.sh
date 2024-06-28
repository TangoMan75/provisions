#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * chef-solo
# * architecture as a code (obsolete version)
# *
# * @category devops
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

if [ ! -e /opt/chef/bin/chef-solo ] ; then
    #echo_info 'curl -L https://www.opscode.com/chef/install.sh | bash'
    #curl -L https://www.opscode.com/chef/install.sh | bash

    echo_info 'wget https://www.opscode.com/chef/install.sh'
    wget https://www.opscode.com/chef/install.sh

    echo_info 'sudo bash install.sh'
    sudo bash install.sh

    echo_info 'rm install.sh'
    rm install.sh
else
    echo_warning 'chef-solo already installed'
fi

if [ ! -e /opt/chef/embedded/bin/berks ] ; then
    echo_info 'sudo /opt/chef/embedded/bin/gem install berkshelf --no-ri --no-rdoc'
    sudo /opt/chef/embedded/bin/gem install berkshelf --no-ri --no-rdoc

    echo_info 'sudo ln -s /opt/chef/embedded/bin/berks /usr/local/bin/berks'
    sudo ln -s /opt/chef/embedded/bin/berks /usr/local/bin/berks
else
    echo_warning 'berks already installed'
fi
