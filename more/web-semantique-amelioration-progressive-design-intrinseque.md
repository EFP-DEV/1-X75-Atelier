# Web sémantique, amélioration progressive et design intrinsèque

## Introduction

Le développement web moderne ne consiste pas seulement à produire des interfaces visuellement correctes. Il vise aussi à rendre les contenus **compréhensibles**, **accessibles**, **robustes** et **adaptables** à des contextes d’usage très variés.

Trois approches jouent ici un rôle central :

1. **Le web sémantique**, qui cherche à rendre la structure et les données plus compréhensibles pour les machines comme pour les humains.
2. **L’amélioration progressive** (*progressive enhancement*), qui consiste à construire d’abord une base simple, fonctionnelle et accessible, puis à l’enrichir progressivement.
3. **Le design intrinsèque**, qui vise à produire des interfaces naturellement flexibles, capables de s’adapter à leur contexte sans multiplication excessive de versions ou de règles spécifiques.

Ces trois approches ne s’opposent pas. Elles se complètent et participent à une même logique : construire des sites plus durables, plus accessibles et plus fiables.

---

## Objectifs pédagogiques

À la fin de ce chapitre, vous devez être capables de :

- distinguer le **web sémantique**, l’**amélioration progressive** et le **design intrinsèque**
- comprendre le rôle de la **structure HTML sémantique**
- appliquer une logique de développement en **couches**
- concevoir des interfaces qui restent **utilisables**, même en contexte dégradé
- produire des layouts plus **fluides** et plus **adaptables**

---

## 1. Le web sémantique

### 1.1 Définition

Le **web sémantique** désigne l’ensemble des pratiques et standards qui permettent de donner un sens plus explicite aux contenus publiés sur le Web.

Cela passe notamment par :

- un **HTML sémantique** clair (`<header>`, `<nav>`, `<main>`, `<article>`, `<section>`, `<footer>`, etc.)
- des systèmes d’annotation comme **Microdata**, **RDFa** ou **JSON-LD**
- l’utilisation de vocabulaires standardisés, comme **Schema.org**

L’objectif est de permettre à différents agents — moteurs de recherche, outils d’indexation, assistants vocaux, agrégateurs, logiciels d’assistance — d’interpréter plus correctement le contenu.

### 1.2 Enjeux

Le web sémantique apporte plusieurs bénéfices :

- **meilleure compréhension du contenu** par les machines
- **interopérabilité** accrue entre sites, services et outils
- **structuration plus claire** pour le développement et la maintenance
- **meilleure exploitabilité** des données publiées

Il ne faut pas le réduire au seul référencement naturel. Il concerne plus largement la qualité de structuration et d’annotation de l’information.

### 1.3 Principes essentiels

#### a. Structurer clairement le document

Le HTML doit d’abord exprimer le sens du contenu, et non uniquement son apparence.

Exemples :
- `<nav>` pour une zone de navigation
- `<article>` pour un contenu autonome
- `<time>` pour une date ou une heure
- `<address>` pour des coordonnées de contact
- `<main>` pour le contenu principal de la page

#### b. Utiliser des annotations standardisées

Lorsque c’est utile, on peut enrichir le contenu avec des annotations reconnues par d’autres services.

Exemples :
- `itemprop`
- `itemscope`
- `itemtype`
- blocs `script type="application/ld+json"`

#### c. Identifier les entités

Une personne, un lieu, un événement, un produit ou un article peuvent être décrits comme des entités distinctes, avec des propriétés explicites.

#### d. Relier les données

Le web sémantique permet aussi de relier les informations entre elles dans des graphes ou des structures cohérentes.

### 1.4 Exemple

