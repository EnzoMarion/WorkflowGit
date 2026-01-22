# Supervision & Observabilité (TP6)

## 1. Composants et rôles

- **Prometheus** : base de données de séries temporelles qui collecte et stocke des métriques numériques exposées par les services (par exemple l’endpoint `/metrics` de NestJS).
- **Grafana** : couche de visualisation qui se connecte à Prometheus et Loki pour créer des tableaux de bord, des alertes et des requêtes exploratoires.
- **Loki** : système d’agrégation de logs qui stocke les journaux applicatifs et des conteneurs, et permet de les interroger avec LogQL, de manière similaire à Prometheus mais pour les logs.
- **Promtail** : agent léger qui s’exécute à côté de vos conteneurs, lit leurs logs stdout et les envoie à Loki avec des labels (nom du service, environnement, etc.).

## 2. Architecture globale

```text
               +-----------------------------+
               |           Grafana           |
               |   Tableaux de bord & Explore |
               +---------------+-------------+
                               |
            Métriques (PromQL)  |   Logs (LogQL)
                               |
         +---------------------+---------------------+
         |                                           |
+--------v----------+                     +----------v--------+
|    Prometheus     |                     |        Loki       |
|  Scrape les métriques|                  |  Stocke les logs  |
+--------+----------+                     +----------+--------+
         |                                        ^
         | /metrics                               | envoie
         |                                        |
+--------v----------+                     +-------+----------+
|  Backend NestJS   |   logs stdout        |      Promtail    |
|  (bleu / vert)    +--------------------->  Agent Docker     |
+-------------------+                     +------------------+
```

### Comment l’application s’intègre

Le backend NestJS expose un endpoint HTTP `/metrics` qui est régulièrement interrogé par Prometheus, et il écrit ses logs sur la sortie standard (stdout) dans ses conteneurs Docker.  
Promtail lit ces logs et les envoie à Loki, tandis que Grafana utilise Prometheus et Loki comme sources de données pour corréler métriques et logs de l’application de gestion de salle de sport.

## 3. Monitoring vs Observabilité

**Le monitoring** consiste à surveiller un ensemble d’indicateurs connus (CPU, mémoire, taux d’erreur, latence) pour détecter quand le système est en mauvaise santé.

**L’observabilité** vise à disposer de signaux suffisamment riches (métriques, logs, traces) pour comprendre pourquoi le système se comporte d’une certaine manière et pour diagnostiquer des problèmes inconnus.

Les trois piliers de l’observabilité sont :

- **Métriques** : séries temporelles numériques pouvant être agrégées dans le temps (compteurs, jauges, histogrammes) – gérées ici par Prometheus.
- **Logs** : événements textuels discrets avec du contexte (message, niveau, stack trace) – gérés ici par Loki et Promtail.
- **Traces** : enregistrements de bout en bout des requêtes traversant plusieurs services – non implémentés dans ce TP mais faisant partie d’une pile d’observabilité complète.

## 4. Ports d’exécution

- **Grafana** : http://localhost:3000
- **Prometheus** : http://localhost:9090
- **Loki** : http://localhost:3100 (API HTTP interne, généralement non exposée publiquement)
- **Promtail** : fonctionne uniquement comme agent ; aucune interface externe n’est nécessaire, il expose seulement des endpoints internes de statut et de métriques.
