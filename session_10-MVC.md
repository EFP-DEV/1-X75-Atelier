# Session 10 — URL, MVC & organisation minimale d’un projet PHP

**Durée : 4h environ · Niveau : bases PHP acquises**

---

## Objectifs de la séance

À la fin de cette séance, l’étudiant sait :

* expliquer pourquoi on sépare les responsabilités dans un projet
* faire le lien entre HTML / CSS / JS côté frontend et Model / View / Controller côté backend
* découper une URL en trois informations : `entity`, `action`, `id`
* encapsuler le parsing d’URL dans une fonction `parse_url_segments()`
* utiliser une fonction `router()` pour organiser le traitement d’une requête
* utiliser `dispatch()` pour trouver le bon fichier à exécuter
* charger une view avec `render()` plutôt qu’avec un `include` direct dans le controller
* organiser un projet PHP en `controllers/`, `models/`, `views/`
* respecter la règle : les fonctions ne font pas d’affichage direct ; seules les views produisent du HTML

---

## Plan

| #  | Bloc                                               | Durée  | Type               |
| -- | -------------------------------------------------- | ------ | ------------------ |
| 1  | Séparer les responsabilités : de HTML/CSS/JS à MVC | 25 min | Cours + discussion |
| 2  | Afficher une view avec `render()`                  | 20 min | Cours + démo       |
| 3  | De l’URL à `parse_url_segments()`                  | 25 min | Cours + démo       |
| 4  | `router()` et `dispatch()` version simple          | 25 min | Cours + démo       |
| 5  | Exercice 1 — router + render fonctionnels          | 30 min | TP                 |
| 6  | Faire évoluer la structure                         | 45 min | Cours + discussion |
| 7  | Controllers, models, views : rôles et règles       | 25 min | Cours              |
| 8  | Exercice 2 — mini projet structuré                 | 45 min | TP                 |
| 9  | Exercice 3 — utilitaires HTTP                      | 30 min | TP                 |
| 10 | Mise en commun & questions                         | 15 min | Discussion         |

---

# Bloc 1 — Séparer les responsabilités : de HTML/CSS/JS à MVC

## Point de départ : côté frontend

Les étudiants connaissent déjà une séparation classique côté frontend :

```text
HTML → structure
CSS  → apparence
JS   → comportement
```

On pourrait tout mélanger dans un seul fichier HTML :

```html
<h1 style="color: red;" onclick="alert('Bonjour')">
    Bienvenue
</h1>
```

Ce code fonctionne.

Mais il mélange trois responsabilités :

```text
<h1>Bienvenue</h1>       → structure HTML
style="color: red;"      → apparence CSS
onclick="alert(...)"     → comportement JavaScript
```

Question à poser :

```text
Pourquoi évite-t-on de tout mélanger ?
```

Réponses attendues :

* c’est difficile à lire
* c’est difficile à modifier
* on ne sait plus où chercher
* le même code risque d’être répété
* modifier l’apparence peut casser autre chose
* modifier le comportement peut rendre le HTML illisible

La séparation HTML / CSS / JS est donc une forme de **separation of concerns**.

En français : séparation des responsabilités.

Chaque partie du code a un rôle clair.

---

## Même idée côté backend

Côté backend, on a le même problème.

Une page PHP peut faire plusieurs choses à la fois :

```php
<?php

$items = [
    ['id' => 1, 'name' => 'Clavier'],
    ['id' => 2, 'name' => 'Souris'],
];

echo '<h1>Items</h1>';
echo '<ul>';

foreach ($items as $item) {
    echo '<li>' . $item['name'] . '</li>';
}

echo '</ul>';
```

Ce code fonctionne.

Mais il mélange plusieurs responsabilités :

```text
Données      → le tableau $items
Décision     → parcourir les items
Affichage    → echo du HTML
```

Question à poser :

```text
Quel est le problème si toute l’application est écrite comme ça ?
```

Réponses attendues :

* le code devient difficile à lire
* on mélange données et HTML
* on ne sait plus où modifier l’affichage
* on ne sait plus où modifier les données
* on ne peut pas réutiliser facilement le code
* les fichiers deviennent longs

---

## MVC : trois noms pour trois responsabilités

MVC veut dire :

```text
Model
View
Controller
```

Ces mots semblent abstraits, mais l’idée est simple.

### View

La **view** est ce que l’utilisateur voit.

Dans notre cas, une view est un fichier PHP qui contient surtout du HTML.

Exemple :

```php
<h1>Items</h1>

<ul>
    <?php foreach ($items as $item): ?>
        <li><?= escape($item['name']) ?></li>
    <?php endforeach; ?>
</ul>
```

La view affiche les données qu’on lui donne.

Elle ne va pas les chercher elle-même.

---

### Model

Le **model** s’occupe des données.

Au début, les données seront de simples tableaux PHP.

Plus tard, elles viendront d’une base de données.

Exemple :

```php
function get_all_items() {
    return [
        ['id' => 1, 'name' => 'Clavier'],
        ['id' => 2, 'name' => 'Souris'],
    ];
}
```

Le model ne fait pas de HTML.

Il retourne des données.

---

### Controller

Le **controller** reçoit la demande, appelle le model, puis choisit la view.

Exemple :

```php
function item_index() {
    $items = get_all_items();

    render('item/index', ['items' => $items]);
}
```

Le controller ne produit pas directement le HTML.

Il orchestre.

Il décide :

```text
De quelles données ai-je besoin ?
Quelle view dois-je afficher ?
```

---

## Comparaison frontend / backend

On peut faire un parallèle simple.

| Frontend                | Rôle                      | Backend MVC | Rôle                                   |
| ----------------------- | ------------------------- | ----------- | -------------------------------------- |
| HTML                    | structure visible         | View        | HTML affiché                           |
| JS                      | réagit, décide, orchestre | Controller  | reçoit la demande et décide quoi faire |
| Données côté navigateur | état, contenu             | Model       | données de l’application               |

