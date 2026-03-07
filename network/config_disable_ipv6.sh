#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## disable ipv6
##
## @category network
## @link     https://itsfoss.com/disable-ipv6-ubuntu-linux/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1\n'
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1

_echo_info 'sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1\n'
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

_echo_info 'sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1\n'
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

# make permanent
sudo bash -c 'cat >> /etc/sysctl.conf <<EOF

###################################################################
# Disable ipv6
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1
EOF'

_echo_info 'sudo sysctl -p\n'
sudo sysctl -p

# make permanent after reboot
sudo bash -c 'cat >> /etc/rc.local <<EOF
#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.
# /etc/rc.local

/etc/sysctl.d
/etc/init.d/procps restart

exit 0
EOF'

# make rc.local executable
_echo_info 'sudo chmod 755 /etc/rc.local\n'
sudo chmod 755 /etc/rc.local
