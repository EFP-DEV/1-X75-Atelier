# Session 9 — Choisir une grammaire d’URL pour le catalogue

## Objectif

Vous devez définir les URLs publiques d’un site de catalogue.

Le but n’est pas seulement de choisir une URL “jolie”. Le but est de comprendre ce que chaque choix d’URL provoque dans le code :

```txt
nombre de fichiers controller
nombre de fonctions
duplication possible
facilité à combiner les filtres
facilité à créer des formulaires
lisibilité pour l’utilisateur
lisibilité pour le développeur
```
---

# Contexte du site

Le site contient un catalogue d’éléments.

Selon les projets, un élément peut être :

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
une catégorie (obligatoire)
un thème (obligatoire)
des tags
un titre
un slug
une description
```

Le visiteur doit pouvoir :

```txt
voir tout le catalogue
chercher dans le catalogue
filtrer par catégorie
filtrer par thème
filtrer par tag
combiner plusieurs filtres
trier les résultats
changer de page
voir le détail d’un élément
```

Exemples de besoins :

```txt
Voir tout le catalogue
Voir les éléments du thème "fantasy"
Voir les éléments de la catégorie "books"
Chercher "monkey" dans le catalogue
Voir les livres du thème "chess"
Voir la page 2 des résultats
Voir le détail d’un élément
```

---

# Partie 1 — Comparer plusieurs grammaires d’URL

Pour afficher un catalogue filtré par thème, on pourrait imaginer plusieurs URLs.

Analysez les quatre grammaires suivantes.

## Grammaire A — URL orientée entité technique

```txt
/theme/show/1
/category/show/1
/tag/show/1
/search/index?q=monkey
```

Questions :

```txt
Quelle page le visiteur voit-il réellement ?
Est-ce vraiment une page "theme" ?
Est-ce vraiment une page "category" ?
Est-ce vraiment une page "tag" ?
Est-ce que "search" est une page séparée du catalogue ?
```

Complétez :

```txt
Fichiers controller probables :

controllers/________________.php
controllers/________________.php
controllers/________________.php
controllers/________________.php
controllers/________________.php
```

Fonctions probables :

```txt
________________()
________________()
________________()
________________()
________________()
```

Conséquences possibles :

```txt
Nombre de fichiers controller : faible / moyen / élevé
Nombre de fonctions : faible / moyen / élevé
Risque de duplication : faible / moyen / élevé
Facilité à combiner les filtres : faible / moyen / élevée
Lisibilité pour le visiteur : faible / moyenne / élevée
Lisibilité pour le développeur : faible / moyenne / élevée
```

Votre analyse :

```txt
Avantages :



Inconvénients :



```

---

## Grammaire B — URL orientée catalogue avec segments

```txt
/catalog
/catalog/theme/fantasy
/catalog/category/books
/catalog/tag/beginner
/catalog/search/monkey
```

Questions :

```txt
Quelle est la page principale ?
Les filtres sont-ils regroupés dans le catalogue ?
Combien de fichiers controller faut-il probablement ?
Combien de fonctions faut-il probablement ?
```

Complétez :

```txt
Fichiers controller probables :

controllers/________________.php
```

Fonctions probables :

```txt
________________()
________________()
________________()
________________()
________________()
```

Conséquences possibles :

```txt
Nombre de fichiers controller : faible / moyen / élevé
Nombre de fonctions : faible / moyen / élevé
Risque de duplication : faible / moyen / élevé
Facilité à combiner les filtres : faible / moyen / élevée
Facilité à créer un formulaire de recherche : faible / moyenne / élevée
Lisibilité pour le visiteur : faible / moyenne / élevée
```

Testez mentalement cette combinaison :

```txt
Je veux chercher "monkey",
dans la catégorie "books",
avec le thème "chess",
sur la page 2.
```

Quelle URL faudrait-il écrire avec cette grammaire ?

```txt
________________________________________________________
```

Votre analyse :

```txt
Avantages :



Inconvénients :



```

---

## Grammaire C — URL catalogue avec query string

```txt
/catalog
/catalog?theme=fantasy
/catalog?category=books
/catalog?tag=beginner
/catalog?q=monkey
/catalog?q=monkey&theme=chess&category=books&page=2
```

Questions :

```txt
Est-ce que la page change vraiment ?
Ou est-ce seulement l’état du catalogue qui change ?
```

Complétez :

```txt
Fichiers controller probables :

