# Planning de développement — Projet Web MVC
Durée totale : **80h**  
Organisation : **20 jours de 4h**

Ce planning présente une progression logique de travail pour réaliser un projet web complet en partant d’abord de ce que vous connaissez déjà : **l’analyse, les wireframes et l’intégration HTML**, puis en ajoutant une étape de **structuration visuelle en CSS**, une étape d’**architecture applicative** pour préparer les URL, le router et la structure MVC, avant d’utiliser **PHP pour rendre les templates dynamiques** et de terminer par **l’administration des contenus** et la **finalisation**.

Le travail d’analyse de base de données, de conception et de modélisation SQL ayant déjà été réalisé dans le cours de base de données, il **n’est pas à recommencer ici**. En revanche, le projet devra **réutiliser correctement ce travail** dans l’implémentation.

---

## Vue d’ensemble

| Phase | Intitulé | Durée |
|------|----------|------:|
| 1 | Analyse UX et conception | 8h |
| 2 | Intégration HTML statique | 12h |
| 3 | Structuration visuelle avec CSS | 8h |
| 4 | Architecture applicative | 4h |
| 5 | Enrichissement côté client | 16h |
| 6 | Dynamisation avec PHP | 16h |
| 7 | Administration des contenus | 8h |
| 8 | Finalisation | 8h |
|   | **Total** | **80h** |

---

# Phase 1 — Analyse UX et conception
Durée : **8h**

Objectif : définir clairement le projet, comprendre les besoins, observer des références existantes, puis préparer la structure du site avant l’intégration.

| Jour | Tâche | Heures | Point de contrôle |
|------|-------|------:|-------------------|
| 1 | Définition du type de site, du thème, des objectifs et analyse concurrentielle | 4h | Document de cadrage validé : public cible, objectifs, fonctionnalités principales, références |
| 2 | Création des wireframes pour les pages principales | 4h | Wireframes finalisés pour les pages essentielles du projet |

## Livrables attendus
- un document de cadrage simple
- une liste claire des pages du site
- des wireframes propres et cohérents
- un repository créé et partagé
- un `README.md` initial

## Points de contrôle globaux
- le projet est défini de manière compréhensible
- les besoins du site sont identifiés
- les pages principales sont prévues avant toute intégration
- la structure générale du projet est validée

---

# Phase 2 — Intégration HTML statique
Durée : **12h**

Objectif : construire la structure HTML du projet **sans dynamique et sans dépendre encore du CSS**, en travaillant à la fois sur les **pages publiques** et sur les **pages principales d’administration**.

| Jour | Tech | Tâche | Heures | Point de contrôle |
|------|------|-------|------:|-------------------|
| 3 à 5 | HTML | Création des pages et des composants communs, côté public et côté administration | 12h | HTML valide, structure sémantique, navigation claire, formulaires structurés, composants réutilisables |

## Livrables attendus
- une version statique HTML du site public
- une première base HTML pour l’administration
- les pages principales intégrées
- une navigation fonctionnelle
- des formulaires compréhensibles sans CSS

## Points de contrôle globaux
- le site public est consultable en HTML
- les pages d’administration essentielles existent en HTML
- les pages sont correctement structurées
- la sémantique HTML est cohérente
- la validation HTML a été vérifiée

---

# Phase 3 — Structuration visuelle avec CSS
Durée : **8h**

Objectif : appliquer un premier niveau de mise en forme pour rendre les pages lisibles, cohérentes et exploitables, sans encore viser la finition visuelle complète.

| Jour | Tech | Tâche | Heures | Point de contrôle |
|------|------|-------|------:|-------------------|
| 6 à 7 | CSS | Mise en place de la charte graphique de base, de la feuille de style principale et des composants communs | 8h | Design cohérent, responsive de base, styles homogènes sur les pages publiques et admin |

## Livrables attendus
- une feuille de style structurée
- une identité visuelle de base
- des composants communs stylés
- une meilleure lisibilité des pages publiques et admin

## Points de contrôle globaux
- le CSS rend les pages plus lisibles et cohérentes
- les composants communs ont un rendu homogène
- l’affichage est utilisable sur mobile et desktop
- la structure HTML reste saine après mise en forme

---

# Phase 4 — Architecture applicative
Durée : **4h**

Objectif : définir la logique d’URL du site, préparer la structure de dossiers du projet et poser les bases du futur router et de l’organisation MVC.

| Jour | Tech | Tâche | Heures | Point de contrôle |
|------|------|-------|------:|-------------------|
| 8 | Architecture | Définition des URL, préparation de l’arborescence du projet et mapping pages / routes / contrôleurs / vues | 4h | Tableau des URL validé, structure de dossiers proposée, mapping architectural prêt |

## Livrables attendus
- un tableau des URL du site
- une arborescence de projet claire
- un mapping page → route → contrôleur → vue
- un `README.md` mis à jour avec l’organisation du projet

## Points de contrôle globaux
- les URL principales du projet sont définies
- la distinction front / admin est claire
- la structure MVC ou équivalente est compréhensible
- le projet est prêt à entrer dans la phase PHP sans improvisation majeure

---

# Phase 5 — Enrichissement côté client
Durée : **16h**

Objectif : ajouter des comportements utiles côté navigateur pour améliorer l’expérience utilisateur, sans complexité inutile.

| Jour | Tech | Tâche | Heures | Point de contrôle |
|------|------|-------|------:|-------------------|
| 9 à 10 | JS | Ajout de comportements interactifs utiles côté visiteur et côté administration si pertinent | 8h | Interactions testées, formulaires améliorés, retours utilisateur visibles |
| 11 à 12 | JS | Mise en place du `visitor_token`, d’une collection ou d’une persistance locale | 8h | Données stockées et récupérées correctement, logique fonctionnelle |

