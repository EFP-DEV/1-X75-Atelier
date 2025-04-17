# CSS : Conception et mise en page

Le CSS est un langage de style qui permet de contrôler l'apparence des pages web.
Il est essentiel de maîtriser les mises en page modernes, la thématisation et les effets dynamiques pour créer des interfaces utilisateur attrayantes et fonctionnelles.
Le CSS moderne offre des outils puissants pour créer des designs adaptatifs et dynamiques, mais il est crucial de les utiliser judicieusement pour éviter des problèmes de performance et d'accessibilité.

Tout au long de ce cours, nous allons explorer les concepts clés du CSS moderne, y compris Flexbox, Grid Layout, les Media Queries, les variables CSS, les transitions et animations, ainsi que les bonnes pratiques d'accessibilité et de performance.

---

## Sommaire
1. [Contexte](#1-contexte)  
2. [Écoles de pensée](#2-ecoles-de-pensee)  
3. [Flexbox](#3-flexbox)  
4. [Grid Layout](#4-grid-layout)  
5. [Quand utiliser Flexbox ou Grid](#5-quand-utiliser-flexbox-ou-grid)  

---

## 1. Contexte

### Objectifs

- Comprendre les concepts de mise en page moderne (Flexbox, Grid, Media Queries)
- Apprendre à utiliser les variables CSS pour la thématisation
- Découvrir les transitions et animations pour améliorer l'expérience utilisateur
- Explorer les bonnes pratiques d'accessibilité et de performance

### Prérequis

- Connaissance de base du HTML et du CSS
- Familiarité avec les concepts de design web
- Compréhension des principes de base de l'accessibilité

### Public cible

Ce cours s'adresse aux développeurs web, designers et toute personne souhaitant améliorer ses compétences en CSS pour créer des interfaces utilisateur modernes et accessibles.

### Durée

Environ 2 heures

### Matériel

- Un éditeur de code (Visual Studio Code, Sublime Text, etc.)
- Un navigateur web moderne (Chrome, Firefox, Safari, etc.)
- Un accès à Internet pour consulter la documentation et les ressources en ligne

---


## 2. Ecoles de pensée 

Sans une bonne maîtrise de Flexbox, Grid et des Media Queries, vous risquez de produire des interfaces fragiles, rigides, et difficiles à adapter aux différents écrans.

Les éléments peuvent se chevaucher, disparaître ou devenir illisibles selon le support.  
L’objectif ici est de construire des structures cohérentes, adaptables et intuitives, qui ne surprennent pas l'utilisateur.

La question n'est pas de savoir si vous devez utiliser Flexbox ou Grid, mais plutôt de savoir quand utiliser l'un ou l'autre, et comment les combiner efficacement.

Au dela de la technique, il est essentiel de comprendre les écoles de pensée qui sous-tendent ces outils.

- **Mobile First** : Concevoir d'abord pour les petits écrans, puis adapter pour les plus grands (min-width).
- **Desktop First** : Concevoir d'abord pour les grands écrans, puis adapter pour les plus petits (max-width).

- **Fluid Design** : Utiliser des unités relatives (%, em, rem) pour créer des mises en page flexibles.
- **Adaptive Design** : Créer des mises en page spécifiques pour différentes tailles d'écran.

- **Responsive Design** : Créer des mises en page qui s'adaptent à toutes les tailles d'écran.

- **Progressive Enhancement** : Construire d'abord une base solide, puis ajouter des fonctionnalités avancées pour les navigateurs modernes, opposant à la dégradation gracieuse.

- **Graceful Degradation** : Concevoir d'abord pour les navigateurs modernes, puis assurer une expérience acceptable sur les anciens navigateurs.

- **Intrinsic Web Design** : Penser en termes de contraintes intrinsèques du web, comme la flexibilité et l'adaptabilité.

- **Container Queries** : Styliser en fonction des contraintes du parent plutôt que de la fenêtre d'affichage.
- **Component-Driven Design** : Penser en termes de composants modulaires et réutilisables.
- **Atomic Design** : Concevoir des systèmes de design en décomposant les éléments en atomes, molécules, organismes, templates et pages.
- **Design Tokens** : Utiliser des variables pour représenter les valeurs de design (couleurs, typographie, etc.) de manière cohérente et réutilisable.
- **Design Systems** : Créer un ensemble de règles, composants et styles pour assurer la cohérence à travers les produits.

Tout cela semble complique ? [bring a towel](../assets/schools-of-css-design.svg)


## 3. Flexbox

**Définition** :  
Flexbox (Flexible Box Layout) est un système d'agencement unidirectionnel permettant de disposer des éléments en ligne ou en colonne de manière souple.

**Propriétés clés** :

- `display: flex`
- `flex-direction`
- `justify-content`
- `align-items`
- `gap`

**Cas d’usage** :

- Centrer un bouton
- Disposer un menu horizontal
- Répartir des colonnes dans une barre de navigation

**Exemple CSS** :

```css
.nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
```

**Exemple HTML** :

```html
<nav class="nav">
  <a href="#">Accueil</a>
  <a href="#">Produits</a>
  <a href="#">Contact</a>
</nav>
```

**Astuce** :  
Flexbox ne gère qu'une direction à la fois. Pour une mise en page à la fois horizontale et verticale, utiliser CSS Grid.

---

## 4. Grid Layout

**Définition** :  
CSS Grid est un système de mise en page bidimensionnel, permettant d'organiser les éléments en lignes et colonnes.

**Propriétés clés** :

- `display: grid`
- `grid-template-columns`
- `grid-template-rows`
- `gap`
- `auto-fit`, `minmax()`

**Cas d’usage** :

- Grille responsive de cartes
- Mise en page d’un tableau de bord
- Disposition complexe d'une page

**Exemple CSS** :

```css
.article-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}
```

**Exemple HTML** :

```html
<section class="article-grid">
  <article class="card">...</article>
  <article class="card">...</article>
</section>
```

**Astuce** :  
Utiliser `auto-fit` avec `minmax()` permet une mise en page fluide sans `@media`.

## 5. Quand utiliser Flexbox ou Grid  

Le choix entre Flexbox et Grid dépend essentiellement de la nature de votre mise en page :

| Critère                  | Flexbox                                         | Grid                                           |
|--------------------------|-------------------------------------------------|------------------------------------------------|
| **Dimension**            | Unidimensionnel (ligne **ou** colonne)          | Bidimensionnel (lignes **et** colonnes)       |
| **Alignement**           | Alignement fin des éléments sur un seul axe     | Placement précis sur deux axes                 |
| **Répartition de l’espace** | Distribution dynamique de l’espace disponible  | Zones de grille définies (track sizing)       |
| **Cas d’usage typiques** | Barre d’outils, menu horizontal/vertical, boutons, alignement simple de composants | Layouts complexes (cards, galleries, sections de page), grille de contenu |  

### 5.1 Flexbox  
```css
.container {
  display: flex;
  /* Sens par défaut : rangée */
  justify-content: space-between; /* espace entre chaque élément */
  align-items: center;            /* alignement vertical centré */
}
.item {
  flex: 1;       /* chaque item prend la même part d'espace */
  margin: 0 1rem;
}
```
- **Quand ?**  
  - Liste d’actions (boutons, icônes) alignés sur une seule ligne ou colonne.  
  - Alignement et répartition d’éléments dont la quantité peut varier.  
- **Pourquoi ?**  
  - Manipulation facile des ordres, des espaces et de la taille relative.  

### 5.2 Grid  
```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: auto 200px;
  grid-gap: 1rem;
}
.header {
  grid-column: 1 / -1; /* occupe toute la largeur */
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
- **Quand ?**  
  - Mise en page de sections multiples (header, sidebar, main, footer).  
  - Contrôle précis du positionnement sur deux axes.  
- **Pourquoi ?**  
  - Définir des « zones » de mise en page clairement nommées.  
  - Gérer facilement les gaps et la répartition en grille.  

### 5.3 Combiner Flexbox et Grid  
1. **Structure Globale (Grid) + Composants Internes (Flexbox)**  
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
   .page-grid { display: grid; /* layout 2×2 ou 3×2 */ }
   .feature-list { display: flex; flex-wrap: wrap; gap: 1rem; }
   .feature-item { flex: 1 1 200px; }
   ```
2. **Grid pour le layout multi-colonnes**, Flexbox pour **aligner les éléments d’un composant** (boutons, cartes, formulaires).



