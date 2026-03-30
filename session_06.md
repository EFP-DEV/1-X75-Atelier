# Session 6 — Atelier
Durée : **4h**

Cette séance marque le passage entre le site statique en HTML et la future mise en place du backend PHP.  
Avant de rendre les pages dynamiques, il faut définir **comment le site sera organisé** : quelles seront ses URL, comment les pages seront réparties dans les dossiers, et quelle structure générale sera utilisée pour préparer le router et l’architecture MVC du projet.

Le but de cette séance n’est pas encore d’implémenter toute la logique PHP.  
Le but est de **cartographier le site** et de préparer une base architecturale claire.

---

## Livrables

Vous devez rendre **quatre éléments** :

1. **Un tableau des URL du site**
2. **Une proposition de structure de dossiers**
3. **Un mapping entre pages, routes, vues et contrôleurs**
4. **Une mise à jour du `README.md`** avec l’organisation du projet

---

## Objectif de la séance

À la fin de cette séance, vous devez être capables d’expliquer clairement :

- quelles URL existent dans votre projet
- quelles URL relèvent du site public
- quelles URL relèvent de l’administration
- quelles pages HTML existantes correspondent à ces URL
- comment vous allez organiser votre projet dans une structure de type MVC
- où se situeront les vues, les contrôleurs, les modèles, les assets et les fichiers publics

L’objectif est de préparer proprement la transition vers le backend PHP, sans improviser la structure au moment de coder.

---

# 1. Définition des URL du site

Vous devez établir la liste des URL principales du projet.

Cette liste doit inclure :

## Côté public
- la page d’accueil
- la page de catalogue ou de listing
- la page de détail
- toute autre page publique essentielle déjà prévue

## Côté administration
- la page de connexion
- le tableau de bord
- la page de liste de gestion
- la page de création
- la page de modification
- toute autre page admin essentielle déjà identifiée

---

## Attendus pour les URL

Pour chaque URL, vous devez préciser :

- le chemin
- son rôle
- si elle appartient au **front** ou à l’**admin**
- si elle correspond à une page statique simple, une page dynamique, un formulaire ou une action

Exemples de logique attendue :

- `/`
- `/catalog`
- `/item`
- `/item/{slug}` ou `/item/{id}`
- `/admin`
- `/admin/login`
- `/admin/items`
- `/admin/items/create`
- `/admin/items/edit`

Le but n’est pas d’avoir déjà une syntaxe technique parfaite, mais d’avoir une logique de navigation propre, cohérente et exploitable.

---

# 2. Structure de dossiers du projet

Vous devez proposer une arborescence claire pour organiser votre futur projet.

Cette structure doit permettre de distinguer au minimum :

- les fichiers publics
- les assets
- les vues
- les contrôleurs
- les modèles
- les éventuels fichiers de configuration ou de base

---

## Attendus pour la structure

Votre arborescence doit être compréhensible et cohérente avec un projet MVC simple.

Exemple de structure possible :

- `public/`
- `public/assets/`
- `app/`
- `app/views/`
- `app/controllers/`
- `app/models/`
- `app/config/`

Vous pouvez proposer une variante plus simple ou plus adaptée à votre projet, à condition qu’elle reste claire.

---

# 3. Mapping page → route → contrôleur → vue

Vous devez produire un tableau simple permettant de faire le lien entre :

- la page ou fonctionnalité
- l’URL
- le contrôleur pressenti
- la vue associée
- les données principales à afficher ou manipuler

---

## Exemple de logique attendue

| Page / Fonction | URL | Contrôleur | Vue | Données |
|----------------|-----|------------|-----|---------|
| Accueil | `/` | `HomeController` | `home.php` | contenus mis en avant |
| Catalogue | `/catalog` | `CatalogController` | `catalog.php` | liste d’items |
| Détail item | `/item/{id}` | `ItemController` | `item.php` | item sélectionné |
| Login admin | `/admin/login` | `AdminAuthController` | `login.php` | formulaire |
| Liste admin | `/admin/items` | `AdminItemController` | `admin-items.php` | liste d’items |

Le nom exact des contrôleurs n’est pas imposé, mais la logique doit être claire.

---

# 4. Distinction entre front et administration

Votre travail doit montrer clairement la séparation entre :

- les pages destinées au visiteur
- les pages destinées à l’administrateur

Cette distinction doit apparaître :

- dans les URL
- dans la structure des dossiers si pertinent
- dans le mapping des routes
- dans votre manière de penser le projet

L’administration ne doit pas être un “ajout flou plus tard”.  
Elle doit déjà être située dans l’architecture du site.

---

# Attendus techniques

Votre travail doit notamment :

- proposer des URL cohérentes et lisibles
- éviter les noms ambigus ou incohérents
- distinguer clairement le front et l’admin
- prévoir une structure de projet réutilisable en PHP
- faire le lien entre les pages HTML déjà produites et leur futur rôle dans l’application
- préparer le terrain pour la création d’un router simple
- rester compréhensible pour une autre personne qui reprendrait le projet

---

# Critères de validation

La séance est considérée comme réussie si :

- les URL principales du projet sont définies
- les zones front et admin sont clairement distinguées
- une structure de dossiers cohérente est proposée
- un mapping route / contrôleur / vue existe
- le projet peut maintenant être transformé en application PHP sans improvisation majeure
- le `README.md` commence à refléter cette organisation

---

# Récapitulatif du rendu

Vous devez fournir :

## Livrable 1 — Tableau des URL
Un tableau clair listant les routes principales du projet.

## Livrable 2 — Arborescence du projet
Une proposition de structure de dossiers pour organiser le code.

## Livrable 3 — Mapping architectural
Un tableau reliant pages, routes, contrôleurs, vues et données.

## Livrable 4 — README mis à jour
Le `README.md` doit désormais inclure une section expliquant l’organisation générale du projet.

---

# Objectif de l’atelier

Cet atelier vise à :

- préparer le passage du HTML statique au projet dynamique
- définir une logique d’URL claire
- poser les bases d’un router futur
- structurer le projet avant d’écrire la logique PHP
- introduire concrètement la pensée MVC à partir d’un projet déjà visible

---

# Checklist de fin de séance

Avant de quitter la séance, vérifiez que vous avez bien :

- listé les URL principales du site
- distingué clairement front et admin
- défini les routes essentielles du projet
- proposé une arborescence de dossiers claire
- associé les pages à des vues et contrôleurs pressentis
- relié votre architecture aux pages HTML déjà produites
- mis à jour le `README.md`
- préparé une base exploitable pour la future création du router

---

# Transition vers la séance suivante

La séance suivante pourra s’appuyer sur ce travail pour commencer à :

- transformer les pages HTML en vues réutilisables
- factoriser les éléments communs
- préparer les includes ou layouts
- commencer l’intégration PHP dans une structure organisée

Autrement dit :

**Session 6 : organiser le site**  
**Session 7 : commencer à transformer la structure HTML en architecture PHP exploitable**

