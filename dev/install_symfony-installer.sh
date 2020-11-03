#!/bin/bash

#/**
# * symfony installer
# *
# * @category dev
# * @link     https://symfony.com/doc/3.4/setup.html
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'curl'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

echo_info 'curl -sS https://get.symfony.com/cli/installer | bash'
curl -sS https://get.symfony.com/cli/installer | bash

# install symfony installer globally
echo_info 'sudo mv ~/.symfony/bin/symfony /usr/local/bin/symfony'
sudo mv ~/.symfony/bin/symfony /usr/local/bin/symfony

echo_info 'sync'
sync

