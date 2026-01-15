# PLAN_BLUE_GREEN.md

## 🎯 Objectif
Mettre en place une stratégie **blue/green** pour l’application Vue.js / NestJS / PostgreSQL permettant :
- De déployer une nouvelle version **sans arrêter l’ancienne**
- De basculer le trafic via un **reverse proxy Nginx sans downtime**
- De pouvoir **rollback quasi instantanément**

---

## 1. Modélisation (recherches et principes)

### 1.1 Plusieurs services pour un même rôle
Chaque rôle applicatif existe en deux versions :
- Backend : `app-back-blue` et `app-back-green`
- Frontend : `app-front-blue` et `app-front-green`

Ces services :
- Sont **stateless**
- Utilisent **la même base PostgreSQL**

Ils peuvent donc tourner **en parallèle** sans conflit.

---

### 1.2 Ne pas impacter tous les services avec `docker compose up`

On sépare la stack en plusieurs fichiers :

| Fichier | Contenu |
|------|-------|
| docker-compose.base.yml | Postgres + Reverse proxy |
| docker-compose.blue.yml | Frontend + Backend **blue** |
| docker-compose.green.yml | Frontend + Backend **green** |

Docker Compose fusionne les fichiers passés avec `-f`.  
Donc :

```
docker compose -f docker-compose.base.yml -f docker-compose.green.yml up -d
```

👉 démarre **uniquement green + infra**, sans toucher à blue.

---

### 1.3 Séparation des responsabilités

| Élément | Rôle |
|------|------|
| Reverse Proxy (Nginx) | Reçoit le trafic utilisateur |
| Blue / Green | Deux versions applicatives |
| Postgres | Base unique partagée |

Le proxy **ne contient aucune logique métier** : il fait uniquement du routage.

---

## 2. Solution technique retenue

### 2.1 Fichiers Docker Compose

Nous utilisons **3 fichiers** :

| Fichier | Rôle |
|-------|------|
| docker-compose.base.yml | Postgres + reverse-proxy |
| docker-compose.blue.yml | app-front-blue + app-back-blue |
| docker-compose.green.yml | app-front-green + app-back-green |

👉 Pas de `docker-compose.proxy.yml` séparé : le proxy est une infra partagée.

---

### 2.2 Commandes de lancement

Premier déploiement (blue) :

```
docker compose -f docker-compose.base.yml -f docker-compose.blue.yml up -d
```

Déploiement d’une nouvelle version sur green :

```
docker compose -f docker-compose.base.yml -f docker-compose.green.yml up -d
```

Arrêter une couleur :

```
docker compose -f docker-compose.green.yml down
```

---

## 3. Mécanisme de bascule côté proxy

### Choix technique
👉 **Option retenue : fichier Nginx dynamique monté dans le conteneur**

Le fichier `active.conf` définit vers quelle couleur router.

`nginx.conf` contient :
```
include /etc/nginx/active.conf;
```

### Exemple active.conf (blue actif)
```
upstream backend {
    server app-back-blue:3000;
}
upstream frontend {
    server app-front-blue:80;
}
```

### Exemple active.conf (green actif)
```
upstream backend {
    server app-back-green:3000;
}
upstream frontend {
    server app-front-green:80;
}
```

Le fichier est monté depuis l’hôte dans le conteneur Nginx.

### Bascule
Modifier `active.conf` puis :
```
docker exec reverse-proxy nginx -s reload
```

👉 Pas de redémarrage → **pas de downtime**

---

## 4. Suivi de la couleur active

Un fichier `.active_color` stocke la couleur actuelle :

```
blue
```

Dans la CI :
```
CURRENT=$(cat .active_color)
if [ "$CURRENT" = "blue" ]; then NEXT=green; else NEXT=blue; fi
```

Après bascule réussie :
```
echo "$NEXT" > .active_color
```

---

## 5. Scénario de déploiement

### État initial
- Couleur active : **blue**
- Proxy → app-front-blue / app-back-blue

```
[Client] → [Nginx] → [Blue]
                  → [Green (off)]
```

---

### Nouveau déploiement
1. La CI lit `.active_color` → blue
2. Elle déploie la nouvelle version sur **green**
3. Elle teste `app-back-green`
4. Elle modifie `active.conf` pour pointer vers green
5. Elle recharge Nginx
6. Elle met `.active_color = green`

Résultat :

```
[Client] → [Nginx] → [Green]
                  → [Blue]
```

Aucune coupure.

---

### Rollback
Si green est cassé :
1. Remettre `active.conf` sur blue
2. `nginx -s reload`
3. `.active_color = blue`

Rollback instantané.

---

## ✅ Critère obligatoire respecté

- Blue et green coexistent
- Le proxy bascule sans redémarrage
- Le rollback ne nécessite ni rebuild ni redeploy
