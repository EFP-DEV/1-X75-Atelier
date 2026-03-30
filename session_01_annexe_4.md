# Annexe 4 — Distinguer objectifs, fonctionnalités, pages et contenus

Cette annexe sert à éviter une confusion très fréquente dans les projets web : mélanger ce que le site doit permettre, ce qu’il doit contenir, les pages qu’il doit proposer, et les éléments techniques qui serviront à le faire fonctionner.

Dans un vrai projet, cette confusion pose rapidement problème.
Elle produit des documents flous, des discussions imprécises, des wireframes incohérents et, ensuite, des développements mal cadrés.

Le but ici est donc simple : apprendre à distinguer clairement plusieurs niveaux de réflexion, pour pouvoir prendre de bonnes décisions et décrire le projet de manière exploitable.

---

## Pourquoi cette distinction est importante

Quand un projet est encore au stade du cadrage, on entend souvent des formulations comme :

* “le site aura une page catalogue”
* “le site sert à vendre”
* “il faudra un formulaire”
* “on mettra des produits”
* “l’utilisateur doit pouvoir chercher”
* “il faut un back-office”

Toutes ces phrases peuvent être justes.
Mais elles ne parlent pas de la même chose.

Certaines parlent du but du site.
D’autres parlent d’une action possible.
D’autres encore parlent d’une page, d’un type de contenu, ou d’un moyen technique.

Si on mélange tout, on ne sait plus :

* ce que le site cherche réellement à permettre
* ce que l’utilisateur pourra faire
* quelles pages sont nécessaires
* quelles données devront exister
* ce qui relève d’un besoin métier et ce qui relève d’une solution

Dans la réalité du métier, cette distinction permet de mieux communiquer entre les différentes personnes impliquées dans le projet :
client, chef de projet, UX, designer, intégrateur, développeur.

---

## Les 4 notions à distinguer

### 1. Objectif

Un objectif décrit ce que le site doit permettre de faire ou d’obtenir, du point de vue du projet.

L’objectif répond à une question comme :

**à quoi sert le site ?**

Exemples d’objectifs :

* informer sur les activités d’une association
* présenter les services d’un professionnel
* permettre la consultation d’un catalogue
* faciliter une prise de contact
* permettre la gestion de contenus
* rendre certaines informations accessibles rapidement

Un objectif n’est pas une page.
Un objectif n’est pas non plus un élément graphique ou technique.

Un objectif reste général, mais il doit être clair et utile.

---

### 2. Fonctionnalité

Une fonctionnalité désigne une action ou un mécanisme concret que le site met à disposition pour répondre à un objectif.

La fonctionnalité répond à une question comme :

**qu’est-ce que l’utilisateur ou l’administrateur pourra faire ?**

Exemples de fonctionnalités :

* consulter une liste de produits
* filtrer un catalogue
* rechercher un article
* envoyer un message via un formulaire
* se connecter à un espace d’administration
* ajouter, modifier ou supprimer un contenu
* afficher un détail complet à partir d’une liste

Une fonctionnalité est plus concrète qu’un objectif.
Elle décrit une capacité du site.

---

### 3. Page

Une page est un écran ou un emplacement identifiable dans la structure du site.

La page répond à une question comme :

**où cette information ou cette action apparaît-elle ?**

Exemples de pages :

* page d’accueil
* page catalogue
* page détail produit
* page contact
* page de connexion
* tableau de bord administrateur
* page de gestion des articles

Une page n’est pas un objectif.
Une page n’est pas non plus une fonctionnalité en elle-même, même si elle peut contenir plusieurs fonctionnalités.

---

### 4. Contenu

Le contenu correspond aux informations concrètes affichées ou manipulées dans le site.

Le contenu répond à une question comme :

**qu’est-ce qu’on montre, lit, saisit ou enregistre ?**

Exemples de contenus :

* titre
* image
* texte descriptif
* prix
* date
* catégorie
* horaires
* adresse
* témoignage
* article
* fiche produit
* message envoyé via formulaire

Le contenu est ce qui remplit les pages.
Il peut être statique ou dynamique.
Il peut être visible côté public ou géré côté administration.

---

## Exemple simple complet

Prenons un projet de site pour un petit restaurant.

### Objectifs

* présenter le restaurant
* permettre au visiteur de consulter les informations utiles
* faciliter la prise de contact

### Fonctionnalités

* consulter la carte
* voir les horaires
* afficher les coordonnées
* envoyer un message via un formulaire
* gérer les plats depuis une administration simple

