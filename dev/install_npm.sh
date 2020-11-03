#!/bin/bash

#/**
# * npm
# * javascript package manager
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes npm'
sudo apt-get install --assume-yes npm

# security fix
# ------------
# 
# avoids npm runnig arbitrary postinstall scripts
# 
# package.json
#```json
# "scripts": {
#     "postinstall": "virus.js"
# }
#```

echo_info 'npm config set ignore-scripts true'
npm config set ignore-scripts true