controllers/________________.php
```

Fonctions probables :

```txt
________________()
```

Paramètres possibles :

```txt
q        = ________________________
theme    = ________________________
category = ________________________
tag      = ________________________
page     = ________________________
sort     = ________________________
```

Conséquences possibles :

```txt
Nombre de fichiers controller : faible / moyen / élevé
Nombre de fonctions : faible / moyen / élevé
Risque de duplication : faible / moyen / élevé
Facilité à combiner les filtres : faible / moyen / élevée
Facilité à créer un formulaire GET : faible / moyenne / élevée
Lisibilité pour le visiteur : faible / moyenne / élevée
Lisibilité pour le développeur : faible / moyenne / élevée
```

Testez mentalement cette combinaison :

```txt
Je veux chercher "monkey",
dans la catégorie "books",
avec le thème "chess",
sur la page 2.
```

URL possible :

```txt
________________________________________________________
```

Votre analyse :

```txt
Avantages :



Inconvénients :



```

---

## Grammaire D — Grammaire mixte

```txt
/catalog
/catalog?theme=fantasy&category=books&q=monkey
/catalog/theme/fantasy
/catalog/category/books
/item/the-great-monkey-gambit
```

Questions :

```txt
Quelles URLs représentent une vraie page ?
Quelles URLs représentent seulement un filtre ?
Est-ce que certaines URLs sont des alias ?
Est-ce qu’un même résultat peut avoir plusieurs URLs ?
Est-ce un problème ?
```

Complétez :

```txt
Fichiers controller probables :

controllers/________________.php
controllers/________________.php
```

Fonctions probables :

```txt
________________()
________________()
________________()
________________()
```

Conséquences possibles :

```txt
Nombre de fichiers controller : faible / moyen / élevé
Nombre de fonctions : faible / moyen / élevé
Risque de duplication : faible / moyen / élevé
Facilité à combiner les filtres : faible / moyen / élevée
Lisibilité pour le visiteur : faible / moyenne / élevée
Complexité pour le développeur : faible / moyenne / élevée
```

Votre analyse :

```txt
Avantages :



Inconvénients :



```

---

# Partie 2 — Comparaison globale

Complétez le tableau suivant.

```txt
+-------------------------------+-------------------+--------------------+----------------------+----------------------+-------------------------+
| Grammaire                     | Fichiers nombreux ?| Fonctions nombreuses?| Filtres combinables ? | Formulaire facile ?  | URL lisible public ?    |
+-------------------------------+-------------------+--------------------+----------------------+----------------------+-------------------------+
| /theme/show/1                 |                   |                    |                      |                      |                         |
| /catalog/theme/fantasy        |                   |                    |                      |                      |                         |
| /catalog?theme=fantasy        |                   |                    |                      |                      |                         |
| /catalog?q=x&theme=y&page=2   |                   |                    |                      |                      |                         |
+-------------------------------+-------------------+--------------------+----------------------+----------------------+-------------------------+
```

Ajoutez une colonne “risque principal”.

```txt
+-------------------------------+------------------------------------------+
| Grammaire                     | Risque principal                         |
+-------------------------------+------------------------------------------+
| /theme/show/1                 |                                          |
| /catalog/theme/fantasy        |                                          |
| /catalog?theme=fantasy        |                                          |
| /catalog?q=x&theme=y&page=2   |                                          |
+-------------------------------+------------------------------------------+
```

---

# Partie 3 — Identifier la vraie page

Pour chaque URL, dites si elle représente :

```txt
A. une vraie page différente
B. la même page avec un état différent
C. une action d’administration
D. une URL ambiguë
```

```txt
/catalog
/catalog?theme=fantasy
/catalog?q=monkey
/catalog?page=2
/catalog/theme/fantasy
/theme/show/1
/item/the-great-monkey-gambit
/admin/item/edit/12
/admin/theme/edit/3
```

Réponses :

```txt
/catalog                         : ______
/catalog?theme=fantasy           : ______
/catalog?q=monkey                : ______
/catalog?page=2                  : ______
/catalog/theme/fantasy           : ______
/theme/show/1                    : ______
/item/the-great-monkey-gambit    : ______
/admin/item/edit/12              : ______
/admin/theme/edit/3              : ______
```

Expliquez deux choix :

```txt
URL choisie :
Explication :



