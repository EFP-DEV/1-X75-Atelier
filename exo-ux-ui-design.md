# Exercice Pratique : Conception UX/UI d'un Site Web

Cet exercice vous guide pas à pas dans la démarche de conception UX/UI d'un site web. Vous allez appliquer une méthodologie professionnelle pour concevoir une interface centrée sur l'utilisateur, avant d'écrire une seule ligne de code.

---

## Mini-glossaire UX/UI
- **UX (User Experience)** : L'expérience globale de l'utilisateur avec un produit
- **UI (User Interface)** : L'interface visuelle avec laquelle l'utilisateur interagit
- **Wireframe** : Maquette simplifiée représentant la structure d'une page
- **Persona** : Profil fictif représentant un groupe d'utilisateurs
- **Sitemap** : Représentation visuelle de l'organisation des pages d'un site

---

## 1. Comprendre le Projet (40 min)

**Objectif** : Poser les bases du projet avant toute maquette.

### 1.1 Quel est le but principal du site ?

- Informer, vendre, divertir, représenter une entreprise ou une personne ?
- Que doit faire l'utilisateur idéalement en visitant le site ? (cliquer, s'inscrire, acheter, lire…)
- Le site est-il conçu pour durer ou pour une période limitée ?

### 1.2 Qui sont les utilisateurs ?

- À qui s'adresse ce site ?
- Âge, profession, habitudes numériques
- Contexte d'utilisation : usage pro, personnel, mobile, rapide ou approfondi ?
- Niveau de confort avec le web (débutants, intermédiaires, experts)
- Contraintes particulières (accessibilité, charge mentale, langue…)

### 1.3 Créez des personas

Créez 3 fiches de personas : donnez-leur un prénom, un âge, un objectif principal sur le site, et une petite histoire (2-3 lignes) qui résume leur situation.

**Exemple de persona** :
```
Nom : Marie L.
Âge : 34 ans
Profession : Enseignante
Objectif sur le site : Trouver rapidement des ressources pédagogiques
Situation : Marie a peu de temps libre et consulte principalement sur son smartphone 
pendant ses pauses. Elle recherche des contenus fiables qu'elle peut sauvegarder 
pour usage ultérieur.
```

### 1.4 Quelle est l'identité du projet ?

- Quelles sont les valeurs ou émotions que le site doit transmettre ?
- Doit-il inspirer confiance, dynamisme, proximité, expertise ?
- Avez-vous une charte visuelle (ou une envie particulière) à respecter ?

**Exemples d'identité de projet** :

```
Exemple 1 - Site de recettes étudiantes :
Valeurs : Accessibilité, simplicité, économie, convivialité
Émotions à transmettre : Enthousiasme, sentiment d'accomplissement, confiance
Ambiance visuelle : Colorée mais pas enfantine, photos de plats réalistes (pas intimidantes),
instructions visuelles, interface intuitive et décontractée
```

```
Exemple 2 - Portfolio de photographe :
Valeurs : Créativité, professionnalisme, originalité, attention aux détails
Émotions à transmettre : Admiration, curiosité, surprise
Ambiance visuelle : Minimaliste pour mettre en valeur les photos, fort contraste,
typographie élégante, navigation fluide entre les projets
```

```
Exemple 3 - Site de clinique médicale :
Valeurs : Expertise, bienveillance, accessibilité, modernité
Émotions à transmettre : Confiance, réassurance, calme
Ambiance visuelle : Couleurs apaisantes, interface simple et claire, photos authentiques
du personnel, navigation sans effort vers les informations importantes
```

### Exercice :

Rédigez une description courte du projet (5 à 10 lignes).
Créez 3 personas avec nom, âge, objectif sur le site, et situation.

**Livrables** :
- Un texte décrivant le projet
- Trois fiches personas (utilisez le template fourni)

**Exemple de projet** : Si vous manquez d'idées, vous pouvez travailler sur un site de recettes de cuisine pour étudiants avec petit budget.

**PAUSE** : 5 minutes

---

## 2. Analyse Concurrentielle (35 min)

**Objectif** : Observer ce que font les autres pour en tirer des leçons utiles.