La comparaison n’est pas parfaite, mais elle aide à comprendre l’idée :

```text
On évite de tout mélanger.
```

C’est le même principe que HTML / CSS / JS.

On sépare pour pouvoir lire, modifier et tester plus facilement.

---

## Règle de la séance

Pendant cette séance, on applique une règle simple :

```text
Aucune fonction ne fait echo.
Seules les views produisent du HTML.
```

Un controller peut choisir une view.

Un model peut retourner des données.

Mais l’affichage se fait dans une view.

---

# Bloc 2 — Afficher une view avec `render()`

## Problème : `include` direct dans le controller

Un controller pourrait faire ceci :

```php
function home_index() {
    include 'views/home/index.php';
}
```

Ce code fonctionne.

Mais on veut une convention plus claire.

On veut que les controllers disent :

```text
Je veux afficher telle view avec telles données.
```

Pour ça, on crée une fonction :

```php
render()
```

---

## `escape()`

Avant d’afficher des variables dans du HTML, on les protège avec une fonction.

```php
// core/html.php

function escape($value) {
    if (is_null($value)) {
        return '';
    }

    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}
```

Exemple dans une view :

```php
<?= escape($name) ?>
```

Pourquoi ?

Parce qu’une variable peut contenir des caractères spéciaux.

Exemple :

```text
<script>alert('test')</script>
```

Avec `escape()`, ce texte est affiché comme du texte.

Il n’est pas interprété comme du HTML ou du JavaScript.

---

## `render()`

```php
// core/html.php

function render($view, $data = []) {
    extract($data);

    include 'views/' . $view . '.php';
}
```

Exemple :

```php
render('home/index');
```

Cette ligne charge :

```text
views/home/index.php
```

Autre exemple :

```php
render('item/show', ['id' => 3]);
```

Cette ligne charge :

```text
views/item/show.php
```

et rend la variable `$id` disponible dans la view.

---

## Pourquoi `$data` ?

Sans `render()`, un controller pourrait faire ceci :

```php
function item_show() {
    $id = 3;
    $debug = true;
    $user = 'admin';

    include 'views/item/show.php';
}
```

La view peut alors utiliser `$id`, mais aussi `$debug` et `$user`.

Le problème : on ne sait pas clairement quelles variables la view est censée recevoir.

Avec `render()` :

```php
function item_show() {
    $id = 3;

    render('item/show', ['id' => $id]);
}
```

La ligne dit clairement :

```text
Je charge la view item/show.
Je lui donne une variable : id.
```

---

## Exemple de view

```php
<!-- views/item/show.php -->

<p>Item n°<?= escape($id) ?></p>
```

La view affiche.

Le controller décide quelle view afficher.

---

# Bloc 3 — De l’URL à `parse_url_segments()`

## Point de départ

L’exercice précédent a produit ce code :

```php
$url   = 'product/show/12';
$parts = explode('/', trim($url, '/'));

$entity = $parts[0];
$action = 'index';

if (isset($parts[1])) {
    $action = $parts[1];
}

$id = null;

if (isset($parts[2])) {
    $id = $parts[2];
}
```

Ce code transforme :

```text
product/show/12
```

en :

```php
$entity = 'product';
$action = 'show';
$id = '12';
```

Trois segments, trois rôles :

```text
entity → de quoi on parle
action → ce qu’on veut faire
id     → sur quel élément
```

Exemples :

```text
/item/show/3
```

donne :

```text
entity = item
action = show
id     = 3
```

```text
/item
```

donne :

```text
entity = item
action = index
id     = null
```

```text
/
```

donne :

```text
entity = home
action = index
id     = null
```

---

## Pourquoi mettre ce code dans une fonction ?

Question à poser :

```text
Quel est le problème si ce code reste directement dans index.php ?
```

Réponses attendues :

* `index.php` devient long
* on ne peut pas réutiliser ce code
* on ne peut pas tester cette partie séparément
* on mélange le point d’entrée du site et la logique de routing

On crée donc une fonction :

```php
parse_url_segments()
```

Son rôle :

```text
Lire l’URL et retourner entity, action et id.
```

---

## D’où vient l’URL ?

Dans un navigateur, l’URL demandée est disponible dans :

```php
$_SERVER['REQUEST_URI']
```

Exemples :

```text
/
```

```text
/item
```

```text
/item/show/3
```

```text
/item/search?q=clavier
```

Dans le dernier cas, l’URL contient une query string :

```text
?q=clavier
```

Pour le router, on ne veut que le chemin :

```text
/item/search
```

On utilise donc :

```php
parse_url($uri, PHP_URL_PATH)
```

---

## `parse_url_segments()`

```php
// core/router.php

function parse_url_segments() {
    $uri = '/';

    if (isset($_SERVER['REQUEST_URI'])) {
        $uri = $_SERVER['REQUEST_URI'];
    }

    $path = parse_url($uri, PHP_URL_PATH);

    if (is_null($path)) {
        $path = '/';
    }

    $path = trim($path, '/');

    if ($path === '') {
        return [
            'entity' => 'home',
            'action' => 'index',
            'id' => null,
        ];
    }

    $parts = explode('/', $path);

    $entity = $parts[0];

    $action = 'index';

    if (isset($parts[1])) {
        $action = $parts[1];
    }

    $id = null;

    if (isset($parts[2])) {
        $id = $parts[2];
    }

    return [
        'entity' => $entity,
        'action' => $action,
        'id' => $id,
    ];
}
```

---

## Pourquoi le cas spécial pour `/` ?

Si l’URL est :

```text
/
```

alors :

```php
trim('/', '/')
```

donne :

```php
''
```

Et :

```php
explode('/', '')
```

donne :

```php
['']
```

Ce n’est pas ce qu’on veut.

On veut que `/` signifie :

```text
home / index / null
```

Donc on traite ce cas explicitement :

