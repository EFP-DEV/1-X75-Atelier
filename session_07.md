# Cours — Construire un système de login (progressif, minimal)

## Objectif

Comprendre **progressivement** comment fonctionne un système de connexion, en partant de zéro :

1. Envoyer un formulaire
2. Traiter une requête côté serveur
3. Mémoriser un utilisateur (session)
4. Protéger une page
5. Identifier les limites → base de données, sécurité…

Chaque étape est **volontairement incomplète**.
On construit le raisonnement avant de construire un système complet.

---

# Étape 0 — Structure minimale (HTML seul)

## Objectif

Avoir un flux simple :

* Accueil → login → dashboard

---

### `index.html`

```html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil</title>
</head>
<body>
    <h1>Accueil</h1>
    <a href="login.html">Se connecter</a>
</body>
</html>
```

---

### `login.html`

```html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <h1>Connexion</h1>

    <form method="POST" action="handler.php">
        <label for="username">Nom d'utilisateur</label>
        <input id="username" name="username" required>

        <label for="password">Mot de passe</label>
        <input id="password" name="password" type="password" required>

        <button type="submit">Se connecter</button>
    </form>
</body>
</html>
```

---

### `dashboard.html`

```html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
</head>
<body>
    <h1>Dashboard</h1>
</body>
</html>
```

---

## À comprendre

À ce stade :

* Le navigateur affiche des pages
* Aucun traitement n’est fait
* Aucun contrôle n’existe

---

# Étape 1 — Traitement + mémoire (PHP minimal)

## Objectif

* Vérifier un login
* Mémoriser l’utilisateur
* Rediriger

---

## Nouveau fichier : `handler.php`

```php
<?php
session_start();

$username = $_POST['username'] ?? null;
$password = $_POST['password'] ?? null;

if ($username === 'admin' && $password === 'admin') {
    $_SESSION['user'] = $username;

    header('Location: dashboard.php');
    exit;
}

header('Location: login.html');
exit;
```

---

## Modifier le dashboard

Renommer :

```
dashboard.html → dashboard.php
```

---

### `dashboard.php`

```php
<?php
session_start();
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
</head>
<body>
    <h1>Dashboard</h1>
</body>
</html>
```

---

## Explications (très importantes)

### 1. `$_POST`

Contient les données envoyées par le formulaire.

---

### 2. `if (...)`

On compare :

```php
$username === 'admin' && $password === 'admin'
```

➡️ C’est volontairement simple (et mauvais en vrai).
➡️ Ici, on apprend le mécanisme.

---

### 3. `session_start()`

Active un système de mémoire côté serveur.

👉 Sans ça, PHP **oublie tout entre deux requêtes**.

---

### 4. `$_SESSION`

```php
$_SESSION['user'] = $username;
```

➡️ On stocke l’utilisateur connecté
➡️ Cette information sera disponible plus tard

---

### 5. `header('Location: ...')`

Permet de dire au navigateur :

> “Va à cette autre page”

---

### 6. `exit`

Arrête le script immédiatement.

👉 Important après un `header()`

---

## Test à faire

1. Aller sur `/login.html`
2. Entrer :

   * user: `admin`
   * password: `admin`
3. Vérifier la redirection vers le dashboard

---

## Ce que vous venez de construire

Un système qui :

* reçoit une requête (POST)
* prend une décision (if)
* stocke un état (session)
* redirige

---

## Problème majeur

➡️ Aller directement sur :

```
/dashboard.php
```

➡️ Ça fonctionne sans login ❗

---

# Étape 2 — Protéger le dashboard

## Objectif

Empêcher l’accès sans être connecté.

---

### Modifier `dashboard.php`

```php
<?php
session_start();

if (!isset($_SESSION['user'])) {
    header('Location: login.html');
    exit;
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
</head>
<body>
    <h1>Dashboard</h1>
</body>
</html>
```

---

## Explication

```php
if (!isset($_SESSION['user']))
```

➡️ Si aucun utilisateur n’est enregistré
➡️ Alors on bloque l’accès

---

## Concept clé

### Avant

> “Je vérifie le login au moment du formulaire”

### Maintenant

> “Je vérifie à **chaque accès** à une page protégée”

---

## Test à faire

1. Ouvrir une fenêtre privée
2. Aller directement sur `/dashboard.php`

➡️ Résultat attendu :

* redirection vers login

---

# Étape 3 — Limites actuelles

## 1. Un seul utilisateur

```php
if ($username === 'admin' && $password === 'admin')
```

➡️ Non scalable

---

## 2. Données en dur

➡️ Impossible à maintenir

---

## 3. Pas sécurisé

* mot de passe en clair
* aucune protection contre attaques

---

# Étape 4 — Évolution naturelle

## Question à poser aux étudiants

> “Comment gérer plusieurs utilisateurs ?”

---

## Réponse

👉 Il faut une **source de données**

→ une base de données

---

## Concept suivant

Remplacer :

```php
if ($username === 'admin' && $password === 'admin')
```

Par :

> “chercher l’utilisateur dans une base de données”

---

# Étape 5 — Sécurité (aperçu)

## Problèmes à résoudre ensuite

### 1. Mots de passe

➡️ Ne jamais stocker en clair
➡️ Utiliser `password_hash()` et `password_verify()`

---

### 2. CSRF

➡️ Vérifier que la requête vient bien du formulaire

---

### 3. Sessions

➡️ Expiration
➡️ régénération d’ID
➡️ protection

---

# Résumé

## Vous avez construit :

* un formulaire
* un traitement PHP
* une session
* une protection de page

---

## Vous avez compris :

* HTTP est **stateless**
* PHP doit **reconstruire le contexte à chaque requête**
* La sécurité est **progressive**

---

# Phrase clé à retenir

> Un système de login n’est pas une page.
> C’est une vérification exécutée à chaque requête.