### Méthode :

1. Recherchez 2 à 3 sites ayant le même objectif que le vôtre.
2. Pour chacun, analysez :
   - Ce qui fonctionne bien (navigation, design, contenus, ergonomie…)
   - Ce qui vous gêne ou semble moins efficace (confusion, lenteur, esthétique dépassée…)

### Critères d'analyse suggérés :
- **Navigation** : Est-elle intuitive et logique ?
- **Lisibilité** : Les textes sont-ils faciles à lire ?
- **Accessibilité** : Le site est-il utilisable par tous ?
- **Responsive** : S'adapte-t-il bien aux différents appareils ?

### Analyse technique (obligatoire) :
Pour chaque site concurrent, mesurez et notez :
- **Temps de chargement** : Page d'accueil et page de détail, avec et sans cache (utilisez l'onglet Network dans les outils de développement du navigateur)
- **Poids des pages** : Taille totale en Mo des pages analysées
- **Nombre de requêtes** : Combien de requêtes sont effectuées au chargement
- **Stack technologique** : Identifiez les technologies utilisées (via whatcms.org ou similaire)
- **Scores de performance** : Résultats Lighthouse ou PageSpeed Insights (pour Mobile et Desktop)

### Exercice :

Pour chaque site concurrent, réalisez deux types d'analyses présentées dans des tableaux séparés :

#### 1. Analyse qualitative

**Exemple de tableau d'analyse qualitative** :

| Site | Navigation (1-5) | Lisibilité (1-5) | Accessibilité (1-5) | Responsive (1-5) | Points forts | Points faibles |
|------|------------------|------------------|---------------------|------------------|--------------|----------------|
| Site A | 4 | 3 | 4 | 5 | Menu intuitif, images de qualité | Trop de publicités, texte trop petit |
| Site B | 2 | 5 | 3 | 2 | Belles photos, contenu clair | Navigation confuse, mauvaise adaptation mobile |

#### 2. Analyse quantitative

**Exemple de tableau d'analyse quantitative** :

| Site | Temps chargement Home (sans cache) | Temps chargement Home (avec cache) | Temps chargement Page détail (sans cache) | Temps chargement Page détail (avec cache) | Poids Home | Poids Page détail | Nb requêtes Home | Nb requêtes détail | Stack technique | Lighthouse Perf. Mobile | Lighthouse Access. Mobile | Lighthouse Perf. Desktop | Lighthouse Access. Desktop |
|------|------------------|------------------|------------------|-----------------|--------------|--------------|------------------|------------------|----------------|----------------|----------------|----------------|----------------|
| Site A | 2.3s | 0.8s | 1.9s | 0.6s | 1.2 Mo | 0.9 Mo | 45 | 38 | WordPress, jQuery | 68 | 92 | 85 | 95 |
| Site B | 3.7s | 1.1s | 4.2s | 1.3s | 3.5 Mo | 2.8 Mo | 87 | 76 | Angular, Bootstrap | 45 | 88 | 62 | 90 |

*Note* : Vous pouvez créer ces tableaux dans un document externe si nécessaire. L'important est d'inclure toutes ces métriques dans votre analyse.

**Livrables** :
- Deux tableaux d'analyse (qualitatif et quantitatif) pour chaque site concurrent
- Un court paragraphe de conclusion sur les enseignements tirés de cette analyse

**PAUSE** : 5 minutes

---

## 3. Architecture de l'Information (40 min)

**Objectif** : Organiser le contenu de manière claire et intuitive.

### Étapes :

1. Dressez la liste des pages principales (Accueil, À propos, Produits, Contact…).
2. Réfléchissez à la hiérarchie logique : quelles pages sont les plus importantes ?
3. Déterminez comment les pages sont reliées entre elles.
4. Visualisez cette structure sous forme de sitemap (schéma hiérarchique).

### Exercice :

Dessinez un sitemap simple (sur papier ou outil comme Whimsical, Figma ou draw.io).

