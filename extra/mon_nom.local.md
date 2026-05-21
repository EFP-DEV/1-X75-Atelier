# Du nom local au fichier servi
### Configurer Apache localement

# Introduction

L’objectif de cet atelier est d’obtenir d’abord cette adresse locale :

```text
http://mon_nom.local
````

Puis cette adresse plus propre :

```text
http://mon_nom.local/about
```

Dans tout le document, `mon_nom` est un exemple. Remplace-le par le nom de ton projet, en minuscules, sans espace et sans accent.

Par exemple, si ton projet s’appelle `tamarine.eu`, tu utiliseras :

```text
http://tamarine.local
```

et les chemins correspondront à un dossier nommé :

```text
tamarine
```

Quand tu écris une URL, la machine suit une course de relais :


1. Le navigateur formule une URL.
2. Windows résout le nom grâce au fichier `hosts`.
3. Apache reçoit la demande.
4. Le `VirtualHost` choisit le bon dossier.
5. Le `DocumentRoot` contient les fichiers à servir.
6. `.htaccess` peut modifier le chemin demandé.
7. La réponse revient dans le navigateur.

# Partie 1 — Première vérification : demander un domaine connu

Avant de toucher Apache, on vérifie une chose simple : est-ce que Windows sait retrouver une adresse à partir d’un nom de domaine ?

Ouvre un terminal Windows, puis inscris cette commande :

```cmd
ping google.com
```

Observation attendue : Windows trouve une adresse IP et affiche des réponses.

Conséquence : le nom `google.com` a été transformé en adresse IP.

Interprétation : pour contacter un site, la machine ne travaille pas seulement avec le nom visible. Elle doit d’abord trouver une adresse IP. Le nom est pratique pour l’humain ; l’IP est utile pour la machine.

Maintenant, demande un domaine qui n’existe pas :

```cmd
ping royaume-introuvable.invalid
```

Observation attendue : Windows ne trouve pas l’hôte.

Conséquence : la demande échoue avant même qu’un serveur web puisse répondre.

Interprétation : Apache n’intervient pas encore. À ce stade, Windows demande seulement : “Quelle adresse IP correspond à ce nom ?” Si personne ne sait répondre, le navigateur ne peut pas atteindre Apache.

Cela ne fonctionne pas encore parce que le nom n’est pas résolu en adresse IP.

# Partie 2 — Déclarer un domaine local : le fichier hosts

Nous allons maintenant créer une correspondance locale. Cette correspondance dit à Windows :

```text
Quand tu vois mon_nom.local, va vers 127.0.0.1.
```

Le fichier à modifier dépend du système :

| Système | Fichier `hosts`                         |
| ------- | --------------------------------------- |
| Windows | `C:\Windows\System32\drivers\etc\hosts` |
| macOS   | `/etc/hosts`                            |
| Linux   | `/etc/hosts`                            |

Si tu ne sais pas encore ouvrir ce fichier avec les droits nécessaires, utilise l’annexe A.

Ajoute cette ligne dans le fichier `hosts` :

```text
127.0.0.1 mon_nom.local
```

Enregistre le fichier.

Maintenant, teste le nom local :

```cmd
ping mon_nom.local
```

Observation attendue : Windows répond depuis `127.0.0.1`.

Conséquence : le domaine `mon_nom.local` est maintenant trouvé.

Interprétation : ce fichier parle à Windows, pas à Apache. Il sert uniquement à résoudre un nom en adresse IP. Il ne dit pas encore quel dossier Apache doit servir.

Apache ne doit pas être redémarré ici parce que le fichier `hosts` n’est pas une configuration Apache. C’est Windows qui le lit.

Maintenant, ouvre dans le navigateur :

```text
http://mon_nom.local
```

Observation possible : une page d’accueil locale apparaît, une erreur apparaît, ou le mauvais contenu apparaît.

Conséquence : le domaine est trouvé, mais le bon dossier n’est pas encore forcément indiqué.

Interprétation : Windows sait maintenant envoyer la demande vers ta machine locale. Apache reçoit probablement la demande, mais il ne sait pas encore forcément quel dossier associer à `mon_nom.local`.

# Partie 3 — Configurer Apache : VirtualHosts et DocumentRoot

Nous allons créer le dossier du projet correspondant à ton environnement :

| Environnement | Dossier à créer           |
| ------------- | ------------------------- |
| XAMPP         | `C:\xampp\htdocs\mon_nom` |
| Laragon       | `C:\laragon\www\mon_nom`  |
| MAMP          | `C:\MAMP\htdocs\mon_nom`  |

Dans ce dossier, crée un fichier `index.html` :

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

Ouvre le fichier de configuration des VirtualHosts.

| Environnement | Fichier de configuration des VirtualHosts                                                           |
| ------------- | --------------------------------------------------------------------------------------------------- |
| XAMPP         | `C:\xampp\apache\conf\extra\httpd-vhosts.conf`                                                      |
| Laragon       | `C:\laragon\etc\apache2\sites-enabled\auto.mon_nom.local.conf` ou configuration générée par Laragon |
| MAMP          | `C:\MAMP\conf\apache\extra\httpd-vhosts.conf`                                                       |

Ajoute ou adapte le bloc correspondant à ton environnement.

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

Redémarre Apache.

| Environnement | Redémarrage Apache                                          |
| ------------- | ----------------------------------------------------------- |
| XAMPP         | Redémarrer Apache depuis le panneau de contrôle XAMPP       |
| Laragon       | Menu Laragon → redémarrer Apache ou redémarrer les services |
| MAMP          | Redémarrer les serveurs depuis MAMP                         |

Apache doit être redémarré ici parce qu’il lit cette configuration au démarrage. Tant qu’il n’a pas redémarré, il peut continuer avec l’ancienne configuration.

Si Apache ne redémarre pas, consulte l’annexe B.

Teste maintenant :

```text
http://localhost
```

Observation attendue : `localhost` continue de pointer vers le dossier local principal.

| Environnement | Dossier normalement servi par `localhost` |
| ------------- | ----------------------------------------- |
| XAMPP         | `C:\xampp\htdocs`                         |
| Laragon       | `C:\laragon\www`                          |
| MAMP          | `C:\MAMP\htdocs`                          |

Teste ensuite :

```text
http://mon_nom.local
```

Observation attendue : le navigateur affiche :

```text
Bienvenue sur mon site local
```

Conséquence : Apache a reconnu le nom demandé, choisi le bon `VirtualHost`, puis servi le bon `DocumentRoot`.

Interprétation : `ServerName` est le nom demandé. `DocumentRoot` est le dossier servi. `index.html` est le fichier ouvert automatiquement quand l’URL ne demande pas de fichier précis.

Si `mon_nom.local` affiche encore la page locale principale ou un mauvais dossier, les `VirtualHosts` ne sont peut-être pas lus correctement. Consulte l’annexe C.

# Partie 4 — Chemins propres et .htaccess

Nous allons maintenant passer de :

```text
http://mon_nom.local/about.html
```

à :

```text
http://mon_nom.local/about
```

Crée ce fichier :

| Environnement | Fichier à créer                      |
| ------------- | ------------------------------------ |
| XAMPP         | `C:\xampp\htdocs\mon_nom\about.html` |
| Laragon       | `C:\laragon\www\mon_nom\about.html`  |
| MAMP          | `C:\MAMP\htdocs\mon_nom\about.html`  |

Avec ce contenu :

```html
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>À propos</title>
</head>
<body>
    <h1>À propos</h1>
    <p>Cette page est servie depuis about.html.</p>
