#!/bin/bash

#/**
# * node-sass
# *
# * `yarn init`
# * `yarn add --dev node-sass`
# * `yarn build`
# * `yarn watch`
# *
# * ```
# * "scripts": {
# *   "build": "node-sass --include-path scss ./scss/style.scss ./css/style.css",
# *   "watch": "node-sass --watch ./scss/style.scss ./css/style.css"
# * },
# * ```
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
    echo_info 'yarn global add node-sass'
    yarn global add node-sass

    echo_info 'yarn global list'
    yarn global list
else
    echo_info 'npm install node-sass -g'
    npm install node-sass -g
fi

echo_info 'node-sass --version'
node-sass --version

