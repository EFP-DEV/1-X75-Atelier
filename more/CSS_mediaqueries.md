# Media Queries (SMACSS hybride)

## 1. Définition

Les **media queries** sont des instructions CSS conditionnelles. Elles permettent d’appliquer des styles en fonction de **caractéristiques spécifiques du terminal ou des préférences utilisateur**, telles que :

- la **taille de l’écran**,
- l’**orientation**,
- les **préférences de thème** (sombre ou clair),
- les **préférences de mouvement** (animations réduites).

---

## 2. Syntaxe de base

```css
@media (condition) {
  /* règles CSS ici */
}
```

### Exemples de conditions :

- `(min-width: 768px)` → si l’écran fait au moins 768 pixels de large
- `(orientation: landscape)` → si l’écran est en paysage
- `(prefers-color-scheme: dark)` → si l’utilisateur a activé le thème sombre
- `(prefers-reduced-motion: reduce)` → si l’utilisateur préfère limiter les animations

---

## 3. Cas d’usage

| Media Query                      | Utilisation typique                      |
|----------------------------------|------------------------------------------|
| `min-width`, `max-width`         | Responsive design                        |
| `orientation`                    | Adaptation de la mise en page            |
| `prefers-color-scheme`           | Thème sombre ou clair                    |
| `prefers-reduced-motion`         | Accessibilité visuelle et cognitive      |

---

## 4. Approche Mobile-First

**Mobile-first** signifie :

- D’abord : écrire les styles pour les petits écrans.
- Ensuite : adapter pour les écrans plus larges via des `@media`.

Cela permet une **amélioration progressive** des interfaces, adaptée à tous les supports.

---

## 5. Conséquences sur les écoles de pensée CSS

### SMACSS (Scalable and Modular Architecture for CSS)

SMACSS propose de structurer les feuilles de style en plusieurs catégories :

- `base.css` : styles de base
- `layout.css` : disposition générale
- `module.css` : composants réutilisables
- `state.css` : états interactifs
- `theme.css` : couleurs, préférences utilisateur

**Les media queries y sont réparties intelligemment selon leur rôle.**

---

## 6. Exemple complet avec SMACSS hybride

### Objectif

Créer un composant `.card` qui :

- s’affiche correctement sur mobile,
- s’adapte en grille sur desktop,
- respecte le thème sombre si activé,
- réduit les animations si demandé.

---

### HTML

```html
<article class="card is-animated">
  <h2 class="card-title">Titre accessible</h2>
  <p class="card-content">Ce bloc s’adapte à l’écran, au thème et aux préférences utilisateur.</p>
</article>
```

---

### module.css

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

---

### layout.css

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

---

### state.css

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

---

### theme.css

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

---

## 7. Bilan pédagogique

| Élément                         | Apprentissage associé                                         |
|----------------------------------|---------------------------------------------------------------|
| Media queries                    | Adaptation contextuelle des styles                           |
| Mobile-first                     | Conception accessible et performante                         |
| SMACSS hybride                   | Organisation claire et évolutive                             |
| `prefers-reduced-motion`        | Prise en compte des besoins cognitifs ou visuels spécifiques |
| `prefers-color-scheme`          | Respect de l’environnement utilisateur (ergonomie visuelle)  |

---

## 8. Résumé final

Les media queries sont des **outils puissants** du design CSS, mais leur usage dépend fortement de la **philosophie de structuration du code**. En SMACSS hybride, elles sont **contextualisées et réparties intelligemment** selon leur fonction, ce qui permet :

- une meilleure lisibilité,
- une maintenance plus simple,
- une meilleure accessibilité,
- une adaptation progressive aux usages modernes du web.