```php
if ($path === '') {
    return [
        'entity' => 'home',
        'action' => 'index',
        'id' => null,
    ];
}
```

---

## Ce que cette fonction ne fait pas encore

Cette fonction ne valide pas vraiment l’URL.

Elle ne vérifie pas si l’entité existe.

Elle ne vérifie pas si l’action existe.

Elle ne vérifie pas si l’id est un nombre.

Elle découpe seulement l’URL.

La validation minimale viendra dans `dispatch()` avec :

```php
file_exists()
```

Puis plus tard avec :

```php
function_exists()
```

---

# Bloc 4 — `router()` et `dispatch()` version simple

## `router()`

On a une fonction qui découpe l’URL.

Maintenant, on veut une fonction qui orchestre le traitement de la requête.

```php
function router() {
    $segments = parse_url_segments();

    dispatch($segments);
}
```

`router()` ne fait presque rien.

Il délègue.

Son rôle est de dire :

```text
1. Je lis l’URL.
2. Je transmets le résultat à dispatch().
```

---

## `dispatch()`

`dispatch()` reçoit ceci :

```php
[
    'entity' => 'item',
    'action' => 'show',
    'id' => '3',
]
```

Son rôle :

```text
Trouver le fichier controller qui correspond.
```

Dans la première version du projet, on utilise une règle très simple :

```text
/entity/action/id
```

devient :

```text
controllers/entity_action.php
```

Exemple :

```text
/item/show/3
```

devient :

```text
controllers/item_show.php
```

---

## Pourquoi le dossier `controllers/` ?

Un controller est le fichier qui reçoit une demande et décide quoi faire.

Dans cette première version :

```text
une URL = un fichier controller
```

Exemple :

```text
/item/show/3
```

est contrôlé par :

```text
controllers/item_show.php
```

On met ces fichiers dans un dossier `controllers/` pour ne pas les mélanger avec :

```text
index.php
.htaccess
core/
views/
```

Le nom `controller` signifie :

```text
Ce fichier contrôle ce qui doit se passer pour une URL donnée.
```

Il ne veut pas dire qu’il fait tout.

Il ne doit pas produire directement le HTML.

Il doit décider quelle view afficher.

---

## Première version de `dispatch()`

```php
function dispatch($segments) {
    $controllerFile = 'controllers/' . $segments['entity'] . '_' . $segments['action'] . '.php';

    if (!file_exists($controllerFile)) {
        http_response_code(404);
        render('error/404', ['message' => 'Page introuvable']);
        return;
    }

    $id = $segments['id'];

    include $controllerFile;
}
```

La seule validation ici est :

```php
file_exists($controllerFile)
```

Si le fichier n’existe pas, on affiche une 404.

---

## Pourquoi `render()` pour la 404 ?

On pourrait écrire :

```php
die('404');
```

Mais ce serait contraire à la règle de la séance.

Même une erreur doit passer par une view.

Donc on fait :

```php
http_response_code(404);
render('error/404', ['message' => 'Page introuvable']);
return;
```

---

## Exemple de controller

```php
// controllers/item_show.php

render('item/show', ['id' => $id]);
```

Ce fichier ne fait pas :

```php
echo '<p>Item</p>';
```

Il appelle une view.

---

## Exemple de view

```php
<!-- views/item/show.php -->

<p>Item n°<?= escape($id) ?></p>
```

La view affiche.

Le controller décide.

---

## `index.php`

```php
<?php

require 'core/html.php';
require 'core/router.php';

router();
```

`index.php` reste minimal.

Il charge les fonctions nécessaires, puis lance le router.

---

# Bloc 5 — Exercice 1 : router + render fonctionnels

## Objectif

Créer un projet minimal avec :

* un router
* une fonction `render()`
* une fonction `escape()`
* un dossier `controllers/`
* un dossier `views/`
* une view 404

---

## Structure attendue

```text
project/
├── index.php
├── .htaccess
├── core/
│   ├── router.php
│   └── html.php
├── controllers/
│   ├── home_index.php
│   ├── item_index.php
│   └── item_show.php
└── views/
    ├── error/
    │   └── 404.php
    ├── home/
    │   └── index.php
    └── item/
        ├── index.php
        └── show.php
```

---

## `.htaccess`

```apache
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ index.php [L]
```

Ce fichier fait en sorte que les URLs soient envoyées vers `index.php`.

Exemple :

```text
/item/show/3
```

ne cherche pas un vrai fichier :

```text
item/show/3
```

La requête passe par :

```text
index.php
```

---

## `core/html.php`

```php
<?php

function escape($value) {
    if (is_null($value)) {
        return '';
    }

    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}

function render($view, $data = []) {
    extract($data);

    include 'views/' . $view . '.php';
}
```

---

## `core/router.php`

```php
<?php

function parse_url_segments() {
    $uri = '/';

    if (isset($_SERVER['REQUEST_URI'])) {
        $uri = $_SERVER['REQUEST_URI'];
    }

    $path = parse_url($uri, PHP_URL_PATH);

    if (is_null($path)) {
        $path = '/';
    }

    $path = trim($path, '/');

    if ($path === '') {
        return [
            'entity' => 'home',
            'action' => 'index',
            'id' => null,
        ];
    }

    $parts = explode('/', $path);

    $entity = $parts[0];

    $action = 'index';

    if (isset($parts[1])) {
        $action = $parts[1];
    }

    $id = null;

    if (isset($parts[2])) {
        $id = $parts[2];
    }

    return [
        'entity' => $entity,
        'action' => $action,
        'id' => $id,
    ];
}

function dispatch($segments) {
    $controllerFile = 'controllers/' . $segments['entity'] . '_' . $segments['action'] . '.php';

    if (!file_exists($controllerFile)) {
        http_response_code(404);
        render('error/404', ['message' => 'Page introuvable']);
        return;
    }

    $id = $segments['id'];

    include $controllerFile;
}

function router() {
    $segments = parse_url_segments();

    dispatch($segments);
}
```