## Livrables attendus
- des interactions JavaScript réellement utiles
- une persistance locale fonctionnelle si elle est prévue
- une amélioration visible de l’expérience utilisateur

## Points de contrôle globaux
- le JavaScript sert un usage clair
- les comportements sont testés
- le `LocalStorage` est utilisé proprement si nécessaire
- le site reste compréhensible et utilisable

---

# Phase 6 — Dynamisation avec PHP
Durée : **16h**

Objectif : transformer les pages statiques en templates PHP réutilisables, factoriser les éléments communs et relier progressivement l’affichage aux données.

| Jour | Tech | Tâche | Heures | Point de contrôle |
|------|------|-------|------:|-------------------|
| 13 à 14 | PHP | Transformation des pages HTML en templates PHP réutilisables, includes, partials, layouts | 8h | Includes/partials fonctionnels, répétitions limitées, structure claire |
| 15 à 16 | PHP | Affichage dynamique des données dans les pages principales et intégration dans l’architecture prévue | 8h | Pages liste/détail dynamiques, intégration correcte des données, structure maintenable |

## Livrables attendus
- des templates PHP propres
- une séparation claire entre structure et données
- des pages principales rendues dynamiquement
- une réutilisation correcte des éléments communs

## Points de contrôle globaux
- les répétitions inutiles ont été réduites
- les templates sont dynamiques et maintenables
- les contenus principaux proviennent de la base de données
- le passage du statique au dynamique est maîtrisé

---

# Phase 7 — Administration des contenus
Durée : **8h**

Objectif : rendre l’administration fonctionnelle en PHP et permettre la gestion des contenus via une interface simple mais exploitable.

| Jour | Tâche | Heures | Point de contrôle |
|------|-------|------:|-------------------|
| 17 | Mise en place de l’authentification administrateur | 4h | Connexion/déconnexion fonctionnelles, session active, accès protégé |
| 18 | Mise en place du CRUD principal pour les contenus | 4h | Création, lecture, modification, suppression testées |

## Livrables attendus
- un espace d’administration protégé
- un CRUD principal opérationnel
- des formulaires utilisables
- une gestion correcte des erreurs de base

## Points de contrôle globaux
- les routes/pages d’administration sont protégées
- le CRUD fonctionne réellement
- les opérations sont testées manuellement
- le lien avec le schéma SQL conçu en cours de base de données est correct

---

# Phase 8 — Finalisation
Durée : **8h**

Objectif : préparer une version propre, démontrable et diffusable du projet.

| Jour | Tâche | Heures | Point de contrôle |
|------|-------|------:|-------------------|
| 19 | Tests fonctionnels et préparation des données de démonstration | 4h | Parcours utilisateur validés, base de démo prête |
| 20 | Documentation, nettoyage et préparation de la présentation | 4h | `README.md` finalisé, installation documentée, projet relisible |

## Livrables attendus
- une base de données de démonstration
- un projet installable
- un `README.md` complet
- une version finale propre et présentable

## Points de contrôle globaux
- les principales fonctionnalités ont été testées
- les données de démonstration sont disponibles
- le projet peut être repris et compris
- la présentation finale est prête

---

# Exigences générales du projet

## Repository
Le projet doit être placé dans un repository Git propre et mis à disposition selon les consignes du cours.

## README
Le fichier `README.md` doit au minimum contenir :
- le nom du projet
- le thème choisi
- une courte description
- les technologies utilisées
- les étapes d’installation
- la structure générale du projet
- l’organisation des routes ou de l’architecture si elle est déjà définie
- les identifiants de démonstration si nécessaire

## SQL
Le schéma SQL doit être :
- versionné
- propre
- cohérent avec le travail réalisé en cours de base de données
- exploité correctement dans le projet

## Qualité attendue
Le projet final doit montrer :
- une structure HTML sémantique
- un CSS cohérent et lisible
- un JavaScript utile
- une architecture de projet compréhensible
- une intégration PHP claire
- un CRUD fonctionnel
- une organisation globale compréhensible

---

# Critères de qualité à vérifier

## Front-end
- HTML valide et structuré
- navigation claire
- responsive de base
- contrastes suffisants
- composants réutilisés correctement

## CSS
- cohérence visuelle
- composants homogènes
- lisibilité du contenu
- responsive de base maîtrisé

## Architecture
- URL cohérentes
- séparation claire entre front et admin
- structure de dossiers compréhensible
- mapping pages / routes / vues clair

## JavaScript
- interactions utiles
- logique testée
- feedback utilisateur visible
- persistance locale correcte si utilisée

## PHP
- templates factorisés
- affichage dynamique fonctionnel
- code organisé
- connexion aux données correcte

## Administration
- accès protégé
- CRUD fonctionnel
- formulaires testés
- erreurs de base gérées proprement

## Projet final
- installation documentée
- données de démonstration disponibles
- démonstration possible sans correction de dernière minute
- repository propre
- README à jour

---

# Conseils de méthode

- Commencez toujours par une version simple qui fonctionne.
- Ne cherchez pas à tout faire en même temps.
- Validez chaque étape avant de passer à la suivante.
- Ne dynamisez pas un template mal conçu : corrigez d’abord le HTML.
- Ne stylisez pas une structure confuse : clarifiez-la d’abord.
- Ne construisez pas le backend sans avoir défini les URL et l’organisation du projet.
- Le JavaScript doit améliorer l’expérience, pas masquer un manque de structure.
- PHP arrive ici comme **outil de dynamisation** de ce que vous avez déjà construit, pas comme point de départ abstrait.

---

# Rappel de progression pédagogique

La logique du cours est volontairement la suivante :

**analyse → wireframe → HTML → CSS → architecture → JavaScript → PHP dynamique → administration → finalisation**
