# Du nom local au fichier servi
## Configurer Apache localement

# Introduction

L’objectif de cet atelier est d’obtenir d’abord cette adresse locale :

```text
http://mon_nom.local
```

Puis cette adresse plus propre :

```text
http://mon_nom.local/about
```

Dans tout le document, `mon_nom` est un exemple. On le remplace par le nom du projet, en minuscules, sans espace et sans accent.

Par exemple, si le projet s’appelle `tamarine.eu`, on utilisera :

```text
http://tamarine.local
```

et les chemins correspondront à un dossier nommé :

```text
tamarine
```

Quand on écrit une URL, la machine suit une course de relais :

1. Le navigateur formule une URL.
2. Le système résout le nom grâce au fichier `hosts`.
3. Apache reçoit la demande.
4. Le `VirtualHost` choisit le bon dossier.
5. Le `DocumentRoot` contient les fichiers à servir.
6. `.htaccess` peut modifier le chemin demandé.
7. La demande peut être transmise à `index.php`.
8. La réponse revient dans le navigateur.

# Partie 1 — Première vérification : demander un domaine connu

Avant de toucher Apache, on vérifie une chose simple : est-ce que la machine sait retrouver une adresse à partir d’un nom de domaine ?

On ouvre un terminal, puis on inscrit cette commande :

```cmd
ping google.com
```

Observation attendue : le système trouve une adresse IP et affiche des réponses.

Conséquence : le nom `google.com` a été transformé en adresse IP.

Interprétation : pour contacter un site, la machine ne travaille pas seulement avec le nom visible. Elle doit d’abord trouver une adresse IP. Le nom est pratique pour l’humain ; l’IP est utile pour la machine.

Maintenant, on demande un domaine qui n’existe pas :

```cmd
ping royaume-introuvable.invalid
```

Observation attendue : le système ne trouve pas l’hôte.

Conséquence : la demande échoue avant même qu’un serveur web puisse répondre.

Interprétation : Apache n’intervient pas encore. À ce stade, le système demande seulement : “Quelle adresse IP correspond à ce nom ?” Si personne ne sait répondre, le navigateur ne peut pas atteindre Apache.

Cela ne fonctionne pas encore parce que le nom n’est pas résolu en adresse IP.

# Partie 2 — Déclarer un domaine local : le fichier hosts

Nous allons maintenant créer une correspondance locale. Cette correspondance dit à la machine :

```text
Quand on voit mon_nom.local, on va vers 127.0.0.1.
```

Le fichier à modifier dépend du système :

| Système | Fichier `hosts`                         |
| ------- | --------------------------------------- |
| Windows | `C:\Windows\System32\drivers\etc\hosts` |
| macOS   | `/etc/hosts`                            |
| Linux   | `/etc/hosts`                            |

Si on ne sait pas encore ouvrir ce fichier avec les droits nécessaires, on utilise l’annexe A.

On ajoute cette ligne dans le fichier `hosts` :

```text
127.0.0.1 mon_nom.local
```

On enregistre le fichier.

Maintenant, on teste le nom local :

```cmd
ping mon_nom.local
```

Observation attendue : la machine répond depuis `127.0.0.1`.

Conséquence : le domaine `mon_nom.local` est maintenant trouvé.

Interprétation : ce fichier parle au système, pas à Apache. Il sert uniquement à résoudre un nom en adresse IP. Il ne dit pas encore quel dossier Apache doit servir.

Apache ne doit pas être redémarré ici parce que le fichier `hosts` n’est pas une configuration Apache. C’est le système qui le lit.

Maintenant, on ouvre dans le navigateur :

```text
http://mon_nom.local
```

Observation possible : une page d’accueil locale apparaît, une erreur apparaît, ou le mauvais contenu apparaît.

Conséquence : le domaine est trouvé, mais le bon dossier n’est pas encore forcément indiqué.

Interprétation : le système sait maintenant envoyer la demande vers la machine locale. Apache reçoit probablement la demande, mais il ne sait pas encore forcément quel dossier associer à `mon_nom.local`.

# Partie 3 — Configurer Apache : VirtualHost et DocumentRoot

Nous allons créer le dossier du projet correspondant à l’environnement utilisé :

