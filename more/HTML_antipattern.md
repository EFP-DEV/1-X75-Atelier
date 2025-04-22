# Cours : Éviter les Anti‑Patterns HTML & CSS

## 🎯 Objectif

Vous apprendrez à repérer et corriger les **anti‑patterns** courants en HTML et CSS. À la fin de ce cours, votre code sera plus **sémantique**, **accessible**, **performant** et **maintenable**.



## 1. Introduction aux anti‑patterns

- **Définition** : un _anti‑pattern_ est une pratique répandue, mais contre‑productive. 
- **Conséquences** : code lourd, difficile à maintenir, problèmes d’accessibilité et performance.

> **Principe** : privilégier la sémantique et la séparation des responsabilités (structure, style, comportement).



## 2. Anti‑Pattern : Soup of `<div>` (« div soup »)

### Mauvais
```html
<div class="header">
  <div class="nav">
    <div class="item">Accueil</div>
  </div>
</div>
```
- Absence de sens sémantique.  
- Difficulté pour les lecteurs d’écran.

### Bon
```html
<header>
  <nav>
    <ul>
      <li><a href="#">Accueil</a></li>
    </ul>
  </nav>
</header>
```
- Utilisation de `<header>`, `<nav>`, `<ul>`, `<li>`.
- Structure claire et accessible.



## 3. Anti‑Pattern : CSS Inline

### Mauvais
```html
<button style="background:red;color:white;">Supprimer</button>
```
- Difficile à modifier globalement.  
- Rend la maintenance chaotique.

### Bon
```html
<button class="btn btn--danger">Supprimer</button>
```
```css
.btn { padding: 0.5rem 1rem; border: none; }
.btn--danger { background: red; color: white; }
```
- Séparation HTML / CSS.  
- Styles réutilisables.



## 4. Anti‑Pattern : Sélecteurs ID pour le style

### Mauvais
```css
#produits article { background: #333; color: #fff; }
```
- Spécificité trop élevée.  
- Difficile à surcharger pour des variantes.

### Bon
```css
.produits article { background: #333; color: #fff; }
```
- Utilisation de classes modulaires.
- Spécificité maîtrisée.



## 5. Anti‑Pattern : Classes Trop Vagues

### Mauvais
```html
<div class="box1">…</div>
```
- `box1` ne décrit ni le rôle, ni le contenu.

### Bon
```html
<aside class="promo-banner">
  …
</aside>
```
- `promo-banner` explicite.
- Balise `<aside>` indique son rôle.



## 6. Anti‑Pattern : Sélecteurs CSS Trop Complexes

### Mauvais
```css
.main-nav ul > li:first-child a:hover span { font-weight:bold; }
```
- Difficulté de lecture.  
- Ralentit le rendu.

### Bon
```html
<li class="nav-item nav-item--active">
  <a class="nav-link" href="#">Accueil</a>
</li>
```
```css
.nav-item--active .nav-link { font-weight: bold; }
```
- Simplicité et clarté.
- Classes descriptives.



## 7. Anti‑Pattern : Table Layout

### Mauvais
```html
<table>
<tr><td>Barre latérale</td><td>Contenu</td></tr>
</table>
```
- Usage détourné de `<table>`.  
- Pas responsive.

### Bon
```html
<div class="layout">
  <aside class="layout__sidebar">…</aside>
  <main class="layout__content">…</main>
</div>
```
```css
.layout { display: flex; }
.layout__sidebar { width: 200px; }
```
- Flexbox / CSS Grid pour la mise en page.
- Résponsive et sémantique.



## 8. Anti‑Pattern : Unités Fixes (px)

### Mauvais
```css
body { font-size: 14px; }
```
- Pas d’adaptation à l’échelle utilisateur.

### Bon
```css
html { font-size: 100%; } /* 16px par défaut */
body { font-size: 0.875rem; } /* 14px équivalent */
```
- Unités relatives (`rem`, `em`, `%`) pour l’accessibilité.



## 9. Anti‑Pattern : Absence de Texte Alternatif

### Mauvais
```html
<img src="portrait.jpg" alt="">
```
- Lecteurs d’écran ignorent l’image.

### Bon
```html
<img src="portrait.jpg" alt="Portrait de Marie Curie en laboratoire">
```
- Description utile pour tous.



## 10. Anti‑Pattern : Inline JavaScript (attributs d’événement)

### Mauvais
```html
<button onclick="submitForm()">Envoyer</button>
```

### Bon
```html
<button id="submitBtn">Envoyer</button>
<script>
  document.getElementById('submitBtn').addEventListener('click', submitForm);
</script>
```
- JavaScript séparé.  
- Préserve la séparation des responsabilités.



## 11. Anti‑Pattern : `!important` abusif

### Mauvais
```css
.title { color: blue !important; }
```
- Rend la maintenance impossible.

### Bon
```css
.header-title { color: blue; }
```
- Structure et classes claires.



## 12. Anti‑Pattern : Liens Non Descriptifs

### Mauvais
```html
<a href="#">Cliquez ici</a>
```
- Contexte perdu pour les lecteurs d’écran.

### Bon
```html
<a href="guide-accessibilite.html">En savoir plus sur l’accessibilité</a>
```
- Texte clair et explicite.



## ✅ Récapitulatif

1. **Sémantique d’abord** : remplacez `<div>`/`<span>` par des balises dédiées.  
2. **Séparer** structure (HTML), style (CSS), comportement (JS).  
3. **Nommage clair** : classes descriptives, pas de vagues `box1` ou `header`.  
4. **Performance & accessibilité** : unités relatives, alt descriptif, labels de formulaire.  
5. **Maintenance et collaboration** : CSS modulaires, sélecteurs simples, éviter `!important`.

En maîtrisant ces principes, vous éviterez les pièges courants et développerez des interfaces solides, accessibles et durables.

