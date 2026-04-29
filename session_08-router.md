# Session 10 — De l'exercice à la fonction `router()`

**Niveau : bases PHP acquises**

**Note :** tous les chemins dans le code sont écrits depuis la racine du projet, car toutes les requêtes passent par `index.php`. Le projet doit être servi à la racine du serveur web ; si on travaille dans un sous-dossier (ex. `localhost/mon-projet/`), il faudra retirer le préfixe.

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

Ce code fonctionne. Mais il est en vrac dans `index.php`, mélangé avec ce qui va suivre.

Quel est le problème si tout ce code reste dans `index.php` ?

Réponses attendues :

* on ne peut pas le réutiliser
* on ne peut pas le tester isolément
* `index.php` devient illisible à mesure qu'on ajoute du code

La solution : mettre ce code dans une fonction. On l'a déjà fait en exercice — on l'appelle `parse_url_segments()`.

### `parse_url_segments()`

Elle retourne un tableau. Indexé ou associatif ?

Avec un tableau indexé, `$segments[0]` ne dit rien. Avec un tableau associatif, `$segments['entity']` dit exactement ce que c'est. Le code qui suit devient lisible sans commentaires.

D'où lit-on l'URL ?

L'exercice utilisait `$_GET['url']` parce que le `.htaccess` redirige tout vers `index.php?url=...`. C'est fonctionnel mais artificiel — on crée un paramètre GET juste pour transporter quelque chose qui est déjà disponible nativement : `$_SERVER['REQUEST_URI']`.

`REQUEST_URI` contient le chemin brut tel que le navigateur l'a envoyé — `/item/show/3`. Il peut aussi contenir une query string — `/item/search?q=clavier`. On ne veut que le chemin, donc on le sépare avec `parse_url()` avant d'exploser.

**Convention :** `entity` et `action` ne contiennent que des lettres minuscules et des underscores. Pas de tirets, pas de caractères spéciaux — on utilise ces valeurs pour construire des noms de fichiers et plus tard des noms de fonctions PHP.

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

Ces deux responsabilités sont distinctes — elles méritent chacune leur propre code. `router()` les orchestre :

```php
function router() {
    $segments = parse_url_segments();
    dispatch($segments);
}
```

`router()` ne fait rien elle-même. Elle délègue.

---
