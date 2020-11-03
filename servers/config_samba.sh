#!/bin/bash

#/**
# * config samba
# *
# * samba file sharing service (default service on ubuntu not NFS as one could expect)
# * https://askubuntu.com/questions/888205/how-to-set-up-an-entire-hard-drive-as-a-shared-drive-in-samba
# *
# * @category servers
# * @link     https://doc.ubuntu-fr.org/samba_smb.conf
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo sed -i "s/\[global\]/[global]\n  force user = ${USER}\n  force group = ${USER}\n/" /etc/samba/smb.conf'
sudo sed -i "s/\[global\]/[global]\n  force user = ${USER}\n  force group = ${USER}\n/" /etc/samba/smb.conf

echo | sudo tee --append /etc/samba/smb.conf <<EOF

# create full hard drive share
[sda1]
  # create mask = 0755
  # guest ok = Yes
  path = /media/${USER}/DATA
  read only = No
  # # restrict access to given users only
  # valid users = ${USER}
EOF

echo_info "sudo subl /etc/samba/smb.conf"
sudo subl /etc/samba/smb.conf

# validate parameters
echo_info 'testparm -s'
testparm -s

# create user password
echo_info 'sudo smbpasswd -a ${USER}'
sudo smbpasswd -a ${USER}

# # delete user
# echo_info 'sudo smbpasswd -x ${USER}'
# sudo smbpasswd -x ${USER}

echo_info 'sudo systemctl restart smbd'
sudo systemctl restart smbd
