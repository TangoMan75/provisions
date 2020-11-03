#!/bin/bash

#/**
# * fluxion
# *
# * Fake accces point generator
# *
# * @category security
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'git'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

# clone project
echo_info 'git clone --depth 1 https://github.com/FluxionNetwork/fluxion.git ~/.fluxion'
git clone --depth 1 https://github.com/FluxionNetwork/fluxion.git ~/.fluxion

# Install requirements from within the .fluxion folder
(
    echo_info 'cd ~/.fluxion'
    cd ~/.fluxion

    # cleaning git cache
    echo_info 'rm -rf .git'
    rm -rf .git

    echo_info 'sudo ./fluxion.sh -i'
    sudo ./fluxion.sh -i
)

