## Base de données et périmètre fonctionnel

Le projet repose sur une **base de données commune**, fournie par l’enseignant et réutilisée par l’ensemble des apprenants.

Cette base n’est pas à redéfinir librement. Elle a été construite dans le cadre du cours de base de données afin de garantir un socle cohérent pour la mise en œuvre du projet web. Elle couvre une grande partie des besoins fonctionnels d’un CMS simple : gestion de contenus, classification, utilisateurs, recherche, messages et collections personnalisées.

### Structure générale

La base s’organise autour de plusieurs entités principales :

- `item` : contenu éditorial principal du site ;
- `operator` : utilisateurs du site et administrateurs ;
- `theme` : thème principal d’un contenu ;
- `category` : catégorie principale d’un contenu ;
- `tag` : mots-clés libres associés aux contenus ;
- `collection` : regroupements personnalisés créés par les utilisateurs ;
- `message` : messages envoyés via le formulaire de contact.

### Règles principales garanties par la base

#### Contenus (`item`)
Chaque contenu doit respecter plusieurs contraintes :

- son **titre** doit être unique ;
- son **slug** doit être unique ;
- il possède un **statut clair** : brouillon, publié ou archivé ;
- il est rattaché à un **utilisateur créateur** ;
- il est obligatoirement lié à **un thème** et **une catégorie** ;
- il peut recevoir plusieurs **tags**, mais un même tag ne peut pas être associé deux fois au même contenu.

#### Utilisateurs (`operator`)
Les utilisateurs sont enregistrés dans une table unique.

- l’adresse e-mail doit être unique ;
- le mot de passe doit être stocké de manière sécurisée ;
- un utilisateur peut être actif ou désactivé ;
- les actions de gestion de contenu doivent pouvoir être rattachées à un utilisateur.

Cette structure signifie qu’un même `operator` peut être simple utilisateur ou administrateur selon les **permissions** mises en place dans le projet.

#### Thèmes et catégories
Les systèmes de classification sont imposés par la base.

- chaque thème possède un nom unique ;
- chaque catégorie possède un nom unique ;
- un contenu doit appartenir à un thème existant et à une catégorie existante ;
- un thème ou une catégorie ne peut pas être supprimé tant qu’il est encore utilisé par au moins un contenu.

#### Tags
Les tags servent à enrichir la description des contenus.

- chaque tag possède un nom unique ;
- un contenu peut recevoir plusieurs tags ;
- un même tag ne peut apparaître qu’une seule fois sur un même contenu ;
- un tag ne peut pas être supprimé s’il est encore utilisé, sauf nettoyage préalable.

#### Messages de contact
La base prévoit un enregistrement minimal des messages de contact.

- chaque message contient les informations envoyées : nom, e-mail, texte ;
- chaque message est daté ;
- chaque message possède un statut de lecture : lu ou non lu.

#### Collections utilisateurs
La base prévoit également un système de collections personnalisées.

- chaque collection appartient à un utilisateur ;
- une collection peut contenir plusieurs contenus ;
- un même contenu ne peut apparaître qu’une seule fois dans une même collection ;
- chaque collection est identifiable par un type, par exemple : favoris, panier, wishlist.

### Conséquences pour le projet

Les apprenants ne doivent pas inventer une nouvelle base de données.  
Ils doivent comprendre celle qui est fournie, la respecter, puis construire leur site à partir de ce cadre.

Le travail consiste donc à :

- exploiter correctement le modèle existant ;
- relier les données aux fonctionnalités du site ;
- organiser les pages, les formulaires et les interfaces à partir de cette structure ;
- mettre en place les permissions et les comportements attendus sans remettre en cause le socle de données imposé.

### Fonctionnalités minimales attendues

À partir de cette base, tout projet doit au minimum permettre :

- la consultation des contenus ;
- la recherche par catégorie ;
- la recherche par thème ;
- la recherche textuelle dans les contenus ;
- l’affichage ou l’utilisation des tags ;
- l’enregistrement des messages de contact ;
- la création et la gestion de collections personnalisées par les utilisateurs ;
- la différenciation des accès selon les permissions.