### Pages

* accueil
* menu / carte
* contact
* connexion administrateur
* gestion des plats

### Contenus

* nom du restaurant
* description
* photos
* plats
* prix
* horaires
* adresse
* numéro de téléphone
* messages envoyés

On voit bien ici que chaque niveau a son rôle.
Tout est lié, mais tout n’est pas au même niveau.

---

## Exemple avec un projet de catalogue

Prenons un projet de catalogue de jeux éducatifs.

### Objectifs

* présenter une sélection de produits
* aider l’utilisateur à trouver un jeu adapté
* permettre l’administration des produits

### Fonctionnalités

* parcourir un listing
* filtrer par catégorie
* consulter une fiche détaillée
* ajouter un produit dans l’administration
* modifier ou supprimer un produit

### Pages

* accueil
* catalogue
* fiche produit
* connexion
* tableau de bord
* gestion des produits

### Contenus

* nom du produit
* image
* résumé
* description complète
* âge conseillé
* catégorie
* stock éventuel
* statut de publication

---

## Ce qu’il ne faut pas confondre

Voici quelques confusions fréquentes.

### Confusion 1 : prendre une page pour un objectif

Exemple :

* “objectif : page contact”

Ce n’est pas un objectif.
La page contact est une page.
L’objectif serait plutôt :

* permettre une prise de contact simple

---

### Confusion 2 : prendre un contenu pour une fonctionnalité

Exemple :

* “fonctionnalité : produits”

Les produits ne sont pas une fonctionnalité.
Ce sont des contenus.
Les fonctionnalités seraient par exemple :

* consulter les produits
* filtrer les produits
* gérer les produits

---

### Confusion 3 : prendre une fonctionnalité pour une page

Exemple :

* “page : rechercher”

La recherche n’est pas forcément une page.
C’est souvent une fonctionnalité intégrée à une ou plusieurs pages.

---

### Confusion 4 : prendre une solution technique pour un objectif

Exemple :

* “objectif : avoir une base de données”

Ce n’est pas un objectif de site.
C’est un moyen technique.
L’objectif serait plutôt :

* permettre l’affichage dynamique et la gestion des contenus

---

## Méthode simple pour bien distinguer

Quand vous rédigez votre cadrage, posez-vous ces 4 questions dans cet ordre :

### 1. Quel est le but du site ?

Cela donne les objectifs.

### 2. Qu’est-ce qu’on doit pouvoir faire sur ce site ?

Cela donne les fonctionnalités.

### 3. Quelles pages sont nécessaires pour porter cela ?

Cela donne les pages.

### 4. Quelles informations devront apparaître ou être gérées ?

Cela donne les contenus.

Si vous respectez cet ordre, vous éviterez beaucoup de flou.

---

## Formulation attendue

On attend des formulations simples, précises et directement exploitables.

Par exemple :

### Mauvais

* objectif : catalogue
* fonctionnalité : accueil
* page : produits
* contenu : filtre

Tout est mélangé.

### Mieux

* objectif : permettre au visiteur de consulter une offre de produits
* fonctionnalité : parcourir un listing et consulter une fiche détaillée
* pages : accueil, catalogue, fiche produit, contact
* contenus : nom, image, description, catégorie, prix

---

## Critères de qualité

Votre travail est clair si :

* les objectifs décrivent le rôle du site
* les fonctionnalités décrivent des actions possibles
* les pages décrivent la structure visible du projet
* les contenus décrivent les informations présentes ou gérées
* chaque élément est placé au bon niveau
* on ne mélange pas besoin, écran, donnée et solution technique

Si, en relisant votre document, vous ne savez plus ce qui relève de quoi, c’est qu’il faut reformuler.

---

## Erreurs fréquentes à éviter

Évitez :

* de faire une seule liste mélangeant tout
* de noter des mots isolés sans préciser leur rôle
* d’écrire des objectifs trop vagues
* de transformer chaque fonctionnalité en page
* d’oublier les contenus concrets
* de confondre besoin utilisateur et choix technique

---

## Ce que cette distinction permet pour la suite

Si ce travail est bien fait, il facilitera directement :

* la définition du périmètre du projet
* la création de l’arborescence
* la préparation des wireframes
* l’identification des données à prévoir
* la réflexion sur l’administration
* la cohérence générale du projet

Autrement dit, ce n’est pas un exercice “de vocabulaire”.
C’est une base de travail pour produire la suite correctement.

