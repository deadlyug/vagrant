#!/bin/bash

# Enable ssh password authentication
echo "Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "Set root password"
echo -e "root\nroot" | passwd root >/dev/null 2>&1

# Set Hostname 
echo "Set Hostname"
sed -i 's/'$(hostname)'/'$(hostname)'.example.com/' /etc/hostname

# Set Hosts
echo "Set Hosts"

sed -i 's/ubuntu2004.localdomain/'$(hostname)'.example.com/g' /etc/hosts

# Change nameserver 
echo "Change nameserver"
systemctl disable systemd-resolved
systemctl stop systemd-resolved
sed -i 's/nameserver.*/nameserver 171.16.16.1/' /etc/resolv.conf

echo "Success $(hostname) has been provisioned"
