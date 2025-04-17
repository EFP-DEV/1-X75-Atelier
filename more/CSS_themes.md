
## 2. Thématisation et effets dynamiques

Un design figé, sans thème ni animation, donne une impression de site statique et impersonnel.  
Pire encore, sans gestion centralisée des couleurs ou transitions, toute modification future devient coûteuse et source d’incohérences visuelles.

Utiliser des variables CSS et des effets contrôlés permet d’améliorer l’expérience utilisateur **sans surprise**, tout en garantissant la maintenabilité du style.

### Variables CSS (Custom Properties)

**Définition** :  
Les variables CSS permettent de définir des valeurs réutilisables, pratiques pour gérer des thèmes ou centraliser une charte graphique.

**Propriétés clés** :

- `--nom: valeur`
- `var(--nom)`
- `:root` pour les variables globales

**Cas d’usage** :

- Thème clair/sombre
- Palette centralisée
- Changement de thème dynamique

**Exemple CSS** :

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

**Astuce** :  
Les variables peuvent être surchargées dans des composants spécifiques pour une meilleure modularité.

---

### Transitions

**Définition** :  
Les transitions permettent d'animer en douceur le changement d'une propriété CSS.

**Propriétés clés** :

- `transition-property`
- `transition-duration`
- `transition-timing-function`
- `transition-delay`

**Cas d’usage** :

- Survol de boutons
- Apparition d’un menu
- Changement de fond

**Exemple CSS** :

```css
.card__button {
  transition: background-color 0.3s ease;
}

.card__button:hover {
  background-color: #007bff;
}
```

**Astuce** :  
Limiter les transitions à des éléments interactifs pour ne pas perturber la navigation.

---

### Animations (`@keyframes`)

**Définition** :  
Les animations permettent de définir des étapes de transition avec `@keyframes`.

**Propriétés clés** :

- `animation-name`
- `animation-duration`
- `animation-delay`
- `animation-iteration-count`

**Cas d’usage** :

- Entrée en fondu
- Chargement
- Animation de notification

**Exemple CSS** :

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

**Astuce** :  
Respecter les préférences d’accessibilité :

```css
@media (prefers-reduced-motion: reduce) {
  * {
    animation: none !important;
    transition: none !important;
  }
}
```

---
