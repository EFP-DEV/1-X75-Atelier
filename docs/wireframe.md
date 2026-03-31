# Demandés pratiques — Wireframes du projet

Ce document précise les wireframes à produire pour ce projet.

Ici, l’objectif n’est pas de faire une maquette graphique détaillée.
L’objectif est de représenter clairement la structure des pages, les zones principales, les actions importantes et l’adaptation des écrans publics aux différents formats.

Les wireframes doivent rester simples, lisibles et exploitables pour la suite du travail.

---

## 1. Ce qu’on attend dans ce projet

Les wireframes doivent permettre de préparer correctement :

* la structure des pages
* la navigation
* les contenus à prévoir
* les futures intégrations HTML, CSS et PHP
* l’adaptation responsive des pages publiques

On attend des wireframes qui montrent clairement :

* les grandes zones de chaque page
* l’ordre des informations
* les actions principales disponibles
* les relations entre les écrans publics et les écrans d’administration
* l’évolution des pages publiques selon les breakpoints

---

## 2. Règle générale pour les wireframes publics

Tous les wireframes publics doivent être réalisés pour **trois breakpoints obligatoires** :

* **Mobile S**
* **Tablet S**
* **Desktop**

Il faut donc produire trois versions distinctes pour chaque page publique concernée.

Ces versions ne doivent pas être de simples copies redimensionnées.
Elles doivent montrer une vraie évolution de la structure si nécessaire.

---

## 3. Pages publiques à wireframer

Les pages publiques à produire sont :

1. la page d’accueil
2. la page catalogue
3. la page détail d’un item

Cela représente :

* 3 wireframes pour la page d’accueil
* 3 wireframes pour la page catalogue
* 3 wireframes pour la page détail d’un item

Total partie publique : **9 wireframes**

---

## 4. Partie administration à wireframer

Les wireframes d’administration peuvent être pensés en priorité pour un usage bureau.

Les pages à produire sont :

4. la page d’accueil du tableau de bord admin
5. un écran de listing générique
6. le listing des items
7. le listing des collections
8. le formulaire d’un item

Total partie administration : **5 wireframes**

---

## 5. Wireframe 1 — Page d’accueil du site public

### Objectif

Présenter le site, orienter l’utilisateur et mettre en avant les contenus importants.

### Ce que le wireframe doit montrer

* un header
* une navigation principale
* une zone d’introduction ou de présentation
* une ou plusieurs zones de mise en avant
* un accès vers des items ou des collections
* un footer

### Questions à se poser

* Que doit comprendre l’utilisateur immédiatement en arrivant ?
* Quelle est l’action principale attendue ?
* Quels contenus doivent être visibles dès le premier écran ?
* Faut-il mettre en avant des items récents, populaires ou recommandés ?

### Déclinaisons obligatoires

* 1 wireframe **Mobile S**
* 1 wireframe **Tablet S**
* 1 wireframe **Desktop**

---

## 6. Wireframe 2 — Page catalogue

### Objectif

Permettre à l’utilisateur de parcourir, rechercher et filtrer les items disponibles.

### Ce que le wireframe doit montrer

* le titre de la page
* une zone de recherche
* une zone de filtres
* éventuellement une zone de tri
* une liste d’items sous forme de cartes
* éventuellement une pagination ou un bouton de chargement
* un accès clair vers la page détail d’un item

### Focus obligatoire

Cette page doit être traitée avec un focus particulier sur :

* **les cartes**
* **les filtres**
* **le moteur de recherche**

Le wireframe doit donc montrer clairement :

* la structure d’une carte
* les informations visibles dans chaque carte
* l’emplacement du moteur de recherche
* l’emplacement et la forme des filtres
* leur évolution selon les breakpoints

### Questions à se poser

* Quels critères de filtre sont utiles pour ce projet ?
* Le moteur de recherche est-il prioritaire par rapport aux filtres ?
* Quels éléments doivent apparaître dans chaque carte ?
* Quelle information permet de distinguer rapidement un item d’un autre ?
* Comment conserver une lecture claire sur petit écran ?

### Contraintes responsive spécifiques au catalogue

Le catalogue doit être pensé comme une grille responsive évolutive.

On attend explicitement que :

* en **Mobile S**, le catalogue affiche le plus souvent **1 colonne**
* en **Tablet S**, le catalogue puisse passer à **2 colonnes**
* en **Desktop**, le catalogue affiche **davantage de colonnes** selon la largeur disponible

Autrement dit, le catalogue responsive doit montrer que la mise en page **revient à afficher de plus en plus de colonnes** à mesure que l’espace horizontal augmente.

Cette progression doit rester compatible avec :

* la lisibilité des cartes
* l’accessibilité des actions
* la visibilité du moteur de recherche
* la compréhension immédiate des filtres actifs

### Déclinaisons obligatoires

* 1 wireframe **Mobile S**
* 1 wireframe **Tablet S**
* 1 wireframe **Desktop**

