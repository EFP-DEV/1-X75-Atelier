# Session 10 — URL, MVC et organisation minimale d'un projet PHP

L'objectif de cette séance n'est pas d'apprendre un framework. C'est de comprendre une mécanique simple : une URL exprime une demande, cette demande pointe vers un fichier, ce fichier exécute une action, et l'action peut utiliser une donnée. Rien de plus.

On part d'une URL à trois segments : `file/function/id`. Quelque chose comme `product/show/12` ou juste `product`. Chaque segment a un rôle précis — le premier désigne le fichier controller à charger, le deuxième l'action à exécuter, le troisième une valeur optionnelle.

Comme le rewrite n'est pas encore au programme, on simule avec une variable :

```php
$url = 'product/show/12';
$parts = explode('/', trim($url, '/'));

$file     = $parts[0] ?? 'home';
$function = $parts[1] ?? 'index';
$id       = $parts[2] ?? null;
```

On manipule une chaîne, on la découpe, on assigne des valeurs par défaut. C'est déjà concret. De là, on construit le chemin du controller et le nom de la fonction à appeler :

```php
$controllerFile     = 'controllers/' . $file . '.php';
$controllerFunction = $file . '_' . $function;
```

Avec `product/show/12`, on obtient `controllers/product.php`, la fonction `product_show`, et l'id `12`. La logique devient visible. On vérifie que le fichier et la fonction existent, puis on exécute :

```php
if (!file_exists($controllerFile)) die('Controller introuvable');
include $controllerFile;
if (!function_exists($controllerFunction)) die('Action introuvable');
$controllerFunction($id);
```

Le controller lui-même est délibérément plat. Il reçoit la demande, appelle le model, charge la view :

```php
function product_show($id = null) {
    $product = get_one_product($id);
    include 'views/product/show.php';
}
```

Le model, pour l'instant, ne touche pas à SQL — c'est intentionnel. Le sujet du jour, c'est l'organisation et la circulation de la demande, pas les requêtes. Un tableau statique suffit :

```php
function get_one_product($id) {
    $products = [
        1 => ['id' => 1, 'name' => 'Clavier'],
        2 => ['id' => 2, 'name' => 'Souris'],
        3 => ['id' => 3, 'name' => 'Écran']
    ];
    return $products[$id] ?? null;
}
```

La view reçoit la donnée et produit du HTML. Rien d'autre.

--- 


# Structure

Good. Clear enough to work with. Here's the URL sitemap and file structure:

---

## URL Sitemap

```text
Public
──────────────────────────────
/                        → home/index
/item                    → item/index        (liste tous les items)
/item/show/{id}          → item/show         (détail d'un item)
/item/category/{id}      → item/category     (items par catégorie)
/item/theme/{id}         → item/theme        (items par thème)
/item/tag/{id}           → item/tag          (items par tag)
/item/search             → item/search       (recherche texte)

Auth
──────────────────────────────
/auth/login              → auth/login
/auth/logout             → auth/logout
/auth/register           → auth/register

User (connecté)
──────────────────────────────
/collection              → collection/index  (mes collections)
/collection/show/{id}    → collection/show
/collection/create       → collection/create
/collection/edit/{id}    → collection/edit
/collection/delete/{id}  → collection/delete

Admin (permission requise)
──────────────────────────────
/admin                   → admin/index
/admin/item              → admin/item/index
/admin/item/create       → admin/item/create
/admin/item/edit/{id}    → admin/item/edit
/admin/item/delete/{id}  → admin/item/delete
/admin/category          → admin/category/index
/admin/category/create   → admin/category/create
/admin/category/edit/{id}→ admin/category/edit
/admin/operator          → admin/operator/index
/admin/operator/edit/{id}→ admin/operator/edit
```

---

## File Structure

```text
project/
│
├── index.php                        ← front controller, routing
├── .htaccess                        ← rewrite all to index.php
│
├── config/
│   └── db.php                       ← PDO connection
│
├── core/
│   ├── router.php                   ← parse URL, dispatch
│   ├── auth.php                     ← session helpers, permission check
│   ├── html.php                     ← escape, render
│   └── http.php                     ← redirect(), get_params(), etc.
│
├── controllers/
│   ├── home.php
│   ├── item.php
│   ├── auth.php
│   ├── collection.php
│   └── admin/
│       ├── admin.php
│       ├── item.php
│       ├── category.php
│       └── operator.php
│
├── models/
│   ├── item_model.php
│   ├── category_model.php
│   ├── theme_model.php
│   ├── tag_model.php
│   ├── collection_model.php
│   └── operator_model.php
│
└── views/
    ├── layout/
    │   ├── header.php
    │   └── footer.php
    ├── home/
    │   └── index.php
    ├── item/
    │   ├── index.php
    │   ├── show.php
    │   └── search.php
    ├── auth/
    │   ├── login.php
    │   └── register.php
    ├── collection/
    │   ├── index.php
    │   ├── show.php
    │   └── form.php                 ← shared by create/edit
    └── admin/
        ├── index.php
        ├── item/
        │   ├── index.php
        │   └── form.php
        ├── category/
        │   ├── index.php
        │   └── form.php
        └── operator/
            └── index.php
```





