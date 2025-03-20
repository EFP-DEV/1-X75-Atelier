Voici une version enrichie du cahier des charges, intégrant des éléments sur l’ergonomie, l’accessibilité, la sécurité, les tests, les performances, la gestion de projet et les livrables.

---

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
- **R**ead : consulter la liste des items existants  
- **U**pdate : modifier un item existant  
- **D**elete : retirer un item du site  

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
