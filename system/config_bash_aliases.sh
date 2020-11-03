#!/bin/bash

#/**
# * config bash_aliases
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo "printf \"\\033[0;36m _____%17s_____\\n|_   _|___ ___ ___ ___|%5s|___ ___\\n  | | | .'|   | . | . | | | | .'|   |\\n  |_| |__,|_|_|_  |___|_|_|_|__,|_|_|\\n%14s|___|%6stangoman.io\\033[0m\\n\"" >> ~/.bash_aliases
