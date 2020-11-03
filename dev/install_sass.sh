#!/bin/bash

#/**
# * sass
# *
# * Sass standalone
# *
# * @category dev
# * @link     https://sass-lang.com/install
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'yarn'` == 'false' ] && [ `is_installed 'npm'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires yarn, try: 'sudo apt-get install -y yarn'"
    exit 1
fi

if [ `is_installed 'yarn'` == 'true' ]; then
    echo_info 'sudo yarn global add sass'
    sudo yarn global add sass

    echo_info 'yarn global list'
    yarn global list
else
    echo_info 'sudo npm install sass -g'
    sudo npm install sass -g
fi

echo_info 'sass --version'
sass --version
