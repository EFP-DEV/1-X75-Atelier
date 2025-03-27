# Cahier des Charges Complet - Projet 1-X75-Atelier

# Table des Matières - Cahier des Charges 1-X75-Atelier

## 1. Présentation du Projet

### 1.1. Objectif
Créer un site web dynamique où le contenu peut être modifié facilement via une interface d'administration sécurisée, sans avoir à toucher au code HTML directement.

### 1.2. Objectifs d'apprentissage
* Comprendre la structure d'un projet web complet
* Maîtriser les bases de l'architecture MVC
* Expérimenter avec l'intégration frontend/backend
* Apprendre les bonnes pratiques de documentation
* Identifier les domaines qui nécessiteraient plus d'attention dans un environnement de production

### 1.3. Durée du projet
- Environ 80 heures au total (conception et réalisation).
- [Plan du projet](step_by_step.md)

---

## 2. Architecture Générale

### 2.1. Partie publique
Visible par tous les visiteurs:
- Page d'accueil présentant les contenus récents
- Page listant tous les contenus (articles, produits, etc.)
- Page détaillée pour chaque contenu
- Filtrage des contenus par catégories (tags, p.e. via un menu ou une sidebar)
- Fonction de recherche avancée (texte libre, par tag, etc., ordre de tri, nombre de résultats)
- Fonction de contact
- Système de favoris, panier, ou liste de souhaits
- Personnalisation de l'affichage (mode sombre, taille du texte)

### 2.2. Partie administration
Réservée aux gestionnaires du site:
- Page de connexion sécurisée (login)
- Tableau de bord
- Gestion complète des contenus (CRUD)
- Gestion des catégories (tags)
- Gestion des relations entre contenus et catégories
- Gestion des images associées aux contenus
- Consultation des messages reçus

### 2.3. Fonctionnalités
- [Liste des fonctionnalités à développer](duty_to_do.md)

## 3. Conception Visuelle

### 3.1. Éléments Visuels
- Palette de couleurs adaptée au thème choisi
- Version claire et sombre de chaque couleur
- Typographie lisible et cohérente
- Iconographie simple et reconnaissable

### 3.2. Wireframes
- Schémas structurels des pages principales
- Disposition des éléments d'interface
- Hiérarchie visuelle et flux de navigation
- Points d'interaction utilisateur

### 3.3. Composants d'Interface
- Système de grille cohérent
- Composants réutilisables (cartes, boutons, formulaires)
- Transitions et animations subtiles
- États interactifs clairement définis

---

## 4. Spécifications Techniques

### 4.1. Architecture Logicielle
- Pattern MVC (Modèle-Vue-Contrôleur)
- Séparation claire des responsabilités
- Organisation modulaire du code

### 4.2. Structure de la Base de Données
Le schéma de base de données comprend les tables suivantes:

1. **operator**: Administrateurs du site
2. **tag**: Système de catégorisation
3. **item**: Contenus principaux (articles ou produits ou ..)
4. **item_tag**: Relation entre contenus et catégories
5. **message**: Messages du formulaire de contact
6. **visitor**: Identification et préférences des visiteurs
7. **collection**: Collections d'items (favoris, etc.)
8. **collection_item**: Éléments dans les collections
9. **search**: Journalisation des recherches (optionnel)

### 4.3. Sécurité
- Protection contre les injections SQL (requêtes préparées)
- Validation des entrées utilisateur
- Échappement des sorties HTML (prévention XSS)
- Protection CSRF sur les formulaires
- Hashage sécurisé des mots de passe
- Gestion sécurisée des sessions

### 4.4. Performances et Optimisation
- Minimisation des requêtes SQL
- Utilisation appropriée des index de base de données
- Optimisation des images et ressources
- Chargement asynchrone des contenus non essentiels

### 4.5. Interface Utilisateur
- Design responsive (mobile-first)
- Interactions fluides avec JavaScript
- Feedback visuel pour les actions utilisateur
- Accessibilité de base (contraste, navigation clavier)
- Compatibilité multi-navigateurs

