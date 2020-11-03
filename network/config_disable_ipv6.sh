#!/bin/bash

#/**
# * disable ipv6
# *
# * @category network
# * @link     https://itsfoss.com/disable-ipv6-ubuntu-linux/
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1'
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1

echo_info 'sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1'
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

echo_info 'sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1'
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

# make permanent
sudo bash -c 'cat >> /etc/sysctl.conf <<EOF

###################################################################
# Disable ipv6
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1
EOF'

echo_info 'sudo sysctl -p'
sudo sysctl -p

# make permanent after reboot
sudo bash -c 'cat >> /etc/rc.local <<EOF
#!/bin/bash
# /etc/rc.local

/etc/sysctl.d
/etc/init.d/procps restart

exit 0
EOF'

# make rc.local executable
echo_info 'sudo chmod 755 /etc/rc.local'
sudo chmod 755 /etc/rc.local
