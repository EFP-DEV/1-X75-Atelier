# Session 8 — Ranger le trajet que vous connaissez déjà

Vous avez déjà vu le trajet général d’une requête.

Quand le navigateur demande une adresse comme :

```txt
/item/show/3
```

vous savez déjà que cette adresse peut être lue comme ceci :

```txt
entity = item
action = show
id     = 3
```

Vous savez aussi que cette route peut mener à :

```txt
controllers/item.php
item_show(3)
```

Le but de cette séance n’est donc pas d’inventer une nouvelle mécanique.

Le but est de ranger une mécanique que vous connaissez déjà.

Jusqu’ici, vous avez écrit les étapes directement dans `index.php`, ou presque directement. C’était utile pour apprendre, parce que vous pouviez voir chaque ligne, chaque variable, chaque transformation.

Mais maintenant, si on laisse tout dans `index.php`, le fichier va bientôt faire trop de choses.

Il va lire l’URL.
Il va retirer la query string.
Il va nettoyer les slashs.
Il va découper les segments.
Il va donner des valeurs par défaut.
Il va vérifier les segments.
Il va chercher le controller.
Il va charger un fichier.
Il va construire un nom de fonction.
Il va appeler cette fonction.
Il va envoyer une réponse.

Toutes ces étapes sont nécessaires.

Mais elles ne racontent pas toutes la même chose.

Certaines étapes parlent de HTTP.
Certaines étapes parlent de route.
Certaines étapes parlent de fichiers PHP.
Certaines étapes parlent de réponse envoyée au navigateur.

Si tout reste au même endroit, `index.php` devient difficile à lire. Le problème n’est pas que le code est faux. Le problème est que le fichier commence à mélanger plusieurs responsabilités.

Aujourd’hui, vous allez donc garder la même mécanique, mais lui donner une forme plus propre.

---

## Avant : le code de l’exercice

Vous êtes partis d’un code de ce genre :

```php
$url   = 'product/show/12';
$parts = explode('/', trim($url, '/'));

$entity = $parts[0] ?? 'home';
$action = $parts[1] ?? 'index';
$id     = $parts[2] ?? null;
```

Ce code est correct pour comprendre l’idée.

Il prend une adresse :

```txt
product/show/12
```

et il en tire trois informations :

```txt
entity = product
action = show
id     = 12
```

Mais ce code reste proche de l’exercice.

Dans un vrai site, l’adresse ne vient pas d’une variable écrite à la main :

```php
$url = 'product/show/12';
```

Elle vient de la requête envoyée par le navigateur.

Quand vous tapez une adresse dans le navigateur, le serveur reçoit une demande HTTP. PHP peut lire cette demande avec :

```php
$_SERVER['REQUEST_URI']
```

Par exemple, si le navigateur demande :

```txt
/item/show/3
```

PHP peut recevoir cette valeur.

Mais attention : cette valeur est encore une donnée HTTP brute.

Elle peut être :

```txt
/item/show/3
```

mais aussi :

```txt
/item/search?q=clavier
```

ou :

```txt
//item//show//3
```

ou simplement :

```txt
/
```

Avant de parler de controller, d’action ou d’id, vous devez d’abord transformer cette demande en segments propres.

C’est le rôle de `http_in()`.

---

# 1. `http_in()` : faire entrer proprement la demande HTTP

La première fonction importante est dans `core/http.php`.

Elle s’appelle :

```php
http_in()
```

Son rôle n’est pas de choisir une page.

Son rôle n’est pas de chercher un controller.

Son rôle n’est pas d’appeler une fonction.

Son rôle est plus simple :

```txt
prendre la demande HTTP
et en extraire les segments du chemin
```

Par exemple :

```txt
/item/show/3
```

devient :

```php
['item', 'show', '3']
```

Et :

```txt
/item/search?q=clavier
```

devient :

```php
['item', 'search']
```

La query string disparaît ici parce qu’elle ne sert pas à choisir le controller.

Dans :

```txt
/item/search?q=clavier
```

la route est :

```txt
/item/search
```

La partie :

```txt
?q=clavier
```

servira peut-être plus tard pour une recherche, un filtre ou une pagination. Mais elle ne sert pas à décider quelle fonction du controller doit être appelée.

C’est pour cela que `http_in()` reste au niveau HTTP.

Elle ne connaît pas encore les mots :

```txt
entity
action
id
```

Ces mots appartiennent à notre projet.

HTTP, lui, connaît seulement une adresse.

Donc `http_in()` dit seulement :

```txt
voici les morceaux du chemin
```

Elle ne dit pas encore :

```txt
voici l’entité, voici l’action, voici l’id
```

Cette différence est importante.

---

# 2. `route()` : donner un rôle aux segments

Après `http_in()`, vous avez un tableau simple :

```php
['item', 'show', '3']
```

Maintenant, vous pouvez utiliser la convention de votre projet.

