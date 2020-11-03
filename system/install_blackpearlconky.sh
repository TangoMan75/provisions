#!/bin/bash

#/**
# * blackpearlconky theme
# * widget gnome system monitor
# *
# * @category system
# * @link     http://www.linuxandubuntu.com/home/5-best-linux-conky-themes
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tool.sh

CONFIG_DIR="${BASEDIR}/../config"

if [ `is_installed 'git'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

echo_info 'mkdir ~/.conky'
mkdir ~/.conky

echo_info 'git clone --depth 1 https://github.com/bchretien/BlackPearlConky ~/.conky'
git clone --depth 1 https://github.com/bchretien/BlackPearlConky ~/.conky

(
    echo_info 'cd ~/.conky'
    cd ~/.conky

    echo_info 'rm -rf .git'
    rm -rf .git
)