---

## `index.php`

```php
<?php

require 'core/html.php';
require 'core/router.php';

router();
```

---

## Controllers

```php
<?php
// controllers/home_index.php

render('home/index');
```

```php
<?php
// controllers/item_index.php

render('item/index');
```

```php
<?php
// controllers/item_show.php

render('item/show', ['id' => $id]);
```

---

## Views

```php
<!-- views/home/index.php -->

<p>Accueil</p>
```

```php
<!-- views/item/index.php -->

<p>Liste des items</p>
```

```php
<!-- views/item/show.php -->

<p>Item n°<?= escape($id) ?></p>
```

```php
<!-- views/error/404.php -->

<h1>404</h1>
<p><?= escape($message) ?></p>
```

---

## À tester

| URL              | Résultat attendu             |
| ---------------- | ---------------------------- |
| `/`              | `Accueil`                    |
| `/item`          | `Liste des items`            |
| `/item/show/3`   | `Item n°3`                   |
| `/admin`         | Vue 404 — `Page introuvable` |
| `/item/delete/3` | Vue 404 — `Page introuvable` |

---

## Critères de validation

Le projet est valide si :

* les cinq URLs produisent le bon résultat
* `index.php` contient seulement les `require` et `router()`
* aucun controller ne fait `echo`
* aucune fonction ne fait `echo`
* toutes les sorties dans les views passent par `escape()`

---

# Bloc 6 — Faire évoluer la structure

## Le projet fonctionne, mais il ne va pas bien grandir

À la fin de l’exercice 1, le projet fonctionne.

Mais l’organisation est encore très simple :

```text
une action = un fichier controller
```

Exemple :

```text
controllers/item_index.php
controllers/item_show.php
```

Pour un petit projet, ça passe.

Pour un projet plus grand, le dossier `controllers/` va vite devenir trop chargé.

---

## Étape 1 — Une seule entité : item

Question à poser :

```text
Quelles actions peut-on vouloir faire sur des items ?
```

Réponses possibles :

```text
/item
/item/show/3
/item/search
/admin_item
/admin_item/create
/admin_item/edit/3
/admin_item/delete/3
```

Avec la règle actuelle, cela donne :

```text
controllers/item_index.php
controllers/item_show.php
controllers/item_search.php
controllers/admin_item_index.php
controllers/admin_item_create.php
controllers/admin_item_edit.php
controllers/admin_item_delete.php
```

Pour une seule entité, on a déjà beaucoup de fichiers.

---

## Étape 2 — Plusieurs entités

Imaginons maintenant :

```text
items
categories
collections
tags
users
auth
```

Le dossier `controllers/` pourrait devenir :

```text
controllers/
├── home_index.php
├── auth_login.php
├── auth_logout.php
├── auth_register.php
├── item_index.php
├── item_show.php
├── item_search.php
├── admin_item_index.php
├── admin_item_create.php
├── admin_item_edit.php
├── admin_item_delete.php
├── category_index.php
├── category_show.php
├── admin_category_index.php
├── admin_category_create.php
├── admin_category_edit.php
├── admin_category_delete.php
├── collection_index.php
├── collection_show.php
├── tag_index.php
├── tag_show.php
└── ...
```

Question à poser :

```text
Qu’est-ce qui ne va plus ?
```

Réponses attendues :

* trop de fichiers dans un seul dossier
* difficile de trouver ce qu’on cherche
* les fichiers liés aux items sont dispersés
* l’admin et le public sont mélangés
* le code fonctionne, mais le projet devient difficile à lire

Ce n’est pas encore un problème de PHP.

C’est un problème d’organisation.

---

## Première idée : ranger dans des dossiers

On pourrait ranger les controllers par entité :

```text
controllers/
├── item/
│   ├── index.php
│   ├── show.php
│   └── search.php
├── category/
│   ├── index.php
│   └── show.php
└── admin_item/
    ├── index.php
    ├── create.php
    ├── edit.php
    └── delete.php
```

Cela rend le dossier plus lisible.

Mais cela demande de changer le `dispatch()` pour chercher :

```text
controllers/item/show.php
```

au lieu de :

```text
controllers/item_show.php
```

On pourrait le faire.

Mais il reste un autre problème.

---

## Le vrai problème : duplication dans les actions d’une même entité

Regardons trois fichiers liés aux items.

```php
// controllers/item_index.php

require 'models/item_model.php';

$items = get_all_items();

render('item/index', ['items' => $items]);
```

```php
// controllers/item_show.php

require 'models/item_model.php';

$item = get_one_item($id);

render('item/show', ['item' => $item]);
```

```php
// controllers/item_search.php

require 'models/item_model.php';

// recherche...

render('item/search');
```

Question à poser :

```text
Qu’est-ce qui est répété ?
```

Réponses attendues :

* le `require` du model
* le fait que tout concerne les items
* le même domaine revient dans plusieurs fichiers
* si on change les données des items, on risque de modifier plusieurs fichiers

---

## Deuxième idée : un fichier controller par entité

On change la convention.

Avant :

```text
un fichier = une action
```

Après :

```text
un fichier controller = une entité
une fonction = une action
```

Avant :

```text
controllers/item_index.php
controllers/item_show.php
controllers/item_search.php
```

Après :

```text
controllers/item.php
```

Dans ce fichier :

```php
// controllers/item.php

require 'models/item_model.php';

function item_index($id = null) {
    $items = get_all_items();

    render('item/index', ['items' => $items]);
}

function item_show($id = null) {
    $item = get_one_item($id);

    render('item/show', ['item' => $item]);
}

function item_search($id = null) {
    render('item/search');
}
```

Toutes les actions liées aux items sont dans le même controller.

C’est plus cohérent.

---

## Nouveau `dispatch()`

Avant, l’URL désignait un fichier complet :

```text
/item/show/3
```

donnait :

```text
controllers/item_show.php
```

Maintenant, l’URL désigne :

