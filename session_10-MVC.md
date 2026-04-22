# Session 10 - Introduction à MVC

## 1. Objectif

Comprendre comment organiser une application web PHP simple.

Pas de framework.
Pas de structure magique.
Pas de “bonne arborescence” à apprendre par cœur.

Le but est de comprendre une logique d’organisation.

Dans une application web, il faut toujours :

* récupérer des données ;
* décider quoi en faire ;
* afficher un résultat.

MVC sert à répartir ce travail correctement.

À la fin de cette séance, vous devez être capables de comprendre :

* ce que sont le Model, la View et le Controller ;
* pourquoi on les sépare ;
* comment cette séparation existe même en PHP brut ;
* pourquoi, dans ce projet, le point central sera le Model.

---

## 2. Point de départ : ce que fait vraiment une page PHP

Prenons une page simple :

```text
item.php?id=12
```

Quand cette page est appelée, plusieurs opérations se succèdent :

1. lire la demande ;
2. comprendre ce qui est attendu ;
3. récupérer les bonnes données ;
4. construire la réponse HTML.

Même une page très simple fait déjà plusieurs métiers à la fois.

Par exemple, une page peut contenir :

* la connexion à la base de données ;
* la lecture de `$_GET` ou `$_POST` ;
* une requête SQL ;
* des conditions en PHP ;
* du HTML.

Tant que le projet est minuscule, cela semble acceptable.

Mais dès que le site grandit, ce mélange devient un problème.

---

## 3. Pourquoi il faut organiser le code

Quand un fichier fait tout, trois difficultés apparaissent.

### 3.1 Le code devient confus

Dans un même fichier, on alterne entre :

* SQL ;
* PHP ;
* HTML ;
* conditions ;
* affichage.

On ne sait plus clairement quelle partie sert à quoi.

### 3.2 Le code devient fragile

Si on veut modifier la base de données, il faut retrouver les requêtes.
Si on veut modifier l’affichage, on touche parfois à la logique.
Si on veut corriger un comportement, on risque de casser la page.

### 3.3 Le code se duplique

Une requête utile est écrite dans une page.
Puis recopiée dans une autre.
Puis légèrement modifiée ailleurs.

Le projet devient plus difficile à maintenir.

Le besoin de MVC vient de là.

> On ne sépare pas pour faire joli.
> On sépare parce qu’un même fichier ne devrait pas porter plusieurs responsabilités différentes.

---

## 4. L’idée de MVC

MVC est une manière de répartir le travail dans une application.

On distingue trois rôles :

* **Model**
* **View**
* **Controller**

Ces trois mots désignent trois fonctions différentes du code.

Le plus important n’est pas de retenir les noms.
Le plus important est de comprendre le rôle de chacun.

---

## 5. Les trois rôles

## 5.1 Le Model

Le Model s’occupe des données.

Dans ce cours, cela veut dire principalement :

* lire dans la base ;
* écrire dans la base ;
* mettre à jour ;
* supprimer ;
* vérifier si une donnée existe.

Exemples :

* récupérer tous les items ;
* récupérer un operator par email ;
* créer un message ;
* vérifier si un email existe déjà.

Important : dans un sens théorique plus large, le Model peut aussi contenir de la logique métier.
Mais dans ce cours, on adopte une définition simple et propre :

> le Model centralise l’accès aux données.

---

## 5.2 Le Controller

Le Controller décide quoi faire.

Il fait le lien entre la demande reçue et le résultat à produire.

Il peut par exemple :

* lire `$_GET` ;
* lire `$_POST` ;
* vérifier si un formulaire a été envoyé ;
* appeler une fonction du Model ;
* choisir quelles données transmettre à l’affichage.

Le Controller coordonne.
Il ne doit pas faire directement le SQL.
Il ne doit pas être confondu avec l’affichage.

---

## 5.3 La View

La View s’occupe de l’affichage.

Elle reçoit des données et les transforme en HTML.

Exemples :

