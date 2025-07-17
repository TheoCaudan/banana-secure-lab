#!/bin/sh
echo "[proxy-init] Début init proxy..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "[proxy-init] Installation outils..."
apk update
apk add --no-cache nftables openssh net-tools iproute2 curl
echo "[proxy-init] Préparation SSH..."
ssh-keygen -A
echo "[proxy-init] Chargement règles nftables..."
nft -f /etc/nftables.conf
echo "[proxy-init] Adding routes..."
ip route add 192.168.99.0/24 via 192.168.47.254
ip route add 192.168.54.0/24 via 192.168.47.254
echo "[proxy-init] Routes OK"
echo "[proxy-init] Lancement sshd..."
/usr/sbin/sshd 
echo "[proxy-init] Lancement Caddy..."
exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
