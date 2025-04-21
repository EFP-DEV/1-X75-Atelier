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
