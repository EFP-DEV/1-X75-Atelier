## Table des matières

1. [Accessibilité & compatibilité](#11-accessibilit%C3%A9--compatibilit%C3%A9)  
2. [Architecture de l’information et navigation](#2-architecture-de-linformation-et-navigation)  
   1. [Navigation par catégories](#21-navigation-par-catégories)  
   2. [Recherche](#22-recherche)  
3. [Conception UX/UI](#3-conception-uxui)  
   1. [Contrainte](#31-contrainte)  
   2. [Graphisme & interactivité](#32-graphisme--interactivit%C3%A9)  
4. [Affichage & gestion des contenus](#4-affichage--gestion-des-contenus)  
   1. [Page d’accueil dynamique](#41-page-daccueil-dynamique)  
   2. [Catalogue paginé](#42-catalogue-pagin%C3%A9)  
   3. [Page détaillée d’un item](#43-page-détaillée-dun-item)  
5. [Interactions & engagement](#5-interactions--engagement)  
   1. [Contact](#51-contact)  
   2. [Système de favoris](#52-système-de-favoris)  
6. [Personnalisation & identification](#6-personnalisation--identification)  
   1. [Personnalisation de l’interface](#61-personnalisation-de-linterface)  
   2. [Identification des visiteurs](#62-identification-des-visiteurs)  
7. [Performances & optimisation](#7-performances--optimisation)  

---

## 1. Accessibilité & compatibilité  
- Respect du WCAG 2.1  
- Polices et couleurs accessibles  
- Contraste suffisant texte/arrière‑plan  
- Support lecteurs d’écran (aria‑labels, rôles)  
- Navigation au clavier  
- Balises HTML sémantiques  
- Navigation intuitive et aide contextuelle  
- [Compatibilité avec navigateurs modernes](/more/browser_compatibility.md)  

---

## 2. Architecture de l’information et navigation

### 2.1 Navigation par catégories  
- Menu / sidebar listant les tags  
- Filtrage par tag  
- Système de « fil d’Ariane » (breadcrumbs)  
- URLs propres (slugs)  

### 2.2 Recherche  
- Recherche par mots‑clés (titres, descriptions, contenus)  
- Filtres avancés (tag, date)  
- Affichage clair des résultats (catalogue paginé)  
- Journalisation des requêtes (simple, mais optionnel) 

---

## 3. Conception UX/UI

### 3.1 Contrainte  
- Progressive enhancement  
- CSS intrinsèque ou responsive  
- Mobile‑First  
- Flexbox & CSS Grid pour la mise en page  
- Pas de [div soup](/more/div_soup.md)  
- Images [adaptatives](/more/images_adaptive.md)  

### 3.2 Graphisme & interactivité  
- SVG, PNG pour les icônes  
- Variables CSS pour la personnalisation  
- Animations CSS pour transitions agréables  

---

## 4. Affichage & gestion des contenus

### 4.1 Page d’accueil dynamique  
- Mise en avant des contenus récents / phares  
- Présentation visuelle attrayante  
- Liens vers pages détaillées  

### 4.2 Catalogue paginé  
- 10 items par page par défaut  
- Pagination claire et intuitive  
- Tri par date, popularité, etc.  
- Filtrage par tag/catégorie  

### 4.3 Page détaillée d’un item  
- Affichage des tags associés  

---

## 5. Interactions & engagement

### 5.1 Contact  
- Champs obligatoires : nom, email, sujet, message  
- Validation client et serveur  
- Anti‑spam  
- Notification de réception + confirmation visuelle  

### 5.2 Système de favoris  
- Marquage de contenus  
- Persistance via localStorage (visitor_token)  
- Interface de gestion des favoris  
- Suppression sans inscription  

---

## 6. Personnalisation & identification

### 6.1 Personnalisation de l’interface  
- Mode sombre / clair  
- Taille de texte ajustable  
- Sauvegarde des préférences (localStorage)  
- Application globale des réglages  

### 6.2 Identification des visiteurs  
- Stockage local des préférences/favoris  
- Option d’inscription / authentification  
- Respect de la vie privée  
- Persistance entre visites  

---

## 7. Performances & optimisation  
- Chargement conditionnel (lazy‑loading)  
- Minification CSS & JS  
- Hébergement local des libs externes  
- Optimisation des images (compression, formats modernes)  
- Mise en cache des ressources statiques  
- Audit performance (ex. Lighthouse)  
