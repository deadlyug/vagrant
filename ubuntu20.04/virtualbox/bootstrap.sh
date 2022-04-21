#!/bin/bash

# Enable ssh password authentication
echo "Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "Set root password"
echo -e "admin\nadmin" | passwd root >/dev/null 2>&1

# Set Hostname 
# echo "Set Hostname"
# sed -i 's/'$(hostname)'/'$(hostname)'.example.com/' /etc/hostname

# Set Hosts
# echo "Set Hosts"
#
# sed -i 's/ubuntu2004.localdomain/'$(hostname)'.example.com/g' /etc/hosts
