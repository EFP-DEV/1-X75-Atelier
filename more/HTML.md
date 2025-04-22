#  HTML

L’HTML constitue la **colonne vertébrale** de tout prototype web. Adopter une structure sémantique claire garantit :

- **Lisibilité** du code pour les développeurs.
- **Accessibilité** pour les utilisateurs (assistants vocaux, claviers).
- **Référencement** naturel (SEO) grâce aux balises appropriées.

## 1. Balises dans `<head>`

1. `<meta charset="UTF-8">`  
   - **Rôle** : Définit l’encodage des caractères (UTF-8 couvre tous les caractères latins, accentués, etc.).  
   - **Bonnes pratiques** : Toujours en première position.

2. `<meta name="viewport" content="width=device-width, initial-scale=1">`  
   - **Rôle** : Assure un affichage responsive sur mobile.

3. `<title>`Titre de la page`</title>`  
   - **Rôle** : Texte du titre affiché dans l’onglet du navigateur et utilisé par les moteurs de recherche.

4. `<link rel="stylesheet" href="styles.css">`  
   - **Rôle** : Importe la feuille de style externe.
   - **Ordre** : Avant les scripts pour éviter le « flash » sans style.

5. `<base href="https://example.com/">`  
   - **Rôle** : Définit l’URL de base pour les liens relatifs.
   - **Usage** : Rare, mais utile sur les sous-domaines ou chemins profonds.

6. `<style>`…`</style>`  
   - **Rôle** : Styles internes pour surcharger rapidement une règle.
   - **Usage** : À limiter aux cas d’urgence (débogage, mailings).

7. `<script src="script.js" defer></script>`  
   - **Rôle** : Charge et exécute le JS après le parsing de l’HTML (`defer`).
   - **Bonne pratique** : Placer les scripts en fin de `<body>` ou utiliser `defer`/`async`.


## 2. Balises dans `<body>`

> **Astuce :** Utilisez un **commentaire HTML** `<!-- Section description -->` avant chaque bloc pour clarifier sa fonction.

| Niveau                         | Objectifs pédagogiques                                                                                             | Exemples de balises & concepts                                                                                                                                                                                                                           |
|-------------------------------|--------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Niveau 1 – Débutant**       | - Comprendre la structure minimale d’une page HTML<br>- Maîtriser les balises de contenu de base                     | `html`, `head`, `title`, `meta`, `body`<br>**Titres** : `h1`→`h6`<br>**Paragraphe** : `p`<br>**Liens** : `a`<br>**Listes** : `ul`, `ol`, `li`<br>**Images** : `img`                                                                                       |
| **Niveau 2 – Intermédiaire**  | - Organiser le contenu avec des conteneurs et formulaires<br>- Utiliser des attributs globaux                        | **Conteneurs** : `div`, `span`<br>**Tableaux** : `table`, `tr`, `td`, `th`<br>**Formulaires** : `form`, `input`, `textarea`, `button`, `select`, `label`<br>**Attributs globaux** : `class`, `id`, `data-*` |
| **Niveau 3 – Avancé**         | - Structurer sémantiquement pour l’accessibilité et le SEO<br>- Exploiter quelques API HTML5                       | **Sémantique** : `header`, `nav`, `main`, `section`, `article`, `aside`, `footer`<br>**Médias & métadonnées** : `figure`, `figcaption`, `time`, `mark`<br>**Widgets** : `details`, `summary`, `progress`    |
| **Niveau 4 – Expert / Rare**  | - Intégrer du contenu multimédia et interactif avancé<br>- Découvrir les balises peu rencontrées et les API Canvas/ARIA | **Multimédia** : `audio`, `video`, `source`, `track`<br>**Graphique** : `canvas`, `svg`<br>**Templates & slots** : `template`, `slot`<br>**Dialogues & cartes d’image** : `dialog`, `map`, `area`, `picture`  |

