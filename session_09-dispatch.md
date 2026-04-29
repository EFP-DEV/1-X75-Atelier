# Session 11 — `dispatch()` et `render()`

**Niveau : bases PHP acquises**

**Note :** tous les chemins dans le code sont écrits depuis la racine du projet, car toutes les requêtes passent par `index.php`. Le projet doit être servi à la racine du serveur web ; si on travaille dans un sous-dossier (ex. `localhost/mon-projet/`), il faudra retirer le préfixe.

---

## Bloc 2 — `dispatch()` : trouver le fichier et l'exécuter (20 min)

### Le minimum : un fichier par URL

`dispatch()` reçoit les segments. Question minimale : **quel est le travail le plus simple possible pour exécuter la demande ?**

Trouver un fichier qui correspond à l'URL et l'inclure. C'est tout. Le fichier *est* l'action. Quand on l'inclut, son code s'exécute.

Pour `item/show/3`, on charge `item_show.php` et on lui rend l'id disponible. Pour `item` (action par défaut `index`), on charge `item_index.php`.

Où ranger ces fichiers ?

Pas dans la racine du projet — ils s'y mélangeraient avec `index.php`, le `.htaccess`, `core/`. On les regroupe dans un dossier dédié : `controllers/`. Le nom traduit ce que ces fichiers font : ils contrôlent ce qui se passe pour une URL donnée.

Comment construit-on le nom du fichier à charger ?

Convention : `entity_action.php`. C'est la traduction directe de l'URL en chemin :

```php
$controllerFile = 'controllers/' . $segments['entity'] . '_' . $segments['action'] . '.php';
```

Avec `item/show/3` → `controllers/item_show.php`. Avec `/` (URL racine) → `controllers/home_index.php` grâce aux valeurs par défaut du parser.

### Première version de `dispatch()`

On utilise ici `render()` comme boîte noire — elle sera définie dans le bloc suivant. Pour l'instant, il suffit de savoir qu'elle charge un fichier view et lui passe des variables.

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

Qu'est-ce qui peut mal tourner ?

Une seule chose pour l'instant : le fichier n'existe pas. URL inconnue → 404.

**Pourquoi `render()` et pas `die('404 ...')` ?**

`die('texte')` envoie du texte brut au navigateur depuis `dispatch()`. La règle qu'on va poser : les fonctions de logique ne produisent pas d'affichage — l'affichage passe par les views. Si `dispatch()` fait une exception dès le départ, la règle est morte avant d'avoir vécu.

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
require 'core/html.php';
require 'core/router.php';
router();
```

`html.php` avant `router.php` parce que `dispatch()` a besoin de `render()`.

### Ce qu'on a construit, et ce qu'on n'a pas encore

À ce stade, le router fonctionne. Une URL → un fichier → exécution. C'est volontairement minimal :

* un fichier par couple (entité, action)
* pas de structure MVC
* pas encore de modèle ou de séparation par couche

Tout ça arrive plus tard, comme **conséquence** des problèmes que cette version va poser quand on l'utilise pour de vrai.

---

## Bloc 3 — Afficher une view avec `render()` (15 min)

`dispatch()` appelle déjà `render()` — il faut donc la définir avant que le router puisse fonctionner.

### Le principe

Le controller ne produit pas de HTML. Il décide *quoi* afficher, puis demande à `render()` de charger la view qui correspond. La view reçoit uniquement les variables que le controller lui passe explicitement.

```php
// core/html.php

function escape($value) {
    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}

function render($view, $data = []) {
    extract($data, EXTR_SKIP);
    include 'views/' . $view . '.php';
}
```

`escape()` encapsule `htmlspecialchars()`. À partir de maintenant, c'est `escape()` qu'on utilise partout dans les views — plus jamais `htmlspecialchars()` directement.

**Pourquoi un tableau `$data` plutôt qu'un `include` direct dans le controller ?**

Avec `include` direct, la view hérite de toutes les variables du scope appelant — y compris celles qu'on n'a pas voulu lui donner. Avec `extract($data)`, la view n'hérite plus du scope du controller ; elle reçoit les variables qu'on choisit de lui transmettre, et `EXTR_SKIP` empêche une clé du tableau d'écraser une variable interne de `render()`.

### Règle d'affichage pour la séance

Aucune fonction de logique ne produit d'affichage. Les controllers, les models et le router ne font pas d'`echo`, pas de `print`, pas de `die('texte')`. L'affichage est réservé aux views chargées par `render()`.

Dans une view, `<?= escape($var) ?>` est autorisé — c'est le rôle de la view.

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

| URL              | Résultat attendu             |
| ---------------- | ---------------------------- |
| `/`              | `Accueil`                    |
| `/item`          | `Liste des items`            |
| `/item/show/3`   | `Item n°3`                   |
| `/admin`         | Vue 404 — `Page introuvable` |
| `/item/delete/3` | Vue 404 — `Page introuvable` |

### Critère de validation

Les cinq cas produisent le bon résultat. Aucun `echo` ni `die` dans le code — tout l'affichage passe par `render()`.
