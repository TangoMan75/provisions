#!/bin/bash

#/**
# * install the latest version of docker engine - community and containerd
# * container environments
# *
# * @category devops
# * @note     not recommended: install docker.io instead
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'curl'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

if [ "${#}" -gt 1 ]; then
    echo_error "too many arguments (${#})"
    echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
    exit 1
fi

OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE='false';;
        h) echo_label 'description'; echo_primary "`basename ${0}`"
            echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

if [ "${UPDATE}" != 'false' ]; then
    # update the apt package index
    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

if [ `is_installed 'apt-transport-https'` == 'false' ]; then
    # install packages to allow apt to use a repository over https
    echo_info 'sudo apt-get install --assume-yes apt-transport-https'
    sudo apt-get install --assume-yes apt-transport-https
fi

if [ `is_installed 'ca-certificates'` == 'false' ]; then
    echo_info 'sudo apt-get install --assume-yes ca-certificates'
    sudo apt-get install --assume-yes ca-certificates
fi

if [ `is_installed 'gnupg-agent'` == 'false' ]; then
    echo_info 'sudo apt-get install --assume-yes gnupg-agent'
    sudo apt-get install --assume-yes gnupg-agent
fi

if [ `is_installed 'software-properties-common'` == 'false' ]; then
    echo_info 'sudo apt-get install --assume-yes software-properties-common'
    sudo apt-get install --assume-yes software-properties-common
fi

if [ "${UPDATE}" != 'false' ]; then
    # add docker's official gpg key
    echo_info 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # set up stable repository
    echo_info "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu `lsb_release -cs` stable\""
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu `lsb_release -cs` stable"

    # update the apt package index
    echo_info 'sudo apt-get update'
    sudo apt-get update
fi

# install the latest version of docker engine - community and containerd
echo_info 'sudo apt-get install --assume-yes docker-ce'
sudo apt-get install --assume-yes docker-ce

echo_info 'sudo apt-get install --assume-yes docker-ce-cli'
sudo apt-get install --assume-yes docker-ce-cli

echo_info 'sudo apt-get install --assume-yes containerd.io'
sudo apt-get install --assume-yes containerd.io

# add current user to docker group
echo_info "sudo usermod -a -G docker ${USER}"
sudo usermod -a -G docker ${USER}

echo_warning 'You will need to log out and log back in current user to use docker'
