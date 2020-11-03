#!/bin/bash

#/**
# * traefik
# *
# * usage: sudo traefik --accesslog=true --api=true --api.insecure=true --api.dashboard=true --api.debug=true --log.level=INFO
# *
# * ```
# * http://localhost:8080/api/rawdata
# * http://localhost:8080/dashboard
# * ```
# *
# * @category servers
# * @link     https://doc.traefik.io/traefik/getting-started/quick-start/
# * @link     https://raw.githubusercontent.com/containous/traefik/v2.3/traefik.sample.toml
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info 'wget -q -O traefik.tar.gz https://github.com/traefik/traefik/releases/download/v2.3.1/traefik_v2.3.1_linux_amd64.tar.gz'
wget -q -O traefik.tar.gz https://github.com/traefik/traefik/releases/download/v2.3.1/traefik_v2.3.1_linux_amd64.tar.gz

# extract tar file
echo_info 'tar xzvf traefik.tar.gz'
tar xzvf traefik.tar.gz

# install traefik globally
echo_info 'sudo mv traefik /usr/local/bin/traefik'
sudo mv traefik /usr/local/bin/traefik

# fix permissions
echo_info 'sudo chmod uga+x /usr/local/bin/traefik'
sudo chmod uga+x /usr/local/bin/traefik

echo_info 'sync'
sync

echo_info 'rm LICENSE.md CHANGELOG.md traefik.tar.gz'
rm LICENSE.md CHANGELOG.md traefik.tar.gz

