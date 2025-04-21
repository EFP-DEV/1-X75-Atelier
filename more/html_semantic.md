# Balises HTML sémantiques

> **Pourquoi c’est essentiel ?**  
> Utiliser des balises sémantiques aide à :  
> - **Accessibilité** : les lecteurs d’écran comprennent mieux la structure.  
> - **SEO** : les moteurs de recherche identifient plus facilement le contenu clé.  
> - **Lisibilité du code** : vos collègues (et vous‑même) saisissent immédiatement le rôle de chaque bloc.  
> - **Maintenabilité** : plus simple d’ajouter, déplacer ou styliser des sections.

---

## 1. Les conteneurs de haut niveau

| Balise       | Rôle                                    | Exemple d’usage                                            |
|--------------|-----------------------------------------|------------------------------------------------------------|
| `<header>`   | En‑tête de page ou de section           | Logo, titre, barre de recherche                            |
| `<nav>`      | Zone de navigation principale ou secondaire | Menu principal, liens de pagination                       |
| `<main>`     | Contenu central unique de la page       | Article de blog, catalogue de produits                     |
| `<footer>`   | Pied de page ou de section              | Mentions légales, crédits, liens sociaux                   |

```html
<body>
  <header>…</header>
  <nav>…</nav>
  <main>…</main>
  <footer>…</footer>
</body>
```

---

## 2. La structuration thématique

| Balise           | Rôle                                    | Quand l’utiliser ?                         |
|------------------|-----------------------------------------|-------------------------------------------|
| `<section>`      | Regroupe un thème ou une fonctionnalité | Chaque section du dossier “À propos”      |
| `<article>`      | Contenu autonome (alerte, billet, post) | Un post de blog<br>Un commentaire         |
| `<aside>`        | Contenu lié mais pas central            | Encadré “Articles similaires”             |
| `<figure>` + `<figcaption>` | Illustration avec légende      | Image, graphique, schéma avec description |
| `<time>`         | Date/heure normalisée                  | `<time datetime="2025-04-22">22 avril 2025</time>` |

```html
<article>
  <header><h2>Mon billet</h2></header>
  <figure>
    <img src="photo.jpg" alt="Vue panoramique">
    <figcaption>Lever de soleil sur la montagne</figcaption>
  </figure>
  <p>…</p>
  <footer>
    Publié le <time datetime="2025-04-22">22 avril 2025</time>
  </footer>
</article>
<aside>
  <h3>À lire aussi</h3>
  <ul>…</ul>
</aside>
```

---

## 3. Bonnes pratiques

1. **Un seul `<main>`**  
   – Le contenu principal ne doit apparaître qu’une seule fois par page.  
2. **Pas de `<div>` inutile**  
   – Remplacez les `<div>` de structuration par des balises sémantiques quand c’est possible.  
3. **Hiérarchie claire**  
   – Ne faites pas de `<h3>` avant un `<h2>`.  
4. **ARIA en appoint**  
   – Les rôles ARIA sont utiles pour des composants complexes, **pas** pour pallier un manque de balise sémantique.

---

## 4. Tester et valider

- **Validator W3C** : <https://validator.w3.org>  
- **Outils d’accessibilité** : Lighthouse (Accessibilité), axe-core, WAVE.  
- **Audit manuel** :  
  1. Parcourez le DOM dans l’inspecteur (Chrome DevTools → Accessibility).  
  2. Vérifiez la liste des landmarks (`<header>`, `<nav>`, `<main>`, `<aside>`, `<footer>`).  
  3. Assurez-vous qu’ils couvrent tout le document sans doublons inutiles.

---

Voici une section complémentaire avec d'autres balises sémantiques importantes :

## 5. Autres balises sémantiques essentielles

| Balise | Rôle | Exemple d'usage |
|--------|------|-----------------|
| `<address>` | Coordonnées de contact | Adresse physique, email, téléphone |
| `<blockquote>` | Citation longue avec attribut `cite` | Citation d'article ou d'auteur |
| `<details>` + `<summary>` | Contenu extensible (accordéon) | FAQ, détails techniques |
| `<mark>` | Texte mis en évidence | Résultat de recherche, surbrillance |
| `<progress>` | Barre de progression | Avancement de téléchargement |
| `<dialog>` | Boîte de dialogue modale | Fenêtre de confirmation, popup |
| `<abbr>` | Abréviation avec définition | `<abbr title="HyperText Markup Language">HTML</abbr>` |
| `<cite>` | Référence à une œuvre | Titre de livre, de film |
| `<code>` | Fragment de code informatique | Exemple de fonction, commande |
| `<data>` | Valeur lisible avec équivalent machine | `<data value="398">Produit XYZ</data>` |
| `<dl>`, `<dt>`, `<dd>` | Liste de définitions | Glossaire, métadonnées |

```html
<details>
  <summary>Comment utiliser cette fonction ?</summary>
  <p>Voici les étapes à suivre :</p>
  <ol>
    <li>Sélectionnez l'option dans le menu</li>
    <li>Configurez les paramètres selon votre besoin</li>
    <li>Cliquez sur <code>Appliquer</code></li>
  </ol>
  <progress value="70" max="100">70%</progress>
</details>

<address>
  <p>Contact : <a href="mailto:info@example.com">info@example.com</a></p>
  <p>Téléphone : <a href="tel:+33123456789">+33 1 23 45 67 89</a></p>
</address>

<dl>
  <dt>HTML</dt>
  <dd>Langage de balisage utilisé pour structurer le contenu web</dd>
  <dt>CSS</dt>
  <dd>Langage de style utilisé pour mettre en forme les pages web</dd>
</dl>
```
---

## 6. Balises de formulaire sémantiques

| Balise | Rôle | Avantage |
|--------|------|----------|
| `<label>` | Étiquette liée à un champ | Association explicite via attribut `for` |
| `<fieldset>` + `<legend>` | Groupe de champs avec titre | Organisation logique des formulaires |
| `<datalist>` | Liste de suggestions pour `<input>` | Autocomplétion avec liberté de saisie |
| `<output>` | Résultat de calcul | Affichage de résultat de manipulation |
| `<meter>` | Mesure scalaire dans une plage connue | Jauge visuelle avec min/max/optimum |

```html
<form>
  <fieldset>
    <legend>Informations personnelles</legend>
    <p>
      <label for="nom">Nom :</label>
      <input type="text" id="nom" name="nom" list="noms-courants">
      <datalist id="noms-courants">
        <option value="Dupont">
        <option value="Martin">
      </datalist>
    </p>
  </fieldset>
  
  <p>
    <label for="satisfaction">Niveau de satisfaction :</label>
    <meter id="satisfaction" min="0" max="100" value="75" low="33" high="66" optimum="80">75%</meter>
  </p>
  
  <p>
    <label for="prix">Prix HT :</label>
    <input type="number" id="prix" name="prix" value="100" min="0" step="0.01">
    <output for="prix" id="prixTTC">120.00 €</output>
  </p>
</form>
```
