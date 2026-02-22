#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## chef-solo
## architecture as a code (obsolete version)
##
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -e /opt/chef/bin/chef-solo ] ; then
    #_echo_info 'curl -L https://www.opscode.com/chef/install.sh | bash\n'
    #curl -L https://www.opscode.com/chef/install.sh | bash

    _echo_info 'wget https://www.opscode.com/chef/install.sh\n'
    wget https://www.opscode.com/chef/install.sh

    _echo_info 'sudo bash install.sh\n'
    sudo bash install.sh

    _echo_info 'rm install.sh\n'
    rm install.sh
else
    _echo_warning 'chef-solo already installed'
fi

if [ ! -e /opt/chef/embedded/bin/berks ] ; then
    _echo_info 'sudo /opt/chef/embedded/bin/gem install berkshelf --no-ri --no-rdoc\n'
    sudo /opt/chef/embedded/bin/gem install berkshelf --no-ri --no-rdoc

    _echo_info 'sudo ln -s /opt/chef/embedded/bin/berks /usr/local/bin/berks\n'
    sudo ln -s /opt/chef/embedded/bin/berks /usr/local/bin/berks
else
    _echo_warning 'berks already installed'
fi
