# Design Web Progressif

Le **design web progressif** (ou *progressive enhancement*) est une stratégie de développement qui consiste à construire d’abord une page web **simple et fonctionnelle**, puis à y ajouter progressivement des styles et des comportements plus avancés là où le navigateur et l’utilisateur le permettent.



## 🎯 Objectifs pédagogiques

- Comprendre la **philosophie** du design web progressif  
- Apprendre les **3 couches** : contenu, présentation, comportement  
- Découvrir les bonnes **pratiques HTML sémantique** et CSS/JS progressifs  



## 1. Pourquoi utiliser le design web progressif ?

1. **Accessibilité maximale**  
   - Les utilisateurs avec de vieux navigateurs ou des connexions lentes obtiennent toujours un contenu lisible.  
2. **Robustesse**  
   - Votre site “tombe” en douceur si une technologie manque (JavaScript désactivé, CSS non chargé…).  
3. **Maintenance facilitée**  
   - Séparation claire entre structure (HTML), mise en forme (CSS) et comportements (JS).  



## 2. Les 3 couches du design progressif

| Couche         | Technologie | Rôle principal                           |
| -- | -- | - |
| 1. **Contenu** | HTML (sémantique) | Structure et sens du document         |
| 2. **Présentation** | CSS         | Styles, mise en forme, responsive      |
| 3. **Comportement** | JavaScript  | Interactions, animations, enrichissements |



## 3. Étape 1 : Base HTML solide et sémantique

1. **Utiliser les balises sémantiques**  
   - `<header>`, `<nav>`, `<main>`, `<article>`, `<section>`, `<footer>`  
   - Elles décrivent le rôle de chaque bloc et améliorent l’accessibilité.  

2. **Respecter le modèle de boîtes**  
   - **Block-level** (ex. `<article>`, `<p>`, `<section>`, `<ul>`, `<li>`, ..)  
   - **Inline-level** (ex. `<em>`, `<a>`, `<strong>`, `label`, ..)  
   - **Règle clé** : un élément de type **block ne doit pas** être imbriqué *directement* dans un élément inline.  
     ```html
     <!-- ❌ Mauvais exemple -->
     <span>
       <div>Contenu</div>
     </span>
     <!-- ✅ Bon exemple -->
     <div>
       <span>Contenu</span>
     </div>
     ```

3. **Contenu d’abord**  
   - Tout le texte, les images et liens doivent apparaître **avant** tout style ou script.  
   - Permet aux moteurs de recherche et aux lecteurs d’écran de récupérer l’essentiel sans obstacles.



## 4. Étape 2 : Mise en forme CSS progressive

1. **Styles de base**  
   - Démarrer par un reset ou normalize.css pour homogénéiser les navigateurs.  
   - Définir la **typographie**, les **espacements**, et la **couleur de fond**.

2. **Responsive design**  
   - Utiliser les media queries pour adapter la mise en page selon les tailles d’écran.  
     ```css
     /* Styles mobiles d’abord */
     body { font-size: 16px; }
     
     @media (min-width: 768px) {
       body { font-size: 18px; }
     }
     ```

3. **Ajouts conditionnels**  
   - Chargement de modules CSS supplémentaires uniquement si le navigateur les supporte (via `@supports`).  
     ```css
     @supports (display: grid) {
       .container { display: grid; }
     }
     ```



## 5. Étape 3 : Enrichissement JavaScript

1. **Feature detection**  
   - Ne jamais supposer la présence d’une API ; tester avant d’utiliser.  
     ```js
     if ('querySelector' in document) {
       // on peut utiliser document.querySelector()
     }
     ```

2. **Chargement asynchrone**  
   - Placer les `<script>` en bas de page ou utiliser l’attribut `defer` pour ne pas bloquer le rendu.  
     ```html
     <script src="app.js" defer></script>
     ```

3. **Fallbacks**  
   - Si une fonctionnalité JS n’est pas disponible, proposer une alternative ou laisser le site fonctionner en mode basique.



## 6. Bonnes pratiques et pièges à éviter

- **Séparation stricte** : jamais de CSS inline dans vos balises HTML, ni de JavaScript “en dur” (éviter les `onclick=""` par exemple).  
- **Performance** : optimiser les fichiers CSS et JS (minification, compression, lazy loading).  
- **Accessibilité** : aria-attributes, ordre de tabulation, textes alternatifs pour les images.  
- **Validation HTML/CSS** : passer vos pages au validateur W3C régulièrement.
