# Session 10 — URL, MVC & organisation minimale d'un projet PHP

---

## Objectifs de la séance

À la fin de cette séance, l'étudiant sait :
- encapsuler le parsing d'URL dans une fonction `router()` qui orchestre deux responsabilités distinctes
- charger une view via `render()` plutôt qu'un `include` direct, et expliquer pourquoi
- justifier chaque choix de nommage et de structure, pas juste les appliquer
- organiser un projet en controllers / models / views à partir d'un diagnostic de ce qui ne va pas
- respecter la règle « aucune fonction ne fait `echo` ; seules les views affichent »

---

## Plan

| # | Bloc | Durée | Type |
|---|------|-------|------|
| 1 | De l'exercice à la fonction `router()` | 25 min | Cours + démo |
| 2 | `dispatch()` : trouver le fichier et l'exécuter | 25 min | Cours + démo |
| 3 | Afficher une view avec `render()` | 15 min | Cours |
| 4 | Exercice 1 — router + render fonctionnels | 30 min | TP |
| 5 | Faire évoluer la structure | 45 min | Cours + discussion |
| 6 | Controllers, models, views : rôles et règles | 20 min | Cours |
| 7 | Exercice 2 — mini projet structuré | 45 min | TP |
| 8 | Exercice 3 — utilitaires HTTP | 30 min | TP |
| 9 | Mise en commun & questions | 15 min | Discussion |

---

## Bloc 1 — De l'exercice à la fonction `router()` (25 min)

### Point de départ

L'exercice précédent a produit ce code dans `index.php` :

```php
$url   = 'product/show/12';
$parts = explode('/', trim($url, '/'));

$entity = $parts[0] ?? 'home';
$action = $parts[1] ?? 'index';
$id     = $parts[2] ?? null;
```

