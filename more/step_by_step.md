# Planning de développement — Projet Web MVC
Durée totale : **80h**  
Organisation : **20 jours de 4h**

Ce planning présente une progression logique de travail pour réaliser un projet web complet en partant d’abord de ce que vous connaissez déjà : **l’analyse, le front-end et l’intégration HTML/CSS**, puis en utilisant **PHP pour rendre les templates dynamiques**, avant de terminer par **l’administration des contenus** et la **finalisation du projet**.

Le travail d’analyse de base de données, de conception et de modélisation SQL ayant déjà été réalisé dans le cours de base de données, il **n’est pas à recommencer ici**. En revanche, le projet devra **réutiliser correctement ce travail** dans l’implémentation.

---

## Vue d’ensemble

| Phase | Intitulé | Durée |
|------|----------|------:|
| 1 | Analyse UX et conception | 8h |
| 2 | Intégration front-end statique | 24h |
| 3 | Enrichissement côté client | 16h |
| 4 | Dynamisation avec PHP | 16h |
| 5 | Administration des contenus | 8h |
| 6 | Finalisation | 8h |
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

# Phase 2 — Intégration front-end statique
Durée : **24h**

Objectif : construire le site **sans dynamique**, en HTML et CSS, pour obtenir une base solide, lisible, responsive et sémantiquement correcte.

| Jour | Tech | Tâche | Heures | Point de contrôle |
|------|------|-------|------:|-------------------|
| 3 à 5 | HTML | Création des pages et des composants communs | 12h | HTML valide, structure sémantique, navigation claire, composants réutilisables |
| 6 à 8 | CSS | Mise en place de la charte graphique et de la feuille de style | 12h | Design cohérent, responsive de base, styles homogènes sur toutes les pages |

## Livrables attendus
- une version statique complète du site
- les pages principales intégrées
- une navigation fonctionnelle
- une feuille de style unique ou bien structurée
- une charte visuelle simple et cohérente

## Points de contrôle globaux
- le site est consultable sans PHP dynamique
- les pages sont correctement structurées en HTML
- le CSS apporte une cohérence visuelle claire
- l’affichage est utilisable sur mobile et desktop
- la validation HTML/CSS a été vérifiée

---

# Phase 3 — Enrichissement côté client
Durée : **16h**

Objectif : ajouter des comportements utiles côté navigateur pour améliorer l’expérience utilisateur, sans complexité inutile.

| Jour | Tech | Tâche | Heures | Point de contrôle |
|------|------|-------|------:|-------------------|
| 9 à 10 | JS | Ajout de comportements interactifs utiles côté visiteur | 8h | Interactions testées, formulaires améliorés, retours utilisateur visibles |
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

# Phase 4 — Dynamisation avec PHP
Durée : **16h**

Objectif : transformer les templates statiques en templates dynamiques, factoriser les éléments communs et relier l’affichage aux données.

| Jour | Tech | Tâche | Heures | Point de contrôle |
|------|------|-------|------:|-------------------|
| 13 à 14 | PHP | Transformation des pages HTML en templates PHP réutilisables | 8h | Includes/partials fonctionnels, répétitions limitées, structure claire |
| 15 à 16 | PHP | Affichage dynamique des données dans les pages principales | 8h | Pages liste/détail dynamiques, intégration correcte des données |

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

# Phase 5 — Administration des contenus
Durée : **8h**

Objectif : permettre la gestion des contenus via une interface d’administration simple mais fonctionnelle.

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

# Phase 6 — Finalisation
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
- Le JavaScript doit améliorer l’expérience, pas masquer un manque de structure.
- PHP arrive ici comme **outil de dynamisation** de ce que vous avez déjà construit, pas comme point de départ abstrait.

---

# Rappel de progression pédagogique

La logique du cours est volontairement la suivante :

**analyse → wireframe → HTML → CSS → JavaScript → PHP dynamique → administration → finalisation**