| Environnement | Dossier à créer           |
| ------------- | ------------------------- |
| XAMPP         | `C:\xampp\htdocs\mon_nom` |
| Laragon       | `C:\laragon\www\mon_nom`  |
| MAMP          | `C:\MAMP\htdocs\mon_nom`  |

Dans ce dossier, on crée un fichier `index.html` :

```html
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>mon_nom.local</title>
</head>
<body>
    <h1>Bienvenue sur mon site local</h1>
    <p>Ce fichier vient du dossier de mon projet local.</p>
</body>
</html>
```

Le fichier se trouve donc ici :

| Environnement | Fichier créé                         |
| ------------- | ------------------------------------ |
| XAMPP         | `C:\xampp\htdocs\mon_nom\index.html` |
| Laragon       | `C:\laragon\www\mon_nom\index.html`  |
| MAMP          | `C:\MAMP\htdocs\mon_nom\index.html`  |

Observation : le fichier existe, mais Apache ne sait pas encore qu’il doit l’utiliser pour `mon_nom.local`.

Conséquence : il faut configurer Apache.

Interprétation : le `VirtualHost` permet à Apache de savoir quel domaine est demandé. Le `DocumentRoot` lui indique quel dossier servir.

On ouvre le fichier de configuration des VirtualHosts.

| Environnement | Fichier de configuration des VirtualHosts                                                           |
| ------------- | --------------------------------------------------------------------------------------------------- |
| XAMPP         | `C:\xampp\apache\conf\extra\httpd-vhosts.conf`                                                      |
| Laragon       | `C:\laragon\etc\apache2\sites-enabled\auto.mon_nom.local.conf` ou configuration générée par Laragon |
| MAMP          | `C:\MAMP\conf\apache\extra\httpd-vhosts.conf`                                                       |

On ajoute ou on adapte le bloc correspondant à l’environnement.

Pour XAMPP :

```apache
<VirtualHost *:80>
    ServerName localhost
    DocumentRoot "C:/xampp/htdocs"

    <Directory "C:/xampp/htdocs">
        Require all granted
        AllowOverride All
    </Directory>
</VirtualHost>

<VirtualHost *:80>
    ServerName mon_nom.local
    DocumentRoot "C:/xampp/htdocs/mon_nom"

    <Directory "C:/xampp/htdocs/mon_nom">
        Require all granted
        AllowOverride All
    </Directory>
</VirtualHost>
```

Pour Laragon :

```apache
<VirtualHost *:80>
    ServerName mon_nom.local
    DocumentRoot "C:/laragon/www/mon_nom"

    <Directory "C:/laragon/www/mon_nom">
        Require all granted
        AllowOverride All
    </Directory>
</VirtualHost>
```

Pour MAMP :

```apache
<VirtualHost *:80>
    ServerName localhost
    DocumentRoot "C:/MAMP/htdocs"

    <Directory "C:/MAMP/htdocs">
        Require all granted
        AllowOverride All
    </Directory>
</VirtualHost>

<VirtualHost *:80>
    ServerName mon_nom.local
    DocumentRoot "C:/MAMP/htdocs/mon_nom"

    <Directory "C:/MAMP/htdocs/mon_nom">
        Require all granted
        AllowOverride All
    </Directory>
</VirtualHost>
```

Ici :

```apache
ServerName mon_nom.local
```

signifie : “Si la demande concerne ce domaine…”

Et `DocumentRoot` signifie : “…sers les fichiers depuis ce dossier.”

| Environnement | DocumentRoot du projet    |
| ------------- | ------------------------- |
| XAMPP         | `C:/xampp/htdocs/mon_nom` |
| Laragon       | `C:/laragon/www/mon_nom`  |
| MAMP          | `C:/MAMP/htdocs/mon_nom`  |

Pour cette première configuration, Apache sert directement le dossier du projet. Plus tard, on pourra ajouter un dossier `public` pour séparer les fichiers exposés des fichiers internes.

Avant de redémarrer Apache, on relit les points les plus fragiles :

- les guillemets autour des chemins ;
- le nom du dossier ;
- le `ServerName` ;
- le `DocumentRoot` ;
- le bloc `<Directory>` ;
- la présence de `AllowOverride All`.

On redémarre Apache.

