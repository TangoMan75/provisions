#!/bin/bash

#/**
# * beef
# *
# * browser exploitation framework
# *
# * @category security
# * @link     https://beefproject.com
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'git'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires git, try: 'apt-get install --assume-yes git'"
    exit 1
fi

if [ `is_installed 'ruby'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires ruby, try: 'apt-get install --assume-yes ruby'"
    exit 1
fi

# clone project
echo_info 'git clone --depth 1 https://github.com/beefproject/beef ~/.beef'
git clone --depth 1 https://github.com/beefproject/beef ~/.beef

# Install requirements from within the .beef folder
(
    echo_info 'cd ~/.beef'
    cd ~/.beef

    # cleaning git cache
    echo_info 'rm -rf .git'
    rm -rf .git

    # install gems
    if [ -w Gemfile.lock ]; then
        rm -f Gemfile.lock
    fi

    echo_info 'sudo ./install'
    sudo ./install

    # change credentials
    echo_info "sed -i -E '/^\s{8}user/ s/:\s*\"\w+\"/: \"root\"/' ./config.yaml"
    sed -i -E '/^\s{8}user/ s/:\s*"\w+"/: "root"/' ./config.yaml

    echo_info "sed -i -E '/^\s{8}passwd/ s/:\s*\"\w+\"/: \"toor\"/' ./config.yaml"
    sed -i -E '/^\s{8}passwd/ s/:\s*"\w+"/: "toor"/' ./config.yaml

    # use port 80
    echo_info "sed -i -E '/^\s{8}port/ s/:\s*\"[0-9]+\"/: \"80\"/' ./config.yaml"
    sed -i -E '/^\s{8}port/ s/:\s*"[0-9]+"/: "80"/' ./config.yaml
)
