# Session 12 — Faire évoluer la structure

**Niveau : bases PHP acquises**

**Note :** tous les chemins dans le code sont écrits depuis la racine du projet, car toutes les requêtes passent par `index.php`. Le projet doit être servi à la racine du serveur web ; si on travaille dans un sous-dossier (ex. `localhost/mon-projet/`), il faudra retirer le préfixe.

---

## Bloc 5 — Faire évoluer la structure (45 min)

À la fin de l'exercice 1, le projet marche. On va maintenant le faire grossir et observer ce que ça produit. Chaque problème va déclencher une décision.

### Étape 1 — Lister les fonctionnalités d'une seule entité

Prenons `item` comme exemple. Un item a une face publique et une face admin. Quelles URLs faut-il pour le gérer complètement ?

Réponse attendue :

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

Avec la règle actuelle (un fichier par action), ça donne 7 fichiers dans `controllers/` pour une seule entité.

### Étape 2 — Projeter sur tout le projet

Combien d'entités dans ce projet ?

Items, catégories, thèmes, tags, collections, utilisateurs — 6 entités. Plus `home` et `auth`.

Si on applique la même logique partout, `controllers/` atteint 30+ fichiers à plat. L'admin et le public sont mélangés. Difficile de trouver ce qu'on cherche.

C'est une saturation visuelle. Le code marche, mais il devient illisible.

---

### Première itération — introduire des dossiers

Sans changer la logique métier des fichiers, juste en changeant leur emplacement, comment améliorer ça ?

Les regrouper en sous-dossiers par entité. La séparation public/admin est la plus évidente. Le contenu des fichiers ne change pas — seuls leurs chemins bougent.

`dispatch()` doit s'adapter pour construire un chemin de fichier qui reflète cette hiérarchie (le parser produit les segments, le dispatcher les assemble en chemin). Ce n'est qu'un détail d'implémentation : on transforme `entity/action` en chemin vers le bon fichier. L'important : **le code métier des fichiers n'a pas changé**, juste leur emplacement.

À ce stade, le projet est rangé. Ça suffit ? Ça marche, oui. Mais il y a un autre problème, plus subtil.

**Note :** les routes admin à plusieurs niveaux (`/admin/item/edit/3`) dépassent les capacités du parser actuel (3 segments fixes). On les montre ici comme diagnostic visuel pour motiver l'organisation — le parser ne les gérera pas dans cette séance.

---

### Deuxième itération — consolider les fichiers d'une même entité

Qu'est-ce qu'ont en commun les différents fichiers d'une même entité — par exemple `item/index.php`, `item/show.php`, `item/search.php` ?

Réponses attendues :

* ils touchent tous au même domaine (les items)
* ils ont tous besoin d'accéder aux données des items
* ils utilisent souvent les mêmes helpers, les mêmes validations
* quand on change la structure d'un item, on les modifie tous en même temps

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

Le `require` du model est répété dans chaque fichier. Si on ajoute demain un helper, une vérification d'autorisation, du logging — il faut le copier dans chaque fichier. Si on renomme le model, chasser toutes les occurrences.

**La solution : un fichier par entité, et chaque action devient une fonction PHP dans ce fichier.**

C'est ici que les *fonctions PHP* entrent en jeu — comme outil d'implémentation des actions du site. Une entité = un fichier ; une action = une fonction.

```php
// controllers/item.php
require 'models/item_model.php';   // une seule fois

function item_index($id = null) {
    $items = get_all_items();
    render('item/index', ['items' => $items]);
}

function item_show($id = null) {
    $item = get_one_item($id);
    if ($item === null) {
        http_response_code(404);
        render('error/404', ['message' => 'Item introuvable']);
        return;
    }
    render('item/show', ['item' => $item]);
}

function item_search($id = null) {
    // ...
}
```

Toutes les actions acceptent `$id = null` — le router transmet toujours l'id, même quand l'action ne l'utilise pas.

C'est un choix de **cohésion** : ce qui change ensemble vit ensemble. La duplication disparaît, le fichier devient le bon endroit où chercher tout ce qui concerne `item`.

### Conséquence : `dispatch()` doit changer

Maintenant qu'un fichier contient plusieurs actions implémentées comme fonctions, charger le fichier ne suffit plus. Il faut aussi appeler la bonne.

Comment nommer la fonction pour qu'elle soit identifiable depuis l'URL ?

Convention : `<entité>_<action>`. Pour `item/show/3`, on charge `controllers/item.php` et on appelle `item_show($id)`. C'est exactement la convention des anciens noms de fichiers — on la transpose au nom de la fonction.

**À partir d'ici, on abandonne le système un fichier = une action. On passe au système un fichier controller = une entité, une fonction = une action.**

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

1. Le chemin du fichier n'utilise plus que `entity` ; `action` sert maintenant à construire le **nom de la fonction à appeler**, et non plus le nom du fichier
2. Une deuxième vérification : le fichier existe peut-être, mais l'action peut ne pas y être implémentée — d'où le second 404 distinct

**Pourquoi le préfixe `<entité>_` sur les fonctions ?**

D'abord pour la lisibilité et par convention : `item_show` dit clairement à quelle entité appartient l'action. Dans un stack trace, dans un `grep`, dans un log, c'est non ambigu.

Cela évite aussi des collisions si jamais plusieurs fichiers sont chargés dans un même contexte — pendant des tests, avec des includes multiples, ou dans les models où c'est effectivement le cas. Pour les models, le préfixe est structurellement obligatoire.

---

### Troisième itération — séparer les responsabilités

À ce stade, `controllers/item.php` contient tout ce qui concerne les items : routing d'URL, accès aux données, génération HTML. Le fichier marche, mais il fait trois choses très différentes.

Dans notre fichier actuel, quels rôles différents sont mélangés ?

Trois rôles vont émerger :

* **recevoir la demande** et décider quoi faire
* **récupérer les données** (souvent depuis une base)
* **générer la sortie** (HTML)

Ces trois rôles changent à des rythmes différents : on change la base sans changer le HTML, on refait le HTML sans changer le routing. Quand ils cohabitent, toute modification oblige à lire le tout.

Comment les séparer ?

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

### Pourquoi on choisit MVC par couche

Les deux options sont valides. Quelle différence concrète entre les deux ?

Avec l'option A, pour changer comment les données `item` sont stockées, on ouvre `item/` — mais le dossier contient aussi du HTML et du routing. Pour toucher à une chose, il faut comprendre le tout.

Avec l'option B, pour changer comment les données `item` sont stockées : `models/`. Pour changer l'affichage : `views/item/`. Les fichiers qui font le même *type* de travail sont ensemble — et surtout, ils ne font *que* ça.

Ce n'est pas que l'option A est fausse. C'est que MVC par couche rend les responsabilités plus visibles — c'est important quand on apprend à les distinguer. Beaucoup de frameworks web encouragent une séparation comparable entre routing/controllers, données et affichage.

### Structure finale

```
project/
├── index.php
├── .htaccess
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
    ├── error/
    │   └── 404.php
    ├── home/
    │   └── index.php
    ├── item/
    │   ├── index.php
    │   ├── show.php
    │   └── search.php
    ├── auth/
    └── collection/
```

**Pourquoi `views/item/` et pas `views/item_show.php` à plat ?**

Un item a plusieurs vues. Sans sous-dossier, `views/` reproduirait exactement le problème qu'on vient de résoudre.