| Environnement | Redémarrage Apache                                          |
| ------------- | ----------------------------------------------------------- |
| XAMPP         | Redémarrer Apache depuis le panneau de contrôle XAMPP       |
| Laragon       | Menu Laragon → redémarrer Apache ou redémarrer les services |
| MAMP          | Redémarrer les serveurs depuis MAMP                         |

Apache doit être redémarré ici parce qu’il lit cette configuration au démarrage. Tant qu’il n’a pas redémarré, il peut continuer avec l’ancienne configuration.

Si Apache ne redémarre pas, on consulte l’annexe B.

On teste maintenant :

```text
http://localhost
```

Observation attendue : `localhost` continue de pointer vers le dossier local principal.

| Environnement | Dossier normalement servi par `localhost` |
| ------------- | ----------------------------------------- |
| XAMPP         | `C:\xampp\htdocs`                         |
| Laragon       | `C:\laragon\www`                          |
| MAMP          | `C:\MAMP\htdocs`                          |

On teste ensuite :

```text
http://mon_nom.local
```

Observation attendue : le navigateur affiche :

```text
Bienvenue sur mon site local
```

Conséquence : Apache a reconnu le nom demandé, choisi le bon `VirtualHost`, puis servi le bon `DocumentRoot`.

Interprétation : `ServerName` est le nom demandé. `DocumentRoot` est le dossier servi. `index.html` est le fichier ouvert automatiquement quand l’URL ne demande pas de fichier précis.

Si `mon_nom.local` affiche encore la page locale principale ou un mauvais dossier, les `VirtualHosts` ne sont peut-être pas lus correctement. On consulte l’annexe C.

# Partie 4 — Chemins propres et point d’entrée PHP

Jusqu’ici, Apache sert des fichiers.

Quand on demande :

```text
http://mon_nom.local
```

Apache cherche automatiquement un fichier d’accueil, par exemple :

```text
index.html
```

Mais quand on demande :

```text
http://mon_nom.local/about
```

Apache cherche quelque chose qui s’appelle réellement :

```text
about
```

Cela peut être un fichier ou un dossier. Mais pour le moment, il n’existe pas.

Observation attendue : `http://mon_nom.local/about` ne fonctionne pas encore.

Conséquence : Apache lit encore la demande de manière directe. Si l’URL demande `/about`, Apache cherche un fichier ou un dossier nommé `about`.

Interprétation : sans règle spéciale, Apache ne comprend pas encore que `/about` doit être une route de notre application.

Une solution simple, pour un site statique, serait de créer un vrai dossier :

```text
about
```

et de mettre dedans :

```text
index.html
```

Dans ce cas, l’adresse suivante fonctionnerait :

```text
http://mon_nom.local/about
```

Mais ce n’est pas la direction choisie ici.

Nous allons préparer une application PHP avec un seul point d’entrée.

Au lieu de créer un fichier ou un dossier pour chaque URL, on va demander à Apache de transmettre les demandes inconnues à :

```text
index.php
```

Cela signifie :

```text
/about
/catalog
/catalog/theme/aventure
/admin/items
```

ne seront plus forcément des fichiers réels. Ce seront des chemins demandés par le navigateur, puis transmis à PHP.

PHP pourra ensuite lire l’URL et décider quoi faire.

# Partie 5 — Créer index.php

Dans le dossier du projet, on remplace ou on complète le fichier d’accueil avec un fichier nommé :

```text
index.php
```

Son chemin complet est :

| Environnement | Fichier à créer                       |
| ------------- | ------------------------------------- |
| XAMPP         | `C:\xampp\htdocs\mon_nom\index.php`  |
| Laragon       | `C:\laragon\www\mon_nom\index.php`   |
| MAMP          | `C:\MAMP\htdocs\mon_nom\index.php`   |

On y place ce contenu provisoire :

```php
<?php

$uri = $_SERVER['REQUEST_URI'];

?><!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Point d’entrée PHP</title>
</head>
<body>
    <h1>Point d’entrée PHP</h1>

    <p>La demande est arrivée dans index.php.</p>

    <p>URL demandée :</p>

    <pre><?= htmlspecialchars($uri, ENT_QUOTES, 'UTF-8') ?></pre>
</body>
</html>
```

On teste :

```text
http://mon_nom.local
```

