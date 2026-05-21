# Session 9 — Choisir une grammaire d’URL pour le catalogue

## Objectif

Vous devez choisir une grammaire d’URL pour la partie publique d’un site de catalogue.

Le but n’est pas seulement de choisir une URL qui fonctionne. Vous devez comprendre ce que chaque choix provoque dans le projet :

```txt
nombre de fichiers controller
nombre de fonctions
duplication du code
facilité à combiner les filtres
facilité à créer un formulaire de recherche
lisibilité pour l’utilisateur
lisibilité pour le développeur
facilité de maintenance
```

À la fin de l’exercice, vous devrez proposer une grammaire d’URL pour votre projet et la justifier.

---

# 1. Contexte

Votre site contient un catalogue d’éléments.

Selon votre projet, un élément peut être :

```txt
un livre
un film
une recette
un produit
un jeu
une chaussette
un article
```

Chaque élément peut avoir :

```txt
un titre
un slug
une description
une ou plusieurs catégories
un ou plusieurs thèmes
un ou plusieurs tags
```

Le visiteur doit pouvoir :

```txt
voir tout le catalogue
chercher un texte dans le catalogue
sélectionner une ou plusieurs catégories
sélectionner un ou plusieurs thèmes
sélectionner un ou plusieurs tags
combiner recherche + catégories + thèmes + tags
trier les résultats
changer de page
voir le détail d’un élément
```

Exemple de besoin complexe :

```txt
Je veux chercher "monkey",
dans les catégories "books" et "games",
avec les thèmes "chess" et "fantasy",
sur la page 2,
trié par titre.
```

---

# 2. Problème à résoudre

On doit représenter ces actions dans des URLs.

Mais plusieurs grammaires sont possibles.

Vous allez comparer plusieurs solutions.

Pour chaque solution, vous devez répondre à cette question :

```txt
Qu’est-ce que cette grammaire d’URL provoque dans le code ?
```

---

# 3. Grammaire A — URL orientée entité technique

Exemples :

```txt
/theme/show/1
/category/show/1
/tag/show/1
/search/index?q=monkey
```

## Analyse

Questions :

```txt
Quelle page le visiteur voit-il réellement ?
Est-ce vraiment une page "theme" ?
Est-ce vraiment une page "category" ?
Est-ce vraiment une page "tag" ?
Est-ce que la recherche est une page séparée du catalogue ?
```

Complétez :

```txt
Page réellement affichée :
________________________________________________________

Controller probable pour /theme/show/1 :
________________________________________________________

Controller probable pour /category/show/1 :
________________________________________________________

Controller probable pour /tag/show/1 :
________________________________________________________

Controller probable pour /search/index?q=monkey :
________________________________________________________
```

## Fichiers probables

Complétez :

```txt
controllers/
    __________________.php
    __________________.php
    __________________.php
    __________________.php
    __________________.php
```

## Fonctions probables

Complétez :

```txt
________________()
________________()
________________()
________________()
________________()
```

## Test avec filtres multiples

Avec cette grammaire, essayez d’écrire l’URL correspondant à ce besoin :

```txt
Chercher "monkey",
dans les catégories "books" et "games",
avec les thèmes "chess" et "fantasy",
sur la page 2.
```

URL proposée :

```txt
________________________________________________________
```

Est-ce facile à écrire ?

```txt
Oui / Non
```

Pourquoi ?

```txt



```

## Conséquences

Complétez :

```txt
Nombre de fichiers controller :
faible / moyen / élevé

Nombre de fonctions :
faible / moyen / élevé

Risque de duplication :
faible / moyen / élevé

Facilité à combiner plusieurs filtres :
faible / moyenne / élevée

Facilité à créer un formulaire de recherche :
faible / moyenne / élevée

Lisibilité pour le visiteur :
faible / moyenne / élevée

Lisibilité pour le développeur :
faible / moyenne / élevée
```

Votre conclusion sur cette grammaire :