**Exemple de sitemap simple** :
```
               Page d'accueil
                    |
    +-----------+---+---+-----------+
    |           |       |           |
 À propos    Catalogue  Blog     Contact
               |
         +-----+-----+
         |     |     |
    Catégorie1 |  Catégorie3
           Catégorie2
```

**Livrable** :
- Un schéma clair des pages du site et de leur organisation.

**PAUSE** : 10 minutes

---

## 4. Wireframing (50 min)

**Objectif** : Créer une maquette basse fidélité pour visualiser la structure du site sans se préoccuper du design.

### Principes de base :
- **Hiérarchie visuelle** : Les éléments les plus importants doivent être plus visibles
- **Grille** : Alignez vos éléments sur une grille invisible
- **Espacement** : Utilisez l'espace blanc pour aérer votre design
- **Cohérence** : Gardez une structure similaire entre les pages

### Éléments à inclure dans vos wireframes :
- En-tête avec logo et navigation
- Zone de contenu principal
- Éléments secondaires (sidebar, etc.)
- Pied de page avec liens importants
- Formulaires (si applicable)
- Appels à l'action

### Conseils :

- Commencez par l'accueil et une autre page importante (produit, article, formulaire…).
- Structurez en zones : en-tête, navigation, contenu, pied de page.
- Utilisez des rectangles, des zones de texte fictives, des boutons vides.

### Exercice :

