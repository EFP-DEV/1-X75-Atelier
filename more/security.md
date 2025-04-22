
# Sécurité en développement web


Nous allons maintenant détailler les failles potentielles de sécurité dans les applications web et la manière de les protéger. Pour chaque cas, nous fournirons des exemples mauvais (vulnérabilités) et bons (protection), ainsi que des méthodes pour tester la bonne mise en place de ces protections.

---

## 1. **Requêtes préparées (protection contre l'injection SQL)**

### **Problématique**

L'injection SQL (SQLi) est une attaque où un utilisateur malveillant insère des commandes SQL dans les champs de saisie d'un formulaire. Cette attaque peut permettre à l'attaquant d'accéder, modifier ou supprimer des données sensibles dans la base de données.

### **Exemple mauvais (vulnérabilité SQLi)**

```php
// Mauvais exemple : requête SQL non préparée
$email = $_POST['email'];
$mot_de_passe = $_POST['mot_de_passe'];
$sql = "SELECT * FROM utilisateurs WHERE email = '$email' AND mot_de_passe = '$mot_de_passe'";
$resultat = mysqli_query($conn, $sql);
```

Dans cet exemple, les variables `$_POST['email']` et `$_POST['mot_de_passe']` sont directement insérées dans la requête SQL sans aucune validation ou protection, ce qui permet à un attaquant de manipuler la requête.

### **Protection (requêtes préparées)**

```php
// Bon exemple : requête préparée avec PDO
$pdo = new PDO('mysql:host=localhost;dbname=test', 'username', 'password');
$stmt = $pdo->prepare("SELECT * FROM utilisateurs WHERE email = :email AND mot_de_passe = :mot_de_passe");
$stmt->bindParam(':email', $email);
$stmt->bindParam(':mot_de_passe', $mot_de_passe);
$stmt->execute();
```

Ici, les paramètres sont liés avant l'exécution de la requête, ce qui empêche l'injection SQL.

### **Test**

1. **Test de vulnérabilité :**
   - Tentez d'envoyer une requête comme `admin' OR 1=1 --` dans le champ email ou mot de passe. Si l'application renvoie une liste d'utilisateurs ou un accès non autorisé, cela indique une vulnérabilité SQLi.
   
2. **Test de protection :**
   - Vérifiez que l'application renvoie une erreur générique (comme "Email ou mot de passe incorrect") sans exposer des informations sur la structure de la base de données.

---

## 2. **Hashage sécurisé des mots de passe (bcrypt)**

### **Problématique**

Stocker les mots de passe en clair est une mauvaise pratique qui expose les utilisateurs en cas de fuite de données. Le hashage des mots de passe permet de les sécuriser de manière irréversible.

### **Exemple mauvais (stockage de mots de passe en clair)**

```php
// Mauvais exemple : stockage en clair
$mot_de_passe = $_POST['mot_de_passe'];
$query = "INSERT INTO utilisateurs (email, mot_de_passe) VALUES ('$email', '$mot_de_passe')";
mysqli_query($conn, $query);
```

Dans cet exemple, le mot de passe est stocké en clair dans la base de données, ce qui est dangereux en cas de fuite.

### **Protection (hashage avec bcrypt)**

```php
// Bon exemple : hashage avec bcrypt
$mot_de_passe = $_POST['mot_de_passe'];
$mot_de_passe_hash = password_hash($mot_de_passe, PASSWORD_BCRYPT);
$query = "INSERT INTO utilisateurs (email, mot_de_passe) VALUES ('$email', '$mot_de_passe_hash')";
mysqli_query($conn, $query);
```

Le mot de passe est maintenant hashé avant d’être stocké, ce qui le rend illisible en cas de fuite de la base de données.

### **Test**

1. **Test de vulnérabilité :**
   - Si un attaquant a accès à la base de données, tenter de récupérer un mot de passe en clair. Si les mots de passe sont stockés en clair, ils seront accessibles.
   
2. **Test de protection :**
   - Vérifiez que les mots de passe stockés dans la base de données sont des chaînes de caractères complexes et non des valeurs identifiables. Utilisez une fonction de vérification comme `password_verify()` pour tester si un mot de passe correspond au hash stocké.

---

## 3. **Validation et échappement des entrées (protection contre XSS)**

### **Problématique**

Les attaques XSS permettent à un attaquant d'injecter du JavaScript malveillant dans une page web, ce qui peut voler des informations sensibles ou compromettre la sécurité de l'utilisateur.

### **Exemple mauvais (vulnérabilité XSS)**

```php
// Mauvais exemple : affichage direct de l'entrée sans échappement
$nom_utilisateur = $_POST['nom_utilisateur'];
echo "Bienvenue, $nom_utilisateur";
```

Si un utilisateur entre une valeur comme `<script>alert('XSS');</script>`, ce script sera exécuté dans le navigateur.

### **Protection (échapper les entrées)**

```php
// Bon exemple : échappement avec htmlspecialchars
$nom_utilisateur = $_POST['nom_utilisateur'];
$nom_utilisateur_echappe = htmlspecialchars($nom_utilisateur, ENT_QUOTES, 'UTF-8');
echo "Bienvenue, $nom_utilisateur_echappe";
```

Ici, toutes les balises HTML et les caractères spéciaux sont échappés, empêchant l'exécution de JavaScript.

### **Test**

1. **Test de vulnérabilité :**
   - Essayez de soumettre un champ de texte avec un code JavaScript comme `<script>alert('XSS');</script>`. Si une alerte JavaScript s'affiche, cela indique une faille XSS.
   
2. **Test de protection :**
   - Vérifiez que le texte affiché est bien échappé et que le code JavaScript n’est pas exécuté dans le navigateur.

---

## 4. **Protection CSRF sur tous les formulaires**

### **Problématique**

Les attaques CSRF permettent à un attaquant d'exécuter des actions non autorisées en utilisant les privilèges d'un utilisateur authentifié sans son consentement.

### **Exemple mauvais (vulnérabilité CSRF)**

```php
// Mauvais exemple : formulaire sans protection CSRF
<form method="POST" action="changer_mot_de_passe.php">
    <input type="text" name="nouveau_mot_de_passe" />
    <input type="submit" value="Changer le mot de passe" />