```txt
Avantages :



Inconvénients :



```

---

# 4. Grammaire B — URL orientée catalogue avec segments

Exemples :

```txt
/catalog
/catalog/theme/chess
/catalog/category/books
/catalog/tag/beginner
/catalog/search/monkey
```

## Analyse

Questions :

```txt
Quelle est la page principale ?
Est-ce que le thème est une page ou un filtre ?
Est-ce que la catégorie est une page ou un filtre ?
Est-ce que la recherche est une page ou un filtre ?
```

Complétez :

```txt
Page principale :
________________________________________________________

Controller probable :
________________________________________________________
```

## Fichiers probables

Complétez :

```txt
controllers/
    __________________.php
```

## Fonctions probables

Complétez :

```txt
________________()
________________()
________________()
________________()
________________()
```

Exemple possible :

```txt
catalog_index()
catalog_theme()
catalog_category()
catalog_tag()
catalog_search()
```

## Test avec filtres multiples

Avec cette grammaire, essayez d’écrire l’URL correspondant à ce besoin :

```txt
Chercher "monkey",
dans les catégories "books" et "games",
avec les thèmes "chess" et "fantasy",
sur la page 2,
trié par titre.
```

URL proposée :

```txt
________________________________________________________
```

Questions :

```txt
L’URL reste-t-elle lisible ?
Est-ce facile d’ajouter une deuxième catégorie ?
Est-ce facile d’ajouter un deuxième thème ?
Est-ce facile d’ajouter une pagination ?
Est-ce facile d’ajouter un tri ?
```

Réponse :

```txt



```

## Conséquences

Complétez :

```txt
Nombre de fichiers controller :
faible / moyen / élevé

Nombre de fonctions :
faible / moyen / élevé

Risque de duplication :
faible / moyen / élevé

Facilité à combiner plusieurs filtres :
faible / moyenne / élevée

Facilité à créer un formulaire de recherche :
faible / moyenne / élevée

Lisibilité pour le visiteur :
faible / moyenne / élevée

Lisibilité pour le développeur :
faible / moyenne / élevée
```

Votre conclusion sur cette grammaire :

```txt
Avantages :



Inconvénients :



```

---

# 5. Grammaire C — Catalogue avec query string simple

Exemples :

```txt
/catalog
/catalog?q=monkey
/catalog?theme=chess
/catalog?category=books
/catalog?tag=beginner
/catalog?page=2
```

## Analyse

Questions :

```txt
Est-ce que la page change vraiment ?
Ou est-ce que l’état du catalogue change ?
```

Complétez :

```txt
Page principale :
________________________________________________________

Controller probable :
________________________________________________________

Fonction probable :
________________________________________________________
```

## Fichiers probables

Complétez :

```txt
controllers/
    __________________.php
```

## Fonctions probables

Complétez :

```txt
________________()
```

## Paramètres possibles

Complétez :

```txt
q        = ________________________________________
theme    = ________________________________________
category = ________________________________________
tag      = ________________________________________
page     = ________________________________________
sort     = ________________________________________
```

## Limite de cette grammaire

Cette grammaire fonctionne bien pour un seul thème ou une seule catégorie.

Mais le moteur de recherche doit permettre plusieurs catégories et plusieurs thèmes.

Question :

```txt
Comment représenter plusieurs catégories avec cette forme ?
```

Exemple attendu :

```txt
/catalog?category=books&category=games
```

ou :

```txt
/catalog?categories=books,games
```

ou :

```txt
/catalog?categories[]=books&categories[]=games
```

Quelle solution semble la plus claire pour votre projet ?

```txt
________________________________________________________
```

Pourquoi ?

```txt



```

## Conséquences

Complétez :

```txt
Nombre de fichiers controller :
faible / moyen / élevé

Nombre de fonctions :
faible / moyen / élevé

Risque de duplication :
faible / moyen / élevé

Facilité à combiner plusieurs filtres :
faible / moyenne / élevée

Facilité à créer un formulaire de recherche :
faible / moyenne / élevée

Lisibilité pour le visiteur :
faible / moyenne / élevée

Lisibilité pour le développeur :
faible / moyenne / élevée
```

