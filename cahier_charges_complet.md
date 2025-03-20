# 1-X75-Atelier
# Cahier des Charges – Projet de Site Web Dynamique

## 1. Contexte et Objectifs Généraux

Le présent document définit les **exigences** pour la réalisation d'un **site web dynamique** dans le cadre du module **5.8.7 ADB** (Atelier de Développement, Fondamentaux).  

- **Contexte pédagogique** : ce projet s'inscrit dans une formation orientée développement web, sur une durée estimée à 80 heures.  
- **Objectif principal** : permettre aux apprenants de mettre en pratique l'**analyse** et la **conception** de sites, en réalisant un **projet fonctionnel**.

**Explication pour débutants** : Un site web dynamique est un site dont le contenu peut être modifié sans avoir à éditer directement le code HTML. Par exemple, un blog où vous pouvez ajouter des articles via une interface d'administration.

---

## 2. Périmètre du Projet

1. **Structure Générale du Site**  
   - **Pages publiques (visiteurs)** : ce sont les pages que n'importe quel visiteur peut voir.
     * Page d'accueil : première page que voit l'utilisateur
     * Liste d'items : affichage des produits/articles/ressources
     * Moteur de recherche : pour trouver rapidement un contenu
     * Page de contact : formulaire permettant aux visiteurs de vous contacter
   
   - **Interface d'administration (admin)** : partie privée du site, accessible uniquement avec un mot de passe.
     * Permet d'ajouter, modifier, et supprimer du contenu
     * Gestion des tags (étiquettes pour classer votre contenu)

2. **Base de Données**  
   - Version simplifiée pour ce module
   - Stocke toutes les informations de votre site (items, tags, utilisateurs)
   - **Remarque** : Vous n'aurez pas besoin de créer une base de données complexe pour ce projet

