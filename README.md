# Cahier des Charges Complet - Projet 1-X75-Atelier

## 1. Présentation du Projet

### Objectif
Créer un site web dynamique où le contenu peut être modifié facilement via une interface d'administration sécurisée, sans avoir à toucher au code HTML directement.


### Durée du projet
Environ 80 heures au total (conception et réalisation).

## 2. Architecture Générale

### 2.1 Structure du Site

Le site sera composé de deux grandes parties :

#### Partie publique
Visible par tous les visiteurs :
- Page d'accueil présentant les contenus récents
- Page listant tous les contenus (articles, produits, etc.)
- Page détaillée pour chaque contenu
- Filtrage des contenus par catégories (tags)
- Fonction de recherche avancée (texte libre, par tag, etc., ordre de tri, nombre de résultats)
- Fonction de contact avec formulaire
- Système de favoris, panier, ou liste de souhaits
- Personnalisation de l'affichage (mode sombre, taille du texte)

#### Partie administration
Réservée aux gestionnaires du site :
- Page de connexion sécurisée (login)
- Tableau de bord
- Gestion complète des contenus (CRUD)
- Gestion des catégories (tags)
- Gestion des relations entre contenus et catégories
- Gestion des images associées aux contenus
- Consultation des messages reçus

### 2.2 Structure de la Base de Données

Le schéma de base de données comprend les tables suivantes :

1. **operator**: Administrateurs du site
2. **tag**: Système de catégorisation
3. **item**: Contenus principaux (articles ou produits ou ..)
4. **item_tag**: Relation entre contenus et catégories
5. **message**: Messages du formulaire de contact
6. **visitor**: Identification et préférences des visiteurs
7. **collection**: Collections d'items (favoris, etc.)
8. **collection_item**: Éléments dans les collections
9. **search**: Journalisation des recherches (optionnel)

## 3. Fonctionnalités à Développer

### 3.1 Gestion des Contenus

#### Caractéristiques des contenus
- Chaque contenu (item) possède :
  - Un titre unique et un slug pour l'URL
  - Une description courte et un contenu détaillé
  - Une image principale (optionnelle)
  - Un prix (optionnel, selon le type de site)
  - Date de création et de dernière modification
  - Lien vers l'administrateur créateur

#### Fonctionnalités administrateur
- Créer de nouveaux contenus
- Modifier les contenus existants
- Supprimer des contenus
- Associer des tags (catégories) aux contenus
- Télécharger et gérer les images associées
- Visualiser l'historique des modifications

### 3.2 Système de Catégorisation

- Gestion des tags comme système principal de catégorisation
- Association multiple entre contenus et tags (many-to-many)
- Navigation par tags sur la partie publique
- Interface d'administration pour créer, modifier et supprimer des tags
- Génération automatique de slugs pour les URLs propres

### 3.3 Moteur de Recherche

- Recherche par mots-clés dans les titres, descriptions et contenus
- Filtres avancés (par tag, date, etc.)
- Affichage clair des résultats
- Journalisation des recherches pour analyses futures (optionnel)
- Suggestions de recherche basées sur les termes populaires

### 3.4 Formulaire de Contact

- Champs obligatoires : nom, email, sujet et message
- Validation côté client et serveur
- Protection anti-spam
- Notification aux administrateurs lors de nouveaux messages
- Interface d'administration pour consulter et marquer les messages comme lus

### 3.5 Système de Favoris

- Possibilité pour les visiteurs de marquer des contenus comme favoris
- Persistance des favoris via localStorage (visitor_token)
- Page dédiée pour consulter et gérer ses favoris
- Aucune inscription utilisateur requise

### 3.6 Personnalisation de l'Affichage

- Mode sombre/clair avec bascule
- Options de taille de texte (petit, moyen, grand)
- Sauvegarde des préférences utilisateur via localStorage
- Application des préférences sur l'ensemble du site

### 3.7 Identification des Visiteurs

- Génération d'un visitor_token unique pour chaque visiteur
- Stockage local des préférences et favoris
- Pas de système d'inscription ou d'authentification pour les visiteurs
- Protection de la vie privée (pas de tracking invasif)

### 3.8 Système d'Administration

- Authentification sécurisée (username/password)
- Hashage des mots de passe avec password_hash()
- Tableau de bord avec statistiques de base
- Gestion des sessions pour maintenir la connexion
- Protection contre les tentatives d'accès non autorisés

## 4. Spécifications Techniques

### 4.1 Architecture Logicielle

- Pattern MVC (Modèle-Vue-Contrôleur)
- Séparation claire des responsabilités
- Organisation modulaire du code

### 4.2 Sécurité

- Protection contre les injections SQL (requêtes préparées)
- Validation des entrées utilisateur
- Échappement des sorties HTML (prévention XSS)
- Protection CSRF sur les formulaires
- Hashage sécurisé des mots de passe
- Gestion sécurisée des sessions

### 4.3 Performances et Optimisation

- Minimisation des requêtes SQL
- Utilisation appropriée des index de base de données
- Optimisation des images et ressources
- Chargement asynchrone des contenus non essentiels

### 4.4 Interface Utilisateur

- Design responsive (mobile-first)
- Interactions fluides avec JavaScript
- Feedback visuel pour les actions utilisateur
- Accessibilité de base (contraste, navigation clavier)
- Compatibilité multi-navigateurs

### 4.5 Stockage Local

- Utilisation de localStorage pour :
  - Le visitor_token
  - Les préférences d'affichage
  - Les identifiants des contenus favoris

## 5. Charte Graphique

