#!/bin/sh
echo "[mariadb] Adding routes..."
ip route add 192.168.99.0/24 via 192.168.54.254
ip route add 192.168.47.0/24 via 192.168.54.254
echo "[mariadb] Routes OK"
echo "[mariadb] Generating SSH host keys..."
ssh-keygen -A
echo "[mariadb] Starting nftables"
nft -f /etc/nftables.conf
echo "[mariadb] Starting MariaDB..."
docker-entrypoint.sh mysqld &
echo "[mariadb] Starting SSH daemon..."
exec /usr/sbin/sshd -D