Réalisez 2 wireframes (page d'accueil + 1 autre page clé) en version desktop ET mobile.
Pour chaque page, vous devez donc produire une version ordinateur et une version smartphone.

Outils recommandés :
- Papier et crayon (le plus simple)
- Figma (gratuit, https://www.figma.com)
- Balsamiq (essai gratuit)
- Whimsical (https://whimsical.com)

**Livrable** :
- Quatre wireframes annotés ou expliqués (2 pages en version desktop + les mêmes 2 pages en version mobile)

**PAUSE** : 10 minutes

---

## 5. Prototype UI (50 min)

**Objectif** : Donner une première vie visuelle à votre interface.

### Principes fondamentaux du design :
- **Contraste** : Assurer la lisibilité entre texte et fond
- **Répétition** : Réutiliser les mêmes éléments pour créer une cohérence
- **Alignement** : Aligner les éléments entre eux
- **Proximité** : Regrouper les éléments liés

### Accessibilité de base :
- Contraste texte/fond suffisant (vérifiez avec WCAG Color Contrast Checker)
- Taille de police minimum de 16px pour le texte courant
- Boutons et zones cliquables suffisamment grands (minimum 44x44px)

### Étapes :

1. Choisissez une palette de couleurs cohérente (2-3 couleurs maximum pour commencer)
   - Outil : Coolors (https://coolors.co)
   - Adobe Color (https://color.adobe.com)

2. Sélectionnez une typographie lisible (1-2 polices maximum)
   - Google Fonts (https://fonts.google.com)
   - Recommandations : Roboto, Open Sans, Lato, Montserrat pour le texte

3. Ajoutez des éléments graphiques simples
   - Icônes : Font Awesome, Material Icons
   - Images : Unsplash, Pexels (images libres de droits)

### Exercice :

Transformez l'un de vos wireframes en une maquette visuelle (versions desktop ET mobile).
Justifiez brièvement vos choix graphiques : couleurs, tailles, alignements, etc.

**Livrable** :
- Deux maquettes visuelles (version desktop + version mobile)
- Une courte note expliquant vos choix de design

**PAUSE** : 10 minutes

---

## 6. Test et Feedback (30 min)

**Objectif** : Valider rapidement votre concept auprès d'utilisateurs potentiels.

### Mini test utilisateur :

1. Montrez votre prototype à une personne et posez-lui les questions suivantes :
   - Que pensez-vous que ce site propose ?
   - Où cliqueriez-vous pour [action principale] ?
   - Qu'est-ce qui vous plaît dans cette interface ?
   - Qu'est-ce qui vous semble confus ou difficile ?

2. Notez ses remarques sans les interpréter.

3. Apportez des ajustements rapides si besoin (placement, contraste, lisibilité…).

**Livrable** :
- Une liste de 3-5 points de feedback reçus et les modifications envisagées

---

## Pièges à éviter

- **Surcharge d'information** : Ne mettez pas trop d'éléments sur une même page
- **Incohérence** : Gardez le même style visuel sur toutes les pages
- **Manque de hiérarchie** : Tout ne peut pas avoir la même importance visuelle
- **Navigation complexe** : L'utilisateur doit toujours savoir où il se trouve
- **Faible contraste** : Le texte doit toujours être lisible sur son fond

---

## Rendu final attendu

Rassemblez vos livrables dans un document unique (PDF ou présentation) :

1. Description du projet + personas
2. Analyse concurrentielle
3. Sitemap
4. Wireframes
5. Prototype UI
6. Feedback et ajustements proposés

**Format** : Préparez une présentation de 5 minutes pour expliquer votre démarche, comme vous le feriez face à un client.

---

## Critères de réussite

### Analyse et conception
- Clarté et logique de la navigation
- Pertinence des choix graphiques
- Adaptation aux utilisateurs cibles
- Qualité de la réflexion globale

### Évaluation technique
- **Analyse concurrentielle complète** incluant les métriques techniques
- **Anticipation des performances** : Justification des choix de design en fonction de leur impact sur les performances
- **Considération pour la taille des assets** : Images optimisées, nombre de polices limité
- **Prévision des scores Lighthouse** : Estimation des scores que votre design pourrait obtenir une fois développé (Performance, Accessibilité, Bonnes pratiques, SEO)

### Communication
- Capacité à expliquer vos choix
- Clarté des livrables
- Prise en compte des retours utilisateurs

---

## Checklist finale

### Conception
☐ J'ai défini clairement le but du site  
☐ J'ai créé 3 personas détaillés  
☐ Mon sitemap montre clairement la structure du site  
☐ Mes wireframes incluent tous les éléments essentiels (desktop + mobile)  
☐ Ma maquette UI respecte les principes fondamentaux du design  

### Analyse technique
☐ J'ai analysé les temps de chargement des sites concurrents (avec/sans cache)  
☐ J'ai mesuré le poids des pages et le nombre de requêtes  
☐ J'ai identifié les technologies utilisées par la concurrence  
☐ J'ai relevé les scores Lighthouse/PageSpeed des concurrents  
☐ J'ai prévu comment optimiser les performances de mon design  

### Feedback et itération
☐ J'ai obtenu et intégré des retours d'utilisateurs  
☐ J'ai documenté les modifications apportées suite aux retours  
☐ Je peux expliquer et justifier tous mes choix de conception  

---

## Mode de travail

**Cet exercice est individuel, mais la collaboration est encouragée.**

Chaque apprenant doit produire son propre travail et ses propres livrables, mais vous êtes encouragés à :
- Échanger des idées et feedback avec vos collègues
- Participer aux tests utilisateurs des uns et des autres
- Partager des ressources et astuces utiles
- Discuter des difficultés rencontrées et solutions trouvées

Cette approche reflète la réalité professionnelle où la conception UX/UI est souvent un effort individuel qui bénéficie grandement de la collaboration et du regard extérieur.

**Pour les débutants complets** : Vous pouvez former des groupes d'entraide de 2-3 personnes pour vous soutenir mutuellement, tout en produisant chacun votre propre travail.

---

## Ressources utiles

### Outils
- **Wireframing** : Figma, Adobe XD, Sketch, Balsamiq, Whimsical
- **Couleurs** : Coolors, Adobe Color, Color Hunt
- **Typographie** : Google Fonts, Typewolf, FontPair
- **Icônes** : Font Awesome, Material Icons, Feather Icons
- **Images** : Unsplash, Pexels, Pixabay

### Références rapides
- Guide des contrastes WCAG : https://contrastchecker.com
- Système de grille simple : https://grid.layoutit.com
- Banque de patterns UI : https://ui-patterns.com

---

## Objectif pédagogique :

Découvrir comment une bonne interface naît d'une compréhension fine des utilisateurs, et comment cela structure tout le design avant d'écrire du code.

**Prochaine étape** : Intégration HTML/CSS à partir de vos maquettes !
