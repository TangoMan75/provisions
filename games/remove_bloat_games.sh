#!/bin/bash

#/**
# * remove bloat game
# *
# * @category games
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes aisleriot'
sudo apt-get purge --assume-yes aisleriot

echo_info 'sudo apt-get purge --assume-yes gnome-mahjongg'
sudo apt-get purge --assume-yes gnome-mahjongg

echo_info 'sudo apt-get purge --assume-yes gnome-mines'
sudo apt-get purge --assume-yes gnome-mines

echo_info 'sudo apt-get purge --assume-yes gnome-sudoku'
sudo apt-get purge --assume-yes gnome-sudoku

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

