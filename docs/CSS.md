# CSS : conception, mise en page et maintenabilité

Le CSS permet de contrôler l’apparence, la lisibilité, l’adaptabilité et une partie importante de l’expérience utilisateur d’un site web.

Un bon CSS ne sert pas seulement à « rendre joli ». Il sert aussi à :

* organiser l’information visuellement ;
* adapter l’interface aux tailles d’écran et aux contextes d’usage ;
* rendre les composants cohérents et réutilisables ;
* limiter les surprises visuelles et comportementales ;
* améliorer l’accessibilité, la performance et la maintenabilité du projet.

Le CSS moderne fournit des outils puissants pour cela : **Flexbox**, **Grid**, **media queries**, **variables CSS**, **transitions**, **animations**, mais aussi des méthodes de structuration comme **BEM**, **SMACSS**, **OOCSS** ou **ITCSS**.

Dans ce document, l’objectif n’est pas de tout empiler, mais de comprendre **quand utiliser quoi**, **pourquoi**, et **avec quelle logique de projet**.

---

## Sommaire

1. [Contexte](#1-contexte)
2. [Écoles de pensée CSS](#2-écoles-de-pensée-css)
3. [Flexbox](#3-flexbox)
4. [Grid Layout](#4-grid-layout)
5. [Quand utiliser Flexbox ou Grid](#5-quand-utiliser-flexbox-ou-grid)
6. [Media Queries](#6-media-queries)
7. [Thématisation et effets dynamiques](#7-thématisation-et-effets-dynamiques)
8. [Structuration et maintenabilité du CSS](#8-structuration-et-maintenabilité-du-css)
9. [Accessibilité et performance](#9-accessibilité-et-performance)
10. [Outils et débogage](#10-outils-et-débogage)
11. [Directions artistiques en CSS](#11-directions-artistiques-en-css)
12. [Conclusion](#12-conclusion)

---

## 1. Contexte

### Objectifs

* Comprendre les principes de mise en page moderne
* Savoir choisir entre Flexbox, Grid et media queries
* Utiliser les variables CSS pour centraliser un thème
* Ajouter des effets dynamiques sans nuire à l’accessibilité
* Structurer son CSS pour qu’il reste lisible et maintenable
* Intégrer les enjeux d’accessibilité et de performance dès la conception

### Prérequis

* Connaissance de base du HTML et du CSS
* Compréhension des sélecteurs, propriétés et classes
* Notions de structure de page et de composants

### Public cible

Ce cours s’adresse aux apprenants en développement web qui souhaitent passer d’un CSS “qui fonctionne” à un CSS **pensé, structuré et durable**.

### Durée estimée

Environ 2 heures, hors exercices.

### Matériel

* un éditeur de code ;
* un navigateur moderne ;
* les outils de développement du navigateur ;
* éventuellement un validateur, Lighthouse ou axe DevTools.

---

## 2. Écoles de pensée CSS

Sans bonne maîtrise des logiques de rendu et d’organisation, on produit vite des interfaces fragiles, rigides et difficiles à faire évoluer.

Les éléments peuvent se chevaucher, devenir illisibles, casser sur certains écrans ou demander des corrections coûteuses à chaque modification.

L’objectif n’est donc pas seulement d’apprendre des propriétés CSS, mais aussi de comprendre les **logiques de conception** qui les accompagnent.

### 2.1 Philosophies adaptatives du rendu

Ces approches définissent la manière dont le style s’adapte à l’écran, au navigateur ou au contexte utilisateur.

#### Responsive Design

Créer des interfaces qui s’adaptent à toutes les tailles d’écran à partir d’une structure flexible.

#### Adaptive Design

Prévoir plusieurs mises en page distinctes pour certaines plages d’écran précises.

#### Mobile First

Concevoir d’abord pour les petits écrans, puis enrichir progressivement avec des `@media (min-width: ...)`.

#### Desktop First

Concevoir d’abord pour les grands écrans, puis corriger ou simplifier pour les plus petits avec `max-width`.

#### Progressive Enhancement

Construire une base simple, robuste et accessible, puis ajouter des améliorations pour les navigateurs qui les supportent.

#### Graceful Degradation

Concevoir d’abord pour des environnements modernes, puis prévoir des solutions de repli acceptables pour les contextes plus limités.

#### Intrinsic Web Design

S’appuyer sur les capacités natives du web pour laisser le contenu s’adapter de lui-même autant que possible.

#### Container Queries

Adapter un composant selon la taille de son conteneur plutôt que selon celle de toute la fenêtre.

### 2.2 Paradigmes de conception de composants

Ces approches pensent l’interface comme un ensemble de blocs réutilisables.

#### Component-Driven Design

Construire l’interface comme une bibliothèque de composants indépendants : boutons, cartes, formulaires, modales, etc.

#### Atomic Design

Décomposer l’interface en atomes, molécules, organismes, templates et pages.

#### Design Tokens

Centraliser les valeurs de design : couleurs, espacements, tailles de police, rayons, ombres.

#### Design System

Formaliser un ensemble cohérent de composants, règles et conventions pour maintenir l’unité visuelle et technique.

### 2.3 Approches utilitaires et low-level

#### Utility-First CSS

Utiliser des classes très ciblées et très courtes pour appliquer directement des styles simples.

### 2.4 Méthodologies architecturales

Ces méthodes servent surtout à organiser le code CSS dans le temps.

#### SMACSS

Structurer les styles par rôle : base, layout, module, state, theme.

#### OOCSS

Distinguer structure et apparence pour créer des objets réutilisables.

#### BEM

Nommer les classes de façon explicite à l’aide d’une convention stable.

#### ITCSS

Classer les couches CSS du plus général au plus spécifique.

#### SUIT CSS

Convention proche de BEM, pensée pour des composants pilotés par JavaScript.

### 2.5 Ce qu’il faut retenir

Il n’existe pas une seule bonne école de pensée.

En pratique, on mélange souvent plusieurs approches. Un projet peut par exemple être :

* **mobile-first** dans sa logique responsive ;
* **intrinsic** dans sa manière de gérer les layouts ;
* **BEM** pour nommer ses composants ;
* **SMACSS** pour organiser ses fichiers ;
* **design-token driven** pour gérer ses couleurs et espacements.

---

## 3. Flexbox

### Définition

Flexbox est un système de mise en page **unidimensionnel**. Il permet d’organiser des éléments sur **un seul axe à la fois** : horizontal ou vertical.

C’est un outil très utile pour aligner, répartir ou centrer des éléments dans un composant.

### Propriétés clés

* `display: flex`
* `flex-direction`
* `justify-content`
* `align-items`
* `flex-wrap`
* `gap`

### Cas d’usage

* centrer un bouton ou un bloc ;
* aligner les éléments d’une barre de navigation ;
* répartir des cartes sur une ligne ;
* organiser un groupe d’actions.

### Exemple CSS

```css
.nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
```

### Exemple HTML

```html
<nav class="nav">
  <a href="#">Accueil</a>
  <a href="#">Produits</a>
  <a href="#">Contact</a>
</nav>
```

### Astuce

Flexbox est excellent pour organiser **un composant**.
Dès qu’il faut raisonner en lignes **et** colonnes en même temps, Grid devient souvent plus adapté.

---

## 4. Grid Layout

### Définition

CSS Grid est un système de mise en page **bidimensionnel**. Il permet d’organiser les éléments à la fois en **lignes** et en **colonnes**.

Il est particulièrement utile pour les structures de page, les galeries, les grilles de cartes et les layouts complexes.

### Propriétés clés

* `display: grid`
* `grid-template-columns`
* `grid-template-rows`
* `grid-column`
* `grid-row`
* `gap`
* `repeat()`
* `minmax()`
* `auto-fit`
* `auto-fill`

### Cas d’usage

* grille responsive de cartes ;
* dashboard ;
* page avec header, sidebar, contenu principal et footer ;
* disposition éditoriale complexe.

### Exemple CSS

```css
.article-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}
```

### Exemple HTML

```html
<section class="article-grid">
  <article class="card">...</article>
  <article class="card">...</article>
</section>
```

### Astuce

L’association `auto-fit` + `minmax()` permet souvent d’obtenir un comportement adaptatif sans multiplier les media queries.

---

## 5. Quand utiliser Flexbox ou Grid

Le choix dépend surtout de la nature du problème de mise en page.

| Critère         | Flexbox                    | Grid                                  |
| --------------- | -------------------------- | ------------------------------------- |
| Dimension       | Un axe                     | Deux axes                             |
| Usage principal | Alignement et répartition  | Organisation spatiale globale         |
| Idéal pour      | Menus, boutons, composants | Sections, pages, galeries, dashboards |
| Contrôle        | Souple                     | Plus structuré                        |

### 5.1 Utiliser Flexbox quand…

* les éléments doivent être alignés sur une ligne ou une colonne ;
* le nombre d’éléments peut varier ;
* on veut centrer, espacer ou inverser facilement ;
* on travaille à l’échelle d’un composant.

```css
.container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.item {
  flex: 1;
  margin: 0 1rem;
}
```

### 5.2 Utiliser Grid quand…

* il faut positionner des zones sur deux axes ;
* la mise en page est plus structurée que simplement alignée ;
* on veut contrôler précisément les colonnes, lignes ou zones.

```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: auto 200px;
  gap: 1rem;
}

.header {
  grid-column: 1 / -1;
}

.sidebar {
  grid-column: 1;
  grid-row: 2;
}

.content {
  grid-column: 2 / 4;
  grid-row: 2;
}
```

### 5.3 Combiner les deux

On combine très souvent Grid et Flexbox dans un même projet.

* **Grid** pour la structure générale ;
* **Flexbox** pour l’alignement interne des composants.

```html
<div class="page-grid">
  <header class="header">…</header>
  <nav class="sidebar">…</nav>
  <main class="content">
    <section class="feature-list">
      <div class="feature-item">…</div>
      <div class="feature-item">…</div>
      <div class="feature-item">…</div>
    </section>
  </main>
</div>
```

```css
.page-grid {
  display: grid;
}

.feature-list {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

.feature-item {
  flex: 1 1 200px;
}
```

---

## 6. Media Queries

### 6.1 Définition

Les **media queries** sont des conditions CSS. Elles permettent d’appliquer certaines règles uniquement dans certains contextes.

Elles peuvent réagir à :

* la largeur de l’écran ;
* l’orientation ;
* le thème clair ou sombre ;
* la préférence de réduction des animations.

### 6.2 Syntaxe de base

```css
@media (condition) {
  /* règles CSS */
}
```

### 6.3 Exemples de conditions

* `(min-width: 768px)`
* `(max-width: 1024px)`
* `(orientation: landscape)`
* `(prefers-color-scheme: dark)`
* `(prefers-reduced-motion: reduce)`

### 6.4 Cas d’usage

| Media query              | Utilisation typique                 |
| ------------------------ | ----------------------------------- |
| `min-width`, `max-width` | responsive design                   |
| `orientation`            | adaptation portrait/paysage         |
| `prefers-color-scheme`   | thème clair/sombre                  |
| `prefers-reduced-motion` | accessibilité visuelle et cognitive |

### 6.5 Approche mobile-first

En mobile-first, on écrit d’abord les styles de base pour les petits écrans, puis on enrichit progressivement.

```css
.card {
  padding: 1rem;
  font-size: 1rem;
}

@media (min-width: 768px) {
  .card {
    padding: 2rem;
    font-size: 1.125rem;
  }
}
```

### 6.6 Place des media queries dans une architecture CSS

Dans une logique **SMACSS hybride**, les media queries ne sont pas toutes regroupées arbitrairement à la fin du fichier.

On les place selon leur rôle :

* dans `layout.css` pour la structure responsive ;
* dans `theme.css` pour les préférences utilisateur ;
* dans `state.css` pour les animations ou transitions conditionnelles ;
* dans `module.css` si le composant a des variantes contextuelles locales.

### 6.7 Exemple complet

#### HTML

```html
<div class="container">
  <article class="card is-animated">
    <h2 class="card-title">Titre accessible</h2>
    <p class="card-content">Ce bloc s’adapte à l’écran, au thème et aux préférences utilisateur.</p>
  </article>
</div>
```

#### module.css

```css
.card {
  background-color: #ffffff;
  color: #111111;
  padding: 1rem;
  border-radius: 0.5rem;
  box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
  opacity: 0;
  transform: translateY(20px);
}

.card-title {
  font-size: 1.2rem;
}

.card-content {
  font-size: 1rem;
  line-height: 1.5;
}
```

#### layout.css

```css
.container {
  display: block;
  padding: 1rem;
}

@media (min-width: 768px) {
  .container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 2rem;
  }
}
```

#### state.css

```css
.is-animated {
  animation: fadeInUp 0.6s ease-out forwards;
}

@keyframes fadeInUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@media (prefers-reduced-motion: reduce) {
  .is-animated {
    animation: none;
    opacity: 1;
    transform: none;
  }
}
```

#### theme.css

```css
@media (prefers-color-scheme: dark) {
  .card {
    background-color: #1e1e1e;
    color: #f0f0f0;
    box-shadow: 0 0 8px rgba(255, 255, 255, 0.1);
  }

  .card a {
    color: #8ab4f8;
  }
}
```

### 6.8 Bilan pédagogique

Les media queries ne servent pas seulement à “faire du responsive”.
Elles servent aussi à respecter le contexte utilisateur et à intégrer l’accessibilité dans le style.

---

## 7. Thématisation et effets dynamiques

Un design figé, sans thème ni animation, donne souvent une impression d’interface pauvre ou rigide.

À l’inverse, trop d’effets ou une gestion dispersée des couleurs produisent vite un site incohérent, coûteux à maintenir, et parfois pénible à utiliser.

### 7.1 Variables CSS

#### Définition

Les variables CSS, aussi appelées **custom properties**, permettent de centraliser des valeurs réutilisables.

Elles sont particulièrement utiles pour :

* les couleurs ;
* les espacements ;
* les rayons ;
* les ombres ;
* la gestion de thèmes.

#### Propriétés clés

* `--nom: valeur`
* `var(--nom)`
* `:root`

#### Exemple

```css
:root {
  --bg-color: #ffffff;
  --text-color: #111111;
}

[data-theme='dark'] {
  --bg-color: #111111;
  --text-color: #ffffff;
}

body {
  background-color: var(--bg-color);
  color: var(--text-color);
}
```

#### Astuce

Une variable globale peut être surchargée localement dans un composant si nécessaire.

### 7.2 Transitions

#### Définition

Les transitions permettent d’adoucir le passage entre deux états CSS.

#### Propriétés clés

* `transition-property`
* `transition-duration`
* `transition-timing-function`
* `transition-delay`

#### Cas d’usage

* hover de bouton ;
* ouverture d’un menu ;
* changement de couleur ;
* focus visuel.

#### Exemple

```css
.card__button {
  transition: background-color 0.3s ease;
}

.card__button:hover {
  background-color: #007bff;
}
```

#### Astuce

Les transitions doivent accompagner l’interaction, pas distraire l’utilisateur.

### 7.3 Animations avec `@keyframes`

#### Définition

Les animations définissent plusieurs étapes d’un changement visuel.

#### Propriétés clés

* `animation-name`
* `animation-duration`
* `animation-delay`
* `animation-iteration-count`
* `animation-timing-function`

#### Cas d’usage

* apparition progressive ;
* notification ;
* chargement ;
* micro-interaction.

#### Exemple

```css
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.card {
  animation: fadeIn 0.5s ease-out;
}
```

### 7.4 Respecter les préférences utilisateur

Certaines animations peuvent gêner, fatiguer ou perturber.

```css
@media (prefers-reduced-motion: reduce) {
  * {
    animation: none !important;
    transition: none !important;
  }
}
```

### 7.5 Ce qu’il faut retenir

Les effets dynamiques sont utiles lorsqu’ils :

* clarifient une action ;
* améliorent la lisibilité d’un changement d’état ;
* restent sobres ;
* respectent les préférences utilisateur.

---

## 8. Structuration et maintenabilité du CSS

Sans méthode claire, le CSS devient vite une accumulation de règles difficiles à comprendre, à retrouver et à modifier.

On duplique, on surcharge, on corrige un endroit en cassant un autre.

L’objectif d’une bonne structuration n’est pas le dogme, mais la **cohérence**.

### 8.1 Pourquoi structurer

Une structure claire permet de :

* réduire la charge mentale ;
* limiter les collisions entre styles ;
* accélérer le débogage ;
* faciliter le travail en équipe ;
* rendre le projet plus durable.

### 8.2 BEM

#### Définition

BEM signifie **Block Element Modifier**.
C’est une convention de nommage conçue pour rendre les composants lisibles et prévisibles.

#### Syntaxe

`.block__element--modifier`

#### Exemple HTML

```html
<article class="card">
  <img src="image.jpg" class="card__image" alt="">
  <header class="card__header">
    <h2 class="card__title">Titre</h2>
  </header>
  <footer class="card__footer">
    <a href="#" class="card__button card__button--primary">Lire</a>
  </footer>
</article>
```

#### Avantages

* lisibilité ;
* faible ambiguïté ;
* bonne maintenabilité ;
* relation explicite entre les parties du composant.

### 8.3 SMACSS

#### Définition

SMACSS organise les styles selon leur rôle dans le projet.

#### Catégories

* **Base** : styles par défaut ;
* **Layout** : structure générale ;
* **Module** : composants réutilisables ;
* **State** : états ;
* **Theme** : variations visuelles.

#### Exemple HTML

```html
<article class="module-card is-highlighted">
  <img src="image.jpg" class="card-image" alt="">
  <header class="card-header">
    <h2 class="card-title">Titre</h2>
  </header>
  <footer class="card-footer">
    <a href="#" class="card-button">Lire</a>
  </footer>
</article>
```

#### Avantages

* structure modulaire ;
* séparation claire des responsabilités ;
* extensibilité.

### 8.4 OOCSS

#### Définition

OOCSS sépare la structure de l’apparence pour favoriser la réutilisation.

#### Exemple HTML

```html
<article class="media-box skin-card">
  <img src="image.jpg" class="media-box__img" alt="">
  <header class="media-box__header">
    <h2 class="media-box__title">Titre</h2>
  </header>
  <footer class="media-box__footer">
    <a href="#" class="btn btn--primary">Lire</a>
  </footer>
</article>
```

#### Avantages

* réutilisabilité ;
* séparation logique ;
* mutualisation des patterns.

### 8.5 Tableau comparatif

| Approche | Objectif principal     | Syntaxe typique               | Avantages               |
| -------- | ---------------------- | ----------------------------- | ----------------------- |
| BEM      | Structuration claire   | `.block__element--modifier`   | Prévisible, maintenable |
| SMACSS   | Organisation modulaire | `.module`, `.is-state`        | Flexible, adaptable     |
| OOCSS    | Réutilisation d’objets | `.media-box`, `.btn--primary` | Composants + thèmes     |

### 8.6 Recommandation pratique

Dans un projet pédagogique ou de petite à moyenne taille, une combinaison simple fonctionne bien :

* **BEM** pour nommer les composants ;
* **SMACSS** pour organiser les fichiers ;
* **variables CSS** pour centraliser le thème ;
* **mobile-first** pour la logique responsive.

---

## 9. Accessibilité et performance

Un site qui n’est ni accessible ni performant exclut une partie des utilisateurs et dégrade la qualité globale du projet.

Cette exclusion peut être liée :

* à la navigation clavier ;
* à la lisibilité ;
* au contraste ;
* à l’excès d’animation ;
* à des temps de chargement trop longs ;
* à des connexions ou appareils limités.

### 9.1 Accessibilité WCAG

#### Définition

Les WCAG sont des recommandations visant à rendre le web utilisable par le plus grand nombre, y compris les personnes en situation de handicap.

#### Bonnes pratiques CSS

* assurer un contraste suffisant ;
* conserver un focus visible ;
* utiliser des unités relatives ;
* respecter les préférences utilisateur ;
* éviter les animations intrusives.

#### Exemple : focus visible

```css
:focus-visible {
  outline: 2px solid #f90;
  outline-offset: 2px;
}
```

#### Exemple : préférences utilisateur

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

### 9.2 Optimisation CSS

#### Définition

Optimiser le CSS consiste à réduire ce qui est inutile et à charger ce qui est nécessaire au bon moment.

#### Bonnes pratiques

* supprimer le CSS non utilisé ;
* minifier les fichiers ;
* inline le CSS critique ;
* découper le CSS si nécessaire ;
* utiliser le cache navigateur.

#### Exemple : CSS critique

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

#### Exemple : PurgeCSS

```bash
npx purgecss --css style.css --content index.html --output cleaned.css
```

### 9.3 Principe directeur

Un bon CSS doit être rapide, lisible, robuste et prévisible.

L’utilisateur ne devrait jamais avoir à “deviner” ce qu’un élément fait, ni attendre inutilement pour l’obtenir.

---

## 10. Outils et débogage

Travailler sans outils de vérification ou de débogage rend le CSS plus fragile, plus lent à corriger et plus difficile à maintenir.

Les outils ne remplacent pas la compréhension, mais ils accélèrent énormément le travail.

### 10.1 DevTools navigateur

Les outils de développement des navigateurs permettent de :

* inspecter le DOM ;
* voir la cascade et les règles appliquées ;
* tester les tailles d’écran ;
* visualiser le box model ;
* forcer des états (`:hover`, `:focus`) ;
* contrôler les animations ;
* repérer certains problèmes d’accessibilité.

### 10.2 Autoprefixer et PostCSS

Autoprefixer ajoute automatiquement les préfixes nécessaires selon les navigateurs ciblés.

```css
.element {
  transform: rotate(45deg);
}
```

Peut être transformé automatiquement en version compatible avec des navigateurs plus anciens.

#### Exemple de configuration Browserslist

```txt
> 0.5%, last 2 versions, not dead
```

### 10.3 Stylelint

Stylelint détecte les erreurs, incohérences et écarts de convention dans le CSS.

#### Exemple

```json
{
  "rules": {
    "color-no-invalid-hex": true,
    "selector-class-pattern": "^[a-z0-9\\-]+$"
  }
}
```

### 10.4 PurgeCSS

PurgeCSS supprime les classes non utilisées pour alléger le CSS final.

```bash
npx purgecss --css style.css --content index.html --output cleaned.css
```

### 10.5 Système de build

Des outils comme Vite, Parcel, Webpack ou Gulp permettent d’automatiser :

* linting ;
* minification ;
* autoprefixing ;
* extraction éventuelle du CSS critique ;
* génération de fichiers finaux.

---

## 11. Directions artistiques en CSS

Les outils techniques ne suffisent pas à définir une identité visuelle.
Il faut aussi une direction artistique.

Cette partie ne relève plus directement de l’architecture du code, mais de la manière dont on choisit de représenter visuellement l’interface.

### 11.1 Minimalisme

Réduction maximale de l’ornement. Priorité à la lisibilité, à l’espace, à la sobriété.

### 11.2 Brutalisme

Aspect brut, frontal, parfois volontairement rugueux. Hiérarchie visuelle forte, peu de polissage.

### 11.3 Skeuomorphisme

Imitation visuelle d’objets réels : textures, reliefs, matières, repères familiers.

### 11.4 Flat Design

Aplats, formes simples, peu ou pas de relief.

### 11.5 Material Design

Surfaces hiérarchisées, ombres contrôlées, animations fonctionnelles, logique de composants.

### 11.6 Neumorphisme

Reliefs doux, interfaces qui semblent légèrement creusées ou extrudées.

### 11.7 Style international / Swiss Design

Grille, rigueur typographique, hiérarchie nette, sobriété fonctionnelle.

### 11.8 Postmodernisme / déconstructivisme

Fragmentation, rupture de grille, expérimentation, composition moins prévisible.

### 11.9 Maximalisme

Accumulation, motifs, couleurs, densité visuelle importante.

### 11.10 Glassmorphism

Transparence, flou, effets de profondeur rappelant un verre dépoli.

### 11.11 Micro-interactions et motion design

Petites animations et transitions destinées à guider, signaler ou confirmer une action.

### Ce qu’il faut retenir

Une direction artistique n’est pas une décoration ajoutée à la fin.
Elle influence :

* la grille ;
* la typographie ;
* les espacements ;
* les couleurs ;
* les animations ;
* le niveau de densité visuelle.

Elle doit rester compatible avec l’accessibilité, la performance et les objectifs du projet.

---

## 12. Conclusion

Le CSS moderne ne consiste pas seulement à appliquer des propriétés. Il consiste à faire des choix.

Ces choix portent sur :

* la logique de rendu ;
* le système de mise en page ;
* la structuration des composants ;
* la façon d’organiser les fichiers ;
* la gestion du thème ;
* l’accessibilité ;
* la performance ;
* la direction artistique.

En pratique, une combinaison simple et robuste fonctionne très bien dans beaucoup de projets :

1. **Mobile-first** pour poser une base légère ;
2. **Progressive enhancement** pour enrichir sans casser ;
3. **Intrinsic web design** pour laisser le layout respirer ;
4. **Grid + Flexbox** selon le niveau de structure ;
5. **BEM + SMACSS** pour garder un CSS compréhensible ;
6. **Variables CSS** pour centraliser le thème ;
7. **Respect des préférences utilisateur** pour ne pas surprendre.

Un bon CSS ne se contente pas d’être beau.
Il doit aussi être **clair**, **prévisible**, **accessible**, **rapide** et **évolutif**.
