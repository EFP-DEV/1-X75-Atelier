# Session 14 — Utilitaires HTTP

**Niveau : bases PHP acquises**

**Note :** tous les chemins dans le code sont écrits depuis la racine du projet, car toutes les requêtes passent par `index.php`. Le projet doit être servi à la racine du serveur web ; si on travaille dans un sous-dossier (ex. `localhost/mon-projet/`), il faudra retirer le préfixe.

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

`redirect()` doit être appelé avant tout affichage HTML — une fois du contenu envoyé au navigateur, `header()` ne fonctionne plus. `post()` est prévu pour des champs texte simples (un champ dont la valeur serait un tableau nécessiterait un traitement différent).

### À faire

1. Créer `core/http.php`
2. L'inclure dans `index.php`
3. Ajouter une action `item_search($id = null)` dans `controllers/item.php` qui :

   * si `is_post()` : récupère `post('q')`, filtre les items, affiche les résultats
   * sinon : affiche le formulaire de recherche vide
4. Créer `views/item/search.php` avec un formulaire POST et l'affichage des résultats
5. Après la soumission du formulaire, `redirect('/item/search?q=' . urlencode($q))` vers une version GET — pour que l'URL soit partageable et que le refresh ne resoumette pas le formulaire

### Critère de validation

La recherche fonctionne. Aucun accès direct à `$_POST` ou `$_SERVER` dans les controllers. `redirect()` est utilisé concrètement dans le flux.

---

## Bloc 9 — Mise en commun & questions (15 min)

### Points à vérifier collectivement

* `index.php` contient-il autre chose que les `require` et `router()` ?
* Les fonctions des controllers font-elles plus de 5 lignes ?
* Les models retournent-ils autre chose que des données ?
* Les views contiennent-elles de la logique métier ?

### Questions fréquentes

**"Pourquoi préfixer les fonctions avec le nom de l'entité ?"**
D'abord pour la lisibilité : `item_show` est non ambigu dans un stack trace ou un `grep`. Ensuite, ça évite des collisions dans les models, qui sont chargés en même temps.

**"Et si l'id n'est pas un nombre ?"**
`$segments['id']` est toujours une chaîne ou `null`. C'est au model de valider — pas au router.

**"Pourquoi deux 404 distincts dans `dispatch()` ?"**
Parce que ce ne sont pas la même erreur. L'un signifie que l'entité n'existe pas. L'autre signifie que l'entité existe mais ne gère pas cette action. En développement, la distinction aide à déboguer.

---

## Récapitulatif

```
URL : /item/show/3
       ↓
index.php            require core/html.php, core/router.php → router()
       ↓
parse_url_segments() → ['entity'=>'item', 'action'=>'show', 'id'=>'3']
       ↓
dispatch($segments)
  → controllers/item.php existe ?  non → 404
  → item_show existe ?             non → 404
  → item_show('3')
       ↓
controller  get_one_item('3') → model retourne ['id'=>3, 'name'=>'Souris']
  → null ? → 404
  → sinon  → render('item/show', ['item' => $item])
       ↓
view        affiche HTML via <?= escape(...) ?>
```
