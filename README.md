# Comment faire tourner le tout ?

---

## Une fois tout extrait, lancer le docker-compose:

```
cd banana-secure-lab
docker-compose up -d --build 

```

---

## Afin de voir les containeurs créés :

```
docker-compose ps -a

```

---

## Run les tests :

```
docker exec -it admin-pc bash /etc/test/test.sh
```

Le script est très rapide et demande d'executer des tests supplémentaires depuis d'autres containeurs:

Les suivants doivent reussir (open):

```
docker exec proxy nc -z -v -w2 192.168.47.50 39100
docker exec webapp nc -z -v -w2 192.168.54.20 3306
```

Et ces derniers doivent échouer ou ne rien retourner:

```
docker exec proxy nc -z -v -w2 192.168.54.20 3306
docker exec webapp curl -s --max-time 5 http://google.com
docker exec proxy curl -s --max-time 5 http://google.com
docker exec mariadb curl -s --max-time 5 http://google.com
```

## Lors du setup il faudra (afin de palier aux limites de Docker) configurer le dhcp à l'aide du script orchestrator.ps1:

```
.\orchestrator.ps1

```

```
docker exec dhcp-client ip a
```
Devrait retourner une ip = 192.168.99.x (dans la plage DHCP 100-150).
