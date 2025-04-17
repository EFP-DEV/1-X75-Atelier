# Masterclass CSS Avancé

## Sommaire

3. [Structuration & maintenabilité CSS](#3-structuration-et-maintenabilité-du-css)  
4. [Accessibilité & performance](#4-accessibilité-et-performance)  
5. [Outils & débogage](#5-outils-et-débogage)  
6. [Conclusion](#conclusion)

---


## 3. Structuration et maintenabilité du CSS

Sans méthode claire pour nommer et organiser les classes, le code CSS devient vite une “soupe de styles” ingérable.  

On se perd, on duplique, on écrase involontairement des styles.  

Quelle que soit la méthode (BEM, SMACSS, OOCSS ou la vôtre), **l’important est de rester cohérent** pour que les autres développeurs (ou vous-même dans 6 mois) puissent comprendre immédiatement ce que fait chaque classe ainsi que leur combinaisons. Reduire la charge mentale et le temps de recherche de bugs, se traduisant par une meilleure productivité, controlant 
- les coûts de développement 
- le temps de mise sur le marché
- la qualité du produit final.



### BEM

**Définition** :  
BEM (Block Element Modifier) est une convention de nommage CSS pour structurer les composants.

**Syntaxe** :  
`.block__element--modifier`

**Exemple HTML** :

```html
<article class="card">
  <img src="image.jpg" class="card__image">
  <header class="card__header">
    <h2 class="card__title">Titre</h2>
  </header>
  <footer class="card__footer">
    <a href="#" class="card__button card__button--primary">Lire</a>
  </footer>
</article>
```

**Avantage** :  
Lisibilité, prévisibilité, maintenabilité.

---

### SMACSS

**Définition** :  
SMACSS (Scalable and Modular Architecture for CSS) organise le CSS par rôle (base, layout, module, state, theme).

**Syntaxe** :  
`.module`, `.is-active`, `.layout-*`

**Exemple HTML** :

```html
<article class="module-card is-highlighted">
  <img src="image.jpg" class="card-image">
  <header class="card-header">
    <h2 class="card-title">Titre</h2>
  </header>
  <footer class="card-footer">
    <a href="#" class="card-button">Lire</a>
  </footer>
</article>
```

**Avantage** :  
Structure modulaire, extensible.

---

### OOCSS

**Définition** :  
OOCSS (Object Oriented CSS) sépare la structure (objet) du style (skin) pour créer des composants réutilisables.

**Syntaxe** :  
`.media-box`, `.btn--primary`

**Exemple HTML** :

```html
<article class="media-box skin-card">
  <img src="image.jpg" class="media-box__img">
  <header class="media-box__header">
    <h2 class="media-box__title">Titre</h2>
  </header>
  <footer class="media-box__footer">
    <a href="#" class="btn btn--primary">Lire</a>
  </footer>
</article>
```

**Avantage** :  
Réutilisabilité, séparation logique.

---

### Tableau comparatif

| Approche | Objectif principal | Syntaxe typique | Avantages |
|----------|--------------------|------------------|-----------|
| BEM | Structuration claire | `.block__element--modifier` | Prévisible, maintenable |
| SMACSS | Organisation modulaire | `.module`, `.is-state` | Flexible, adaptable |
| OOCSS | Réutilisation d'objets | `.media-box`, `.btn--primary` | Composants + thèmes |

---

Parfait. Voici la **section 4 "Accessibilité et performance"** entièrement **étoffée et contextualisée** avec une approche pédagogique centrée sur l’impact réel d’un CSS non accessible ou non optimisé, tout en maintenant la cohérence avec le **principe de prévisibilité (Law of Least Surprise)**.

---

## 4. Accessibilité et performance

Un site qui n’est ni accessible ni performant **exclut une partie des utilisateurs** (lecteurs d’écran, daltoniens, personnes sensibles aux mouvements, connexions lentes, etc.).  
De plus, un CSS trop lourd ou mal structuré **ralentit le chargement**, augmente le taux de rebond et nuit à votre référencement.  
Cette section vous permet de **penser l’expérience utilisateur dans sa diversité**, tout en maintenant un code CSS **fiable, rapide et prévisible**.

---

### Accessibilité WCAG

**Définition** :  
Les WCAG (*Web Content Accessibility Guidelines*) sont un ensemble de recommandations internationales visant à rendre le web accessible aux personnes en situation de handicap (visuel, moteur, cognitif…).

**Conséquences d’une mauvaise accessibilité** :  
- Utilisateurs qui ne peuvent pas naviguer au clavier  
- Textes illisibles pour les malvoyants  
- Animations perturbantes pour les personnes photosensibles  
- Sites inutilisables par les lecteurs d’écran

**Bonnes pratiques CSS** :  
- **Contraste élevé** : au moins 4.5:1 pour le texte normal, 3:1 pour les grands textes  
- **Focus visible** : essentiel pour les utilisateurs clavier  
- **Unités relatives** : utiliser `rem`, `em`, `%` plutôt que `px` pour le zoom  
- **Préférences utilisateurs** : détecter les réglages d’accessibilité avec les media queries suivants :

```css
@media (prefers-reduced-motion: reduce) {
  * {
    animation: none !important;
    transition: none !important;
  }
}

@media (prefers-color-scheme: dark) {
  body {
    background-color: #111;
    color: #eee;
  }
}
```

**Exemple CSS : focus visible** :

```css
:focus-visible {
  outline: 2px solid #f90;
  outline-offset: 2px;
}
```

**Astuce** :  
Les tests de contraste peuvent être faits avec des outils comme **Color Contrast Checker**, **axe DevTools**, ou **Lighthouse**.

**Règle à retenir** :  
Un site accessible **ne doit jamais surprendre l'utilisateur**. Chaque interaction doit être prévisible, claire et signalée.

---

### Optimisation CSS

**Définition** :  
Optimiser le CSS consiste à **réduire la taille, améliorer le temps de chargement, et limiter l’impact visuel inutile** pour offrir une meilleure expérience à tous les utilisateurs, y compris sur mobile ou en zone de faible débit.

**Conséquences d’un CSS non optimisé** :  
- Fichiers inutiles transmis au navigateur  
- Temps de chargement allongé  
- Mauvaise note Google PageSpeed  
- Expérience ralentie, frustration

**Bonnes pratiques d’optimisation** :  
- **Supprimer le CSS non utilisé** (ex. PurgeCSS)  
- **Compresser les fichiers CSS** (`.min.css`)  
- **Inline le CSS critique** (styles essentiels dans le `<head>`)  
- **Utiliser un système de cache** HTTP  
- **Découper par page ou composant** (lazy loading)

**Exemple : suppression du CSS non utilisé avec PurgeCSS** :

```bash
npx purgecss --css style.css --content index.html --output cleaned.css
```

**Exemple : inclusion du CSS critique dans le `<head>`** :

```html
<style>
  body {
    background: #fff;
    color: #111;
    font-family: system-ui, sans-serif;
  }
</style>
<link rel="stylesheet" href="style.min.css">
```

**Astuce** :  
Analysez votre site avec **Lighthouse**, **WebPageTest** ou **PageSpeed Insights** pour identifier les ralentissements liés au CSS.

**Règle à retenir** :  
Un CSS bien optimisé **devrait se charger sans que l’utilisateur s’en aperçoive**. Il doit être rapide, fluide et invisible.

---


## 5. Outils et débogage

Coder sans outils, c’est comme réparer une montre à l’aveugle.  

Sans DevTools, linters ou automatisation, on corrige à la main, on oublie des erreurs, on réinvente la roue, et surtout, on crée du code fragile, difficile à maintenir.  

Utiliser les bons outils permet de :

- gagner du temps sur les tâches répétitives,  
- identifier immédiatement les erreurs ou incohérences,  
- standardiser la structure du CSS,  
- garantir un résultat **cohérent et prévisible** (loi du moindre étonnement).  

Les outils de cette section vous aideront à **mieux écrire, mieux tester et mieux livrer** votre CSS.


---

### DevTools navigateur

**Définition** :  
Les **outils de développement** intégrés aux navigateurs (Chrome, Firefox, Edge) permettent de visualiser, modifier et déboguer votre CSS directement sur la page.

**Fonctionnalités utiles** :
- Inspection du DOM et des styles appliqués
- Visualisation de la cascade CSS
- Outil de box model interactif
- Simulateur de responsive (taille, rotation, pixel ratio)
- Affichage des animations en cours

**Exemple de cas d’usage** :
- Tester un `hover` sur un élément invisible
- Identifier quel style surcharge un autre
- Corriger un `margin` trop grand sans toucher au code source

**Astuce** :  
Utilisez la **vue "accessibilité"** (onglet "Accessibility") pour vérifier le contraste et les focus visibles.


---

### Autoprefixer et PostCSS

**Définition** :  
Autoprefixer est un plugin de **PostCSS** qui ajoute automatiquement les préfixes nécessaires pour assurer la compatibilité des propriétés CSS avec les anciens navigateurs.

**Contexte** :  
Avant, il fallait écrire à la main :

```css
.element {
  -webkit-transform: rotate(45deg);
  -moz-transform: rotate(45deg);
  transform: rotate(45deg);
}
```

Aujourd’hui, Autoprefixer fait ce travail à votre place, à partir d’un simple :

```css
.element {
  transform: rotate(45deg);
}
```

**Exemple simplifié** :

```css
.example {
  display: flex;
}
```

Autoprefixer générera :

```css
.example {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
}
```

**Avantages** :
- Gain de temps
- Moins de code redondant
- Fiabilité accrue sur tous les navigateurs supportés

**Astuce** :  
Utilisez `browserslist` dans votre projet pour configurer précisément quels navigateurs doivent être pris en charge. Exemple :

```txt
> 0.5%, last 2 versions, not dead
```

---

### Linting avec Stylelint

**Définition** :  
**Stylelint** est un outil d’analyse statique qui **détecte les erreurs, incohérences ou mauvaises pratiques** dans votre code CSS ou SCSS.

**Ce qu’il permet** :
- Éviter les doublons de propriétés
- Respecter des conventions de nommage (BEM, kebab-case…)
- Signaler les erreurs de syntaxe
- Harmoniser la structure du fichier

**Exemple de règle** dans `.stylelintrc.json` :

```json
{
  "rules": {
    "indentation": 2,
    "color-no-invalid-hex": true,
    "selector-class-pattern": "^[a-z0-9\\-]+$"
  }
}
```

**Astuce** :  
Intégrez Stylelint à votre éditeur (VS Code, Sublime…) pour des erreurs en temps réel.

---

### Nettoyage avec PurgeCSS

**Définition** :  
**PurgeCSS** analyse vos fichiers HTML, JS, PHP, etc., pour supprimer toutes les classes CSS non utilisées.

**Pourquoi c’est important** :
- Les fichiers `.css` trop volumineux ralentissent le site
- Un style non utilisé est une dette technique
- Vous réduisez la bande passante et le temps de chargement

**Exemple CLI** :

```bash
npx purgecss --css style.css --content index.html --output cleaned.css
```

**Astuce** :  
Dans des projets avec Tailwind CSS ou des frameworks dynamiques, il est crucial d’ajouter un `safelist` pour éviter la suppression de classes générées dynamiquement.

---

### Intégration avec un système de build

**Définition** :  
Des outils comme **Webpack**, **Vite**, **Parcel** ou **Gulp** vous permettent d'automatiser l’enchaînement de vos outils :  
- Linting  
- Minification  
- Auto-prefixing  
- Extraction du CSS critique  
- Génération des fichiers `.min.css`

**Avantages** :
- Moins d’erreurs humaines  
- Build reproductible sur chaque machine  
- Déploiement plus rapide

**Astuce** :  
Configurez votre build pour lancer automatiquement Stylelint, PostCSS et Autoprefixer lors de l’enregistrement d’un fichier.
