# CSS Design Schools of Thought

Ce guide pédagogique regroupe à la fois les grandes philosophies adaptatives du Web et les méthodologies purement techniques d’architecture CSS. Chaque approche vise à rendre vos feuilles de styles plus claires, modulaires et performantes.

---

## 1. Responsive Philosophy  
**Principe :** adapter le rendu en fonction de la taille du viewport, pour une expérience fluide sur tous les écrans.  
**Contexte :** popularisée par Ethan Marcotte en 2010, cette philosophie a prouvé qu’en 2022, les sites vraiment responsive affichaient +67 % de taux de conversion par rapport à des designs fixes sur mobile.  
**Astuce :** utilisez des unités relatives (`%, em, rem`) et des grilles flexibles pour que votre contenu « respire » sur tous les appareils.

---

## 2. Adaptive Design (Conception adaptative)  
**Principe :** prévoir plusieurs mises en page distinctes pour des plages de tailles d’écran définies (breakpoints fixes).  
**Pourquoi ?** optimiser l’ergonomie et la lisibilité en ajustant spécifiquement chaque layout (mobile, tablette, bureau).  
**Exemple :**  
```css
/* mobile (jusqu’à 480px) */
.article { font-size: 1rem; }
/* tablette (481px–768px) */
@media (min-width: 481px) and (max-width: 768px) {
  .article { font-size: 1.125rem; }
}
/* bureau (769px et plus) */
@media (min-width: 769px) {
  .article { font-size: 1.25rem; }
}
```

---

## 3. Mobile‑First Design  
**Principe :** écrire d’abord vos styles pour mobile, puis ajouter des media queries pour tablettes et ordinateurs.  
**Pourquoi ?** concentrer l’attention sur l’essentiel, garantir des performances optimales et limiter la surcharge CSS.  
**Exemple :**  
```css
/* mobile */
.card { padding: 1rem; font-size: 1rem; }
/* tablette et plus */
@media (min-width: 768px) {
  .card { padding: 2rem; font-size: 1.125rem; }
}
```

---

## 4. Progressive Enhancement (Amélioration progressive)  
**Principe :** construire d’abord une expérience fonctionnelle de base (HTML + CSS minimal), puis ajouter des fonctionnalités pour navigateurs modernes (animations, grilles CSS…).  
**Bénéfice :** tout le monde accède au contenu, même sur navigateurs anciens ou en environnement restreint.  
**Conseil :** testez toujours votre site sans JavaScript et avec CSS limité pour valider votre « noyau dur ».

---

## 5. Graceful Degradation (Dégradation élégante)  
**Principe :** concevoir pour les navigateurs modernes, tout en planifiant des repli (« fallbacks ») pour les versions plus anciennes.  
**Illustration :** la BBC gère plus de 4 000 types d’appareils, mais propose une version dégradée permettant de conserver 92 % des fonctionnalités même sur des navigateurs âgés.  
**Astuce :** définissez des `@supports` et des polyfills ciblés pour maintenir l’expérience utilisateur.

---

## 6. Component‑Driven Design (Design piloté par composants)  
**Principe :** penser interface en « boîtes » réutilisables (bouton, carte, modal…) gérées par un Design System.  
**Résultat :** Airbnb a réduit de 34 % le temps de développement et de 68 % les incohérences visuelles grâce à cette approche.  
**Mise en œuvre :** documentez chaque composant (HTML + CSS + comportements) pour faciliter le partage entre équipes.

---

## 7. Intrinsic Web Design (Design intrinsèque du Web)  
**Principe :** exploiter au maximum les capacités natives du Web (CSS Grid, Flexbox, fonctions CSS) plutôt que multiplier les hacks.  
**Avantage :** moins de media queries (–60 % de code grid ajouté selon Jen Simmons), meilleure adaptabilité.  
**Bonne pratique :** combinez `minmax()`, `auto-fit`/`auto-fill` et fonctions CSS pour des mises en page auto‑ajustables.

