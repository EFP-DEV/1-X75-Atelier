# URLs Frontend (Public)

## Accueil et navigation principale
- `/` — Page d’accueil  
- `/items` — Catalogue principal des items  
- `/items/page/{page}` — Pagination du catalogue  
- `/tag/{slug}` — Liste filtrée par tag  
- `/tag/{slug}/page/{page}` — Pagination des items filtrés par tag  

## Recherche
- `/search` — Recherche  
  - **Paramètres** (GET)  
    | Nom         | Type      | Requis | Description                                                                                 |
    |-------------|-----------|--------|---------------------------------------------------------------------------------------------|
    | `q`         | string    | oui    | Terme(s) ou expression à rechercher                                                         |
    | `page`      | integer   | non    | Numéro de la page (défaut : 1). Peut être ignoré si vous utilisez `/search/page/{page}`     |
    | `per_page`  | integer   | non    | Nombre de résultats par page (défaut : 20)                                                  |
    | `sort`      | string    | non    | Champ de tri (`name`, `date`, `price`, etc.)                                                |
    | `order`     | string    | non    | Sens de tri (`asc` ou `desc`)                                                               |
    | `tags[]`    | array     | non    | Liste de slugs de tags pour filtrer (ex. `tags[]=foo&tags[]=bar`)                           |
    | `category`  | string    | non    | Slug de catégorie pour filtrer                                                             |
    | `price_min` | number    | non    | Filtrer les items dont le prix est ≥ cette valeur                                           |
    | `price_max` | number    | non    | Filtrer les items dont le prix est ≤ cette valeur                                           |
- `/search/page/{page}` — Pagination des résultats de recherche  

## Affichage détaillé des items
- `/item/{slug}` — Page détaillée d’un item  

## Système de collections et favoris
- `/collections` — Liste des collections de l’utilisateur  
- `/collection/{id}` — Détail d’une collection  
- `/collection/{id}/page/{page}` — Pagination d’une collection  
- `/favorites` — Liste des favoris de l’utilisateur  
- `/favorites/page/{page}` — Pagination des favoris  

## Contact et interaction
- `/contact` — Formulaire de contact  
- `/contact/success` — Confirmation d’envoi du formulaire  
- `/collection/add/{item_id}` — Ajouter un item à une collection (POST)  
- `/collection/remove/{item_id}` — Retirer un item d’une collection (POST)  
- `/favorite/toggle/{item_id}` — Ajouter/retirer des favoris (POST)  

## Utilisateur (authentification légère)
- `/user/preferences` — Réglages utilisateur (thème, affichage)  
- `/user/login` — Connexion (optionnel)  
- `/user/register` — Inscription (optionnel)  
- `/user/account` — Compte utilisateur (optionnel)  

---

# URLs Backend (Administration)

## Authentification
- `/admin` — Redirection vers login si non connecté, sinon dashboard  
- `/admin/login` — Formulaire de connexion  
- `/admin/logout` — Déconnexion  
- `/admin/password-reset` — Réinitialisation de mot de passe  

## Gestion des items
- `/admin/items` — Liste des items  
- `/admin/items/page/{page}` — Pagination des items  
- `/admin/items/create` — Créer un nouvel item  
- `/admin/items/edit/{id}` — Éditer un item existant  
- `/admin/items/delete/{id}` — Supprimer un item (POST/DELETE)  
- `/admin/items/status/{id}` — Changer le statut d’un item (POST)  

## Gestion des tags
- `/admin/tags` — Liste des tags  
- `/admin/tags/create` — Créer un nouveau tag  
- `/admin/tags/edit/{id}` — Éditer un tag existant  
- `/admin/tags/delete/{id}` — Supprimer un tag (POST/DELETE)  

## Gestion des médias
- `/admin/media` — Bibliothèque média  
- `/admin/media/page/{page}` — Pagination bibliothèque média  
- `/admin/media/upload` — Téléverser des médias  
- `/admin/media/delete/{id}` — Supprimer un média (POST/DELETE)  

## Gestion des messages
- `/admin/messages` — Liste des messages de contact  
- `/admin/messages/page/{page}` — Pagination des messages  
- `/admin/messages/view/{id}` — Voir un message  
- `/admin/messages/status/{id}` — Marquer comme lu/non lu (POST)  
- `/admin/messages/delete/{id}` — Supprimer un message (POST/DELETE)  

## Paramètres du site
- `/admin/settings` — Paramètres généraux  
- `/admin/settings/users` — Gestion des utilisateurs admin  
- `/admin/settings/users/create` — Créer un nouvel utilisateur admin  
- `/admin/settings/users/edit/{id}` — Éditer un utilisateur admin  
- `/admin/settings/users/delete/{id}` — Supprimer un utilisateur admin (POST/DELETE)  

---

# Redirections et pages d’erreur
- `/404` — Page non trouvée  
- `/403` — Accès interdit  
- `/maintenance` — Site en maintenance  