```html
<article itemscope itemtype="https://schema.org/Article">
  <header>
    <h1 itemprop="headline">Titre de l’article</h1>
    <p>
      Par <span itemprop="author">Alice Dupont</span> –
      <time datetime="2025-04-22" itemprop="datePublished">22 avril 2025</time>
    </p>
  </header>

  <div itemprop="articleBody">
    <p>Contenu riche du texte…</p>
  </div>
</article>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Titre de l’article",
  "author": "Alice Dupont",
  "datePublished": "2025-04-22"
}
</script>
````

Dans cet exemple, la structure HTML est déjà sémantique, et l’annotation supplémentaire rend les données plus facilement exploitables par des outils externes.

---

## 2. L’amélioration progressive

### 2.1 Définition

L’**amélioration progressive** (*progressive enhancement*) est une méthode de conception qui consiste à partir d’une base simple, stable et accessible, puis à ajouter des couches d’enrichissement.

On construit donc :

1. le **contenu et la structure** en HTML
2. la **présentation** avec CSS
3. les **comportements avancés** avec JavaScript

Le principe fondamental est le suivant : le site doit rester compréhensible et utilisable même si certaines couches ne sont pas disponibles.

### 2.2 Pourquoi adopter cette approche

Cette méthode permet de garantir :

* une **accessibilité minimale solide**
* une meilleure **robustesse**
* une meilleure **tolérance aux pannes**
* une meilleure **compatibilité**
* une meilleure **maintenabilité**

Un site conçu selon cette logique continue à fonctionner, même si :

* JavaScript est désactivé
* une feuille CSS échoue à charger
* le navigateur ne prend pas en charge certaines fonctionnalités récentes
* le réseau est lent ou instable

### 2.3 Les trois couches

| Couche       | Technologie principale | Rôle                                      |
| ------------ | ---------------------- | ----------------------------------------- |
| Contenu      | HTML                   | structurer et donner du sens              |
| Présentation | CSS                    | mettre en forme et organiser visuellement |
| Comportement | JavaScript             | enrichir l’interaction et la dynamique    |

Cette séparation permet un développement plus clair et plus robuste.

### 2.4 Étape 1 : une base HTML solide

Le point de départ doit être un document HTML exploitable sans dépendre d’un script.

Bonnes pratiques :

* utiliser des balises sémantiques
* écrire un contenu lisible dans l’ordre logique
* prévoir des formulaires et des liens fonctionnels sans JavaScript
* ne pas masquer le contenu essentiel derrière des scripts

Exemple :

```html
<main>
  <article>
    <h1>Actualité</h1>
    <p>Le contenu principal est disponible immédiatement.</p>
    <a href="/archive">Voir les archives</a>
  </article>
</main>
```

### 2.5 Étape 2 : une mise en forme progressive

Le CSS améliore la lisibilité, la hiérarchie visuelle et l’adaptation aux différents écrans.

On peut commencer par des styles simples, puis enrichir selon les capacités du navigateur.

Exemple :

```css
body {
  font-size: 1rem;
  line-height: 1.5;
}

