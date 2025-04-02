
# Étapes de Développement Détaillées
Je vais ajouter des points de contrôle précis pour chaque phase de votre planning de développement.

## Phase 1 : Préparation et Conception (8h)

| Jour | Tâche | Heures | Point de contrôle |
|------|-------|--------|-------------------|
| 1 | Définition du type de site et du thème | 1h | Document de spécifications validé avec personas et objectifs |
| 1 | Création des wireframes pour les pages principales | 3h | Fichiers wireframes finalisés pour home, listing, detail et admin |
| 2 | Mise en place de l'environnement de développement (LAMP & GIT) | 1h | Serveur accessible via URL locale, PHP ≥ 8.2, MySQL ≥ 8 |
| 2 | Mise en place de la [structure MVC](structure_mvc_php.md) | 3h | Arborescence conforme, routes testées |

### Points de contrôle globaux :
* Envoi du repository par mail (ate@amstram.be)
* README.md documentant l'installation et l'architecture

## Phase 2 : Front-End (40h)

| Jour | Tech | Tâche | Heures | Point de contrôle |
|------|------|-------|--------|-------------------|
| 9-11 | `HTML` | Création des templates et composants communs | 12h | Composants réutilisables, HTML valide W3C, structure sémantique |
| 12-14 | `CSS` | Développement d'une feuille de style CSS simple | 12h | Responsive design validé (mobile/tablet/desktop), variables CSS |
| 15-16 | `JS` | Mise en place du visitor_token et collection | 8h | Token généré/stocké, API endpoints fonctionnels, persistance vérifiée |
| 17-18 | `JS` | Amelioration UX/UI Javascript | 8h | Navigation sans reload, formulaires interactifs, feedback utilisateur |

### Points de contrôle globaux :
* HTML/CSS/JS validés par les outils de validation
* Accessibilité WCAG 2.1 AA validée (contraste, navigation clavier)
* Tests de performance (Lighthouse) : Performance 85+, Accessibilité 90+
* Compatibilité cross-browser testée (Chrome, Firefox, Safari)
* LocalStorage vérifié pour le visitor_token et les préférences


## Phase 3 : Back-Office (24h)

| Jour | Tâche | Heures | Point de contrôle |
|------|-------|--------|-------------------|
| 3 | Création du système d'authentification administrateur simple | 4h | Login fonctionnel, session sécurisée, déconnexion, protection routes admin |
| 4-5 | Développement du CRUD pour les contenus (fonctionnalités de base) | 8h | Toutes opérations CRUD testées, validation des formulaires, gestion erreurs |
| 6-7 | Implémentation de la gestion des tags | 8h | Relations BDD fonctionnelles, ajout/suppression tags, recherche par tag |
| 8 | Création de l'interface pour gérer les messages | 4h | Liste messages, marquage lu/non-lu, réponse, suppression |

### Points de contrôle globaux :
* Tests pour chaque fonction critique (auth, CRUD)
* Validation SQL: schema.sql versionné et documenté


## Phase 4 : Finalisation (8h)

| Jour | Tâche | Heures | Point de contrôle |
|------|-------|--------|-------------------|
| 19 | Tests fonctionnels de base et jeux de donnees de demonstration | 4h | Scénarios utilisateurs validés, import SQL de démo versionné |
| 20 | Documentation du code et des concepts pour l'apprentissage | 4h | PHPDoc complet, README mis à jour, tutoriel d'utilisation |

### Points de contrôle globaux Phase 4 :
* Revue de code complète avec checklist de qualité
* Benchmark de performance (temps de chargement < 2s)