Votre conclusion sur cette grammaire :

```txt
Avantages :



Inconvénients :



```

---

# 6. Grammaire D — Catalogue avec query string et filtres multiples

Exemples :

```txt
/catalog
/catalog?q=monkey
/catalog?categories[]=books&categories[]=games
/catalog?themes[]=chess&themes[]=fantasy
/catalog?tags[]=beginner&tags[]=rare
/catalog?q=monkey&categories[]=books&categories[]=games&themes[]=chess&themes[]=fantasy&page=2&sort=title
```

Cette grammaire utilise la query string pour représenter l’état du catalogue.

Le chemin reste :

```txt
/catalog
```

Les options actives sont dans la query string :

```txt
?q=monkey&categories[]=books&themes[]=chess&page=2
```

## Analyse

Questions :

```txt
Quelle est la vraie page ?
Qu’est-ce qui change dans la page ?
Est-ce que la recherche est une page séparée ?
Est-ce que les catégories sont des pages séparées ?
Est-ce que les thèmes sont des pages séparées ?
```

Complétez :

```txt
Vraie page :
________________________________________________________

État de la page :
________________________________________________________

Controller probable :
________________________________________________________

Fonction probable :
________________________________________________________
```

## Fichiers probables

Complétez :

```txt
controllers/
    __________________.php
```

## Fonctions probables

Complétez :

```txt
________________()
```

## Paramètres possibles

Complétez :

```txt
q            = ________________________________________
categories  = ________________________________________
themes      = ________________________________________
tags        = ________________________________________
page        = ________________________________________
sort        = ________________________________________
```

## Test avec filtres multiples

Écrivez l’URL correspondant à ce besoin :

```txt
Chercher "monkey",
dans les catégories "books" et "games",
avec les thèmes "chess" et "fantasy",
sur la page 2,
trié par titre.
```

URL proposée :

```txt
________________________________________________________
```

## Formulaire HTML

Cette grammaire peut être produite naturellement par un formulaire GET.

Complétez le formulaire :

```html
<form action="_____________" method="_____">

    <label for="q">Recherche</label>
    <input id="q" type="text" name="_____" placeholder="Recherche">

    <fieldset>
        <legend>Catégories</legend>

        <label>
            <input type="checkbox" name="_____________" value="books">
            Books
        </label>

        <label>
            <input type="checkbox" name="_____________" value="games">
            Games
        </label>

        <label>
            <input type="checkbox" name="_____________" value="comics">
            Comics
        </label>
    </fieldset>

    <fieldset>
        <legend>Thèmes</legend>

        <label>
            <input type="checkbox" name="_____________" value="chess">
            Chess
        </label>

        <label>
            <input type="checkbox" name="_____________" value="fantasy">
            Fantasy
        </label>

        <label>
            <input type="checkbox" name="_____________" value="absurdity">
            Absurdity
        </label>
    </fieldset>

    <label for="sort">Tri</label>
    <select id="sort" name="_____">
        <option value="title">Titre</option>
        <option value="date">Date</option>
    </select>

    <button type="submit">Filtrer</button>

</form>
```

URL produite si l’utilisateur cherche `monkey`, coche `books`, `games`, `chess`, `fantasy`, puis trie par titre :

```txt
________________________________________________________
```

## Conséquences

Complétez :

```txt
Nombre de fichiers controller :
faible / moyen / élevé

Nombre de fonctions :
faible / moyen / élevé

Risque de duplication :
faible / moyen / élevé

Facilité à combiner plusieurs filtres :
faible / moyenne / élevée

Facilité à créer un formulaire de recherche :
faible / moyenne / élevée

Facilité à ajouter pagination et tri :
faible / moyenne / élevée

Lisibilité pour le visiteur :
faible / moyenne / élevée

Lisibilité pour le développeur :
faible / moyenne / élevée
```

