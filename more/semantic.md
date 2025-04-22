# Utilisation sémantique de `<div>` et `<span>`

Les balises `<div>` et `<span>` sont des conteneurs **génériques** dont le rôle est **structural** ou **de style**, et non sémantique. Elles ne portent pas de sens propre ; ce sont des « boîtes » que l’on utilise lorsque **aucune balise sémantique** adaptée n’existe.


## 1. `<div>` : conteneur « block-level »

- **Nature** : élément de type **block**  
- **Usage principal** : regrouper des sections de page pour la mise en forme (CSS) ou le découpage logique quand aucune balise sémantique ne convient.  
- **Quand l’éviter** :  
  - Si votre contenu représente un en-tête, un article, un paragraphe, une navigation, un pied de page, etc., préférez les balises sémantiques correspondantes (`<header>`, `<article>`, `<p>`, `<nav>`, `<footer>`, …).  
  - Pour un simple groupement de listes ou d’éléments de formulaire, employez `<ul>`, `<fieldset>`, `<section>`, `<aside>`, etc.

```html
<!-- ❌ Trop de <div> sans sémantique -->
<div class="header">
  <div class="logo">…</div>
  <div class="menu">…</div>
</div>

<!-- ✅ Balises sémantiques -->
<header>
  <div class="logo">…</div>
  <nav class="menu">…</nav>
</header>
```


## 2. `<span>` : conteneur « inline »

- **Nature** : élément de type **inline**  
- **Usage principal** : cibler une portion de texte ou un petit morceau de document **pour le style** ou **le script**, sans en changer le flux textuel.  
- **Quand l’éviter** :  
  - Si vous marquez un contenu qui a du sens (emphase, forte importance, citation, définition, abréviation…), utilisez plutôt `<em>`, `<strong>`, `<q>`, `<dfn>`, `<abbr>`, etc.  
  - Pour un lien, utilisez `<a>` ; pour un bouton, `<button>` ; pour une étiquette de formulaire, `<label>`, etc.

```html
<!-- ❌ <span> pour tout -->
<p>
  Ce texte est <span class="important">important</span> et doit se détacher.
</p>

<!-- ✅ balise sémantique adaptée -->
<p>
  Ce texte est <strong>important</strong> et doit se détacher.
</p>
```


## 3. Bonnes pratiques générales

1. **Toujours préférer le plus sémantique** possible  
   - Interrogez-vous : « Existe-t-il une balise HTML5 qui décrit déjà ce contenu ? »  
2. **Ne pas imbriquer un block dans un inline**  
   - `<span><div>…</div></span>` est invalide.  
3. **Classes et rôles ARIA**  
   - Quand vous devez absolument ~ utiliser `<div>` ou `<span>`,  
     - Donnez-leur une `class` ou un `id` explicite (`.card`, `#sidebar`, …).  
     - Si nécessaire, ajoutez un rôle ARIA pour renforcer l’accessibilité (`role="navigation"`, `role="region"`, …).  

```html
<!-- Exemple de sidebar avec rôle ARIA -->
<div id="sidebar" role="complementary">
  <h2>Liens utiles</h2>
  <ul>…</ul>
</div>
```

4. **Clarté du code**  
   - Vos noms de classes doivent refléter le rôle ou le contenu (`.author-bio`, `.promo-banner`).  
   - Limitez l’usage des `<div>` et `<span>` « juste parce que » : chaque balise doit avoir une raison d’être.


## 4. Récapitulatif

| Balise   | Type        | Rôle sémantique             | Alternative sémantique           |
| -------- | ----------- | --------------------------- | --------------------------------- |
| `<div>`  | Block-level | Conteneur générique         | `<section>`, `<article>`, `<nav>`, `<aside>`, `<header>`, `<footer>`, `<p>`, … |
| `<span>` | Inline      | Conteneur générique en ligne| `<strong>`, `<em>`, `<a>`, `<label>`, `<abbr>`, `<q>`, … |

> **Principe clé** : n’utilisez `<div>` et `<span>` **que** lorsqu’aucune balise plus spécifique ou sémantique ne répond à votre besoin.  
> Cela rend votre HTML plus **lisible**, **accessible** et **maintenable**.

---

### Ressources complémentaires

- [MDN – The `<div>` HTML element](https://developer.mozilla.org/fr/docs/Web/HTML/Element/div)  
- [MDN – The `<span>` HTML element](https://developer.mozilla.org/fr/docs/Web/HTML/Element/span)  
- [HTML5 Doctor – Semantic Elements](http://html5doctor.com/element-index/)  
```