</form>
```

Ce formulaire est vulnérable aux attaques CSRF, car il ne vérifie pas que la requête provient du bon utilisateur.

### **Protection (utilisation d'un token CSRF)**

```php
// Bon exemple : utilisation d'un token CSRF
session_start();
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}
?>

<form method="POST" action="changer_mot_de_passe.php">
    <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>" />
    <input type="text" name="nouveau_mot_de_passe" />
    <input type="submit" value="Changer le mot de passe" />
</form>
```

Lors de la soumission du formulaire, vous vérifiez que le token CSRF correspond à celui stocké dans la session.

### **Test**

1. **Test de vulnérabilité :**
   - Essayez de soumettre un formulaire à partir d'un autre site web en utilisant une requête POST malveillante. Si cela réussit, l'application est vulnérable à CSRF.
   
2. **Test de protection :**
   - Vérifiez que si le token CSRF dans la requête ne correspond pas à celui stocké dans la session, l'action est refusée.

---

## 5. **Politique CSP (Content Security Policy)**

### **Problématique**

Les attaques XSS peuvent être limitées en utilisant une politique CSP, qui définit les sources autorisées pour les scripts, les images, etc.

### **Exemple mauvais (absence de CSP)**

Il n'y a pas de politique de sécurité définie pour les sources de contenu, ce qui permet à des scripts malveillants externes d’être chargés.

### **Protection (ajout d'une politique CSP)**

```php
// Bon exemple : ajout d'un en-tête CSP
header("Content-Security-Policy: default-src 'self'; script-src 'self' https://apis.google.com;");
```

Cette politique limite les sources autorisées à 'self' (le même domaine) et `apis.google.com` pour les scripts.

### **Test**

1. **Test de vulnérabilité :**
   - Essayez d'injecter un script provenant d'une source externe. Si le script s'exécute, cela signifie que la CSP n'est pas correctement configurée.
   
2. **Test de protection :**
   - Vérifiez que les scripts externes non autorisés ne peuvent pas être chargés et que seuls les scripts définis dans la politique CSP sont exécutés.

---

## Conclusion

La sécurité des applications web est primordiale. En appliquant les bonnes pratiques mentionnées (requêtes préparées, hashage sécurisé, validation et échappement des entrées, protection CSRF et CSP), vous pouvez protéger votre application contre de nombreuses attaques. Tester régulièrement ces protections est essentiel pour garantir leur efficacité et la sécurité de votre application.