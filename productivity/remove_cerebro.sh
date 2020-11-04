#!/bin/bash

#/**
# * cerebro
# *
# * @category productivity
# * @link     https://cerebroapp.com
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'rm -rf ~/.cerebro'
rm -rf ~/.cerebro

echo_info 'rm ~/.local/share/applications/appimagekit-cerebro.desktop'
rm ~/.local/share/applications/appimagekit-cerebro.desktop

