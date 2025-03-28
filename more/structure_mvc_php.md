# Table des matières

1. [Introduction](#1-introduction)
2. [Problèmes quotidiens liés à une mauvaise organisation](#2-problèmes-quotidiens-liés-à-une-mauvaise-organisation)
3. [Architecture de fichiers d'application web](#3-architecture-de-fichiers-dapplication-web)
4. [Validation de la structure de projet](#4-validation-de-la-structure-de-projet)
   - 4.1. [Validation bibliothéconomique](#41-validation-bibliothéconomique)
     - 4.1.1. [Classification et taxonomie](#411-classification-et-taxonomie)
     - 4.1.2. [Proximité logique](#412-proximité-logique)
     - 4.1.3. [Points d'accès normalisés](#413-points-daccès-normalisés)
     - 4.1.4. [Préservation et sécurité](#414-préservation-et-sécurité)
     - 4.1.5. [Contextualisation](#415-contextualisation)
   - 4.2. [Validation selon les principes de développement](#42-validation-selon-les-principes-de-développement)
     - 4.2.1. [Separation of Concerns (SoC)](#421-separation-of-concerns-soc)
     - 4.2.2. [Don't Repeat Yourself (DRY)](#422-dont-repeat-yourself-dry)
     - 4.2.3. [Convention over Configuration (CoC)](#423-convention-over-configuration-coc)
     - 4.2.4. [Keep It Simple, Stupid (KISS)](#424-keep-it-simple-stupid-kiss)
     - 4.2.5. [Principle of Least Surprise](#425-principle-of-least-surprise)
     - 4.2.6. [Security by Design](#426-security-by-design)
   - 4.3. [Validation par comparaison avec les standards de l'industrie](#43-validation-par-comparaison-avec-les-standards-de-lindustrie)
     - 4.3.1. [Frameworks PHP populaires](#431-frameworks-php-populaires)
5. [Architecture de fichiers et dossiers](#5-architecture-de-fichiers-et-dossiers)

---

# 1. Introduction

L'organisation des fichiers dans un projet de développement est aussi fondamentale qu'un établi bien rangé pour un menuisier. Un menuisier qui perd du temps à chercher ses outils ou qui doit déplacer plusieurs objets pour accéder à une scie spécifique voit sa productivité diminuer drastiquement. De même, un développeur naviguant dans une architecture désordonnée perd un temps précieux et augmente les risques d'erreurs.

# 2. Problèmes quotidiens liés à une mauvaise organisation

**Questionnaire d'auto-évaluation :**

1. Perdez-vous régulièrement du temps à chercher où vous avez enregistré un document?
2. Avez-vous déjà recréé un document parce que vous ne retrouviez pas l'original?
3. Vos espaces numériques (bureau, dossiers) sont-ils encombrés de fichiers non classés?
4. Avez-vous du mal à déterminer rapidement quelle est la version la plus récente d'un document?
5. Rencontrez-vous des difficultés à partager des fichiers avec d'autres personnes car ils sont éparpillés?
6. Avez-vous déjà perdu des données importantes à cause d'un mauvais système de sauvegarde?
7. Votre système de nommage de fichiers est-il incohérent ou confus?
8. Éprouvez-vous de l'anxiété face à l'accumulation de documents numériques non organisés?

Si vous avez répondu "oui" à plusieurs de ces questions, votre système d'organisation pourrait bénéficier d'une restructuration.

# 3. Architecture de dossiers

```
/
├── app/                        # Code de l'application
│   ├── controller/             # Scripts des contrôleurs
│   │   ├── admin/              # Contrôleurs admin
│   │   └── public/             # Contrôleurs publics
│   ├── model/                  # Scripts des modèles
│   ├── view/                   # Templates de vues
│   │   ├── admin/              # Vues admin
│   │   └── public/             # Vues publiques
│   ├── helper/                 # Fonctions d'aide
│   └── config/                 # Fichiers de configuration
├── public/                     # Fichiers accessibles publiquement
│   ├── index.php               # Point d'entrée public
│   ├── admin/                  # Section admin
│   │   ├── index.php           # Point d'entrée admin
│   │   └── assets/             # Ressources spécifiques à l'admin
│   │       ├── css/
│   │       ├── js/
│   │       └── ui/             # Éléments d'interface (icônes, graphiques)
│   ├── assets/                 # Ressources statiques publiques
│   │   ├── css/
│   │   ├── js/
│   │   └── ui/                 # Éléments d'interface (icônes, graphiques)
│   ├── images/                 # Images téléchargées/de contenu publiques
│   └── .htaccess               # Configuration Apache
├── doc/                        # Documentation
└── import/                     # Scripts et données d'importation
```

# 4. Validation de la structure de projet

## 4.1 Validation bibliothéconomique

La bibliothéconomie, science de l'organisation des connaissances, offre des principes pertinents pour structurer efficacement un projet de développement.

### 4.1.1 Classification et taxonomie

Dans la structure présentée, on observe une classification hiérarchique claire:

- Séparation fonctionnelle (`app/`, `public/`, `doc/`, `import/`)
- Classification par rôle technique (MVC: `controller/`, `model/`, `view/`)
- Subdivision par contexte d'utilisation (`admin/`, `public/`)

Cette taxonomie reflète le principe bibliothéconomique de classement par sujet et fonction, facilitant la navigation intuitive.

### 4.1.2 Proximité logique

En bibliothéconomie, les ouvrages traitant de sujets connexes sont placés à proximité. Dans la structure présentée:

- Les contrôleurs administratifs sont regroupés (`controller/admin/`)
- Les ressources liées à l'interface utilisateur sont centralisées (`assets/ui/`)
- La configuration est isolée dans un emplacement dédié (`app/config/`)

### 4.1.3 Points d'accès normalisés

Les bibliothèques utilisent des points d'entrée standardisés (catalogues, index). Le projet implémente ce principe avec:

- Des points d'entrée clairement définis (`public/index.php`, `admin/index.php`)
- Des conventions de nommage cohérentes
- Une organisation prévisible des ressources statiques

### 4.1.4 Préservation et sécurité

En bibliothéconomie, certains documents précieux nécessitent une protection particulière. Cette structure applique ce principe:

- Le code sensible est placé hors de la racine web (`app/`)
- Seuls les fichiers destinés au public sont exposés (`public/`)
- Des barrières de sécurité supplémentaires sont définies (`.htaccess`)

### 4.1.5 Contextualisation

Les métadonnées contextuelles enrichissent la compréhension d'un document. Cette architecture fournit du contexte par:

- La séparation claire entre administration et interface publique
- Le regroupement logique des fonctionnalités connexes
- La documentation dédiée (`doc/`)

## 4.2 Validation selon les principes de développement

L'architecture de fichiers présentée repose sur des principes de développement éprouvés, favorisant la maintenabilité et la sécurité.

### 4.2.1 Separation of Concerns (SoC)

Le projet sépare clairement les différentes responsabilités:

- Les contrôleurs gèrent le traitement des requêtes
- Les modèles gèrent les données et la logique métier
- Les vues gèrent la présentation
- Les ressources publiques sont isolées du code applicatif

### 4.2.2 Don't Repeat Yourself (DRY)

- Les fonctions d'aide partagées dans `/app/helper/` évitent la duplication
- Configurations communes centralisées dans `/app/config/`

### 4.2.3 Convention over Configuration (CoC)

- Nommage cohérent des répertoires (`controller/`, `model/`, `view/`)
- Points d'entrée prévisibles (`index.php`)
- Organisation standard des ressources dans les sections admin et public

### 4.2.4 Keep It Simple, Stupid (KISS)

- Hiérarchie plate et logique qui minimise la complexité
- Correspondance directe entre contrôleurs et vues
- Séparation claire entre contenu téléchargé et ressources statiques
- Les ressources statiques sont organisées pour un accès facile et évitent la redondance

### 4.2.5 Principle of Least Surprise

- Les composants sont là où les développeurs s'attendraient à les trouver
- Structures similaires pour les sections admin et public
- Implémentation standard du modèle MVC

### 4.2.6 Security by Design

- Code applicatif en dehors de la racine web
- Seul `/public/` est exposé aux requêtes web
- `.htaccess` pour des contrôles de sécurité supplémentaires

## 4.3 Validation par comparaison avec les standards de l'industrie

### 4.3.1 Frameworks PHP populaires

1. **Laravel** - Framework PHP populaire suivant une architecture MVC similaire avec app/Http/Controllers, app/Models et resources/views.

2. **Symfony** - Très utilisé pour les projets d'entreprise, avec src/Controller, config/ et templates/ suivant une organisation comparable.

3. **CodeIgniter** - Structure par défaut très similaire avec les dossiers app/controllers, app/models, app/views et une séparation claire des ressources publiques.

4. **Yii Framework** - Organisation comparable avec controllers/, models/, views/ et web/ pour les fichiers publics.


## 5. Architecture de fichiers et dossiers

```
/
├── app/                        # Code de l'application
│   ├── controller/             # Scripts des contrôleurs
│   │   ├── admin/              # Contrôleurs admin
│   │   │   ├── auth.php        # Authentification admin
│   │   │   ├── dashboard.php   # Tableau de bord
│   │   │   ├── items.php       # Gestion des items
│   │   │   ├── tags.php        # Gestion des tags
│   │   │   ├── operators.php   # Gestion des opérateurs
│   │   │   └── messages.php    # Gestion des messages
│   │   └── public/             # Contrôleurs publics
│   │       ├── home.php        # Page d'accueil
│   │       ├── item.php        # Page détail item
│   │       ├── items.php       # Liste des items
│   │       ├── search.php      # Recherche
│   │       ├── contact.php     # Formulaire de contact
│   │       └── collection.php  # Collections utilisateur
│   ├── model/                  # Scripts des modèles
│   │   ├── item.php            # Fonctions CRUD items
│   │   ├── tag.php             # Fonctions CRUD tags
│   │   ├── operator.php        # Fonctions CRUD opérateurs
│   │   ├── visitor.php         # Fonctions CRUD visiteurs
│   │   ├── message.php         # Fonctions CRUD messages
│   │   ├── collection.php      # Fonctions CRUD collections
│   │   ├── item_tag.php        # Relations items-tags
│   │   ├── collection_item.php # Relations collections-items
│   │   └── search.php          # Journalisation des recherches
│   ├── view/                   # Templates de vues
│   │   ├── admin/              # Vues admin
│   │   │   ├── layout.php      # Template principal admin
│   │   │   ├── login.php       # Page connexion
│   │   │   ├── dashboard.php   # Tableau de bord
│   │   │   ├── items/          # Vues gestion items
│   │   │   │   ├── list.php    # Liste des items
│   │   │   │   ├── edit.php    # Formulaire édition
│   │   │   │   └── create.php  # Formulaire création
│   │   │   ├── tags/           # Vues gestion tags
│   │   │   ├── operators/      # Vues gestion opérateurs
│   │   │   └── messages/       # Vues gestion messages
│   │   └── public/             # Vues publiques
│   │       ├── layout.php      # Template principal public
│   │       ├── header.php      # En-tête
│   │       ├── footer.php      # Pied de page
│   │       ├── home.php        # Page d'accueil
│   │       ├── item.php        # Détail d'un item
│   │       ├── items.php       # Liste d'items
│   │       ├── search.php      # Résultats de recherche
│   │       ├── contact.php     # Formulaire de contact
│   │       ├── collection.php  # Collections utilisateur
│   │       └── 404.php         # Page d'erreur 404
│   ├── helper/                 # Fonctions d'aide
│   │   ├── database.php        # Fonctions de base de données
│   │   ├── auth.php            # Fonctions d'authentification
│   │   ├── validation.php      # Validation des données
│   │   ├── security.php        # Fonctions de sécurité
│   │   ├── upload.php          # Gestion des téléchargements
│   │   ├── format.php          # Formatage des données
│   │   └── pagination.php      # Pagination
│   └── config/                 # Fichiers de configuration
│       ├── database.php        # Configuration base de données
│       ├── app.php             # Configuration générale
│       └── routes.php          # Configuration des routes
├── public/                     # Fichiers accessibles publiquement
│   ├── index.php               # Point d'entrée public
│   ├── admin/                  # Section admin
│   │   ├── index.php           # Point d'entrée admin
│   │   └── assets/             # Ressources spécifiques à l'admin
│   │       ├── css/
│   │       ├── js/
│   │       └── ui/             # Éléments d'interface (icônes, graphiques)
│   ├── assets/                 # Ressources statiques publiques
│   │   ├── css/
│   │   ├── js/
│   │   └── ui/                 # Éléments d'interface (icônes, graphiques)
│   ├── images/                 # Images téléchargées/de contenu publiques
│   └── .htaccess               # Configuration Apache
├── doc/                        # Documentation
└── import/                     # Scripts et données d'importation
```