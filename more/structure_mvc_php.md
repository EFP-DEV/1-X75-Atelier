# Table des matières

1. [Introduction](#1-introduction)
2. [Problèmes quotidiens liés à une mauvaise organisation](#2-problèmes-quotidiens-liés-à-une-mauvaise-organisation)
3. [Architecture de Fichiers d'Application Web](#3-architecture-de-fichiers-dapplication-web)
4. Concepts de bibliothéconomie appliqués au développement
    - 4.1. [Classification et taxonomie](#41-classification-et-taxonomie)
    - 4.2. [Proximité logique](#42-proximité-logique)
    - 4.3. [Points d'accès normalisés](#43-points-daccès-normalisés)
    - 4.4. [Préservation et sécurité](#44-préservation-et-sécurité)
    - 4.5. [Contextualisation](#45-contextualisation)

5. Principes de développement dans l'architecture présentée
   - 5.1. [Separation of Concerns (SoC)](#51-separation-of-concerns-soc)
   - 5.2. [Don't Repeat Yourself (DRY)](#52-dont-repeat-yourself-dry)
   - 5.3. [Convention over Configuration (CoC)](#53-convention-over-configuration-coc)
   - 5.4. [Keep It Simple, Stupid (KISS)](#54-keep-it-simple-stupid-kiss)
   - 5.5. [Principle of Least Surprise](#55-principle-of-least-surprise)
   - 5.6. [Security by Design](#56-security-by-design)
6. Frameworks correspondant à cette structure
   - 6.1. [Frameworks PHP](#61-frameworks-php)
   - 6.2. [Framework JavaScript](#62-framework-javascript)

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

# 3. Architecture de Fichiers d'Application Web

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

# 4. Analyse bibliothéconomique

La bibliothéconomie, science de l'organisation des connaissances, offre des principes pertinents pour structurer efficacement un projet de développement:

## 4.1. Classification et taxonomie

Dans la structure présentée, on observe une classification hiérarchique claire:

- Séparation fonctionnelle (`app/`, `public/`, `doc/`, `import/`)
- Classification par rôle technique (MVC: `controller/`, `model/`, `view/`)
- Subdivision par contexte d'utilisation (`admin/`, `public/`)

Cette taxonomie reflète le principe bibliothéconomique de classement par sujet et fonction, facilitant la navigation intuitive.

## 4.2. Proximité logique

En bibliothéconomie, les ouvrages traitant de sujets connexes sont placés à proximité. Dans la structure présentée:

- Les contrôleurs administratifs sont regroupés (`controller/admin/`)
- Les ressources liées à l'interface utilisateur sont centralisées (`assets/ui/`)
- La configuration est isolée dans un emplacement dédié (`app/config/`)

## 4.3. Points d'accès normalisés

Les bibliothèques utilisent des points d'entrée standardisés (catalogues, index). Le projet implémente ce principe avec:

- Des points d'entrée clairement définis (`public/index.php`, `admin/index.php`)
- Des conventions de nommage cohérentes
- Une organisation prévisible des ressources statiques

## 4.4. Préservation et sécurité

En bibliothéconomie, certains documents précieux nécessitent une protection particulière. Cette structure applique ce principe:

- Le code sensible est placé hors de la racine web (`app/`)
- Seuls les fichiers destinés au public sont exposés (`public/`)
- Des barrières de sécurité supplémentaires sont définies (`.htaccess`)

## 4.5. Contextualisation

Les métadonnées contextuelles enrichissent la compréhension d'un document. Cette architecture fournit du contexte par:

- La séparation claire entre administration et interface publique
- Le regroupement logique des fonctionnalités connexes
- La documentation dédiée (`doc/`)

# 5. Architecture et principes de développement

L'architecture de fichiers présentée repose sur des principes de développement éprouvés, favorisant la maintenabilité et la sécurité. Voici un aperçu des principes clés appliqués:

## 5.1. Separation of Concerns (SoC)

_Séparation des Préoccupations_

Le projet sépare clairement les différentes responsabilités :

- Les contrôleurs gèrent le traitement des requêtes
- Les modèles gèrent les données et la logique métier
- Les vues gèrent la présentation
- Les ressources publiques sont isolées du code applicatif

## 5.2. Don't Repeat Yourself (DRY)

_Ne Pas Se Répéter_

- Les fonctions d'aide partagées dans `/app/helper/` évitent la duplication
- Configurations communes centralisées dans `/app/config/`

## 5.3. Convention over Configuration (CoC)

_Convention plutôt que Configuration_

- Nommage cohérent des répertoires (`controller/`, `model/`, `view/`)
- Points d'entrée prévisibles (`index.php`)
- Organisation standard des ressources dans les sections admin et public

## 5.4. Keep It Simple, Stupid (KISS)

_Faites Simple_

- Hiérarchie plate et logique qui minimise la complexité
- Correspondance directe entre contrôleurs et vues
- Séparation claire entre contenu téléchargé et ressources statiques
- Les ressources statiques sont organisées pour un accès facile et évitent la redondance

## 5.5. Principle of Least Surprise

_Principe de Moindre Surprise_

- Les composants sont là où les développeurs s'attendraient à les trouver
- Structures similaires pour les sections admin et public
- Implémentation standard du modèle MVC

## 5.6. Security by Design

_Sécurité par Conception_

- Code applicatif en dehors de la racine web
- Seul `/public/` est exposé aux requêtes web
- `.htaccess` pour des contrôles de sécurité supplémentaires

# 6. Frameworks correspondant à cette structure

## 6.1. Frameworks PHP

1. **Laravel** - Framework PHP populaire suivant une architecture MVC similaire avec app/Http/Controllers, app/Models et resources/views.

2. **Symfony** - Très utilisé pour les projets d'entreprise, avec src/Controller, config/ et templates/ suivant une organisation comparable.

3. **CodeIgniter** - Structure par défaut très similaire avec les dossiers app/controllers, app/models, app/views et une séparation claire des ressources publiques.

4. **Yii Framework** - Organisation comparable avec controllers/, models/, views/ et web/ pour les fichiers publics.

## 6.2. Framework JavaScript

1. **Express.js avec structure MVC** - Framework Node.js configurable pour adopter cette structure avec controllers/, models/ et views/.

2. **React**, **Vue.js** et **Angular** - Peuvent être organisés de manière similaire et intégrés dans une structure MVC avec un backend PHP.

La structure présentée illustre l'application de ces principes au développement web, créant une architecture qui favorise la maintenabilité, l'efficacité et la sécurité, tout en restant intuitive pour les nouveaux contributeurs.