```text
un fichier controller
une fonction dans ce fichier
```

Exemple :

```text
/item/show/3
```

donne :

```text
controllers/item.php
```

puis :

```php
item_show('3')
```

---

## `dispatch()` version finale de la séance

```php
function dispatch($segments) {
    $controllerFile = 'controllers/' . $segments['entity'] . '.php';
    $controllerAction = $segments['entity'] . '_' . $segments['action'];

    if (!file_exists($controllerFile)) {
        http_response_code(404);
        render('error/404', ['message' => 'Entité inconnue']);
        return;
    }

    include $controllerFile;

    if (!function_exists($controllerAction)) {
        http_response_code(404);
        render('error/404', ['message' => 'Action inconnue']);
        return;
    }

    $controllerAction($segments['id']);
}
```

Ici, on ajoute une deuxième vérification :

```php
function_exists($controllerAction)
```

Pourquoi ?

Parce que le fichier controller peut exister, mais l’action demandée peut ne pas exister.

Exemple :

```text
/item/delete/3
```

Le fichier existe :

```text
controllers/item.php
```

Mais la fonction n’existe peut-être pas :

```php
item_delete()
```

---

## Pourquoi toutes les fonctions prennent `$id = null` ?

Le router appelle toujours l’action comme ceci :

```php
$controllerAction($segments['id']);
```

Donc même une action qui n’utilise pas l’id accepte un paramètre.

Exemple :

```php
function item_index($id = null) {
    $items = get_all_items();

    render('item/index', ['items' => $items]);
}
```

L’id existe dans la signature, mais la fonction ne l’utilise pas.

Cela garde le router simple.

---

## Pourquoi préfixer les fonctions ?

On écrit :

```php
item_index()
item_show()
category_index()
category_show()
```

et non :

```php
index()
show()
```

Pourquoi ?

Parce que PHP ne peut pas avoir deux fonctions avec le même nom.

On ne peut pas avoir :

```php
function show() {
}
```

dans un controller, puis encore :

```php
function show() {
}
```

dans un autre.

Avec le préfixe, les noms sont différents :

```php
item_show()
category_show()
```

C’est aussi plus lisible.

Quand on lit :

```php
item_show()
```

on sait immédiatement que l’action concerne les items.

---

## Structure finale

```text
project/
├── index.php
├── .htaccess
├── core/
│   ├── router.php
│   └── html.php
├── controllers/
│   ├── home.php
│   ├── item.php
│   ├── category.php
│   └── auth.php
├── models/
│   ├── item_model.php
│   └── category_model.php
└── views/
    ├── error/
    │   └── 404.php
    ├── home/
    │   └── index.php
    ├── item/
    │   ├── index.php
    │   ├── show.php
    │   └── search.php
    └── category/
        ├── index.php
        └── show.php
```

À partir de maintenant, on utilise cette convention :

```text
URL              → /item/show/3
controller       → controllers/item.php
fonction appelée → item_show('3')
view             → views/item/show.php
```

---

# Bloc 7 — Controllers, models, views : rôles et règles

## Les trois responsabilités

On revient maintenant aux noms MVC.

```text
Model
View
Controller
```

L’objectif n’est pas d’apprendre un mot compliqué.

L’objectif est de séparer les responsabilités.

---

## Controller

Le controller reçoit la demande, appelle le model, puis choisit la view.

Exemple :

```php
// controllers/item.php

require 'models/item_model.php';

function item_show($id = null) {
    $item = get_one_item($id);

    if (is_null($item)) {
        http_response_code(404);
        render('error/404', ['message' => 'Item introuvable']);
        return;
    }

    render('item/show', ['item' => $item]);
}
```

Le controller décide.

Il ne produit pas de HTML.

Il ne contient pas les données.

Il ne fait pas de SQL.

---

## Model

Le model fournit les données.

Pour cette séance, les données sont dans des tableaux PHP.

```php
// models/item_model.php

function get_all_items() {
    return [
        ['id' => 1, 'name' => 'Clavier', 'category_id' => 1],
        ['id' => 2, 'name' => 'Souris', 'category_id' => 1],
        ['id' => 3, 'name' => 'Écran', 'category_id' => 2],
    ];
}

function get_one_item($id) {
    if (is_null($id)) {
        return null;
    }

    foreach (get_all_items() as $item) {
        if ($item['id'] == $id) {
            return $item;
        }
    }

    return null;
}
```

Le model ne fait pas de HTML.

Il ne charge pas de view.

Il ne sait pas quelle URL a été demandée.

Il retourne seulement des données.

---

## View

La view affiche les données.

```php
<!-- views/item/show.php -->

<h1><?= escape($item['name']) ?></h1>

<p>Identifiant : <?= escape($item['id']) ?></p>
```

La view reçoit une variable `$item`.

Elle ne va pas chercher l’item elle-même.

Elle affiche ce qu’on lui donne.

---

## Une view peut contenir une boucle

Dire “la view ne contient pas de logique” peut être trop vague.

Une view peut contenir une logique d’affichage simple.

Exemple :

```php
<!-- views/item/index.php -->

<h1>Items</h1>

<?php if (empty($items)): ?>
    <p>Aucun item.</p>
<?php else: ?>
    <ul>
        <?php foreach ($items as $item): ?>
            <li><?= escape($item['name']) ?></li>
        <?php endforeach; ?>
    </ul>
<?php endif; ?>
```

C’est autorisé.

Pourquoi ?

Parce que cette logique sert uniquement à afficher.

Ce qui n’est pas autorisé dans une view :

```text
- accéder directement au model
- faire une requête SQL
- décider quelle page afficher
- modifier les données principales de l’application
```

---

## Contre-exemple : HTML dans un controller

```php
// Mauvais exemple

function item_show($id = null) {
    $item = get_one_item($id);

    echo '<h1>' . $item['name'] . '</h1>';
}
```

Problème :

```text
Le controller produit du HTML.
```