URL choisie :
Explication :



```

---

# Partie 4 — Tester la règle “page ou état”

Pour chaque valeur dans l’URL, posez-vous cette question :

```txt
Si j’enlève cette valeur, est-ce que je suis encore sur la même page ?
```

Exemple :

```txt
/catalog?theme=fantasy
```

Si j’enlève `theme=fantasy`, j’obtiens :

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
/catalog?category=books

Si j’enlève category=books :
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

# Partie 5 — Conséquences dans le code

Pour chaque grammaire, proposez une organisation de fichiers.

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

Vue ou vues nécessaires :

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
/catalog/theme/fantasy
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

Vue ou vues nécessaires :

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
/catalog?theme=fantasy
/catalog?category=books
/catalog?tag=beginner
/catalog?q=monkey
/catalog?q=monkey&theme=chess&category=books&page=2
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

Vue ou vues nécessaires :

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

# Partie 6 — Formulaire de recherche et de filtres

On veut créer un formulaire avec :

```txt
champ de recherche
liste des catégories
liste des thèmes
liste des tags
tri
pagination
```

Quelle grammaire est la plus naturelle pour un formulaire HTML en méthode GET ?

Choix :

```txt
A. /theme/show/1
B. /catalog/theme/fantasy
C. /catalog?theme=fantasy&q=monkey
```

Réponse :

```txt
Je choisis : ______
```

Pourquoi ?

```txt



```

Complétez le formulaire :

```html
<form action="_____________" method="_____">

    <input type="text" name="_____" placeholder="Recherche">

    <select name="__________">
        <option value="">Toutes les catégories</option>
        <option value="books">Books</option>
        <option value="games">Games</option>
    </select>

    <select name="__________">
        <option value="">Tous les thèmes</option>
        <option value="fantasy">Fantasy</option>
        <option value="chess">Chess</option>
    </select>

    <button type="submit">Filtrer</button>

</form>
```

URL produite par ce formulaire si l’utilisateur cherche `monkey` dans la catégorie `books` avec le thème `chess` :

```txt
________________________________________________________
```

---

# Partie 7 — Slug ou id ?

Comparez :

```txt
/catalog?theme=1
/catalog?theme=fantasy
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

# Partie 8 — Décision finale pour votre projet

Vous devez maintenant choisir la grammaire d’URL de votre projet.

Complétez cette liste.

```txt
Accueil :
________________________________________________

Catalogue complet :
________________________________________________

Recherche dans le catalogue :
________________________________________________

Catalogue filtré par catégorie :
________________________________________________

Catalogue filtré par thème :
________________________________________________

Catalogue filtré par tag :
________________________________________________

Catalogue avec plusieurs filtres :
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

# Partie 9 — Justification finale

Rédigez une réponse courte.

Votre réponse doit expliquer :

```txt
1. quelle grammaire vous choisissez ;
2. pourquoi cette grammaire correspond au fonctionnement réel du site ;
3. combien de fichiers controller cela implique ;
4. combien de fonctions principales cela implique ;
5. si les filtres sont faciles à combiner ;
6. si les formulaires sont faciles à créer ;
7. si les URLs publiques sont lisibles ;
8. quelle différence vous faites entre URL publique et URL admin.
```

Réponse attendue :

```txt
Nous choisissons la grammaire suivante :

________________________________________________________

Nous la choisissons parce que :



Conséquences sur les fichiers controller :



Conséquences sur les fonctions :



Conséquences sur les formulaires :



Conséquences sur la lisibilité des URLs :



Différence entre public et admin :



```

---

# Phrase de conclusion à retenir

```txt
Une URL ne sert pas seulement à accéder à une page.

Elle révèle comment on comprend le site.

Si la valeur identifie une vraie page, elle appartient souvent au chemin.

Si la valeur modifie seulement l’état d’une page, elle appartient souvent à la query string.
```
