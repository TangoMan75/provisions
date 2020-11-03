#!/bin/bash

#/**
# * config known ssh hosts
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# add github.com, gitlab.com and bitbucket.org keys to known_hosts
echo_info 'ssh-keyscan -H github.com >> ~/.ssh/known_hosts'
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

echo_info 'ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts'
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

echo_info 'ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts'
ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts

echo_info 'chmod 644 ~/.ssh/known_hosts'
chmod 644 ~/.ssh/known_hosts

echo_info "chown ${USER}:${USER} ~/.ssh/known_hosts"
chown ${USER}:${USER} ~/.ssh/known_hosts