Dans ce projet, vous décidez que les routes ont cette forme :

```txt
/entity/action/id
```

Donc :

```txt
/item/show/3
```

signifie :

```php
[
    'entity' => 'item',
    'action' => 'show',
    'id'     => '3',
]
```

C’est le rôle de `route()`.

`route()` ne lit pas directement `$_SERVER`.

`route()` ne s’occupe pas de la query string.

`route()` ne nettoie pas les doubles slashs.

Tout cela a déjà été fait par `http_in()`.

`route()` reçoit seulement des segments et leur donne un rôle.

Vous pouvez retenir la différence comme ceci :

```txt
http_in()
    découpe le chemin HTTP

route()
    donne un nom aux morceaux
```

C’est une séparation simple, mais très importante.

Si demain vous changez la manière de lire l’URL, vous irez voir `http_in()`.

Si demain vous changez la convention `/entity/action/id`, vous irez voir `route()`.

Vous n’aurez pas un seul gros bloc mélangé dans `index.php`.

---

## Les valeurs par défaut

Vous ne voulez pas obliger l’utilisateur à écrire :

```txt
/home/index
```

pour arriver sur l’accueil.

Vous voulez que cette adresse fonctionne :

```txt
/
```

Donc, si aucun segment n’est donné, `route()` décide :

```php
[
    'entity' => 'home',
    'action' => 'index',
    'id'     => null,
]
```

De la même façon, si l’utilisateur demande :

```txt
/item
```

vous décidez que cela signifie :

```txt
/item/index
```

Donc :

```php
[
    'entity' => 'item',
    'action' => 'index',
    'id'     => null,
]
```

Ces valeurs par défaut ne viennent pas de HTTP.

Elles viennent de la convention de votre projet.

C’est pour cela qu’elles appartiennent à `route()`, pas à `http_in()`.

---

# 3. `is_safe_segment()` : vérifier avant de construire un nom

À partir du moment où un morceau d’URL sert à construire un fichier, vous devez vérifier ce morceau.

Avec cette route :

```txt
/item/show/3
```

vous allez construire :

```txt
controllers/item.php
```

et :

```txt
item_show()
```

Donc `item` et `show` ne sont plus seulement du texte.

Ils deviennent des morceaux utilisés par PHP pour chercher un fichier et appeler une fonction.

Vous ne pouvez donc pas accepter n’importe quoi.

Vous ne voulez pas qu’une URL puisse contenir des caractères dangereux, des chemins bizarres ou du HTML.

Avant de construire le chemin du controller, vous posez donc une question simple :

```txt
Est-ce que ce segment est utilisable sans danger ?
```

C’est le rôle de :

```php
is_safe_segment()
```

Cette fonction ne vérifie pas si la page existe.

Elle vérifie seulement si le segment est acceptable.

Ce sont deux questions différentes.

Première question :

```txt
Est-ce que ce segment est propre ?
```

Deuxième question :

```txt
Est-ce que le controller existe ?
```

La première question appartient à `is_safe_segment()`.

La deuxième arrivera dans `run()`.

---

# 4. `run()` : passer de la route au vrai code PHP

Après `route()`, vous avez une route structurée.

Par exemple :

```php
[
    'entity' => 'item',
    'action' => 'show',
    'id'     => '3',
]
```

Mais cette route n’a encore rien exécuté.

Elle décrit seulement ce qu’il faut faire.

`run()` est la fonction qui transforme cette description en appel réel.

Elle applique la convention que vous avez déjà vue :

```txt
entity → fichier controller
entity + action → fonction
```

Donc :

```txt
/item/show/3
```

devient :

```txt
controllers/item.php
item_show('3')
```

`run()` fait plusieurs choses dans l’ordre.

Elle construit le chemin du controller.

Elle vérifie que le fichier existe.

Elle charge le fichier.

Elle construit le nom de la fonction.

Elle vérifie que la fonction existe.

Elle appelle la fonction.

Et surtout : elle retourne le résultat.

Elle ne fait pas `echo`.

C’est volontaire.

Le routeur ne doit pas envoyer la réponse au navigateur. Il doit seulement trouver et appeler le bon controller.

---

## Pourquoi `run()` retourne une chaîne ?

Dans ce projet, on veut garder un trajet clair :

```txt
le controller produit un contenu
index.php envoie la réponse
```

Donc `run()` appelle le controller et récupère ce que le controller retourne.

Pour l’instant, un controller peut retourner directement une chaîne HTML :

```php
function home_index()
{
    return '<main><h1>Accueil</h1></main>';
}
```

Ce n’est pas encore idéal, mais cela respecte déjà une règle importante :

```txt
le controller retourne
http_out() envoie
```

Si le controller faisait `echo`, si le routeur faisait `echo`, et si `index.php` faisait aussi `echo`, vous ne sauriez plus clairement qui répond au navigateur.

Donc on garde une règle simple :

```txt
Les fonctions préparent.
http_out() envoie.
```