Correction :

```php
function item_show($id = null) {
    $item = get_one_item($id);

    render('item/show', ['item' => $item]);
}
```

---

## Contre-exemple : données dans une view

```php
<!-- Mauvais exemple -->

<?php
$items = get_all_items();
?>

<ul>
    <?php foreach ($items as $item): ?>
        <li><?= escape($item['name']) ?></li>
    <?php endforeach; ?>
</ul>
```

Problème :

```text
La view va chercher les données.
```

Correction :

```php
// controller

$items = get_all_items();

render('item/index', ['items' => $items]);
```

Puis :

```php
<!-- view -->

<ul>
    <?php foreach ($items as $item): ?>
        <li><?= escape($item['name']) ?></li>
    <?php endforeach; ?>
</ul>
```

---

## Contre-exemple : HTML dans un model

```php
// Mauvais exemple

function get_one_item($id) {
    return '<h1>Item ' . $id . '</h1>';
}
```

Problème :

```text
Le model décide de l’affichage.
```

Correction :

```php
function get_one_item($id) {
    if (is_null($id)) {
        return null;
    }

    foreach (get_all_items() as $item) {
        if ($item['id'] == $id) {
            return $item;
        }
    }

    return null;
}
```

Le model retourne des données.

La view affiche ces données.

---

## Règles à retenir

```text
Controller :
- reçoit la demande
- appelle le model
- choisit la view
- ne fait pas de HTML

Model :
- fournit les données
- ne fait pas de HTML
- ne charge pas de view

View :
- affiche les données reçues
- utilise escape()
- peut contenir des boucles simples
- ne va pas chercher les données elle-même
```

---

# Bloc 8 — Exercice 2 : mini projet structuré

## Objectif

Construire un mini catalogue avec deux types de données :

```text
items
categories
```

Les URLs à faire fonctionner :

```text
/                        → home_index()
/item                    → item_index()
/item/show/1             → item_show('1')
/item/category/1         → item_category('1')
```

---

## Structure attendue

```text
project/
├── index.php
├── .htaccess
├── core/
│   ├── router.php
│   └── html.php
├── controllers/
│   ├── home.php
│   └── item.php
├── models/
│   ├── item_model.php
│   └── category_model.php
└── views/
    ├── error/
    │   └── 404.php
    ├── home/
    │   └── index.php
    └── item/
        ├── index.php
        ├── show.php
        └── category.php
```

---

## `core/router.php`

```php
<?php

function parse_url_segments() {
    $uri = '/';

    if (isset($_SERVER['REQUEST_URI'])) {
        $uri = $_SERVER['REQUEST_URI'];
    }

    $path = parse_url($uri, PHP_URL_PATH);

    if (is_null($path)) {
        $path = '/';
    }

    $path = trim($path, '/');

    if ($path === '') {
        return [
            'entity' => 'home',
            'action' => 'index',
            'id' => null,
        ];
    }

    $parts = explode('/', $path);

    $entity = $parts[0];

    $action = 'index';

    if (isset($parts[1])) {
        $action = $parts[1];
    }

    $id = null;

    if (isset($parts[2])) {
        $id = $parts[2];
    }

    return [
        'entity' => $entity,
        'action' => $action,
        'id' => $id,
    ];
}

function dispatch($segments) {
    $controllerFile = 'controllers/' . $segments['entity'] . '.php';
    $controllerAction = $segments['entity'] . '_' . $segments['action'];

    if (!file_exists($controllerFile)) {
        http_response_code(404);
        render('error/404', ['message' => 'Entité inconnue']);
        return;
    }

    include $controllerFile;

    if (!function_exists($controllerAction)) {
        http_response_code(404);
        render('error/404', ['message' => 'Action inconnue']);
        return;
    }

    $controllerAction($segments['id']);
}

function router() {
    $segments = parse_url_segments();

    dispatch($segments);
}
```

---

## `core/html.php`

```php
<?php

function escape($value) {
    if (is_null($value)) {
        return '';
    }

    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}

function render($view, $data = []) {
    extract($data);

    include 'views/' . $view . '.php';
}
```

---

## `index.php`

```php
<?php

require 'core/html.php';
require 'core/router.php';

router();
```

---

## `controllers/home.php`

```php
<?php

function home_index($id = null) {
    render('home/index');
}
```

---

## `controllers/item.php`

```php
<?php

require 'models/item_model.php';
require 'models/category_model.php';

function item_index($id = null) {
    $items = get_all_items();
    $categories = get_all_categories();

    render('item/index', [
        'items' => $items,
        'categories' => $categories,
    ]);
}

function item_show($id = null) {
    $item = get_one_item($id);

    if (is_null($item)) {
        http_response_code(404);
        render('error/404', ['message' => 'Item introuvable']);
        return;
    }

    $category = get_one_category($item['category_id']);

    render('item/show', [
        'item' => $item,
        'category' => $category,
    ]);
}

function item_category($id = null) {
    $category = get_one_category($id);

    if (is_null($category)) {
        http_response_code(404);
        render('error/404', ['message' => 'Catégorie introuvable']);
        return;
    }

    $items = get_items_by_category($id);

    render('item/category', [
        'category' => $category,
        'items' => $items,
    ]);
}
```

---

## `models/item_model.php`

```php
<?php

function get_all_items() {
    return [
        ['id' => 1, 'name' => 'Clavier', 'category_id' => 1],
        ['id' => 2, 'name' => 'Souris', 'category_id' => 1],
        ['id' => 3, 'name' => 'Écran', 'category_id' => 2],
    ];
}

function get_one_item($id) {
    if (is_null($id)) {
        return null;
    }

    foreach (get_all_items() as $item) {
        if ($item['id'] == $id) {
            return $item;
        }
    }

    return null;
}

function get_items_by_category($categoryId) {
    $results = [];

    if (is_null($categoryId)) {
        return $results;
    }

    foreach (get_all_items() as $item) {
        if ($item['category_id'] == $categoryId) {
            $results[] = $item;
        }
    }

    return $results;
}
```