1. `<header>`…`</header>`  
   - **Usage** : En‑tête global (logo, titre, slogan).
   - **Accessibilité** : Rôle implicite `banner`.

2. `<nav>`…`</nav>`  
   - **Usage** : Barres de navigation principales ou secondaires.
   - **ARIA** : `role="navigation"`, `aria-label="menu principal"`.

3. `<main>`…`</main>`  
   - **Usage** : Contenu principal unique de la page.  
   - **Règle** : Un seul `<main>` par document.

4. `<section>`…`</section>`  
   - **Usage** : Regroupement thématique de contenu.
   - **ARIA** : Peut recevoir `aria-labelledby` si un titre existe.

5. `<article>`…`</article>`  
   - **Usage** : Contenu autonome (article, billet de blog, produit).

6. `<aside>`…`</aside>`  
   - **Usage** : Contenu secondaire ou parentéral (barre latérale, extraits).

7. `<footer>`…`</footer>`  
   - **Usage** : Pied de page global ou sectionnel (mentions légales, lien de retour).
   - **Rôle implicite** : `contentinfo`.

8. Titres `<h1>` à `<h6>`  
   - **Usage** : Structuration hiérarchique.  
   - **Bonnes pratiques** : Un seul `<h1>` principal, puis `<h2>` pour les sections.

9. Listes `<ul>`, `<ol>`, `<li>`  
   - **Usage** : Listes non ordonnées ou ordonnées.

10. `<blockquote cite="URL">…</blockquote>`  
    Pour citer une source externe.

11. `<address>`  
    Informations de contact ou localisation d’un auteur ou d’une entreprise.

12. `<noscript>`…`</noscript>`  
   - **Rôle** : Contenu alternatif si JavaScript est désactivé.

### 2.1 Formulaires

```html
<form action="submit.php" method="post">
    <label for="email">Email :</label>
    <input type="email" name="email" required>

    <label for="choices">Choix :</label>
    <select name="choices">
    <option value="">Choose an option A</option>
    <option value="A">Option A</option>
    <option value="B">Option B</option>
    <option value="ALL">Option A+B</option>
    </select>

    <label for="message">Message :</label>
    <textarea name="message"></textarea>

    <button type="submit">Envoyer</button>
</form>
```
- **ARIA** : Utiliser `aria-required="true"` si nécessaire.

### 2.2 Tableaux

```html
<table>
    <caption>Liste des utilisateurs</caption>
    <thead>
    <tr><th>Nom</th><th>Âge</th></tr>
    </thead>
    <tbody>
    <tr><td>Dupont</td><td>30</td></tr>
    </tbody>
</table>
```

### 2.3 Médias

- `<img src="photo.jpg" alt="Description"]>`  
    **Toujours** fournir `alt` pour l’accessibilité.

- `<figure> <img…> <figcaption>Légende</figcaption> </figure>`  
    Pour relier image et légende.

- `<audio controls src="son.mp3">Votre navigateur ne supporte pas l’audio.</audio>`

- `<video controls width="640"> <source src="film.mp4" type="video/mp4"> </video>`
- `<iframe src="..." title="Contenu intégré"></iframe>`  
- **Usage** : Vidéo YouTube, Google Maps.
- **Accessibilité** : Toujours ajouter `title`.


### 2.4 Commentaires HTML  

```html
<!-- Ce bloc gère l’en-tête fixe -->
```

--- 

# Exemple de structure minimale :
```html
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Prototype Accessible</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header>
    <h1>Mon prototype</h1>
    <nav aria-label="Menu principal">
      <ul><li><a href="#">Accueil</a></li></ul>
    </nav>
  </header>
  <main>
    <section aria-labelledby="intro">
      <h2 id="intro">Introduction</h2>
      <p>Contenu pédagogique détaillé.</p>
    </section>
  </main>
  <footer>
    <address>Contact : contact@example.com</address>
  </footer>
  <script src="script.js" defer></script>
</body>
</html>
```