---

# 5. `index.php` devient le chef d’orchestre

Après cette mise en fonction, `index.php` devient beaucoup plus lisible.

Il ne contient plus tous les détails.

Il montre seulement le trajet principal :

```php
$segments = http_in($_SERVER['REQUEST_URI'] ?? '/');

$route = route($segments);

$html = run($route, __DIR__);

http_out(200, $html);
```

Vous pouvez lire ce code comme une phrase :

```txt
Je lis la demande HTTP.
Je transforme les segments en route.
J’exécute la route.
J’envoie la réponse.
```

C’est le rôle du front controller.

Il ne fait pas tout lui-même.

Il organise les étapes.

---

# 6. Ce que vous avez vraiment fait aujourd’hui

Vous n’avez pas inventé une nouvelle architecture.

Vous avez pris un trajet que vous connaissiez déjà et vous l’avez rangé.

Avant, le raisonnement était écrit directement en lignes successives.

Après, chaque étape reçoit un nom.

Quand vous écrivez :

```php
http_in(...)
```

vous dites :

```txt
ici, je m’occupe de l’entrée HTTP
```

Quand vous écrivez :

```php
route(...)
```

vous dites :

```txt
ici, je donne un sens aux segments
```

Quand vous écrivez :

```php
run(...)
```

vous dites :

```txt
ici, j’appelle le bon controller
```

Quand vous écrivez :

```php
http_out(...)
```

vous dites :

```txt
ici, j’envoie la réponse HTTP
```

Nommer les étapes rend le code plus lisible.

Cela permet aussi de savoir où chercher quand quelque chose ne fonctionne pas.

Si l’URL est mal découpée, vous regardez `http_in()`.

Si les valeurs par défaut sont mauvaises, vous regardez `route()`.

Si le controller n’est pas trouvé, vous regardez `run()`.

Si la réponse ne part pas correctement, vous regardez `http_out()`.

---

# 7. La pièce manquante

À la fin de cette séance, le trajet ressemble à ceci :

```txt
http_in()
    ↓
route()
    ↓
run()
    ↓
controller
    ↓
http_out()
```

Il reste pourtant un problème.

`run()` attend que le controller retourne du HTML.

Donc, pour l’instant, un controller pourrait faire ceci :

```php
function home_index()
{
    return '<main><h1>Accueil</h1></main>';
}
```

Pour une petite page, cela passe.

Mais imaginez une vraie page HTML avec :

```txt
un titre
une navigation
une liste d’articles
des cartes
des boutons
des classes CSS
des conditions
des boucles
```

Si vous écrivez tout cela dans une chaîne de caractères retournée par le controller, le controller va devenir illisible.

Vous venez de nettoyer `index.php`.

Il ne faut pas maintenant salir les controllers avec tout le HTML.

Donc une nouvelle question apparaît :

```txt
Comment un controller peut-il retourner du HTML
sans écrire lui-même tout le HTML ?
```

C’est la pièce manquante.

---

# 8. Le prochain cours : `render()`

Le prochain cours répondra à cette question.

L’idée sera simple :

```txt
Le controller prépare les données.
La vue contient le HTML.
render() relie les deux.
```

Au lieu d’écrire tout le HTML dans le controller, vous aurez un fichier de vue :

```txt
views/home/index.php
```

Et le controller pourra dire :

```txt
utilise cette vue
avec ces données
et retourne-moi le HTML produit
```

Cette fonction s’appellera :

```php
render()
```

Elle devra faire attention à une règle déjà importante dans notre projet :

```txt
elle ne doit pas envoyer directement le HTML au navigateur
```

Elle devra retourner une chaîne.

Pourquoi ?

Parce que le trajet final doit rester le même :

```txt
controller
    retourne du HTML

run()
    récupère ce HTML

index.php
    l’envoie avec http_out()
```

Donc la prochaine pièce sera :

```txt
render()
    transforme une vue + des données en chaîne HTML
```

---

# Résumé à retenir

Aujourd’hui, vous avez rangé le trajet déjà compris :

```txt
http_in()
    reçoit le chemin HTTP et le transforme en segments

route()
    donne un rôle aux segments

run()
    appelle le controller correspondant

http_out()
    envoie la réponse au navigateur
```

Mais il manque encore une étape propre pour produire le HTML :

```txt
render()
    permettra au controller d’utiliser une vue
    sans écrire tout le HTML lui-même
```

La séparation n’est pas faite pour décorer le code.

Elle apparaît parce que chaque fichier commence à avoir un métier précis.

```txt
http.php
    entrée et sortie HTTP

router.php
    route et controller

html.php
    production du HTML

index.php
    orchestration du trajet
```

À ce stade, vous savez faire arriver une requête jusqu’au bon controller.

Au prochain cours, vous apprendrez à faire produire au controller une réponse HTML propre, sans le transformer en fichier rempli de chaînes de caractères.
