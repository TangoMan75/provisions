#!/bin/bash

#/**
# * chef-solo
# * architecture as a code (obsolete version)
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
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