</body>
</html>
```

Teste dans le navigateur :

```text
http://mon_nom.local/about.html
```

Observation attendue : la page s’affiche.

Conséquence : Apache trouve le fichier réel `about.html`.

Maintenant, teste :

```text
http://mon_nom.local/about
```

Observation attendue : cela ne fonctionne pas encore.

Conséquence : Apache cherche un fichier ou un dossier nommé `about`.

Interprétation : `/about` n’est pas automatiquement équivalent à `/about.html`. Sans règle spéciale, Apache lit la demande littéralement. Si l’URL demande `/about`, Apache cherche `about`.

Une solution simple, sans réécriture, consiste à créer un vrai dossier :

| Environnement | Dossier à créer                 |
| ------------- | ------------------------------- |
| XAMPP         | `C:\xampp\htdocs\mon_nom\about` |
| Laragon       | `C:\laragon\www\mon_nom\about`  |
| MAMP          | `C:\MAMP\htdocs\mon_nom\about`  |

Puis à mettre dedans un fichier :

| Environnement | Fichier à créer                            |
| ------------- | ------------------------------------------ |
| XAMPP         | `C:\xampp\htdocs\mon_nom\about\index.html` |
| Laragon       | `C:\laragon\www\mon_nom\about\index.html`  |
| MAMP          | `C:\MAMP\htdocs\mon_nom\about\index.html`  |

Dans ce cas, l’adresse suivante fonctionne :

```text
http://mon_nom.local/about
```

Observation : Apache entre dans le dossier `about` et ouvre automatiquement son `index.html`.

Conséquence : c’est simple et valable pour un site statique.

Interprétation : la structure physique impose alors les URLs. Si tu veux `/about`, tu crées un dossier `about`. C’est propre, mais parfois trop rigide.

Avant la suite, supprime ou mets de côté ce dossier `about`. Vérifie que ce fichier existe bien :

| Environnement | Fichier à conserver                  |
| ------------- | ------------------------------------ |
| XAMPP         | `C:\xampp\htdocs\mon_nom\about.html` |
| Laragon       | `C:\laragon\www\mon_nom\about.html`  |
| MAMP          | `C:\MAMP\htdocs\mon_nom\about.html`  |

Nous allons maintenant créer une règle de réécriture : une URL propre qui mène vers un fichier réel différent.

Dans le dossier du projet, crée un fichier nommé :

```text
.htaccess
```

Son chemin complet est :

| Environnement | Chemin du fichier `.htaccess`       |
| ------------- | ----------------------------------- |
| XAMPP         | `C:\xampp\htdocs\mon_nom\.htaccess` |
| Laragon       | `C:\laragon\www\mon_nom\.htaccess`  |
| MAMP          | `C:\MAMP\htdocs\mon_nom\.htaccess`  |

Ajoute ceci :

```apache
RewriteEngine On

RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ index.php [L]
```

Cette règle dit, en pratique :

Si la demande ne correspond pas déjà à un vrai fichier, si elle ne correspond pas déjà à un vrai dossier, mais si le même nom avec `.html` existe, alors sers ce fichier `.html`.

Teste sans redémarrer Apache :

```text
http://mon_nom.local/about
```

Observation attendue : la page “À propos” s’affiche.

Conséquence : l’URL reste `/about`, mais le fichier réel servi est `about.html`.

Interprétation : `.htaccess` est une règle locale lue par Apache dans le dossier du site. Ce fichier parle à Apache, pas à Windows.

Apache ne doit pas être redémarré après modification de `.htaccess`, parce que `.htaccess` est relu pendant les requêtes.

Attention : pour que cela fonctionne, le `VirtualHost` doit autoriser la lecture de `.htaccess` avec cette ligne déjà présente :

```apache
AllowOverride All
```

Si `.htaccess` semble ignoré, consulte l’annexe D.

# Conclusion

Tu as configuré une chaîne complète.

Si `ping mon_nom.local` échoue, le problème est avant Apache. Windows ne sait pas résoudre le nom local.

Si `ping mon_nom.local` fonctionne mais que le navigateur affiche le mauvais site, le problème est probablement dans le `VirtualHost` ou le `DocumentRoot`.

Si `http://mon_nom.local/about.html` fonctionne mais que `http://mon_nom.local/about` échoue, le problème concerne soit la structure de dossiers, soit la réécriture d’URL.

Si Apache ne redémarre pas, la dernière modification de configuration est suspecte. Reviens au dernier fichier Apache modifié, puis vérifie la syntaxe, les chemins et les guillemets.
