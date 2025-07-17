#!/bin/sh
echo "[admin-pc] Adding routes..."
ip route add 192.168.54.0/24 via 192.168.99.254
ip route add 192.168.47.0/24 via 192.168.99.254
echo "[admin-pc] Routes OK"
echo "[admin-pc] Génération clefs SSH..."
ssh-keygen -A
echo "[admin-pc] Déverouille PermitRootLogin..."
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo "[admin-pc] Lancement sshd..."
exec /usr/sbin/sshd -D