#!/bin/bash
set -e

echo "[router] Enabling IP forwarding..."
sysctl -w net.ipv4.ip_forward=1

echo "[router] Applying nftables rules..."
nft -f /etc/nftables.conf

echo "[router] Adding static routes..."
ip route add 192.168.47.0/24 dev eth0 || true
ip route add 192.168.54.0/24 dev eth1 || true
ip route add 192.168.99.0/24 dev eth2 || true

echo "[router] Generating SSH keys..."
ssh-keygen -A

echo "[router] Déverouille PermitRootLogin..."
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "[router] Preparing DHCP lease database..."
mkdir -p /var/lib/dhcp
touch /var/lib/dhcp/dhcpd.leases
chown -R root:root /var/lib/dhcp 

echo "[router] Starting DHCP server..."
rm -f /run/dhcp-server/dhcpd.pid
/usr/sbin/dhcpd -4 -cf /etc/dhcp/dhcpd.conf -pf /run/dhcp-server/dhcpd.pid eth2 &

echo "[router] Starting SSH daemon..."
exec /usr/sbin/sshd -D
