# Session 1 — Cadrage du projet

## Contexte

C'est le dernier cours de l'année. Tout ce que vous avez appris — HTML, CSS, JavaScript, PHP, SQL — converge ici dans un seul projet : un site web dynamique avec interface d'administration.

Avant d'écrire une seule ligne de code, vous allez définir **ce que** vous construisez et **pour qui**.

## Livrables de cette session

1. **Document de spécifications** (1–2 pages)
2. **3 fiches personas**
3. **Analyse concurrentielle** (2 sites minimum)
4. **Sitemap**
5. **Wireframes** des pages principales

Tous les livrables sont à remettre dans votre repository Git, dans le dossier `doc/`.

---

# 1. Définition du projet (1h)

## 1.1 Choisir un thème

Votre site est un **système de gestion de contenu**. Le contenu peut être ce que vous voulez : articles de blog, fiches produits, recettes, portfolios, annonces, fiches de jeux, etc.

Choisissez un thème qui vous motive. Vous allez vivre avec pendant 4 semaines.

## 1.2 Rédiger les spécifications

Votre document doit répondre à ces questions :

* Quel est l'objectif principal du site ?
* Qui sont les utilisateurs cibles ?
* Quelles actions un visiteur doit-il pouvoir réaliser ?
* Quelles actions un administrateur doit-il pouvoir réaliser ?

Soyez concis. Un paragraphe par question suffit.

## 1.3 Créer 3 personas

Pour chaque persona :

* Prénom, âge, profession
* Objectif principal sur le site
* Contexte d'utilisation (mobile ? desktop ? temps limité ?)
* Une contrainte ou frustration spécifique

```
Exemple :
Nom : Karim D.
Âge : 28 ans
Profession : Graphiste freelance
Objectif : Trouver rapidement des inspirations classées par style
Contexte : Consulte sur mobile entre deux rendez-vous clients
Contrainte : Peu de patience pour les interfaces lentes ou confuses
```

## 1.4 Analyse concurrentielle

Identifiez **2 sites existants** qui font quelque chose de similaire à votre projet.

Pour chaque site, relevez :

* Points forts de l'interface
* Points faibles ou manques
* Structure de navigation (combien de niveaux ?)
* Technologies visibles (outils de dev du navigateur)
* Score Lighthouse (Performance, Accessibilité)

Le but n'est pas de copier. C'est de comprendre ce qui fonctionne et ce qui ne fonctionne pas dans votre domaine.

---

# 2. Architecture de l'information (30 min)

## 2.1 Sitemap

Dessinez la hiérarchie des pages de votre site. Toutes les pages, publiques et admin.

Le sitemap doit inclure au minimum :

**Pages publiques :**
* Accueil
* Catalogue (liste des items)
* Détail d'un item
* Recherche
* Contact
* Collections utilisateur

**Pages admin :**
* Login
* Dashboard
* CRUD items
* CRUD tags
* Messages
* Paramètres

Référence : [urls_example.md](urls_example.md) pour la liste complète des routes attendues.

## 2.2 Système de tags

Avant de dessiner vos wireframes, définissez votre taxonomie :

* **3 thèmes** (grandes orientations éditoriales)
* **2 catégories** par thème
* **8 tags libres** (mots-clés transversaux)

Référence : [more/tag-theme-category.md](more/tag-theme-category.md)

---

# 3. Wireframes (2h30)

## 3.1 Pages à wireframer

Produisez des wireframes pour les pages suivantes :

* **Accueil**
* **Catalogue** (avec filtres et cartes)
* **Détail item**
* **Admin dashboard**
* **Admin formulaire** (création/édition d'item)

## 3.2 Formats requis

Pour chaque page publique, au minimum :

* **Mobile** (≤ 320px)
* **Tablet** (≤ 768px)
* **Desktop** (≥ 1024px)

Pour les pages admin, le desktop suffit.

## 3.3 Ce que le wireframe doit montrer

* La structure générale de la page
* La hiérarchie des contenus
* Les zones de navigation
* Les blocs principaux (header, main, aside, footer)
* Les éléments interactifs (boutons, champs, filtres)

## 3.4 Ce que le wireframe ne doit PAS montrer

* Des couleurs
* Des polices décoratives
* Des images réelles
* Du contenu définitif

Un wireframe est un squelette. Papier, crayon, tableau blanc — ce sont les meilleurs outils à ce stade.

Référence : [more/wireframe.md](more/wireframe.md)

---

# 4. Environnement de développement

Avant la prochaine session, vous devez avoir :

* Un serveur local fonctionnel (LAMP/MAMP/WAMP), PHP ≥ 8.2, MySQL ≥ 8
* Un repository Git initialisé


Rédigez un README contenant :

* Nom du projet et description en une phrase
* Instructions d'installation (prérequis, base de données, configuration)

## 4.4 Envoi du repository

Envoyez le lien de votre repository par mail à **ate@amstram.be** avant la prochaine session.

---


# Références

* [README.md](README.md) — Présentation complète du projet
* [more/step_by_step.md](more/step_by_step.md) — Planning détaillé par phase
* [more/wireframe.md](more/wireframe.md) — Méthodologie wireframe
* [urls_example.md](urls_example.md) — Liste des URLs frontend et admin
* [exo-ux-ui-design.md](exo-ux-ui-design.md) — Exercice UX/UI complet
* [checklist.md](checklist.md) — Checklist finale du projet