@supports (display: grid) {
  .layout {
    display: grid;
    gap: 1rem;
  }
}
```

### 2.6 Étape 3 : un JavaScript non bloquant

Le JavaScript doit enrichir l’expérience, pas être la condition d’existence de la page.

Bonnes pratiques :

* charger les scripts avec `defer`
* tester la disponibilité des API avant usage
* prévoir des alternatives lorsqu’une interaction avancée n’est pas disponible

Exemple :

```html
<script src="app.js" defer></script>
```

```js
if ('querySelector' in document) {
  const button = document.querySelector('.menu-toggle');
  if (button) {
    button.addEventListener('click', () => {
      document.body.classList.toggle('menu-open');
    });
  }
}
```

### 2.7 Bonnes pratiques générales

* ne pas dépendre entièrement de JavaScript pour afficher le contenu essentiel
* préférer la **détection de fonctionnalité** à la détection de navigateur
* tester régulièrement la page avec JS désactivé
* conserver une séparation claire entre structure, présentation et comportement

---

## 3. Le design intrinsèque

### 3.1 Définition

Le **design intrinsèque** consiste à concevoir des composants et des mises en page qui s’adaptent naturellement à leur espace disponible, à leur contenu et à leur contexte d’affichage.

L’idée n’est pas de supprimer totalement les media queries, mais de **réduire la dépendance à des adaptations rigides** basées uniquement sur quelques tailles d’écran prédéfinies.

On cherche plutôt à produire des interfaces :

* plus **fluides**
* plus **modulaires**
* plus **contextuelles**
* plus **résilientes**

### 3.2 Principes

#### a. Fluidité

On privilégie les unités relatives :

* `%`
* `em`
* `rem`
* `vw`
* `vh`
* `fr`
* `min()`
* `max()`
* `clamp()`

#### b. Modularité

Les composants doivent pouvoir s’adapter selon leur propre espace disponible, et non seulement selon la taille globale de la fenêtre.

#### c. Adaptation contextuelle

On évite autant que possible les règles trop spécifiques et les ajustements manuels en cascade.

#### d. Réorganisation naturelle

Le layout doit pouvoir se réorganiser sans rupture brutale, selon la largeur disponible, la quantité de contenu ou le support utilisé.

### 3.3 Outils CSS souvent associés

Le design intrinsèque s’appuie notamment sur :

* **CSS Grid**
* **Flexbox**
* **Container Queries**
* les fonctions de taille fluides comme `minmax()` ou `clamp()`

### 3.4 Exemple

```css
.cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));
  gap: 1rem;
}
```

Ici, les cartes s’organisent automatiquement selon l’espace disponible, sans qu’il soit nécessaire de définir une série de points de rupture rigides.

### 3.5 Exemple avec Container Query

```css
.card {
  container-type: inline-size;
}

@container (min-width: 20rem) {
  .card {
    display: grid;
    grid-template-columns: 1fr 2fr;
    gap: 1rem;
  }
}
```

Dans cet exemple, le composant s’adapte à la largeur de son propre conteneur, et non à celle de toute la fenêtre.

---

## 4. Articulation des trois approches

Ces trois notions répondent à des questions différentes, mais convergent dans la pratique.

| Approche                 | Question principale                                        | Apport                                                      |
| ------------------------ | ---------------------------------------------------------- | ----------------------------------------------------------- |
| Web sémantique           | comment donner du sens au contenu ?                        | structure claire et données mieux interprétables            |
| Amélioration progressive | comment garantir un accès large et robuste ?               | base fonctionnelle pour tous, enrichie par couches          |
| Design intrinsèque       | comment adapter l’interface à la diversité des contextes ? | composants fluides, layouts flexibles, adaptation naturelle |

En pratique :

* le **web sémantique** améliore la qualité structurelle du HTML
* l’**amélioration progressive** organise le développement de manière robuste
* le **design intrinsèque** améliore l’adaptation visuelle et spatiale

Ensemble, ils permettent de produire des sites plus cohérents, plus durables et plus accessibles.

---

## 5. Bonnes pratiques transversales

* écrire un HTML clair avant toute recherche d’effet visuel
* éviter de confondre structure logique et habillage graphique
* ne pas faire dépendre le contenu principal d’un script
* tester les cas dégradés
* utiliser les fonctionnalités CSS modernes pour assouplir le layout
* valider régulièrement le HTML et le CSS
* garder une attention constante à l’accessibilité

---

## Conclusion

Le web sémantique, l’amélioration progressive et le design intrinsèque ne sont pas trois modes concurrentes, mais trois dimensions complémentaires d’un même objectif : construire un Web plus fiable, plus lisible, plus adaptable et plus accessible.

* Le **web sémantique** renforce le sens et la structure des contenus.
* L’**amélioration progressive** garantit une base solide avant l’enrichissement.
* Le **design intrinsèque** permet une adaptation plus naturelle des interfaces.

Adopter cette triple approche revient à produire des sites :

* plus **accessibles**
* plus **robustes**
* plus **pérennes**
* plus **maintenables**
* plus **adaptés à la diversité réelle du Web**