3. **Technologies à Utiliser**  
   - **Front-end** (ce que voit l'utilisateur) :
     * HTML : structure des pages
     * CSS : mise en forme et style
     * JavaScript : interactions comme le tri ou l'ajout aux favoris
   
   - **Back-end** (côté serveur) :
     * PHP : traitement des données et génération des pages web
     * MySQL : base de données (via phpMyAdmin pour une gestion simplifiée)

**Explication pour débutants** : Pensez à un site web comme à une maison. Le front-end est tout ce que les visiteurs peuvent voir et toucher (murs, portes, décoration). Le back-end est la plomberie, l'électricité et la structure cachée qui fait tout fonctionner.

---

## 3. Fonctionnalités Attendues

### 3.1. Gestion des Items (Produits/Articles/Ressources)

Un "item" peut être n'importe quel contenu principal de votre site, par exemple :
- Un produit dans une boutique en ligne
- Un article dans un blog
- Une ressource dans une bibliothèque numérique

**Pour l'administrateur**, vous devez permettre de :
- **C**réer : ajouter un nouvel item (formulaire avec titre, description, etc.)
- **R**ead (lire) : consulter la liste des items existants
- **U**pdate (mettre à jour) : modifier un item existant
- **D**elete (supprimer) : retirer un item du site

**Concrètement** : Créez un formulaire pour ajouter/modifier des items et une page affichant la liste des items avec des boutons "Modifier" et "Supprimer".

### 3.2. Système de Tags (Étiquettes)

Les tags permettent de catégoriser vos items :
- Chaque item peut avoir plusieurs tags (ex: "Vêtements", "Femme", "Été")
- Les visiteurs peuvent cliquer sur un tag pour voir tous les items associés

**Implémentation** :
- Table dans la base de données pour stocker les tags
- Interface pour créer/modifier/supprimer les tags
- Possibilité d'associer des tags lors de la création/modification d'un item

### 3.3. Moteur de Recherche

**Fonctionnalités minimales** :
- Recherche par mot-clé dans le titre et la description des items
- Possibilité de filtrer par tag
- Affichage des résultats sans rechargement complet de la page

**Principe de fonctionnement** :
La recherche consiste à interroger la base de données pour trouver des correspondances entre les mots-clés saisis par l'utilisateur et le contenu des items (titre, description, etc.).

### 3.4. Formulaire de Contact

**Éléments requis** :
- Champs : nom, email, sujet, message
- Validation des données (email valide, champs requis)
- Envoi du message par email ou stockage en base de données

**Astuce débutant** : Pour un projet d'apprentissage, vous pouvez simplement stocker les messages dans votre base de données. L'envoi d'emails réels nécessite une configuration supplémentaire du serveur.

### 3.5. Listes Temporaires (Wishlist, Panier, Favoris)

**Principe** : Permettre aux visiteurs de sauvegarder temporairement des items qui les intéressent, sans avoir à créer un compte.

**Fonctionnalités** :
- Bouton "Ajouter aux favoris" sur chaque item
- Page ou popup affichant les items sauvegardés
- Possibilité de retirer un item de la liste

**Principe technique** :
Le navigateur dispose d'une fonctionnalité appelée "localStorage" qui permet de stocker des données sur l'appareil de l'utilisateur. Vous l'utiliserez pour sauvegarder les items que l'utilisateur ajoute à ses favoris, même après qu'il ait fermé son navigateur ou éteint son ordinateur.

### 3.6. Mode Sombre et Ajustement de la Taille de Police

**Mode sombre** :
- Bouton pour basculer entre thème clair et sombre
- Les couleurs doivent s'adapter automatiquement

**Ajustement de la taille de police** :
- Boutons A- et A+ pour réduire ou augmenter la taille du texte
- Sauvegarder les préférences de l'utilisateur

**Astuce** : Utilisez une classe CSS pour le mode sombre et JavaScript pour changer la taille de police.

### 3.7. Tri en JavaScript

Permettre aux visiteurs de réorganiser la liste des items sans recharger la page :
- Tri par titre (A-Z, Z-A)
- Tri par date (plus récent, plus ancien)
- Tri par prix (si applicable)

**Explication du processus** :
Lorsque l'utilisateur clique sur un bouton de tri, le JavaScript récupère tous les éléments affichés sur la page, les réorganise selon le critère choisi (titre, date, prix), puis modifie l'affichage sans avoir à recharger la page entière.

### 3.8. Authentification de l'Administrateur

**Système simple** :
- Formulaire de login (identifiant + mot de passe)
- Vérification des identifiants
- Création d'une session PHP pour maintenir la connexion

**Principe** :
Le système vérifie si l'identifiant et le mot de passe saisis correspondent à ceux stockés dans la base de données. Si oui, il crée une "session" qui permet à l'administrateur de naviguer entre les pages d'administration sans avoir à se reconnecter à chaque fois.

**Sécurité minimale** :
- Ne jamais stocker les mots de passe en clair dans la base de données
- Utiliser la fonction `password_hash()` pour hasher les mots de passe
- Protéger toutes les pages d'administration en vérifiant la session

---

## 4. Étapes Pratiques pour les Débutants

### 4.1. Première étape : Structure et maquettes

1. **Créez un dossier de projet** avec cette structure :
   ```
   mon_projet/
   ├── css/
   │   ├── style.css
   │   └── dark-mode.css
   ├── js/
   │   ├── search.js
   │   ├── favorites.js
   │   └── darkmode.js
   ├── admin/
   │   ├── index.php (login)
   │   ├── dashboard.php
   │   ├── items.php (CRUD)
   │   └── tags.php
   ├── includes/
   │   ├── header.php
   │   ├── footer.php
   │   └── db_connect.php
   ├── index.php
   ├── items.php
   ├── search.php
   └── contact.php
   ```

2. **Dessinez des wireframes** (croquis simples) pour chaque page principale

### 4.2. Deuxième étape : Comprendre et configurer la base de données

La base de données est le "cerveau" de votre application web. Elle stocke toutes les informations de manière organisée. Pour ce projet, vous aurez besoin de comprendre et créer plusieurs tables :

#### 1. Table `items` 
Cette table stockera les éléments principaux de votre site (produits, articles, etc.) :
- **id** : identifiant unique pour chaque item (numéro auto-incrémenté)
- **titre** : le nom ou titre de l'item (texte)
- **description** : description détaillée de l'item (texte long)
- **date_creation** : date à laquelle l'item a été ajouté (date/heure)
- **image** : chemin vers une image illustrant l'item (optionnel)
- **prix** : montant en euros si applicable (optionnel)
- **stock** : quantité disponible si applicable (optionnel)

#### 2. Table `tags`
Cette table contient les différentes catégories ou étiquettes que vous pouvez attribuer aux items :
- **id** : identifiant unique pour chaque tag
- **nom** : nom du tag (ex: "Vêtements", "Électronique", "Tutoriel")
- **description** : brève explication du tag (optionnel)

#### 3. Table `items_tags` (table de relation)
Cette table spéciale établit les liens entre items et tags. Elle permet d'associer plusieurs tags à un item et vice-versa :
- **item_id** : référence à un item spécifique
- **tag_id** : référence à un tag spécifique

La combinaison de ces deux colonnes forme une "clé primaire composée" qui garantit qu'un tag ne peut être associé qu'une seule fois à un item donné.

#### 4. Table `users`
Stocke les informations des administrateurs autorisés à gérer le site :
- **id** : identifiant unique pour chaque utilisateur
- **username** : nom d'utilisateur pour la connexion
- **password_hash** : mot de passe crypté (jamais en texte clair !)
- **email** : adresse email de l'administrateur
- **role** : niveau d'accès (ex: "admin", "editor")
- **date_creation** : date de création du compte

#### 5. Table `messages` (optionnelle)
Si vous choisissez de stocker les messages du formulaire de contact :
- **id** : identifiant unique pour chaque message
- **nom** : nom de l'expéditeur
- **email** : email de l'expéditeur
- **sujet** : sujet du message
- **contenu** : texte du message
- **date_envoi** : date et heure de réception
- **lu** : statut de lecture (0 = non lu, 1 = lu)

#### Relations entre les tables

Le schéma relationnel ressemblera à ceci :
- Un **item** peut avoir plusieurs **tags** (relation many-to-many via items_tags)
- Un **tag** peut être associé à plusieurs **items** (relation many-to-many via items_tags)
- Un **utilisateur** (admin) peut gérer tous les **items** et **tags**

Ce type de structure relationnelle est fondamental dans les bases de données et vous permettra de faire des requêtes complexes comme "trouver tous les items associés au tag 'Été'" ou "compter combien d'items sont dans chaque catégorie".

2. **Structure des tables de base** :
   Votre formateur vous aidera à créer les tables nécessaires dans phpMyAdmin.

### 4.3. Troisième étape : Développement progressif

1. **Commencez par les pages statiques** (HTML/CSS)
2. **Ajoutez la connexion à la base de données**
3. **Implémentez les fonctionnalités une par une** dans cet ordre :
   - Affichage de la liste des items
   - Création du formulaire d'ajout d'item (admin)
   - Moteur de recherche basique
   - Système de tags
   - Listes temporaires (favoris)
   - Mode sombre et ajustement de la taille
   - Tri en JavaScript

---

## 5. Ressources pour Débutants

### 5.1. Tutoriels recommandés

- **HTML/CSS** : MDN Web Docs (Mozilla Developer Network)
- **PHP** : W3Schools ou PHP.net
- **JavaScript** : JavaScript.info
- **MySQL** : SQLBolt (pour apprendre les requêtes SQL de base)

### 5.2. Outils utiles

- **Visual Studio Code** : éditeur de code gratuit
- **XAMPP** : package incluant Apache, MySQL, PHP (pour développer en local)
- **Git** : pour le versionnage du code
- **Bootstrap** (optionnel) : framework CSS pour accélérer le développement

### 5.3. Structure des fichiers principaux

#### Fichiers d'inclusion
- **header.php** : contient l'en-tête HTML, les liens CSS et le menu de navigation
- **footer.php** : contient le pied de page et les liens JavaScript
- **db_connect.php** : établit la connexion avec la base de données

#### Pages principales
- **index.php** : page d'accueil avec la liste des items récents
- **items.php** : affichage détaillé d'un item spécifique
- **search.php** : gestion du moteur de recherche
- **contact.php** : formulaire de contact

#### Section d'administration
- **admin/index.php** : page de connexion admin
- **admin/dashboard.php** : tableau de bord après connexion
- **admin/items.php** : gestion des items (ajout, modification, suppression)
- **admin/tags.php** : gestion des tags

---

## 6. Critères d'Évaluation Simplifiés

Votre projet sera considéré comme réussi s'il remplit ces critères :

1. **Site fonctionnel** : navigation fluide, pas d'erreurs visibles
2. **CRUD opérationnel** : possibilité d'ajouter, modifier et supprimer des items
3. **Fonctionnalités principales** implémentées :
   - Système de tags
   - Moteur de recherche
   - Liste temporaire (favoris)
   - Mode sombre
4. **Interface responsive** : adaptation aux différentes tailles d'écran
5. **Code propre et commenté** : organisation claire des fichiers, commentaires explicatifs

---

## 7. Conseils pour Réussir

1. **Planifiez avant de coder** : prenez le temps de bien comprendre le projet
2. **Avancez progressivement** : implémentez une fonctionnalité à la fois
3. **Testez régulièrement** : vérifiez chaque nouvelle fonction
4. **N'hésitez pas à demander de l'aide** quand vous êtes bloqué
5. **Documentez votre code** avec des commentaires
6. **Gardez le design simple** au début, améliorez-le progressivement

N'oubliez pas : ce projet est un apprentissage, les erreurs font partie du processus !