### 4.6. Stockage Local
- Utilisation de localStorage pour:
  - Le visitor_token
  - Les préférences d'affichage
  - Les identifiants des contenus favoris

## 5. Livrables Attendus

### 5.1. Code source complet
- Structure MVC organisée
- Commentaires pertinents
- Respect des conventions de nommage

### 5.2. Base de données
- Structure conforme au schéma fourni
- Jeu de données de démonstration

### 5.3. Documentation
- Guide d'installation
- Manuel utilisateur pour l'administration
- Documentation technique

### 5.4. Site fonctionnel
- Interface publique responsive
- Système d'administration opérationnel
- Toutes les fonctionnalités implémentées

## 6. Critères d'Évaluation

### 6.1. Fonctionnalités
- Implémentation complète des fonctionnalités requises
- Bon fonctionnement sur différents navigateurs et appareils
- Robustesse et gestion des erreurs

### 6.2. Qualité du Code
- Structure et organisation du code
- Bonnes pratiques de programmation
- Sécurité et optimisation

### 6.3. Interface Utilisateur
- Ergonomie et facilité d'utilisation
- Cohérence visuelle
- Adaptabilité aux différents appareils

### 6.4. Documentation et Présentation
- Clarté de la documentation
- Qualité de la présentation finale
- Respect des délais

## 7. Ressources Recommandées

### 7.1. Environnement de Développement
- [XAMPP](https://www.apachefriends.org/index.html)
- [Visual Studio Code](https://code.visualstudio.com/) ou autre éditeur de code
- [Git](https://git-scm.com/doc) pour la gestion de versions
- [GitHub Copilot](https://github.com/features/copilot) pour l'aide à la rédaction de code
- [Postman](https://www.postman.com/)
- [Figma](https://www.figma.com/)
- [phpMyAdmin](https://www.phpmyadmin.net/)
- [W3C Validator](https://validator.w3.org/)
- [WAVE Accessibility Tool](https://wave.webaim.org/)

### 7.2. Technologies à Utiliser
- [HTML5](https://developer.mozilla.org/fr/docs/Web/HTML), [CSS3](https://developer.mozilla.org/fr/docs/Web/CSS), [JavaScript](https://developer.mozilla.org/fr/docs/Web/JavaScript)
- [PHP](https://www.php.net/docs.php) (version 8.1 ou supérieure)
- [MySQL](https://dev.mysql.com/doc/) ou [MariaDB](https://mariadb.org/)
- [PDO](https://www.php.net/manual/fr/book.pdo.php) pour les requêtes de base de données

### 7.3. Librairies autorisées
- **Aucune sans accord préalable**
- [FontAwesome](https://fontawesome.com/docs/web/setup/quick), [Feather Icons](https://feathericons.com/), [Lucide](https://lucide.dev/), [Heroicons](https://heroicons.com/), [Phosphor Icons](https://phosphoricons.com/), [Iconoir](https://iconoir.com/), [Google Material Icons](https://fonts.google.com/icons)
- [Google Fonts](https://fonts.google.com/)

### 7.4. Documentation

#### 7.4.1. Backend
- [PHP Delusion PDO](https://phpdelusions.net/pdo)

#### 7.4.2. Frontend
- [Accessibilité Web](https://www.w3.org/WAI/WCAG21/quickref/)
- [Responsive Web Design](https://developer.mozilla.org/fr/docs/Learn/CSS/CSS_layout/Responsive_Design)
- [JavaScript Fetch API](https://developer.mozilla.org/fr/docs/Web/API/Fetch_API)
- [LocalStorage Documentation](https://developer.mozilla.org/fr/docs/Web/API/Window/localStorage)

#### 7.4.3. Full
- [Git Documentation](https://git-scm.com/doc)

## 8. Conseils et Bonnes Pratiques
- Commencez par une version minimale fonctionnelle puis enrichissez-la
- Testez régulièrement chaque fonctionnalité
- Utilisez Git pour suivre vos modifications et pouvoir revenir en arrière
- Privilégiez la qualité à la quantité de fonctionnalités
- N'hésitez pas à demander de l'aide à votre formateur
- Documentez votre code au fur et à mesure