---

## `models/category_model.php`

```php
<?php

function get_all_categories() {
    return [
        ['id' => 1, 'name' => 'Périphériques'],
        ['id' => 2, 'name' => 'Écrans'],
    ];
}

function get_one_category($id) {
    if (is_null($id)) {
        return null;
    }

    foreach (get_all_categories() as $category) {
        if ($category['id'] == $id) {
            return $category;
        }
    }

    return null;
}
```

---

## `views/home/index.php`

```php
<h1>Accueil</h1>

<p>Bienvenue dans le mini catalogue.</p>
```

---

## `views/item/index.php`

```php
<h1>Items</h1>

<?php if (empty($items)): ?>
    <p>Aucun item.</p>
<?php else: ?>
    <ul>
        <?php foreach ($items as $item): ?>
            <li>
                <a href="/item/show/<?= escape($item['id']) ?>">
                    <?= escape($item['name']) ?>
                </a>
            </li>
        <?php endforeach; ?>
    </ul>
<?php endif; ?>

<h2>Catégories</h2>

<?php if (empty($categories)): ?>
    <p>Aucune catégorie.</p>
<?php else: ?>
    <ul>
        <?php foreach ($categories as $category): ?>
            <li>
                <a href="/item/category/<?= escape($category['id']) ?>">
                    <?= escape($category['name']) ?>
                </a>
            </li>
        <?php endforeach; ?>
    </ul>
<?php endif; ?>
```

---

## `views/item/show.php`

```php
<h1><?= escape($item['name']) ?></h1>

<p>Identifiant : <?= escape($item['id']) ?></p>

<?php if (!is_null($category)): ?>
    <p>Catégorie : <?= escape($category['name']) ?></p>
<?php endif; ?>

<p><a href="/item">Retour à la liste</a></p>
```

---

## `views/item/category.php`

```php
<h1>Catégorie : <?= escape($category['name']) ?></h1>

<?php if (empty($items)): ?>
    <p>Aucun item dans cette catégorie.</p>
<?php else: ?>
    <ul>
        <?php foreach ($items as $item): ?>
            <li>
                <a href="/item/show/<?= escape($item['id']) ?>">
                    <?= escape($item['name']) ?>
                </a>
            </li>
        <?php endforeach; ?>
    </ul>
<?php endif; ?>

<p><a href="/item">Retour à la liste</a></p>
```

---

## `views/error/404.php`

```php
<h1>404</h1>

<p><?= escape($message) ?></p>
```

---

## Critères de validation

Le projet est valide si :

* `/` affiche l’accueil
* `/item` affiche tous les items
* `/item/show/1` affiche l’item 1
* `/item/show/999` affiche une 404
* `/item/category/1` affiche les items de la catégorie 1
* `/item/category/999` affiche une 404
* les views utilisent `escape()`
* les controllers utilisent `render()`
* les models retournent seulement des données
* aucun controller ne fait `echo`

---

# Bloc 9 — Exercice 3 : utilitaires HTTP

## Objectif

Créer des fonctions simples pour :

* rediriger
* savoir si une requête est en POST
* lire une valeur dans `$_POST`

Ces fonctions seront utiles pour les formulaires.

---

## Créer `core/http.php`

```php
<?php

function redirect($url) {
    header('Location: ' . $url);
    exit;
}

function is_post() {
    if (isset($_SERVER['REQUEST_METHOD'])) {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            return true;
        }
    }

    return false;
}

function post($key, $default = null) {
    if (isset($_POST[$key])) {
        return trim($_POST[$key]);
    }

    return $default;
}
```

---

## Ajouter le fichier dans `index.php`

```php
<?php

require 'core/html.php';
require 'core/http.php';
require 'core/router.php';

router();
```

---

## Ajouter une recherche d’items

Nouvelle URL :

```text
/item/search
```

Elle appelle :

```php
item_search()
```

---

## Ajouter une fonction dans `models/item_model.php`

```php
function search_items($query) {
    $results = [];

    if ($query === '') {
        return $results;
    }

    foreach (get_all_items() as $item) {
        if (stripos($item['name'], $query) !== false) {
            $results[] = $item;
        }
    }

    return $results;
}
```

---

## Ajouter l’action dans `controllers/item.php`

```php
function item_search($id = null) {
    $q = '';
    $results = [];
    $hasSearched = false;

    if (is_post()) {
        $q = post('q', '');

        if ($q === '') {
            redirect('/item/search');
        }

        $results = search_items($q);
        $hasSearched = true;
    }

    render('item/search', [
        'q' => $q,
        'results' => $results,
        'hasSearched' => $hasSearched,
    ]);
}
```

---

## Créer `views/item/search.php`

```php
<h1>Recherche</h1>

<form method="post" action="/item/search">
    <label for="q">Rechercher un item</label>
    <input type="text" id="q" name="q" value="<?= escape($q) ?>">

    <button type="submit">Rechercher</button>
</form>

<?php if ($hasSearched): ?>
    <h2>Résultats</h2>

    <?php if (empty($results)): ?>
        <p>Aucun résultat.</p>
    <?php else: ?>
        <ul>
            <?php foreach ($results as $item): ?>
                <li>
                    <a href="/item/show/<?= escape($item['id']) ?>">
                        <?= escape($item['name']) ?>
                    </a>
                </li>
            <?php endforeach; ?>
        </ul>
    <?php endif; ?>
<?php endif; ?>

<p><a href="/item">Retour à la liste</a></p>
```

---

## Critères de validation

L’exercice est valide si :

* `/item/search` affiche le formulaire
* le formulaire utilise `method="post"`
* une recherche avec `clavier` affiche `Clavier`
* une recherche sans résultat affiche `Aucun résultat`
* une recherche vide redirige vers `/item/search`
* les controllers n’utilisent pas directement `$_POST`
* les controllers n’utilisent pas directement `$_SERVER['REQUEST_METHOD']`
* les views utilisent `escape()`

