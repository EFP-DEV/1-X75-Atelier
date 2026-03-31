# Checklist Atelier

## Fonctionnalités attendues

- [ ] Affichage de la liste des items  
- [ ] Page détail pour chaque item  
- [ ] Recherche simple par mot-clé et categorie + theme  
- [ ] Interface admin sécurisée (login + session) 
- [ ] CRUD complet sur les items
- [ ] Upload image

## Base de données

- [ ] Table `items` (structure complète)  
- [ ] Table `tags` (catégories et thèmes)
  - [ ] Distinction par `type ENUM('categorie', 'theme', 'libre')` **ou** `parent_id`
- [ ] Table `items_tags` (relation many-to-many)  
- [ ] Clés primaires et étrangères définies + contraintes unicites et ON DELETE
- [ ] Script SQL complet et fonctionnel  
- [ ] Connexion PDO centralisée et memoizee

## Frontend & Code

- [ ] HTML sémantique : balises structurantes correctement utilisées  
- [ ] Accessibilité minimale assurée :
  - [ ] Attributs `alt` sur les images  
  - [ ] Titres hiérarchisés  
  - [ ] `label` associé à chaque champ de formulaire  
  - [ ] Navigation clavier fonctionnelle  
- [ ] CSS dans des fichiers externes uniquement
  - [ ] Aucun `<style>` ni `style=""` dans le HTML  
- [ ] JavaScript non obstrusif
  - [ ] Aucun événement inline (`onclick`, etc.)  
  - [ ] Scripts déclenchés proprement après chargement  
- [ ] Mode sombre implémenté (CSS + JS) 
- [ ] DRY strictement respecté : aucun duplicat inutile dans le HTML ou le PHP
- [ ] Separation of concern: respecter MVC

## Sécurité minimale

- [ ] Authentification avec mot de passe hashé  
- [ ] Vérification de session sur toutes les pages admin  
- [ ] Requêtes SQL préparées (anti-injection)  
- [ ] Aucune donnée sensible stockée en clair

## Organisation et qualité

- [ ] Structure de fichiers claire et logique  
- [ ] Code lisible, aéré, et commenté  
- [ ] Aucune répétition inutile : application stricte de DRY et CoC
- [ ] Présence d’un README avec instructions d’installation

## Validation finale

- [ ] Toutes les fonctionnalités testées manuellement (CRUD, recherche)  
- [ ] Affichage sans image fonctionne sans erreur  
- [ ] Responsive testé sur mobile, tablette, et ordinateur  
- [ ] Accessibilité clavier testée  
- [ ] Aucun message d’erreur en console navigateur ou PHP
- [ ] Tester dans 2 navigateurs
