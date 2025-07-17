#!/bin/sh
set -e

echo "[webapp] Applying nftables rules..."
nft -f /etc/nftables.conf

echo "[webapp] Ajout de la route nécessaire via router..."
ip route add 192.168.54.0/24 via 192.168.47.254

echo "[webapp] Starting PHP-FPM..."
service php8.3-fpm start

echo "[webapp] Starting NGINX..."
service nginx start

echo "[webapp] Génération clefs SSH..."
ssh-keygen -A

echo "[webapp] Déverouille PermitRootLogin..."
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "[webapp] Lancement sshd..."
exec /usr/sbin/sshd -D 