---

# Bloc 10 — Mise en commun & questions

## Points à vérifier collectivement

Question :

```text
index.php contient-il autre chose que les require et router() ?
```

Réponse attendue :

```php
require 'core/html.php';
require 'core/http.php';
require 'core/router.php';

router();
```

---

Question :

```text
Les controllers produisent-ils du HTML ?
```

Réponse attendue :

```text
Non. Ils appellent render().
```

---

Question :

```text
Les models produisent-ils du HTML ?
```

Réponse attendue :

```text
Non. Ils retournent des données.
```

---

Question :

```text
Les views peuvent-elles contenir foreach ?
```

Réponse attendue :

```text
Oui, si c’est uniquement pour afficher.
```

---

Question :

```text
Les views peuvent-elles appeler get_all_items() ?
```

Réponse attendue :

```text
Non. C’est le controller qui appelle le model.
```

---

# Questions fréquentes

## “Pourquoi appeler ça une view ?”

Parce que c’est ce que l’utilisateur voit.

Dans notre projet, une view est un fichier qui contient le HTML final ou presque final.

Exemple :

```text
views/item/show.php
```

affiche le détail d’un item.

---

## “Pourquoi appeler ça un controller ?”

Parce que ce fichier contrôle ce qui se passe après une demande.

Il ne fait pas tout lui-même.

Il décide :

```text
- quelles données demander
- quelle view afficher
- quoi faire si les données n’existent pas
```

---

## “Pourquoi appeler ça un model ?”

Parce que le model représente les données de l’application.

Dans cette séance, ce sont des tableaux.

Plus tard, ce seront des données venant d’une base de données.

Le rôle reste le même :

```text
fournir des données propres au controller
```

---

## “Pourquoi préfixer les fonctions avec le nom de l’entité ?”

Parce que PHP ne peut pas avoir deux fonctions avec le même nom.

On ne peut pas avoir plusieurs fonctions :

```php
function show() {
}
```

Mais on peut avoir :

```php
function item_show() {
}

function category_show() {
}
```

C’est aussi plus lisible.

---

## “Pourquoi toutes les actions ont `$id = null` ?”

Parce que le router appelle toujours l’action avec un id :

```php
$controllerAction($segments['id']);
```

Certaines actions utilisent cet id.

Exemple :

```php
item_show($id)
```

D’autres ne l’utilisent pas.

Exemple :

```php
item_index($id = null)
```

C’est volontaire : cela garde le router simple.

---

## “Et si l’id n’est pas bon ?”

Le router ne décide pas si l’id est bon.

Le router transmet l’id.

Le model cherche les données.

Si le model ne trouve rien, il retourne :

```php
null
```

Puis le controller affiche une 404.

---

## “Pourquoi deux 404 dans dispatch() ?”

Parce qu’il y a deux erreurs possibles.

Première erreur :

```text
Le controller n’existe pas.
```

Exemple :

```text
/admin
```

Le router cherche :

```text
controllers/admin.php
```

S’il ne trouve pas le fichier, on affiche :

```text
Entité inconnue
```

Deuxième erreur :

```text
Le controller existe, mais l’action n’existe pas.
```

Exemple :

```text
/item/delete/3
```

Le router trouve :

```text
controllers/item.php
```

Mais il ne trouve pas :

```php
item_delete()
```

On affiche :

```text
Action inconnue
```

---

## “Pourquoi pas de validation plus forte de l’URL ?”

Dans cette séance, on garde le router volontairement simple.

La seule validation au début est :

```php
file_exists()
```

Puis on ajoute :

```php
function_exists()
```

Plus tard, on pourra ajouter :

* validation des segments
* validation des méthodes HTTP
* routes nommées
* contraintes sur les ids
* routes plus complexes

Mais pas dans cette séance.

---

# Récapitulatif

Pour l’URL :

```text
/item/show/3
```

Le navigateur demande :

```text
/item/show/3
```

Le `.htaccess` envoie la requête vers :

```text
index.php
```

`index.php` lance :

```php
router();
```

`router()` appelle :

```php
parse_url_segments();
```

qui retourne :

```php
[
    'entity' => 'item',
    'action' => 'show',
    'id' => '3',
]
```

`dispatch()` construit :

```php
$controllerFile = 'controllers/item.php';
$controllerAction = 'item_show';
```

Il vérifie :

```php
file_exists($controllerFile)
```

Puis il inclut :

```php
controllers/item.php
```

Il vérifie :

```php
function_exists($controllerAction)
```

Puis il appelle :

```php
item_show('3');
```

Le controller appelle le model :

```php
$item = get_one_item('3');
```

Le model retourne :

```php
[
    'id' => 3,
    'name' => 'Écran',
    'category_id' => 2,
]
```

Le controller appelle :

```php
render('item/show', ['item' => $item]);
```

`render()` charge :

```text
views/item/show.php
```

La view affiche :

```php
<h1><?= escape($item['name']) ?></h1>
```

Chaîne complète :

```text
URL
 ↓
index.php
 ↓
router()
 ↓
parse_url_segments()
 ↓
dispatch()
 ↓
controller
 ↓
model
 ↓
render()
 ↓
view
 ↓
HTML
```

---

# Règles finales de la séance

```text
1. index.php est le point d’entrée.
2. Le router lit l’URL.
3. dispatch() trouve le controller.
4. Au début, un controller = un fichier par action.
5. Ensuite, un controller = une entité.
6. Dans un controller, une fonction = une action.
7. Le controller appelle le model.
8. Le model retourne des données.
9. Le controller choisit la view.
10. La view affiche.
11. render() charge une view.
12. escape() protège les sorties HTML.
13. Les controllers ne font pas echo.
14. Les models ne font pas de HTML.
15. Les views ne vont pas chercher les données elles-mêmes.
```