* afficher une liste d’items ;
* afficher une page détail ;
* afficher un formulaire ;
* afficher un message d’erreur ou de confirmation.

La View montre.
Elle ne décide pas quelle requête lancer.
Elle ne parle pas directement à la base de données.

---

## 6. Le lien entre les trois

Comprendre MVC, ce n’est pas seulement connaître trois définitions séparées.

Il faut comprendre leur enchaînement.

### Flux général

```text
Requête → Controller → Model → Controller → View → navigateur
```

---

## 7. Exemple complet

Prenons cette URL :

```text
/item.php?id=12
```

Voici le déroulement :

1. le navigateur appelle `item.php?id=12` ;
2. le Controller lit `id=12` ;
3. il demande au Model l’item correspondant ;
4. le Model interroge la base ;
5. le Model retourne le résultat ;
6. le Controller transmet cet item à la View ;
7. la View affiche la page HTML.

Ce schéma est fondamental :

```text
demande → récupération → décision → affichage
```

MVC est une façon claire de répartir ces étapes.

---

## 8. MVC n’est pas un framework

Il faut être précis ici.

MVC ne dépend pas d’un framework.

On peut faire du MVC en PHP brut.

Dans cette séance, il n’y aura pas :

* de routing complexe ;
* d’autoloading ;
* de classes imposées ;
* d’architecture lourde.

On va utiliser une forme simple :

```text
model.php
index.php
item.php
contact.php
admin.php
```

Dans cette organisation :

* `model.php` contient les fonctions du Model ;
* les pages PHP jouent le rôle de Controller ;
* le HTML contenu dans ces pages joue le rôle de View.

Autrement dit :

> MVC est d’abord une séparation des rôles, pas une arborescence décorative.

---

## 9. Une précision importante : dans ce cours, les pages jouent deux rôles

Dans un projet très simple, une page PHP peut contenir :

* une partie Controller ;
* une partie View.

Par exemple :

* en haut du fichier : lecture de `$_GET`, appel au Model ;
* en bas du fichier : affichage HTML.

Ce n’est pas un MVC “pur” au sens d’un framework moderne.
Mais c’est déjà une séparation utile.

Le point critique à respecter est le suivant :

> la page peut faire Controller + View, mais elle ne doit pas contenir les requêtes SQL.

C’est là que le Model devient central.

---

## 10. Pourquoi le focus du cours est le Model

Dans un petit projet, on peut encore tolérer que le Controller et la View restent proches.
En revanche, disperser le SQL partout est une très mauvaise habitude.

Si chaque page contient ses propres requêtes :

* on copie ;
* on oublie ;
* on corrige à moitié ;
* on mélange logique, données et affichage.

C’est pour cela que, dans cette séance, le vrai travail architectural porte sur le Model.

Le Model doit devenir le point unique d’accès aux données.

---

## 11. Règle centrale du cours

La règle la plus importante de cette séance est la suivante :

```text
Aucune requête SQL en dehors du Model
```

Cela signifie :

* pas de `SELECT` directement dans `index.php` ;
* pas de `INSERT` dans `contact.php` ;
* pas de `UPDATE` dans `admin.php` ;
* pas de `DELETE` directement dans une page.

Toutes les requêtes passent par des fonctions du Model.

Cette règle suffit déjà à faire progresser fortement la qualité du code.

---

## 12. Ce que le Model fait

Le Model :

* reçoit des arguments ;
* prépare une requête ;
* exécute cette requête ;
* retourne un résultat.

Selon le cas, il peut retourner :

* plusieurs lignes ;
* une seule ligne ;
* un booléen ;
* un succès ou un échec d’exécution.

Le Model ne doit pas être pensé comme une page.
Il doit être pensé comme une bibliothèque de fonctions de données.

---

## 13. Ce que le Model ne fait jamais

Le Model ne doit jamais :

* afficher du HTML ;
* contenir du code de présentation ;
* faire des `echo` pour construire la page ;
* décider quelle page doit être affichée.

