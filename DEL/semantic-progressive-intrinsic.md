# Web sémantique, Progressive Enhancement et Design intrinsèque

---

## Introduction

Le développement web moderne cherche à concilier **accessibilité**, **interopérabilité**, **performance** et **expérience utilisateur**. Trois concepts essentiels guident cette démarche :

1. **Web sémantique** : enrichir les pages d’une structure de données compréhensible par les machines, pour faciliter la découverte et le traitement automatique de l’information.
2. **Progressive Enhancement** : construire d’abord une version fonctionnelle et accessible pour tous, puis y superposer des améliorations pour les navigateurs les plus avancés.
3. **Design intrinsèque** : concevoir des interfaces a priori adaptées à la diversité des environnements (taille d’écran, capacités du navigateur), sans recourir à de multiples versions séparées.

Nous allons explorer chacun de ces volets, illustrer leurs principes et montrer comment ils se complètent pour bâtir des sites robustes, accessibles et pérennes.

---

## 1. Web sémantique

### 1.1 Définition et enjeux  
Le **Web sémantique** vise à donner du sens aux données publiées sur le Web, en utilisant des **standards** tels que :
- **HTML5 sémantique** (balises `<article>`, `<header>`, `<nav>`, etc.),
- **Microformats**, **RDFa**, **Microdata** (pour annoter le contenu),
- **JSON-LD** (pour diffuser des graphes de connaissances).

**Objectifs** :  
- **Interrogation automatisée** : moteurs de recherche, assistants vocaux et agents intelligents peuvent interpréter précisément le contenu.  
- **Interopérabilité** : facilitation de l’échange et de l’agrégation de données entre sites, API et services tiers.  
- **Accessibilité renforcée** : les technologies d’assistance exploitent souvent les mêmes annotations.

### 1.2 Principes clés  
1. **Structure explicite** : employer les balises HTML sémantiques pour hiérarchiser le contenu.  
2. **Annotations standardisées** : ajouter des attributs (ex. `itemscope`, `itemprop`) ou un bloc JSON-LD dans `<head>`.  
3. **URI identifiants** : chaque ressource (personne, lieu, événement) dispose d’un identifiant unique.  
4. **Graphes de données** : relier les entités entre elles (ontologies, vocabularies comme Schema.org).

### 1.3 Exemple pratique  
```html
<article itemscope itemtype="https://schema.org/Article">
  <header>
    <h1 itemprop="headline">Titre de l’article</h1>
    <p>Par <span itemprop="author">Alice Dupont</span> – <time datetime="2025-04-22" itemprop="datePublished">22 avril 2025</time></p>
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
```
Ici, Google, Bing ou un assistant vocal peuvent facilement extraire titre, auteur et date de publication.

---

## 2. Progressive Enhancement

### 2.1 Concept  
Le **Progressive Enhancement** (amélioration progressive) prône une **approche par couches** :
1. **Contenu et structure** : HTML basique, accessible et sémantique.  
2. **Styles et layout** : CSS pour la mise en forme, garantissant une présentation dégradée acceptable si les CSS ne sont pas chargés.  
3. **Comportement avancé** : JavaScript pour interactions, animations ou appels dynamiques, activés uniquement si le navigateur les supporte.

### 2.2 Avantages  
- **Accessibilité garantie** (sans JS, le contenu reste lisible et navigable).  
- **Meilleure performance** (chargement prioritaire du HTML, CSS minimal).  
- **Robustesse** face aux interruptions réseaux ou navigateurs désuets.  
- **SEO optimisé** (les bots indexent le contenu HTML statique).

### 2.3 Mise en œuvre  
1. **Réserver JavaScript** : charger le script en fin de page (`defer`) ou conditionnellement.  
2. **Feature Detection** : utiliser `@supports` en CSS ou `if ('querySelector' in document)` en JS plutôt que de détecter le navigateur.  
3. **Comportements alternatifs** : prévoir des formulaires et des liens fonctionnels sans AJAX.  
4. **Tests réguliers** : désactiver JS pour vérifier l’intégrité fonctionnelle.

---

## 3. Design intrinsèque

### 3.1 Définition  
Le **Design intrinsèque** consiste à concevoir d’emblée des composants et des mises en page **fluides**, qui s’adaptent naturellement à tout environnement :
- **Sans avoir à maintenir plusieurs « breakpoints »** pour chaque taille d’écran.  
- **Sans recourir exclusivement** aux media queries – on tire parti des **unités relatives** (%, `vw`, `vh`, `rem`) et des **nouvelles fonctionnalités CSS** (Container Queries, CSS Grid auto-fit).

### 3.2 Principes  
1. **Fluidité** : largeur et hauteur en unités relatives.  
2. **Modularité** : composants isolés, calculant leur taille en fonction de leur conteneur (Container Queries).  
3. **Adaptativité naturelle** : éviter les « hacks » trop spécifiques, préférer des règles génériques.  
4. **Progression du layout** : laisser le contenu se réorganiser sans contraintes arbitraires.

### 3.3 Exemple de Container Query  
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
Le composant `.card` bascule automatiquement en grille quand sa largeur atteint 20 rem, quel que soit son contexte d’insertion.

---

## 4. Articulation des trois approches

| Concept              | Rôle                                      | Complémentarité                              |
|----------------------|-------------------------------------------|-----------------------------------------------|
| Web sémantique       | Structure riche, compréhensible par les machines | Fournit la base HTML accessible exploitable par tous |
| Progressive Enhancement | Assure l’accès universel et ajoute des couches de richesse | Utilise le HTML sémantique avant tout, puis ajoute styles et scripts |
| Design intrinsèque   | Mise en page fluide et adaptative         | S’appuie sur des structures sémantiques et des feuilles de style progressives |

En combinant ces méthodes, on obtient une interface **solide** (web sémantique), **accessible** (progressive enhancement) et **naturellement adaptable** (design intrinsèque).

---

## Conclusion

- **Web sémantique** : rédigez une structure HTML claire, documentée et annotée pour machines et humains.  
- **Progressive Enhancement** : commencez par l’essentiel (HTML), puis ajoutez CSS et JS en toute sécurité.  
- **Design intrinsèque** : adoptez des layouts fluides, modulaires et auto‑adaptatifs.

Cette triple approche garantit des sites plus **accessibles**, **pérennes**, **performants** et **responsifs**, tout en simplifiant la maintenance et en améliorant l’expérience utilisateur sur toute la diversité de terminaux et de contextes d’usage.
