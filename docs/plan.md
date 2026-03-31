# Plan

Ce projet se construit par étapes.

L’objectif n’est pas de produire un site “le plus vite possible”, ni de commencer directement par le code sans cadre clair.
L’objectif est de développer un projet web de manière progressive, logique et structurée, en partant d’abord de l’analyse, puis de la structure, ensuite de la mise en forme, puis de l’architecture dynamique, avant de terminer par les mécanismes d’administration, les accès et la finalisation.

Le travail est donc organisé en **6 phases**.
Chaque phase correspond à un ensemble de tâches cohérentes et à des résultats concrets attendus.
Ces livrables ne sont pas accessoires : ils servent de preuve d’avancement, de support de vérification, et de point d’appui pour la suite du projet.
Le projet devra donc être mené en respectant cette progression :

## Table des matières
1. [Analyse](#phase-1--analyse)
2. [Structure HTML](#phase-2--structure-html)
3. [Habillage CSS](#phase-3--habillage-css)
4. [Architecture PHP](#phase-4--architecture-php) 
5. [Administration et accès](#phase-5--administration-et-accès) 
6. [Finalisation](#phase-6--finalisation)

---

## Phase 1 — Analyse

Cette première phase sert à **définir le projet avant de le fabriquer**.

Vous devez d’abord comprendre ce que vous allez produire, pour qui, dans quel but, et sous quelle forme générale.
Cette étape évite de partir dans plusieurs directions à la fois et permet de prendre des décisions utiles dès le départ.

### Objectifs

* définir clairement le type de site à réaliser
* identifier le thème du projet
* préciser le public cible
* formuler les objectifs du site
* distinguer ce qui relève des objectifs, des fonctionnalités, des pages et des contenus
* observer des sites concurrents ou comparables pour mieux situer le projet
* organiser les premières décisions de structure

### Livrables attendus

* une présentation claire du projet
* une liste des objectifs du site
* une première analyse concurrentielle exploitable
* une arborescence simple ou une liste structurée des pages prévues
* des wireframes des pages principales

[Lien vers l’annexe](analyse.md)

---

## Phase 2 — Structure HTML

Cette phase sert à **construire la base du site en HTML**, sans se concentrer encore sur l’apparence finale.

Vous devez produire des pages bien structurées, logiques, lisibles et sémantiques.
Le HTML constitue la fondation du projet : si cette base est confuse ou incomplète, tout le reste sera plus difficile à construire proprement.

### Objectifs

* créer la structure HTML des pages principales du front
* créer la structure HTML des pages principales de l’administration
* organiser correctement les zones de page
* utiliser un balisage clair, cohérent et sémantique
* préparer des pages exploitables pour le CSS et pour la dynamisation future en PHP

### Livrables attendus

* les pages principales du front en HTML
* les pages principales de l’interface admin en HTML
* une structure cohérente de navigation
* des formulaires présents en HTML lorsque nécessaire
* un ensemble de pages statiques suffisamment complet pour servir de base à la suite
* 
[Lien vers l’annexe](HTML.md)
[Lien vers contenu avance](../more/HTML_antipattern.md)

---

## Phase 3 — Habillage CSS


Cette phase sert à **transformer la structure HTML en interface utilisable et cohérente**.

Le but n’est pas seulement de “faire joli”, mais surtout de rendre l’interface claire, lisible, hiérarchisée, et adaptée à plusieurs tailles d’écran.

### Objectifs

* mettre en place le layout général du site
* organiser les blocs principaux de l’interface
* styliser les composants récurrents
* améliorer la lisibilité et la hiérarchie visuelle
* assurer une cohérence visuelle entre le front et l’administration
* rendre l’interface responsive

### Livrables attendus

* un layout CSS fonctionnel pour le front
* un layout CSS fonctionnel pour l’admin
* des composants stylisés de manière cohérente
* une interface lisible sur différents formats d’écran
* un ensemble front + admin visuellement stable et exploitable

[Lien vers l’annexe 3](CSS.md)


---

## Phase 4 — Architecture PHP


Cette phase sert à **faire passer le projet d’un ensemble de pages statiques à une application structurée**.

Vous devez organiser le projet de manière logique, mettre en place une architecture claire, et permettre au site de répondre correctement aux URL grâce au routeur et aux includes.

### Objectifs

* comprendre et mettre en place la structure générale du projet
* organiser les dossiers et les rôles des différentes parties
* mettre en place une architecture PHP claire
* créer un routeur simple
* gérer les routes et le traitement de l’URL
* charger les bons fichiers selon les pages demandées
* préparer la dynamisation des vues

### Livrables attendus

* une architecture de projet propre et compréhensible
* un point d’entrée principal fonctionnel
* un système simple de routes
* un mécanisme de chargement des pages via PHP
* des pages front connectées à cette architecture

[Lien vers l’annexe 4](./more/annexe-4--architecture-php.md)


---

## Phase 5 — Administration et accès


Cette phase sert à **ajouter la gestion des utilisateurs, des accès, et les premières fonctions réellement utiles côté administration**.

Le projet doit commencer à se comporter comme une application : on se connecte, on contrôle les accès, et on utilise l’administration de manière sécurisée.

### Objectifs

* mettre en place un système de connexion
* gérer les formulaires liés à l’authentification
* utiliser les sessions
* différencier les rôles utilisateur et administrateur
* protéger certaines pages selon le rôle
* rendre l’espace d’administration réellement fonctionnel
* permettre la gestion de contenus ou d’éléments du site

### Livrables attendus

* un système de login fonctionnel
* un système de déconnexion fonctionnel
* une gestion minimale des rôles
* des pages protégées selon les permissions
* une interface d’administration exploitable
* au moins un mécanisme de gestion de données ou de contenus dans l’admin

[Lien vers l’annexe 5](./more/annexe-5--administration-et-acces.md)

---

## Phase 6 — Finalisation


Cette dernière phase sert à **terminer, corriger, consolider et préparer la remise du projet**.

Le but est de transformer un projet “presque fini” en projet cohérent, présentable, et suffisamment robuste.
C’est aussi le moment de vérifier que les différentes parties du travail fonctionnent bien ensemble.

### Objectifs

* ajouter les dernières fonctionnalités utiles, comme la recherche
* vérifier le bon fonctionnement général du site
* corriger les incohérences ou les oublis
* améliorer la validation des données et la gestion des erreurs
* nettoyer le code et la structure du projet
* tester les parcours essentiels
* préparer une version finale claire et démontrable

### Livrables attendus

* un moteur de recherche ou de filtre fonctionnel
* un projet cohérent dans son ensemble
* des formulaires testés et vérifiés
* des accès contrôlés correctement
* un code suffisamment propre pour être relu et présenté
* une version finale prête à être remise ou démontrée

[Lien vers l’annexe 6](./more/annexe-6--finalisation.md)
