#!/bin/bash
# Force IPv4 for APT and disable IPv6 permanently
# echo 'Acquire::ForceIPv4 "true";' > /etc/apt/apt.conf.d/99force-ipv4
# echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf
# echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf
# sysctl -p

# Install Apache with essential packages only
apt-get update -y
apt-get install -y apache2

# Start service and create index.html
systemctl start apache2
systemctl enable apache2
mkdir -p /var/www/html
echo "<h1>Healthy Instance</h1>" > /var/www/html/index.html