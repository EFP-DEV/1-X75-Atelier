# Note sur les techniques d’images adaptatives

---

## 1. Objectifs et enjeux  
- **Performance** : réduire le poids des images pour améliorer les temps de chargement, notamment sur mobile.  
- **Qualité visuelle** : fournir une résolution et un recadrage adaptés à l’appareil et au contexte d’affichage.  
- **Accessibilité et UX** : éviter les décalages de mise en page (Cumulative Layout Shift) et garantir une expérience fluide.  
- **Économie de bande passante** : ne transmettre que la version nécessaire à l’utilisateur.

---

## 2. Techniques côté client

### 2.1 `<img>` avec `srcset` et `sizes`  
Permet de spécifier plusieurs sources pour une même image et de laisser le navigateur choisir la plus adaptée :  
```html
<img
  src="image-800.jpg"
  srcset="
    image-400.jpg 400w,
    image-800.jpg 800w,
    image-1200.jpg 1200w"
  sizes="(max-width: 600px) 100vw, 50vw"
  alt="Exemple d’image adaptive">
```
- **`srcset`** : liste de fichiers avec leur largeur intrinsèque (`400w`, `800w`, …).  
- **`sizes`** : largeur d’affichage attendue selon les media queries (`100vw` si écran ≤600 px, sinon `50vw`).  

### 2.2 `<picture>` pour l’**art direction**  
Quand on veut non seulement redimensionner, mais aussi recadrer ou remplacer l’image selon la taille ou la densité d’écran :  
```html
<picture>
  <source
    media="(min-width: 800px)"
    srcset="large-recadrage.jpg">
  <source
    media="(max-width: 799px)"
    srcset="small-recadrage.jpg">
  <img src="fallback.jpg" alt="Photo recadrée">
</picture>
```
Le `<picture>` permet d’alterner en amont le visuel ou le format (WebP vs JPEG) pour chaque condition.

### 2.3 Lazy‑loading natif et polyfills  
- **Attribut `loading="lazy"`** sur `<img>` ou `<iframe>` :  
  ```html
  <img src="photo.jpg" loading="lazy" alt="...">
  ```  
- Sans support natif, on peut utiliser un **polyfill** ou l’**IntersectionObserver** en JS pour charger les images au seuil choisi.

---

## 3. Techniques côté serveur et CDN  

### 3.1 Redimensionnement à la volée  
Les CDN ou services spécialisés (imgix, Cloudinary, Akamai) génèrent dynamiquement la taille et le format désirés :  
```
https://cdn.exemple.com/photo.jpg?width=800&format=webp
```
- **Avantages** : pas de multitude de fichiers à stocker, contrôle granulaire des transformations.  
- **Inconvénients** : dépendance à un service externe et coût éventuel.

### 3.2 Client Hints (Indications client)  
Le navigateur envoie des entêtes HTTP (`Viewport-Width`, `DPR`) ; le serveur adapte la réponse :  
```http
Accept-CH: DPR, Viewport-Width
```
Permet d’optimiser sans inclure `srcset` dans le HTML, mais reste peu répandu.

---

## 4. Formats modernes et optimisations  

- **WebP, AVIF, JPEG XL** : meilleurs taux de compression.  
- **Compression adaptative** : ajuster la qualité (`quality=75`) selon l’usage (vignette vs image pleine page).  
- **Blur‑up / LQIP (Low‑Quality Image Placeholder)** : afficher un placeholder flou pendant le chargement de la version finale.  
- **SVG** pour les illustrations vectorielles et icônes, afin de conserver une netteté parfaite quel que soit l’écran.

---

## 5. Meilleures pratiques  

1. **Définir un système cohérent** de breakpoints pour `srcset` correspondant à votre grille CSS.  
2. **Tester sur de vrais réseaux** (3G, 4G faible) et appareils pour valider les gains.  
3. **Prioriser les images above-the-fold** en inlining ou preload (`<link rel="preload" as="image" href="hero.jpg">`).  
4. **Surveiller le CLS** (Cumulative Layout Shift) en réservant les dimensions des images (`width` & `height` ou via CSS).  
5. **Automatiser** l’export des différentes tailles et formats avec des outils de build (Webpack, Gulp, ou scripts Node).

---

## 6. Conclusion  

Les images adaptatives sont une brique essentielle du **web performant et responsive**. En combinant :

- le **`srcset`/`sizes`** et le **`<picture>`** pour le client,  
- les **CDN** et **Client Hints** pour le serveur,  
- les **formats modernes** et les **placeholders** pour l’expérience,

on obtient un rendu optimisé, rapide et esthétiquement cohérent sur l’ensemble des devices.
