# Fonctionnalités à Développer

## Interface Publique

### 1. Affichage des Contenus
- Page d'accueil (contenus récents/mis en avant)
- Liste paginée de tous les contenus
- Vue détaillée par contenu
- Tags associés visibles
- Responsive design (tous appareils)

### 2. Navigation par Catégories
- Menu/sidebar avec liste des tags
- Filtrage par tag
- Système de breadcrumb
- URLs propres (slugs)

### 3. Recherche
- Recherche par mots-clés (titres, descriptions, contenus)
- Filtres avancés (tag, date)
- Présentation claire des résultats
- Log des recherches (optionnel)
- Suggestions basées sur termes populaires

### 4. Contact
- Champs obligatoires: nom, email, sujet, message
- Validation client/serveur
- Anti-spam
- Notification de réception
- Confirmation visuelle d'envoi

### 5. Système de Favoris
- Marquage de contenus
- Persistance via localStorage (visitor_token)
- Page de gestion dédiée
- Sans inscription requise
- Suppression de favoris

### 6. Personnalisation Interface
- Mode sombre/clair
- Options de taille de texte
- Sauvegarde préférences (localStorage)
- Application globale des préférences
- Interface intuitive

### 7. Identification Visiteurs
- Génération visitor_token unique
- Stockage local (préférences/favoris)
- Sans inscription/authentification
- Respect vie privée
- Persistance entre visites

## Interface Administration

### 1. Gestion des Contenus

#### Structure des contenus
- Titre unique + slug URL
- Description courte + contenu détaillé
- Image principale (optionnelle)
- Prix (optionnel)
- Horodatage (création/modification)
- Référence administrateur créateur

#### Actions administrateur
- Création contenus
- Modification contenus
- Suppression contenus
- Association tags/catégories
- Gestion médias
- Historique modifications

### 2. Gestion des Catégories
- CRUD tags
- Génération automatique slugs
- Association/dissociation contenus
- Vue contenus par tag
- Statistiques utilisation

### 3. Gestion des Messages
- Liste messages (formulaire contact)
- Tri (date, statut lu/non-lu)
- Vue détaillée
- Marquage statut
- Suppression

### 4. Authentification
- Connexion sécurisée
- Hashage password_hash()
- Protection brute force
- Déconnexion auto (inactivité)
- Réinitialisation mot de passe

### 5. Tableau de Bord
- Statistiques globales
- Contenus récents
- Alertes messages
- Raccourcis actions fréquentes
- Journal activités récentes