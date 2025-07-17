#!/bin/bash

echo "==============================================="
echo "   TEST DE CONNECTIVITE RESEAU POUR BANANACORP "
echo "==============================================="
echo "Exécuté depuis admin-pc (192.168.99.10)"
echo "-----------------------------------------------"

# PING TESTS
echo -e "\n[TEST PING] Vérification de la connectivité réseau"
for host in 192.168.47.10 192.168.47.50 192.168.47.254 192.168.54.20 192.168.54.254 192.168.99.254; do
    echo -n "Ping $host ... "
    ping -c 1 $host &> /dev/null && echo "OK" || echo "ECHEC"
done

# SSH TESTS
echo -e "\n[TEST SSH] Vérification accès SSH (port 22) depuis admin-pc"
for host in 192.168.47.10 192.168.47.50 192.168.54.20; do
    echo -n "Port 22 sur $host ... "
    nc -z -v -w2 $host 22 &> /dev/null && echo "OK" || echo "FERME"
done

# HTTP/HTTPS TESTS
echo -e "\n[TEST HTTP/HTTPS] Vérification accès externe au proxy (192.168.47.10)"
for port in 80 443; do
    echo -n "Port $port (TCP) ... "
    nc -z -v -w2 192.168.47.10 $port &> /dev/null && echo "OK" || echo "FERME"
done

# WEBAPP TEST depuis proxy
echo -e "\n[TEST WEBAPP] Vérification accès au PHP-FPM (192.168.47.50:39100) depuis proxy"
echo "Exécuter dans le conteneur 'proxy' : nc -z -v -w2 192.168.47.50 39100"
echo "Résultat attendu : OK"

# MARIADB TESTS
echo -e "\n[TEST MARIADB] Vérification accès à MariaDB (192.168.54.20:3306)"

echo -n "Depuis admin-pc (192.168.99.X) ... "
nc -z -v -w2 192.168.54.20 3306 &> /dev/null && echo "OK" || echo "FERME"

echo -n "Depuis App (192.168.47.50) ... "
echo "Exécuter dans le conteneur 'webapp' : nc -z -v -w2 192.168.54.20 3306"
echo "Résultat attendu : OK"

echo -n "Depuis Proxy (192.168.47.10) ... "
echo "Exécuter dans le conteneur 'proxy' : nc -z -v -w2 192.168.54.20 3306"
echo "Résultat attendu : FERME (doit être bloqué)"

# INTERNET TESTS
echo -e "\n[TEST INTERNET] Vérification blocage sortie Internet"

echo -n "Depuis admin-pc : Connexion HTTP vers google.com ... "
curl -s --max-time 5 http://google.com &> /dev/null && echo "OUVERTE (OK)" || echo "BLOQUEE (ECHEC)"

echo "Depuis Proxy : Exécuter dans le conteneur 'proxy' : curl -s --max-time 5 http://google.com"
echo "Résultat attendu : BLOQUEE"

echo "Depuis Webapp : Exécuter dans le conteneur 'webapp' : curl -s --max-time 5 http://google.com"
echo "Résultat attendu : BLOQUEE"

echo "Depuis MariaDB : Exécuter dans le conteneur 'mariadb' : curl -s --max-time 5 http://google.com"
echo "Résultat attendu : BLOQUEE"

echo -e "\n==============================================="
echo "    TOUS LES TESTS SONT TERMINÉS               "
echo "=> Pensez à exécuter manuellement les tests marqués."
echo "==============================================="
