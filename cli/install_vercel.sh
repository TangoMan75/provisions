#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## vercel
##
## First Use:
## ```
## vercel login
## ```
##
## Run your project locally with the same environment as Vercel’s serverless functions:
## ```
## vercel dev
## ```
##
## Configuration: `vercel.json`
## ```json
## {
##   "version": 2,
##   "builds": [
##     {
##       "src": "api/*.js",
##       "use": "@vercel/node"
##     }
##   ],
##   "routes": [
##     {
##       "src": "/api/(.*)",
##       "dest": "/api/$1"
##     }
##   ]
## }
## ```
##
## @category cli
## @link     https://vercel.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PACKAGE_NAME=vercel

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm install -g ${PACKAGE_NAME}\n"
sudo npm install -g ${PACKAGE_NAME}

#--------------------------------------------------

_echo_info 'vercel --version\n'
vercel --version