---

## 8. Container Queries Paradigm (Requêtes de conteneur)  
**Principe :** utiliser la taille d’un conteneur parent plutôt que celle du viewport pour adapter un composant.  
**Impact :** Shopify relève une réduction de 41 % de la complexité CSS et +27 % de réutilisabilité des composants depuis le support généralisé (2023).  
**Exemple :**  
```css
.card {
  container-type: inline-size;
}
@container (min-width: 30rem) {
  .card { display: flex; }
}
```

---

## 9. Utility‑First CSS (CSS utilitaire)  
**Principe :** créer des classes courtes et précises (`.m-4`, `.text-center`) au lieu de styles dédiés par composant.  
**Framework :** Tailwind CSS — présent sur 1 % des sites du Web — peut réduire vos payloads de 60–80 %.  
**Astuce :** activez la purge des classes pour n’envoyer en production que ce que vous utilisez réellement.

---

## 10. CSS‑in‑JS Paradigm  
**Principe :** co‑localiser les styles avec les composants JavaScript (React, Vue…), construits au moment de la compilation.  
**Tendances 2024 :** 61 % des développeurs utilisent CSS Modules, 59 % Styled Components.  
**Pour qui ?** idéal pour les écosystèmes à composants, avec scoping automatique et theming dynamique.

---

## 11. SMACSS (Scalable and Modular Architecture for CSS)  
**Principe :** catégoriser vos règles en cinq types — *Base*, *Layout*, *Module*, *State*, *Theme* — pour un code structuré.  
**Avantage :** clarifie la séparation des responsabilités et simplifie l’évolution du code à grande échelle.  
**Arborescence type :**  
```
/css
├─ base/       _reset.css
├─ layout/     _grid.css
├─ module/     _carousel.css
├─ state/      _is-active.css
└─ theme/      _colors.css
```

---

## 12. OOCSS (Object‑Oriented CSS)  
**Principe :** dissocier « structure » (layout, dimensions) et « skin » (couleurs, typographie) pour créer des objets CSS réutilisables.  
**Bénéfices :** moins de duplication, bundle plus léger, maintenance facilitée.  
**Exemple :**  
```html
<div class="Media u-flex u-gap">
  <img class="Media__img" src="…" />
  <div class="Media__body u-padding">Texte…</div>
</div>
```

---

## 13. BEM (Block Element Modifier)  
**Principe :** nommage strict `block__element--modifier` pour éviter collisions et clarifier la hiérarchie.  
**Point fort :** chaque classe est unique, on sait exactement où elle s’applique.  
**Exemple :**  
```html
<button class="Button Button--primary Button--large">Envoyer</button>
```

---

## 14. ITCSS (Inverted Triangle CSS)  
**Principe :** empiler vos styles du moins spécifique (variables, resets) au plus spécifique (utilities), en forme de triangle inversé.  
**Objectif :** maîtriser la cascade, éviter les conflits de spécificité, garder la base CSS légère.  
**Séquence :**  
1. Settings (variables)  
2. Tools (mixins)  
3. Generic (normalize)  
4. Elements (balises par défaut)  
5. Objects (layout)  
6. Components (UI)  
7. Utilities (classes d’override)

---

## 15. SUIT CSS  
**Principe :** proche de BEM, mais taillé pour les composants JS : conventions de nommage pour composants, parties et états (`Component`, `Component–part`, `is-active`).  
**Usage :** s’intègre à Webpack/Gulp pour encapsuler et tester vos styles.  
**Exemple :**  
```html
<div class="Modal Modal--large is-open">
  <header class="Modal–header">Titre</header>
  …
</div>
```

---

> **En pratique**, commencez par choisir une philosophie adaptative (responsive, adaptative ou mobile‑first), puis ajoutez une architecture CSS (BEM, OOCSS, ITCSS…) pour structurer et scaler votre code sur le long terme.  