Observation attendue : le navigateur affiche la page “Point d’entrée PHP”.

Conséquence : Apache sait servir `index.php` comme fichier d’accueil.

Interprétation : quand l’URL demande simplement le domaine, Apache cherche un fichier d’accueil. Si `index.php` existe, il peut être servi automatiquement.

Maintenant, on teste :

```text
http://mon_nom.local/about
```

Observation attendue : cela ne fonctionne pas encore, ou Apache affiche une erreur.

Conséquence : Apache cherche encore un fichier ou un dossier nommé `about`.

Interprétation : `index.php` fonctionne comme page d’accueil, mais Apache ne lui transmet pas encore toutes les URLs inconnues.

# Partie 6 — Transmettre les routes à index.php avec .htaccess

Dans le dossier du projet, on crée un fichier nommé :

```text
.htaccess
```

Son chemin complet est :

| Environnement | Chemin du fichier `.htaccess`       |
| ------------- | ----------------------------------- |
| XAMPP         | `C:\xampp\htdocs\mon_nom\.htaccess` |
| Laragon       | `C:\laragon\www\mon_nom\.htaccess`  |
| MAMP          | `C:\MAMP\htdocs\mon_nom\.htaccess`  |

On ajoute ceci :

```apache
RewriteEngine On

RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ index.php [L]
```

Cette règle dit, en pratique :

Si la demande ne correspond pas déjà à un vrai fichier, et si elle ne correspond pas déjà à un vrai dossier, alors on transmet la demande à `index.php`.

Cela ne veut pas dire que `/about` devient `about.html`.

Cela veut dire que `/about` arrive dans `index.php`.

On teste sans redémarrer Apache :

```text
http://mon_nom.local/about
```

Observation attendue : la page “Point d’entrée PHP” s’affiche.

Dans la page, on doit voir que l’URL demandée est :

```text
/about
```

Conséquence : l’URL reste `/about`, mais le fichier exécuté est `index.php`.

Interprétation : `.htaccess` est une règle locale lue par Apache dans le dossier du site. Ce fichier parle à Apache, pas au système.

Apache ne doit pas être redémarré après modification de `.htaccess`, parce que `.htaccess` est relu pendant les requêtes.

Attention : pour que cela fonctionne, le `VirtualHost` doit autoriser la lecture de `.htaccess` avec cette ligne déjà présente :

```apache
AllowOverride All
```

Si `.htaccess` semble ignoré, on consulte l’annexe D.

# Partie 7 — Ce que cette étape prépare

À ce stade, Apache ne décide plus de la signification de `/about`.

Apache fait seulement ceci :

```text
/about → index.php
```

Ensuite, `index.php` peut lire :

```php
$_SERVER['REQUEST_URI']
```

et notre code pourra décider :

```text
/about        → page à propos
/catalog      → catalogue
/item/12      → détail d’un élément
/admin        → administration
```

C’est le début du routage.

Pour l’instant, on ne construit pas encore tout le routeur. On vérifie seulement que toutes les demandes peuvent arriver au même endroit.

C’est important parce qu’une application PHP ne veut pas forcément avoir un fichier physique pour chaque page.

On ne veut pas forcément ceci :

```text
about.php
catalog.php
item.php
admin.php
```

On prépare plutôt ceci :

```text
index.php
```

qui reçoit la demande, puis appelle le bon code.

# Conclusion

On a configuré une chaîne complète.

Si `ping mon_nom.local` échoue, le problème est avant Apache. Le système ne sait pas résoudre le nom local.

Si `ping mon_nom.local` fonctionne mais que le navigateur affiche le mauvais site, le problème est probablement dans le `VirtualHost` ou le `DocumentRoot`.

Si `http://mon_nom.local` fonctionne mais que `http://mon_nom.local/about` échoue, le problème concerne probablement `.htaccess`, `AllowOverride All` ou le module de réécriture.

Si `http://mon_nom.local/about` affiche `index.php`, la réécriture fonctionne.

Si Apache ne redémarre pas, la dernière modification de configuration est suspecte. On revient au dernier fichier Apache modifié, puis on vérifie la syntaxe, les chemins et les guillemets.

À partir de là, la suite logique sera de lire l’URL dans `index.php`, puis de la transformer en route.