---

## 7. Wireframe 3 — Page détail d’un item

### Objectif

Afficher un contenu complet de manière lisible et structurée.

### Ce que le wireframe doit montrer

* le titre de l’item
* le contenu principal
* les éventuels médias associés
* les métadonnées utiles
* les liens ou actions secondaires
* la navigation de retour ou de continuation

### Questions à se poser

* Quelles informations sont indispensables pour comprendre l’item ?
* Quelle place donner au contenu principal par rapport aux informations secondaires ?
* Quels liens de navigation doivent aider l’utilisateur à continuer sa visite ?
* Que doit-on pouvoir faire depuis cette page ?

### Déclinaisons obligatoires

* 1 wireframe **Mobile S**
* 1 wireframe **Tablet S**
* 1 wireframe **Desktop**

---

## 8. Wireframe 4 — Page d’accueil du tableau de bord admin

### Objectif

Donner une vue d’ensemble de l’administration et offrir des accès rapides aux sections principales.

### Ce que le wireframe doit montrer

* un header ou repère d’administration
* un menu admin
* une zone de résumé
* des raccourcis vers les actions fréquentes
* éventuellement un aperçu de l’état du contenu

---

## 9. Wireframe 5 — Listing générique

### Objectif

Définir un modèle de page réutilisable pour afficher une liste d’éléments administrables.

### Ce que le wireframe doit montrer

* un titre de page
* un bouton de création
* une zone de filtres ou de recherche si nécessaire
* une liste ou un tableau
* des actions par ligne
* éventuellement une pagination

---

## 10. Wireframe 6 — Listing des items

### Objectif

Afficher la liste des items dans l’administration.

### Ce que le wireframe doit montrer

* le titre de la section
* un bouton de création d’item
* une liste ou un tableau d’items
* les informations utiles à la gestion
* les actions disponibles sur chaque item

### Exemples d’informations possibles

* ID
* titre
* statut
* date
* collection
* actions

---

## 11. Wireframe 7 — Listing des collections

### Objectif

Afficher la liste des collections utilisées pour regrouper les items.

### Ce que le wireframe doit montrer

* le titre de la section
* un bouton de création de collection
* une liste ou un tableau des collections
* les données utiles à l’organisation
* les actions disponibles sur chaque collection

### Exemples d’informations possibles

* ID
* nom de la collection
* nombre d’items
* statut éventuel
* actions

---

## 12. Wireframe 8 — Formulaire d’un item

### Objectif

Créer ou modifier un item dans l’administration.

### Ce que le wireframe doit montrer

* un titre de page
* la structure générale du formulaire
* les champs principaux
* les boutons d’action
* l’emplacement des messages d’erreur ou de validation

### Exemples de champs possibles

* titre
* contenu
* image
* collection
* tags
* statut
* date
* résumé

### Exemples d’actions possibles

* enregistrer
* enregistrer et continuer
* supprimer
* annuler
* retour à la liste

---

## 13. Conseils de réalisation pour ce projet

### Pour les pages publiques

Il est conseillé de commencer par la version **Mobile S**, puis d’adapter vers :

* **Tablet S**
* **Desktop**

### Ce qu’il faut montrer clairement

Les wireframes doivent permettre de comprendre :

* quelles pages existent
* à quoi elles servent
* quelles zones elles contiennent
* quelles actions elles permettent
* comment elles se relient entre elles
* comment les pages publiques s’adaptent aux trois breakpoints demandés

### Annotations utiles

Vous pouvez ajouter quelques notes courtes pour préciser :

* le rôle d’une zone
* le type de contenu prévu
* l’action associée à un bouton
* une contrainte particulière
* le comportement responsive attendu
* le nombre de colonnes prévu selon le breakpoint pour le catalogue

---

## 14. Résultat attendu

À la fin de cette étape, vous devez avoir un ensemble cohérent de wireframes servant de base pour :

* la structuration HTML
* la répartition des contenus
* l’organisation de l’administration
* la préparation du travail CSS
* l’intégration future en PHP

---

## 15. Résumé des livrables

### Partie publique

* 1 wireframe de page d’accueil en **Mobile S**
* 1 wireframe de page d’accueil en **Tablet S**
* 1 wireframe de page d’accueil en **Desktop**
* 1 wireframe de page catalogue en **Mobile S**
* 1 wireframe de page catalogue en **Tablet S**
* 1 wireframe de page catalogue en **Desktop**
* 1 wireframe de page détail d’un item en **Mobile S**
* 1 wireframe de page détail d’un item en **Tablet S**
* 1 wireframe de page détail d’un item en **Desktop**

### Partie administration

* 1 wireframe de dashboard admin
* 1 wireframe de listing générique
* 1 wireframe de listing des items
* 1 wireframe de listing des collections
* 1 wireframe de formulaire d’item

Total : **14 wireframes**