Votre conclusion sur cette grammaire :

```txt
Avantages :



Inconvénients :



```

---

# 7. Grammaire E — Grammaire mixte

Exemples :

```txt
/catalog
/catalog?q=monkey&categories[]=books&themes[]=chess
/catalog/theme/chess
/catalog/category/books
/item/the-great-monkey-gambit
```

Dans cette solution, on mélange deux idées :

```txt
/catalog?... 
```

pour la recherche et les filtres combinés,

et :

```txt
/catalog/theme/chess
/catalog/category/books
```

pour certaines pages publiques plus lisibles.

## Analyse

Questions :

```txt
Est-ce que /catalog/theme/chess affiche un résultat différent de /catalog?themes[]=chess ?
Est-ce que ce sont deux URLs pour le même contenu ?
Est-ce que cela peut créer de la confusion ?
Est-ce que cela peut être utile pour certaines pages publiques importantes ?
```

Réponse :

```txt



```

## Fichiers probables

Complétez :

```txt
controllers/
    __________________.php
    __________________.php
```

## Fonctions probables

Complétez :

```txt
________________()
________________()
________________()
________________()
```

## Conséquences

Complétez :

```txt
Nombre de fichiers controller :
faible / moyen / élevé

Nombre de fonctions :
faible / moyen / élevé

Risque de duplication :
faible / moyen / élevé

Risque d’avoir plusieurs URLs pour le même contenu :
faible / moyen / élevé

Facilité à combiner plusieurs filtres :
faible / moyenne / élevée

Lisibilité pour le visiteur :
faible / moyenne / élevée

Complexité pour le développeur :
faible / moyenne / élevée
```

Votre conclusion sur cette grammaire :

```txt
Avantages :



Inconvénients :



```

---

# 8. Comparaison globale

Complétez le tableau.

```txt
+---------------------------------------------+-------------------+--------------------+----------------------+----------------------+-------------------------+
| Grammaire                                   | Fichiers nombreux ?| Fonctions nombreuses?| Filtres combinables ? | Formulaire facile ?  | URL lisible public ?    |
+---------------------------------------------+-------------------+--------------------+----------------------+----------------------+-------------------------+
| /theme/show/1                               |                   |                    |                      |                      |                         |
| /catalog/theme/chess                        |                   |                    |                      |                      |                         |
| /catalog?theme=chess                        |                   |                    |                      |                      |                         |
| /catalog?themes[]=chess&themes[]=fantasy    |                   |                    |                      |                      |                         |
| /catalog?q=x&categories[]=a&themes[]=b      |                   |                    |                      |                      |                         |
+---------------------------------------------+-------------------+--------------------+----------------------+----------------------+-------------------------+
```

Ajoutez le risque principal de chaque solution.

```txt
+---------------------------------------------+------------------------------------------+
| Grammaire                                   | Risque principal                         |
+---------------------------------------------+------------------------------------------+
| /theme/show/1                               |                                          |
| /catalog/theme/chess                        |                                          |
| /catalog?theme=chess                        |                                          |
| /catalog?themes[]=chess&themes[]=fantasy    |                                          |
| /catalog?q=x&categories[]=a&themes[]=b      |                                          |
+---------------------------------------------+------------------------------------------+
```

---

# 9. Identifier la vraie page

Pour chaque URL, indiquez si elle représente :

```txt
A. une vraie page différente
B. la même page avec un état différent
C. une action d’administration
D. une URL ambiguë
```

URLs :

```txt
/catalog
/catalog?q=monkey
/catalog?page=2
/catalog?categories[]=books&categories[]=games
/catalog?themes[]=chess&themes[]=fantasy
/catalog/theme/chess
/theme/show/1
/item/the-great-monkey-gambit
/admin/item/edit/12
/admin/theme/edit/3
```

Réponses :

