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
echo "Set Hostname"
sed -i 's/'$(hostname)'/'$(hostname)'.example.com/' /etc/hostname

# Set Hosts
echo "Set Hosts"

sed -i 's/ubuntu2004.localdomain/'$(hostname)'.example.com/g' /etc/hosts

cat >>/etc/hosts<<EOF
172.16.16.11   kmaster1.example.com    kmaster1
172.16.16.12   kmaster2.example.com    kmaster2
172.16.16.21   kworker1.example.com    kworker1
172.16.16.31   lbmaster.example.com    lbmaster
EOF

# Change nameserver 
echo "Change nameserver"
systemctl disable systemd-resolved
systemctl stop systemd-resolved
sed -i 's/nameserver.*/nameserver 172.16.16.1/' /etc/resolv.conf

echo "Success $(hostname) has been provisioned"