Le Model manipule des données.
Il ne gère pas l’interface.

---

## 14. Pourquoi les fonctions reçoivent `$pdo`

Dans ce cours, les fonctions du Model auront des signatures comme :

```php
function getAll($pdo, $table)
```

ou :

```php
function getOne($pdo, $table, $id)
```

Le principe est simple :

> une fonction reçoit ce dont elle a besoin.

Cela permet :

* de mieux lire la fonction ;
* de comprendre ses dépendances ;
* d’éviter les variables cachées ;
* de préparer de bonnes habitudes de conception.

On ne veut pas d’une fonction qui “devine” où trouver sa connexion.
On veut une fonction claire, explicite, lisible.

---

## 15. Le noyau minimal du Model

Pour cette séance, on se concentre sur un noyau simple de fonctions.

### Lecture

```php
getAll($pdo, $table)
getAllBy($pdo, $table, $field, $value)
getOne($pdo, $table, $id)
getOneBy($pdo, $table, $field, $value)
```

### Écriture

```php
create($pdo, $table, $data)
update($pdo, $table, $id, $data)
delete($pdo, $table, $id)
```

### Vérification

```php
exists($pdo, $table, $field, $value)
```

Ce noyau n’est pas “toute l’architecture du monde”.
C’est un socle pédagogique simple pour comprendre le rôle du Model.

---

## 16. Pourquoi commencer par des fonctions génériques

Des fonctions comme `getAll` ou `getOne` ont un intérêt pédagogique fort.

Elles permettent de comprendre :

* ce qu’une fonction du Model reçoit ;
* ce qu’elle doit faire ;
* ce qu’elle retourne ;
* comment elle sera appelée depuis une page.

Elles font apparaître la structure commune des accès aux données.

C’est une bonne manière de poser les bases avant de créer plus tard des fonctions plus précises.

Par exemple, dans un projet plus avancé, on écrira aussi des fonctions plus spécifiques comme :

```php
getOperatorByEmail($pdo, $email)
getCollectionsByOperator($pdo, $operatorId)
getMessagesByItem($pdo, $itemId)
```

Mais pour cette séance, le plus important est de comprendre la mécanique générale.

---

## 17. Les tables du projet

Le projet repose sur plusieurs tables principales :

* `item`
* `operator`
* `theme`
* `category`
* `tag`
* `collection`
* `message`

Le but n’est pas seulement de connaître leurs noms.

Le but est de comprendre qu’une même logique de Model doit permettre d’interagir proprement avec toutes ces données.

Autrement dit :

> le Model n’est pas lié à une page, il est lié aux données du projet.

---

## 18. Comment relier MVC au projet concret

Voyons maintenant comment les rôles se traduisent dans des pages très simples.

### Cas 1 — Catalogue

Fichier :

```text
index.php
```

Ce que fait le Controller :

* appeler `getAll($pdo, 'item')`

Ce que fait la View :

* parcourir les résultats ;
* afficher la liste en HTML.

---

### Cas 2 — Détail

Fichier :

```text
item.php?id=12
```

Ce que fait le Controller :

* lire `$_GET['id']` ;
* appeler `getOne($pdo, 'item', 12)`

Ce que fait la View :

* afficher l’item.

---

### Cas 3 — Formulaire de contact

Fichier :

```text
contact.php
```

Ce que fait le Controller :

* détecter le POST ;
* récupérer les données envoyées ;
* appeler `create($pdo, 'message', $data)`

Ce que fait la View :

* afficher le formulaire ;
* afficher un retour visuel si nécessaire.

---

## 19. Ce que vous devez comprendre avant de coder

Avant même l’exercice, il faut être capables de répondre à trois questions.

### 1. Où met-on les requêtes SQL ?
### 2. Où lit-on `$_GET` et `$_POST` ?
### 3. Où met-on le HTML ?

Si ces trois réponses sont claires, alors MVC est déjà compris dans ses fondations.