```txt
/catalog                                      : ______
/catalog?q=monkey                            : ______
/catalog?page=2                              : ______
/catalog?categories[]=books&categories[]=games : ______
/catalog?themes[]=chess&themes[]=fantasy     : ______
/catalog/theme/chess                         : ______
/theme/show/1                                : ______
/item/the-great-monkey-gambit                : ______
/admin/item/edit/12                          : ______
/admin/theme/edit/3                          : ______
```

Expliquez trois choix :

```txt
URL choisie :
Explication :



URL choisie :
Explication :



URL choisie :
Explication :



```

---

# 10. La règle “page ou état”

Pour chaque URL, posez-vous cette question :

```txt
Si j’enlève la valeur, est-ce que je suis encore sur la même page ?
```

Exemple :

```txt
/catalog?themes[]=chess
```

Si j’enlève `themes[]=chess`, j’obtiens :

```txt
/catalog
```

Question :

```txt
Suis-je encore sur une page catalogue ?
```

Réponse :

```txt
Oui / Non
```

Conclusion possible :

```txt
Le thème est probablement un état ou un filtre de la page catalogue.
```

Maintenant testez :

```txt
/item/the-great-monkey-gambit
```

Si j’enlève `the-great-monkey-gambit`, j’obtiens :

```txt
/item
```

Question :

```txt
Suis-je encore sur la page détail du même élément ?
```

Réponse :

```txt
Oui / Non
```

Conclusion possible :

```txt
Le slug de l’élément identifie probablement la page elle-même.
```

Complétez :

```txt
/catalog?categories[]=books&categories[]=games

Si j’enlève les catégories :
J’obtiens : ________________________
Même page ? Oui / Non
Conclusion : _______________________


/catalog?q=monkey

Si j’enlève q=monkey :
J’obtiens : ________________________
Même page ? Oui / Non
Conclusion : _______________________


/catalog?page=2

Si j’enlève page=2 :
J’obtiens : ________________________
Même page ? Oui / Non
Conclusion : _______________________


/item/my-product-slug

Si j’enlève my-product-slug :
J’obtiens : ________________________
Même page ? Oui / Non
Conclusion : _______________________
```

---

# 11. Conséquences dans le code

## Hypothèse A

URLs :

```txt
/theme/show/1
/category/show/1
/tag/show/1
/search/index?q=monkey
```

Fichiers :

```txt
controllers/
    __________________.php
    __________________.php
    __________________.php
    __________________.php
```

Fonctions :

```txt
________________()
________________()
________________()
________________()
```

Vues nécessaires :

```txt
views/
    __________________
    __________________
    __________________
```

Risque de duplication :

```txt
faible / moyen / élevé
```

Pourquoi ?

```txt



```

---

## Hypothèse B

URLs :

```txt
/catalog
/catalog/theme/chess
/catalog/category/books
/catalog/tag/beginner
/catalog/search/monkey
```

Fichiers :

```txt
controllers/
    __________________.php
```

Fonctions :

```txt
________________()
________________()
________________()
________________()
________________()
```

Vues nécessaires :

```txt
views/
    __________________
```

Risque de duplication :

```txt
faible / moyen / élevé
```

Pourquoi ?

```txt



```

---

## Hypothèse C

URLs :

```txt
/catalog
/catalog?q=monkey
/catalog?categories[]=books&categories[]=games
/catalog?themes[]=chess&themes[]=fantasy
/catalog?q=monkey&categories[]=books&categories[]=games&themes[]=chess&themes[]=fantasy&page=2
```

Fichiers :

```txt
controllers/
    __________________.php
```

Fonctions :

```txt
________________()
```

Vues nécessaires :

```txt
views/
    __________________
```

Paramètres lus dans `$_GET` :

```txt
________________
________________
________________
________________
________________
```

Risque de duplication :

```txt
faible / moyen / élevé
```

Pourquoi ?

```txt



```

---

# 12. Lecture possible des filtres en PHP