### 5.1 Éléments Visuels
- Palette de couleurs adaptée au thème choisi
- Version claire et sombre de chaque couleur
- Typographie lisible et cohérente
- Iconographie simple et reconnaissable

### 5.2 Composants d'Interface
- Système de grille cohérent
- Composants réutilisables (cartes, boutons, formulaires)
- Transitions et animations subtiles
- États interactifs clairement définis

## 6. Étapes de Développement Détaillées

### Phase 1 : Préparation et Configuration (16h)
- Définition du type de site et du thème
- Création des maquettes pour les pages principales
- Mise en place de l'environnement de développement
- Configuration de la base de données selon le schéma fourni
- Mise en place de la structure de fichiers (MVC)

### Phase 2 : Développement du Back-Office (16h)
- Création du système d'authentification administrateur
- Développement des fonctionnalités CRUD pour les contenus
- Implémentation de la gestion des tags
- Création de l'interface pour gérer les messages de contact

### Phase 3 : Développement de la Partie Publique (32h)
- Création des templates et composants communs
- Implémentation de l'affichage des contenus et de la navigation
- Développement du système de recherche
- Création du formulaire de contact
- Mise en place du système de visitor_token
- Développement des fonctionnalités de favoris et de préférences

### Phase 4 : Finalisation et Tests (16h)
- Tests fonctionnels sur tous les modules
- Optimisation des performances
- Correction des bugs et ajustements
- Préparation des jeux de données de démonstration
- Documentation du code et du projet

## 7. Livrables Attendus

1. **Code source complet**
   - Structure MVC organisée
   - Commentaires pertinents
   - Respect des conventions de nommage

2. **Base de données**
   - Structure conforme au schéma fourni
   - Jeu de données de démonstration

3. **Documentation**
   - Guide d'installation
   - Manuel utilisateur pour l'administration
   - Documentation technique

4. **Site fonctionnel**
   - Interface publique responsive
   - Système d'administration opérationnel
   - Toutes les fonctionnalités implémentées

## 8. Critères d'Évaluation

### 8.1 Fonctionnalités
- Implémentation complète des fonctionnalités requises
- Bon fonctionnement sur différents navigateurs et appareils
- Robustesse et gestion des erreurs

### 8.2 Qualité du Code
- Structure et organisation du code
- Bonnes pratiques de programmation
- Sécurité et optimisation

### 8.3 Interface Utilisateur 
- Ergonomie et facilité d'utilisation
- Cohérence visuelle
- Adaptabilité aux différents appareils

### 8.4 Documentation et Présentation
- Clarté de la documentation
- Qualité de la présentation finale
- Respect des délais

## 9. Ressources Recommandées

### 9.1 Environnement de Développement

- [XAMPP](https://www.apachefriends.org/index.html)
- [Visual Studio Code](https://code.visualstudio.com/) ou autre éditeur de code
- [Git](https://git-scm.com/doc) pour la gestion de versions
- [GitHub Copilot](https://github.com/features/copilot) pour l'aide à la rédaction de code
- [Postman](https://www.postman.com/)
- [Figma](https://www.figma.com/)
- [phpMyAdmin](https://www.phpmyadmin.net/)
- [W3C Validator](https://validator.w3.org/)
- [WAVE Accessibility Tool](https://wave.webaim.org/)

### 9.2 Technologies à Utiliser
Voici la liste complétée avec les liens pour les technologies à utiliser :

### 9.2 Technologies à Utiliser
- [HTML5](https://developer.mozilla.org/fr/docs/Web/HTML), [CSS3](https://developer.mozilla.org/fr/docs/Web/CSS), [JavaScript](https://developer.mozilla.org/fr/docs/Web/JavaScript)
- [PHP](https://www.php.net/docs.php) (version 8.1 ou supérieure)
- [MySQL](https://dev.mysql.com/doc/) ou [MariaDB](https://mariadb.org/)
- [PDO](https://www.php.net/manual/fr/book.pdo.php) pour les requêtes de base de données


### 9.3 Librairies autorisées
- **Aucune sans accord préalable**
- [FontAwesome Documentation](https://fontawesome.com/docs/web/setup/quick), [Feather Icons](https://feathericons.com/), [Lucide](https://lucide.dev/), [Heroicons](https://heroicons.com/),[Phosphor Icons](https://phosphoricons.com/), [Iconoir](https://iconoir.com/), [Google Material Icons](https://fonts.google.com/icons)

- [Google Fonts](https://fonts.google.com/)

### 9.4 Documentation
#### Backend
- [PHP Delusion PDO](https://phpdelusions.net/pdo)

#### Frontend

- [Accessibilité Web](https://www.w3.org/WAI/WCAG21/quickref/)
- [Responsive Web Design](https://developer.mozilla.org/fr/docs/Learn/CSS/CSS_layout/Responsive_Design)
- [JavaScript Fetch API](https://developer.mozilla.org/fr/docs/Web/API/Fetch_API)
- [LocalStorage Documentation](https://developer.mozilla.org/fr/docs/Web/API/Window/localStorage)

#### Full
- [Git Documentation](https://git-scm.com/doc)

## 10. Conseils et Bonnes Pratiques

- Commencez par une version minimale fonctionnelle puis enrichissez-la
- Testez régulièrement chaque fonctionnalité
- Utilisez Git pour suivre vos modifications et pouvoir revenir en arrière
- Privilégiez la qualité à la quantité de fonctionnalités
- N'hésitez pas à demander de l'aide à votre formateur
- Documentez votre code au fur et à mesure
