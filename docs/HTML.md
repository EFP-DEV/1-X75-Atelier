# HTML

L’HTML constitue la **colonne vertébrale** de tout prototype web.  
Adopter une structure sémantique claire garantit :

- la **lisibilité** du code ;
- l’**accessibilité** pour les utilisateurs ;
- une meilleure **cohérence** entre les pages ;
- une base propre pour le **CSS** et la **dynamisation en PHP**.

Dans ce projet, le HTML ne sert pas seulement à afficher du contenu.  
Il sert à **organiser le site**, à **préparer les parcours utilisateurs**, à **poser les formulaires** et à **structurer les futures zones dynamiques**.

---

## 1. Structure minimale d’une page

Chaque page HTML doit contenir au minimum :

- `<!DOCTYPE html>`
- `<html lang="fr">`
- `<head>`
- `<body>`

Dans le `<head>`, on retrouve généralement :

### `<meta charset="UTF-8">`
Définit l’encodage des caractères.

### `<meta name="viewport" content="width=device-width, initial-scale=1">`
Permet un affichage correct sur mobile.

### `<title>`
Définit le titre de la page.

### `<link rel="stylesheet" href="styles.css">`
Lie la feuille de style CSS externe.

### `<script src="script.js" defer></script>`
Charge le JavaScript sans bloquer l’analyse de la page.

---

## 2. Structure générale dans `<body>`

Une page web doit être organisée en zones claires.

Les balises sémantiques les plus utiles dans ce projet sont :

- `<header>` : en-tête du site ou d’une section ;
- `<nav>` : navigation principale ou secondaire ;
- `<main>` : contenu principal unique de la page ;
- `<section>` : regroupement thématique ;
- `<article>` : contenu autonome ;
- `<aside>` : contenu secondaire ;
- `<footer>` : pied de page.

### Exemple

```html
<body>
  <header>
    <h1>Mon prototype</h1>
    <nav aria-label="Menu principal">
      <ul>
        <li><a href="#">Accueil</a></li>
      </ul>
    </nav>
  </header>

  <main>
    <section aria-labelledby="intro">
      <h2 id="intro">Introduction</h2>
      <p>Contenu pédagogique détaillé.</p>
    </section>
  </main>

  <footer>
    <address>Contact : contact@example.com</address>
  </footer>
</body>
````

---

## 3. Balises fondamentales à maîtriser

### Titres : `<h1>` à `<h6>`

Ils organisent la hiérarchie du contenu.
En pratique, on attend :

* un `h1` principal par page ;
* des `h2` pour les grandes sections ;
* des `h3` pour les sous-parties.

### Paragraphes : `<p>`

Pour les blocs de texte simples.

### Liens : `<a>`

Pour naviguer d’une page à l’autre.

### Listes : `<ul>`, `<ol>`, `<li>`

Pour regrouper des éléments liés entre eux.

### Images : `<img>`

Toujours avec un attribut `alt`.

```html
<img src="photo.jpg" alt="Description de l’image">
```

### Citation : `<blockquote>`

Pour citer une source ou un extrait.

### Adresse : `<address>`

Pour des coordonnées ou des informations de contact.

---

## 4. Formulaires

Les formulaires doivent déjà exister en HTML à cette étape du projet, même s’ils ne sont pas encore reliés au PHP.

Balises importantes :

* `<form>`
* `<label>`
* `<input>`
* `<textarea>`
* `<select>`
* `<option>`
* `<button>`

### Exemple

```html
<form action="submit.php" method="post">
  <label for="email">Email :</label>
  <input type="email" id="email" name="email" required>

  <label for="choices">Choix :</label>
  <select id="choices" name="choices">
    <option value="">Choisissez une option</option>
    <option value="A">Option A</option>
    <option value="B">Option B</option>
    <option value="ALL">Option A + B</option>
  </select>

  <label for="message">Message :</label>
  <textarea id="message" name="message"></textarea>

  <button type="submit">Envoyer</button>
</form>
```

---

## 5. Tableaux

Les tableaux servent à afficher des données structurées, surtout en administration.

Balises importantes :

* `<table>`
* `<caption>`
* `<thead>`
* `<tbody>`
* `<tr>`
* `<th>`
* `<td>`

### Exemple

```html
<table>
  <caption>Liste des utilisateurs</caption>
  <thead>
    <tr>
      <th>Nom</th>
      <th>Âge</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Dupont</td>
      <td>30</td>
    </tr>
  </tbody>
</table>
```

---

## 6. Médias et contenus intégrés

Certaines balises peuvent être utiles selon les besoins du projet :

* `<figure>` et `<figcaption>` ;
* `<audio>` ;
* `<video>` ;
* `<iframe>`.

Exemple :

```html
<figure>
  <img src="photo.jpg" alt="Description de l’image">
  <figcaption>Légende de l’image</figcaption>
</figure>
```

Pour un contenu intégré :

```html
<iframe src="..." title="Contenu intégré"></iframe>
```

Le `title` est important pour l’accessibilité.

---

## 7. Commentaires HTML

Les commentaires peuvent aider à repérer les grandes zones pendant la phase de construction.

```html
<!-- Navigation principale -->
```

Ils doivent rester utiles et sobres.

---

## 8. Ce qu’il faut retenir pour le projet

Dans cette phase, on attend surtout :

* des pages front bien structurées ;
* des pages admin bien structurées ;
* une navigation claire ;
* des formulaires présents en HTML ;
* un code lisible, cohérent et sémantique.

Le HTML doit permettre de comprendre le site même sans CSS.
Il doit aussi préparer correctement la suite du travail.
