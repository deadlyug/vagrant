#!/bin/bash

# Change nameserver 
echo "Change nameserver"
systemctl disable systemd-resolved
systemctl stop systemd-resolved
sed -i 's/nameserver.*/nameserver 172.16.16.1/' /etc/resolv.conf

echo "Success $(hostname) has been provisioned"