Cette partie sert à réfléchir à la structure du controller.

Avec une URL comme :

```txt
/catalog?q=monkey&categories[]=books&categories[]=games&themes[]=chess&themes[]=fantasy&page=2
```

PHP peut recevoir :

```txt
$_GET['q']
$_GET['categories']
$_GET['themes']
$_GET['page']
```

Complétez ce pseudo-code :

```php
function catalog_index(): array
{
    $filters = [];

    if (isset($_GET['q'])) {
        $filters['q'] = ____________________;
    }

    if (isset($_GET['categories'])) {
        $filters['categories'] = ____________________;
    }

    if (isset($_GET['themes'])) {
        $filters['themes'] = ____________________;
    }

    if (isset($_GET['tags'])) {
        $filters['tags'] = ____________________;
    }

    if (isset($_GET['page'])) {
        $filters['page'] = ____________________;
    }

    $items = item_find_for_catalog($filters);

    return [
        'title' => 'Catalogue',
        'content' => render('catalog/index', [
            'items' => $items,
            'filters' => $filters
        ])
    ];
}
```

Question :

```txt
Cette fonction remplace-t-elle plusieurs fonctions séparées ?
```

Réponse :

```txt
Oui / Non
```

Si oui, lesquelles ?

```txt



```

---

# 13. Slug ou id ?

Comparez :

```txt
/catalog?themes[]=1
/catalog?themes[]=chess
/item/42
/item/the-great-monkey-gambit
/admin/item/edit/42
```

Questions :

```txt
Quelle version est plus lisible pour le visiteur ?
Quelle version est plus directe pour la base de données ?
Quelle version est plus adaptée à l’administration ?
Quelle version est plus adaptée aux URLs publiques ?
```

Complétez :

```txt
Pour les URLs publiques, je préfère utiliser :
id / slug

Pourquoi ?



Pour les URLs admin, je peux utiliser :
id / slug

Pourquoi ?



```

---

# 14. Décision finale pour votre projet

Vous devez maintenant choisir la grammaire d’URL de votre projet.

Complétez cette liste.

```txt
Accueil :
________________________________________________

Catalogue complet :
________________________________________________

Recherche dans le catalogue :
________________________________________________

Catalogue filtré par plusieurs catégories :
________________________________________________

Catalogue filtré par plusieurs thèmes :
________________________________________________

Catalogue filtré par plusieurs tags :
________________________________________________

Catalogue avec recherche + catégories + thèmes + page + tri :
________________________________________________

Détail public d’un élément :
________________________________________________

Page admin liste des éléments :
________________________________________________

Page admin création :
________________________________________________

Page admin modification :
________________________________________________
```

---

# 15. Justification finale

Rédigez une réponse courte.

Votre réponse doit expliquer :

```txt
1. quelle grammaire vous choisissez ;
2. pourquoi cette grammaire correspond au fonctionnement réel du site ;
3. combien de fichiers controller cela implique ;
4. combien de fonctions principales cela implique ;
5. si les filtres multiples sont faciles à combiner ;
6. si les formulaires sont faciles à créer ;
7. si les URLs publiques restent lisibles ;
8. quelle différence vous faites entre URL publique et URL admin.
```

Réponse :

```txt
Nous choisissons la grammaire suivante :

________________________________________________________

Nous la choisissons parce que :



Conséquences sur les fichiers controller :



Conséquences sur les fonctions :



Conséquences sur les formulaires :



Conséquences sur les filtres multiples :



Conséquences sur la lisibilité des URLs :



Différence entre public et admin :



```

---


# Conclusion

```txt
Une URL ne sert pas seulement à accéder à une page.

Elle révèle comment on comprend le site.

Si une valeur identifie une vraie page, elle appartient souvent au chemin.

Si une valeur modifie seulement l’état d’une page, elle appartient souvent à la query string.

Plus les filtres sont nombreux et combinables, plus la query string devient naturelle.
```
