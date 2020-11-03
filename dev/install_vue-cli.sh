#!/bin/bash

#/**
# * vue-cli
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

if [ -x "$(command -v yarn)" ]; then
    echo_info 'sudo yarn global add @vue/cli'
    sudo yarn global add @vue/cli

    echo_info 'sudo yarn global add @vue/cli-init'
    sudo yarn global add @vue/cli-init

    exit 0
elif [ ! -x "$(command -v npm)" ]; then
    echo_error 'vue-cli requires npm or yarn to install'
    exit 1
fi

echo_info 'sudo npm install -g @vuecli'
sudo npm install -g @vuecli