Trois segments, trois rôles : **une entité** (de quoi on parle), **une action** (ce qu'on en fait), **un id** (sur quel exemplaire). C'est le vocabulaire qu'on garde toute la séance.

Ce code fonctionne. Mais il est en vrac dans `index.php`, mélangé avec ce qui va suivre. **Poser la question à la classe : quel est le problème si tout reste dans `index.php` ?**

Réponses attendues :
- on ne peut pas le réutiliser
- on ne peut pas le tester isolément
- `index.php` devient illisible à mesure qu'on ajoute du code

La solution : mettre ce code dans une fonction. On l'a déjà fait en exercice — on l'appelle `parse_url_segments()`.

### `parse_url_segments()`

Elle retourne un tableau. **Poser la question : tableau indexé ou associatif ?**

Avec un tableau indexé, `$segments[0]` ne dit rien. Avec un tableau associatif, `$segments['entity']` dit exactement ce que c'est. Le code qui suit devient lisible sans commentaires.

**Poser la question : d'où on lit l'URL ?**

L'exercice utilisait `$_GET['url']` parce que le `.htaccess` redirige tout vers `index.php?url=...`. C'est fonctionnel mais artificiel — on crée un paramètre GET juste pour transporter quelque chose qui est déjà disponible nativement : `$_SERVER['REQUEST_URI']`.

`REQUEST_URI` contient le chemin brut tel que le navigateur l'a envoyé — `/item/show/3`. Il peut aussi contenir une query string — `/item/search?q=clavier`. On en veut que le chemin, donc on la retire avec `parse_url()` avant d'exploser.

```php
function parse_url_segments() {
    $uri  = $_SERVER['REQUEST_URI'] ?? '/';
    $path = trim(parse_url($uri, PHP_URL_PATH), '/');

    if ($path === '') {
        return ['entity' => 'home', 'action' => 'index', 'id' => null];
    }

    $parts = explode('/', $path);
    return [
        'entity' => $parts[0],
        'action' => $parts[1] ?? 'index',
        'id'     => $parts[2] ?? null,
    ];
}
```

**Pourquoi le cas spécial pour `/` ?**

`trim('/', '/')` donne `''`. `explode('/', '')` donne `['']` — un tableau d'un seul élément vide, pas un tableau vide. Sans le test, `$parts[0]` vaudrait `''` et le router chercherait `controllers/.php`. L'URL racine est le premier cas que les étudiants vont tester — il faut qu'elle marche.

### `router()`

On a une fonction qui parse. La séance d'aujourd'hui ajoute une deuxième responsabilité : **vérifier que ce que l'URL demande existe réellement**, et exécuter si c'est le cas.

Ces deux responsabilités sont distinctes — elles méritent chacune leur fonction. `router()` les orchestre :

```php
function router() {
    $segments = parse_url_segments();
    dispatch($segments);
}
```

`router()` ne fait rien elle-même. Elle délègue.

---

## Bloc 2 — `dispatch()` : trouver le fichier et l'exécuter (25 min)

### Le minimum : un fichier par URL

`dispatch()` reçoit les segments. Question minimale : **quel est le travail le plus simple possible pour exécuter la demande ?**

Trouver un fichier qui correspond à l'URL et l'inclure. C'est tout. Pas de fonction à appeler, pas de découpage : le fichier *est* l'action. Quand on l'inclut, son code s'exécute.

Pour `item/show/3`, on charge `item_show.php` et on lui rend l'id disponible. Pour `item`, on charge `item.php` (ou `item_index.php`).

**Poser la question : où mettre ces fichiers ?**

Pas dans la racine du projet — ils s'y mélangeraient avec `index.php`, le `.htaccess`, `core/`. On les regroupe dans un dossier dédié : `controllers/`. Le nom traduit ce que ces fichiers font : ils contrôlent ce qui se passe pour une URL donnée.

**Poser la question : comment construit-on le nom du fichier à charger ?**

Convention : `entity_action.php`. C'est la traduction directe de l'URL en chemin :

```php
$controllerFile = 'controllers/' . $segments['entity'] . '_' . $segments['action'] . '.php';
```

Avec `item/show/3` → `controllers/item_show.php`. Avec `/` (URL racine) → `controllers/home_index.php` grâce aux valeurs par défaut du parser.

### Première version de `dispatch()`

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

C'est tout. Une vérification, un include. La variable `$id` est définie juste avant l'`include` pour qu'elle soit disponible dans le fichier inclus — `include` partage le scope.

### À l'intérieur d'un controller

```php
// controllers/item_show.php
$item = get_one_item($id);
render('item/show', ['item' => $item]);
```

Pas de structure particulière. Le fichier est lu de haut en bas, `$id` est déjà là, le travail se fait.

### `dispatch()` et son seul cas d'erreur

**Poser la question : qu'est-ce qui peut mal tourner ?**

Une seule chose pour l'instant : le fichier n'existe pas. URL inconnue → 404.

**Pourquoi `render()` et pas `die('404 ...')` ?**

`die('texte')` envoie du texte brut au navigateur depuis `dispatch()`. Mais on vient d'établir que les fonctions métier ne produisent pas d'affichage — l'affichage passe par les views. Si `dispatch()` fait une exception, on enseigne la règle et on la viole dans la même fonction.

`render('error/404')` charge une view dédiée. `dispatch()` se contente de choisir laquelle, puis `return` pour s'arrêter proprement.

**Pourquoi `http_response_code(404)` ?**

Sans appel explicite, le navigateur reçoit un code 200 (succès) — alors que la page demandée n'existe pas. Le code HTTP doit refléter la réalité, indépendamment du contenu affiché.

La view `views/error/404.php` est minimale :

```php
<!-- views/error/404.php -->
<h1>404</h1>
<p><?= escape($message) ?></p>
```

### `index.php` résultant

```php
require 'core/router.php';
require 'core/html.php';
router();
```

`index.php` ne connaît pas les détails du routing.

### Ce qu'on a construit, et ce qu'on n'a pas encore

À ce stade, le router fonctionne. Une URL → un fichier → exécution. C'est volontairement minimal :
- un fichier par couple (entité, action)
- pas de structure MVC
- pas encore de modèle ou de séparation par couche

Tout ça arrive plus tard, comme **conséquence** des problèmes que cette version va poser quand on l'utilise pour de vrai.

---

## Bloc 3 — Afficher une view avec `render()` (15 min)

`dispatch()` appelle déjà `render()` pour la vue d'erreur 404 — il faut donc définir cette fonction avant que le router puisse fonctionner.

### Le principe

Le controller ne produit pas de HTML. Il décide *quoi* afficher, puis demande à `render()` de charger la view qui correspond. La view reçoit uniquement les variables que le controller lui passe explicitement.

```php
// core/html.php

function escape($value) {
    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}

function render($view, $data = []) {
    extract($data);
    include 'views/' . $view . '.php';
}
```

**Pourquoi un tableau `$data` plutôt qu'un `include` direct dans le controller ?**

Avec `include` direct, la view hérite de toutes les variables du scope appelant — y compris celles qu'on n'a pas voulu lui donner. `extract($data)` rend les dépendances explicites : la view reçoit *exactement* ce qu'on lui passe, rien de plus.

### Règle d'affichage pour la séance

Aucune fonction ne fait `echo`. Les controllers, models et le router ne produisent pas d'affichage. L'affichage est réservé aux views chargées par `render()`.

Dans une view, `<?= escape($var) ?>` est autorisé — c'est la *seule* exception, et c'est le rôle de la view.

```
controller  → décide quoi afficher
model       → fournit les données
view        → affiche
render()    → charge la view avec les bonnes données
```

---

## Bloc 4 — Exercice 1 : router + render fonctionnels (30 min)

### Consigne

Créer un projet minimal — un fichier par action :

```
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

`.htaccess` redirige toutes les requêtes vers `index.php` :

```apache
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ index.php [L]
```

`core/router.php` contient `parse_url_segments()`, `dispatch()`, et `router()`.
`core/html.php` contient `escape()` et `render()`.

Les controllers sont de simples scripts — du code qui s'exécute quand le fichier est inclus :

```php
// controllers/home_index.php
render('home/index');
```

```php
// controllers/item_index.php
render('item/index');
```

```php
// controllers/item_show.php
render('item/show', ['id' => $id]);
```

Les views sont minimales :

```php
<!-- views/home/index.php -->
<p>Accueil</p>

<!-- views/item/index.php -->
<p>Liste des items</p>

<!-- views/item/show.php -->
<p>Item n°<?= escape($id) ?></p>

<!-- views/error/404.php -->
<h1>404</h1>
<p><?= escape($message) ?></p>
```

### À tester

Tester avec les URLs réelles dans le navigateur :

| URL | Résultat attendu |
|-----|-----------------|
| `/` | `Accueil` |
| `/item` | `Liste des items` |
| `/item/show/3` | `Item n°3` |
| `/admin` | Vue 404 — `Page introuvable` |
| `/item/delete/3` | Vue 404 — `Page introuvable` |

### Critère de validation

Les cinq cas produisent le bon résultat. Aucun `echo` ni `die` dans le code — tout l'affichage passe par `render()`.

---

## Bloc 5 — Faire évoluer la structure (45 min)

À la fin de l'exercice 1, le projet marche. On va maintenant le faire grossir et observer ce que ça produit. Chaque problème va déclencher une décision.

### Étape 1 — Partir d'une seule entité

Prendre `item` comme exemple. Un item a une face publique et une face admin. **Poser la question : quelles URLs faut-il pour gérer un item complètement ?**

Laisser la classe lister. Réponse attendue :

```
# côté visiteur
/item                  → liste des items
/item/show/{id}        → détail
/item/search           → recherche

# côté admin
/admin_item            → liste avec actions
/admin_item/create     → formulaire de création
/admin_item/edit/{id}  → formulaire d'édition
/admin_item/delete/{id}→ suppression
```

Avec la règle actuelle (un fichier par action), ça donne :

```
controllers/item_index.php
controllers/item_show.php
controllers/item_search.php
controllers/admin_item_index.php
controllers/admin_item_create.php
controllers/admin_item_edit.php
controllers/admin_item_delete.php
```

7 fichiers pour une seule entité.

### Étape 2 — Projeter sur tout le projet

**Poser la question : combien d'entités dans ce projet ?**

Items, catégories, thèmes, tags, collections, utilisateurs — 6 entités. Plus `home` et `auth`.

Si on applique la même logique partout, voici à quoi ressemble le dossier `controllers/` :

```
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
├── admin_category_index.php
├── admin_category_create.php
├── admin_category_edit.php
├── admin_category_delete.php
├── collection_index.php
├── collection_show.php
├── admin_collection_index.php
├── admin_collection_create.php
├── admin_collection_edit.php
├── admin_collection_delete.php
├── tag_index.php
├── admin_tag_index.php
...
```

Et c'est sans compter `models/` et `views/` qui suivent la même logique.

**Poser la question : qu'est-ce qui ne va plus ?**

Laisser la classe répondre. Réponses attendues :
- 30+ fichiers dans un seul dossier
- l'admin et le public sont mélangés
- difficile de trouver ce qu'on cherche

C'est une saturation visuelle. Le code marche, mais il devient illisible.

---

### Première itération — introduire des dossiers

**Poser la question : qu'est-ce qu'on peut faire sans toucher au code, juste en réorganisant les fichiers ?**

Les regrouper en sous-dossiers. La séparation public / admin est la plus évidente :

```
controllers/
├── home_index.php
├── auth/
│   ├── login.php
│   ├── logout.php
│   └── register.php
├── item/
│   ├── index.php
│   ├── show.php
│   └── search.php
├── category/
│   └── index.php
├── collection/
│   ├── index.php
│   └── show.php
├── tag/
│   └── index.php
└── admin/
    ├── item/
    │   ├── index.php
    │   ├── create.php
    │   ├── edit.php
    │   └── delete.php
    ├── category/
    │   └── ...
    └── ...
```

Chaque entité a son dossier. L'admin a son propre arbre. On retrouve ses fichiers en suivant la hiérarchie.

**Conséquence pour `dispatch()` :**

Le segment `file` de l'URL doit maintenant pouvoir représenter un chemin. `item/show` → `controllers/item/show.php`. `admin/item/edit` → `controllers/admin/item/edit.php`.

C'est un détail d'implémentation : on adapte le parser pour qu'il garde le chemin complet sauf le dernier segment-id, ou on transforme `entity/action` en chemin de fichier. Ne pas s'attarder dessus — l'important c'est que **le code source n'a pas changé**, juste son emplacement.

À ce stade, le projet est rangé. Ça suffit ? Ça marche, oui. Mais il y a un autre problème, plus subtil.

---

### Deuxième itération — consolider les fichiers d'une même ressource

**Poser la question : qu'est-ce qu'ont en commun `controllers/item/index.php`, `controllers/item/show.php`, `controllers/item/search.php` ?**

Réponses attendues :
- ils touchent tous au même domaine (les items)
- ils ont tous besoin d'accéder aux données des items
- ils utilisent souvent les mêmes helpers, les mêmes validations
- quand on change la structure d'un item, on les modifie tous en même temps

**Concrètement, qu'est-ce qu'on duplique ?**

```php
// controllers/item/index.php
require 'models/item_model.php';
$items = get_all_items();
render('item/index', ['items' => $items]);

// controllers/item/show.php
require 'models/item_model.php';   // ← même require
$item = get_one_item($id);
render('item/show', ['item' => $item]);

// controllers/item/search.php
require 'models/item_model.php';   // ← encore
// ...
```

Le `require` du model est répété dans chaque fichier. Si on ajoute demain un helper, une vérification d'autorisation, du logging — il faut le copier dans chaque fichier de la ressource. Si on renomme le model, chasser toutes les occurrences.

**La solution : un fichier par entité, et chaque action devient une fonction PHP dans ce fichier.**

C'est ici que les *fonctions* PHP entrent en jeu — comme outil d'implémentation des actions. Une entité = un fichier ; une action = une fonction.

```php
// controllers/item.php
require 'models/item_model.php';   // une seule fois

function item_index() {
    $items = get_all_items();
    render('item/index', ['items' => $items]);
}

function item_show($id) {
    $item = get_one_item($id);
    render('item/show', ['item' => $item]);
}

function item_search() {
    // ...
}
```

C'est un choix de **cohésion** : ce qui change ensemble vit ensemble. La duplication disparaît, le fichier devient le bon endroit où chercher tout ce qui concerne `item`.

### Conséquence : `dispatch()` doit changer

Maintenant qu'un fichier contient plusieurs actions implémentées comme fonctions, charger le fichier ne suffit plus. Il faut aussi appeler la bonne.

**Poser la question : comment nommer la fonction pour qu'elle soit identifiable depuis l'URL ?**

Convention : `<entité>_<action>`. Pour `item/show/3`, on charge `controllers/item.php` et on appelle `item_show($id)`. C'est exactement la convention des anciens noms de fichiers — on la transpose au nom de la fonction.

`dispatch()` devient :

```php
function dispatch($segments) {
    $controllerFile   = 'controllers/' . $segments['entity'] . '.php';
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

Deux différences avec la version précédente :
1. Le chemin du fichier n'utilise plus que `entity` ; `action` sert maintenant à construire le **nom de la fonction à appeler**, plus le nom du fichier
2. Une deuxième vérification : le fichier existe peut-être, mais l'action peut ne pas y être implémentée — d'où le second 404 distinct

**Pourquoi le préfixe `<entité>_` sur les fonctions ?**

Pas pour éviter les collisions — `dispatch()` n'inclut qu'un controller à la fois, donc deux `show()` dans des fichiers différents ne se croisent jamais. C'est pour la lisibilité : `item_show` dit clairement à quelle entité appartient l'action. Dans un stack trace, dans un `grep`, dans un log, c'est non ambigu.

Pour les models, en revanche, la collision serait réelle — ils sont inclus ensemble, on y reviendra.

---

### Troisième itération — séparer les responsabilités

À ce stade, `controllers/item.php` contient tout ce qui concerne les items : routing d'URL, accès aux données, génération HTML. Le fichier marche, mais il fait trois choses très différentes.

**Poser la question : un controller bien conçu, qu'est-ce qu'il fait ?**

Trois rôles vont émerger :
- **recevoir la demande** et décider quoi faire
- **récupérer les données** (souvent depuis une base)
- **générer la sortie** (HTML)

Ces trois rôles changent à des rythmes différents : on change la base sans changer le HTML, on refait le HTML sans changer le routing. Quand ils cohabitent, toute modification oblige à lire le tout.

**Poser la question : comment les séparer ?**

Deux réponses raisonnables.

**Option A — grouper par ressource** : `item/` contient son controller, son model, ses vues.

```
project/
├── item/
│   ├── controller.php
│   ├── model.php
│   └── views/
├── category/
│   ├── controller.php
│   ├── model.php
│   └── views/
└── ...
```

**Option B — grouper par couche (MVC)** : tout ce qui fait du routing ensemble, tout ce qui touche aux données ensemble, tout ce qui affiche ensemble.

```
project/
├── controllers/
│   ├── item.php
│   ├── category.php
│   └── ...
├── models/
│   ├── item_model.php
│   ├── category_model.php
│   └── ...
└── views/
    ├── item/
    ├── category/
    └── ...
```

### Pourquoi MVC l'a emporté

Les deux options sont valides. **Poser la question : quelle différence concrète ?**

Avec l'option A, pour changer comment les données `item` sont stockées, on ouvre `item/` — mais le dossier contient aussi du HTML et du routing. Pour toucher à une chose, il faut comprendre le tout.

Avec l'option B, pour changer comment les données `item` sont stockées : `models/`. Pour changer l'affichage : `views/item/`. Les fichiers qui font le même *type* de travail sont ensemble — et surtout, ils ne font *que* ça.

Ce n'est pas que l'option A est fausse. C'est que MVC rend explicite une séparation qui existe de toute façon : dans n'importe quel projet, il y a du code qui touche aux données, du code qui affiche, du code qui orchestre. MVC dit juste : *ne les mélange pas dans le même fichier, et range-les séparément*.

C'est pour ça que tous les frameworks web — Laravel, Symfony, Rails, Django, Express — organisent le code de cette façon. Ce n'est pas une opinion, c'est une convention qui a émergé de décennies de projets où les responsabilités mélangées ont posé problème.

### Structure finale

```
project/
├── index.php
├── core/
│   ├── router.php
│   └── html.php
├── controllers/
│   ├── home.php
│   ├── item.php
│   ├── auth.php
│   └── collection.php
├── models/
│   ├── item_model.php
│   ├── category_model.php
│   └── collection_model.php
└── views/
    ├── home/
    ├── item/
    │   ├── index.php
    │   ├── show.php
    │   └── search.php
    ├── auth/
    └── collection/
```

**Pourquoi `views/item/` et pas `views/item_show.php` à plat ?**

Un item a plusieurs vues. Sans sous-dossier, `views/` reproduirait exactement le problème qu'on vient de résoudre.

---

## Bloc 6 — Controllers, models, views : rôles et règles (20 min)

### Trois rôles, trois règles

**Controller** — reçoit la demande, appelle le model, charge la view. Rien d'autre.

```php
function item_show($id = null) {
    $item = get_one_item($id);
    include 'views/item/show.php';
}
```

**Model** — retourne des données. Ne sait pas qu'il y a une view, ne sait pas qu'il y a une URL.

```php
function get_one_item($id) {
    $items = [
        1 => ['id' => 1, 'name' => 'Clavier'],
        2 => ['id' => 2, 'name' => 'Souris'],
    ];
    return $items[$id] ?? null;
}
```

**View** — reçoit des variables, produit du HTML. Aucun calcul, aucun accès aux données.

```php
<!-- views/item/show.php -->
<h1><?= htmlspecialchars($item['name']) ?></h1>
```

### Contre-exemples — montrer ce qu'on veut éviter

**SQL dans un controller :**
```php
// ❌
function item_show($id) {
    $pdo  = new PDO(...);
    $item = $pdo->query("SELECT * FROM items WHERE id = $id")->fetch();
    include 'views/item/show.php';
}
```
Si on change de base de données, on touche au controller. Si on change l'affichage, on doit lire du SQL pour s'y retrouver. Les responsabilités sont mélangées.

**HTML dans un model :**
```php
// ❌
function get_one_item($id) {
    return "<h1>Item $id</h1>";
}
```
Le model décide de l'affichage. Si on veut afficher le même item différemment selon le contexte, le model doit être modifié. C'est le rôle de la view.

### Règle à retenir

- Controller : **ni HTML, ni SQL**
- Model : **ni HTML, ni include**
- View : **ni calcul, ni accès direct aux données**

---

## Bloc 7 — Exercice 2 : mini projet structuré (45 min)

### Consigne

Construire un mini catalogue avec deux entités : **items** et **categories**.

URLs à faire fonctionner :
```
/                        → home_index()
/item                    → item_index()
/item/show/{id}          → item_show($id)
/item/category/{id}      → item_category($id)
```

Contraintes :
- Données en tableaux statiques dans les models — pas de SQL
- Chaque item a : `id`, `name`, `category_id`
- Chaque catégorie a : `id`, `name`
- `item_category($id)` filtre les items par `category_id`
- Les views utilisent `htmlspecialchars()` sur toutes les sorties

### Bonus

Ajouter `/item/search` qui filtre les items dont le nom contient `$_GET['q']`.

---

## Bloc 8 — Exercice 3 : utilitaires HTTP (30 min)

### Consigne

`render()` et `escape()` existent déjà dans `core/html.php`. Il manque les utilitaires pour gérer les requêtes POST et les redirections — utiles dès qu'on traitera les formulaires (login, création, édition).

Créer `core/http.php` :

```php
function redirect($url) {
    header('Location: ' . $url);
    exit;
}

function is_post() {
    return $_SERVER['REQUEST_METHOD'] === 'POST';
}

function post($key, $default = null) {
    return isset($_POST[$key]) ? trim($_POST[$key]) : $default;
}
```

### À faire

1. Créer `core/http.php`
2. L'inclure dans `index.php` (au même endroit que `core/html.php`)
3. Ajouter une action `item_search()` dans `controllers/item.php` qui utilise `post('q')` si la requête est `is_post()`, sinon affiche le formulaire de recherche
4. Créer `views/item/search.php` avec un formulaire et l'affichage des résultats

### Critère de validation

Le formulaire de recherche fonctionne en POST. Aucun accès direct à `$_POST` ou `$_SERVER` dans les controllers.

---

## Bloc 9 — Mise en commun & questions (15 min)

### Points à vérifier collectivement

- `index.php` contient-il autre chose que les `require` et `router()` ?
- Les fonctions des controllers font-elles plus de 5 lignes ?
- Les models retournent-ils autre chose que des données ?
- Les views contiennent-elles de la logique ?

### Questions fréquentes

**"Pourquoi préfixer les fonctions avec le nom du fichier ?"**
Pour éviter les collisions. PHP ne peut pas avoir deux fonctions `show()`. `item_show` et `product_show` coexistent sans problème.

**"Et si l'id n'est pas un nombre ?"**
`$segments['id']` est toujours une chaîne ou `null`. C'est au model de valider — pas au router.

**"Pourquoi deux 404 distincts dans `dispatch()` ?"**
Parce que ce ne sont pas la même erreur. L'un signifie que le controller n'existe pas. L'autre signifie que le controller existe mais ne gère pas cette action. En développement, la distinction aide à déboguer.

---

## Récapitulatif

```
URL : /item/show/3
       ↓
index.php            require core/router.php → router()
       ↓
parse_url_segments() → ['entity'=>'item', 'action'=>'show', 'id'=>'3']
       ↓
dispatch($segments)
  → controllers/item.php existe ?  non → 404
  → item_show existe ?             non → 404
  → item_show('3')
       ↓
controller  get_one_item('3') → model retourne ['id'=>3, 'name'=>'Souris']
       ↓
render('item/show', ['item' => $item])
       ↓
view        echo HTML
```
