# ATE — site dynamique avec administration

## Présentation

Ce dépôt contient le cadre, les consignes et la documentation d’un projet de site web dynamique avec interface d’administration.

Le but est de concevoir et développer un site complet permettant :

- l’affichage de contenus côté public
- la gestion de contenus via une interface d’administration sécurisée
- l’utilisation d’une base de données relationnelle
- l’intégration progressive du frontend et du backend

Ce `README.md` est le **point d’entrée** du projet.  
Il donne une vue d’ensemble et renvoie vers les documents détaillés.

---

## Objectif du projet

Réaliser un site web dynamique administrable, structuré, fonctionnel et cohérent, en mobilisant les compétences vues au cours :

- analyse du besoin
- structuration des pages
- intégration HTML
- habillage CSS
- architecture PHP
- gestion des accès
- manipulation de données en base
- finalisation, tests et documentation

Le projet doit aboutir à une production exploitable, lisible, démontrable et maintenable.

---

## Base de données et périmètre fonctionnel

Le projet repose sur une **base de données commune**, définie à l’avance et construite collectivement dans le cours de base de données, afin de fournir un socle stable permettant de mettre en œuvre **environ 80 % des fonctionnalités attendues d’un CMS**.

La structure s’organise autour de plusieurs éléments principaux :

- une table centrale `item`, qui représente l’unité de contenu principale du site ;
- un système de classification permettant d’associer les items à des **catégories**, des **thèmes** et des **tags** ;
- un système de **collections**, qui permet à un utilisateur de créer ses propres regroupements d’items, de manière ponctuelle et indépendamment des systèmes de classification ;
- une table `operator`, qui regroupe les utilisateurs du site et les administrateurs.

Le projet ne distingue donc pas deux types d’utilisateurs dans deux structures séparées.  
Un même `operator` peut être simple utilisateur ou administrateur selon ses **permissions**.

À partir de ce modèle, tout projet doit permettre au minimum :

- la consultation des items ;
- la recherche d’items par catégorie ;
- la recherche d’items par thème ;
- la recherche d’items par contenu ;
- la création de collections personnalisées par les utilisateurs ;
- la gestion des accès selon les permissions attribuées.

Cette contrainte est volontaire : elle permet de concentrer le travail sur l’analyse, l’interface, l’architecture du code et la mise en œuvre des fonctionnalités, plutôt que sur la redéfinition complète du modèle de données.

---

## Documents du projet

### Cadrage et organisation
- [Plan général du projet](plan.md)
- [README du projet](README.md)
- [Base de données](database.md)
- 
### Analyse
- [Analyse du projet](docs/analyse.md)
- [Questions de cadrage](docs/analyse-questions.md)
- [Analyse concurrentielle](docs/analyse-concurrentielle.md)

### Conception
- [Wireframes et structure des pages](docs/wireframes.md)
- [Arborescence du site](docs/arborescence.md)

### Frontend
- [Consignes HTML](docs/html.md)
- [Consignes CSS](docs/css.md)

### Backend
- [Architecture PHP](docs/php-architecture.md)
- [Routing et contrôleurs](docs/php-routing.md)
- [Authentification et sessions](docs/php-auth.md)
- [Permissions et accès](docs/php-permissions.md)

### Données
- [Structure de la base de données](docs/database.md)
- [Tags, thèmes, catégories](more/tag-theme-category.md)

### Sécurité
- [Consignes de sécurité](more/security.md)
- [Réécriture d’URL / .htaccess](more/htaccess.md)

### Fonctionnalités détaillées
- [Fonctionnalités frontend](duty_to_do_front.md)
- [Fonctionnalités admin](docs/admin-features.md)

### Évaluation et livrables
- [Livrables attendus](docs/livrables.md)
- [Critères d’évaluation](docs/evaluation.md)

---

## Ce que ce dépôt doit contenir à terme

Le projet final devra inclure au minimum :

- un frontend fonctionnel
- un backend administrable
- une base de données correctement structurée
- un système d’authentification
- des opérations CRUD sur les contenus principaux
- une documentation minimale d’installation et d’utilisation

Selon le type de site choisi, certaines fonctionnalités complémentaires pourront être ajoutées.
