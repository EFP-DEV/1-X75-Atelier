# De l’idée au site

## Partie I — Faire apparaître la vitrine

### 0. Quand la vie vous donne des citrons

On ne rencontre pas d’abord un site web.

On rencontre quelqu’un.

Il fait chaud ce jour-là. Une chaleur simple, de trottoir, de fin d’après-midi. Le genre de chaleur qui donne envie de boire quelque chose avec des glaçons.

Au coin d’une rue, il y a une petite table.

Pas une boutique. Pas encore.

Une table pliante, un parasol, quelques citrons dans une cagette, une carafe transparente, des gobelets empilés. Sur un morceau de carton écrit au feutre :

**Limonade maison — 2 €**

Je m’arrête.

— Une limonade, s’il vous plaît.

L’homme derrière la table prend un citron, le coupe, le presse. Il ajoute de l’eau fraîche, un peu de sucre, des glaçons. Rien de spectaculaire. Pas de machine compliquée. Pas de logo. Pas de carte imprimée. Juste quelqu’un qui fait une limonade correctement.

Je goûte.

Elle est bonne. Froide, citronnée, équilibrée.

Je regarde les citrons dans la cagette.

Il sourit.

— J’ai commencé cette semaine.

Il montre la table.

— Au départ, j’avais surtout trop de citrons.

Je recule un peu pour regarder le stand depuis le trottoir.

Vu de près, il existe.

Vu de loin, presque pas.

Entre la boulangerie, les voitures garées et les passants qui avancent sans lever les yeux, le stand disparaît vite. Il suffit de regarder son téléphone, de passer de l’autre côté de la rue, ou de marcher un peu trop vite, et le stand n’existe plus.

— Je passe souvent dans cette rue. Je ne vous avais jamais vu.

Il hoche la tête.

— Voilà. C’est le problème. Quand les gens s’arrêtent, ils aiment bien. Mais il faut qu’ils s’arrêtent.

Puis il sort un petit papier plié de sa poche. Les coins sont mous. L’encre commence à traverser.

**Le Stand Citronné**
Limonade maison
12 rue des Tilleuls
Ouvert de 14h à 18h
Téléphone : 04 00 00 00 00

— Vous vous y connaissez un peu en informatique, non ? Vous pensez qu’on pourrait mettre ça quelque part ? Une petite page, peut-être. Juste pour que les gens sachent que je suis là.

À ce moment-là, il ne demande pas une boutique en ligne.

Il ne demande pas un panier.

Il ne demande pas une base de données.

Il ne demande pas une interface d’administration.

Il vend une seule chose : de la limonade.

Son problème est plus simple que tout ça.

Le stand existe dans la rue, mais il n’existe pas encore sur le Web.

Alors nous répondons :

— Oui, bien sûr, je peux te faire ça.

Nous pensons construire une page.

En réalité, nous construisons la première frontière d’un système.

Ce jour-là, il n’y a qu’une table pliante, quelques citrons et un homme qui vient de commencer. Des années plus tard, Le Stand Citronné aura plusieurs boutiques, des employés, des commandes en ligne, des stocks par point de vente, des rôles, des historiques et des workflows.

Mais rien de tout cela n’est nécessaire encore.

Pour l’instant, il faut seulement dire au monde :

**Limonade maison.**
**Ici.**
**Aujourd’hui.**

Et pour ça, une page HTML suffit.

---

### 1. L’affiche — HTML

Le premier besoin n’est pas de vendre en ligne.

Le premier besoin est d’exister dans un navigateur.

Le papier plié contient déjà l’essentiel : un nom, une phrase, une adresse, des horaires, un numéro. Il ne manque pas une application. Il ne manque pas une architecture. Il manque seulement une affiche que le Web peut lire.

On crée donc un fichier :

```html
index.html
```

Et on y place les informations de base :

```html
<h1>Le Stand Citronné</h1>

<p>Limonade maison préparée avec des citrons frais.</p>

<p>Adresse : 12 rue des Tilleuls</p>
<p>Ouvert de 14h à 18h</p>
<p>Téléphone : 04 00 00 00 00</p>
```

HTML ne prépare pas la limonade.

HTML ne choisit pas les couleurs.

HTML ne sait pas encore ce qui est disponible ou non.

HTML dit simplement :

ceci est le titre,
ceci est un paragraphe,
ceci est une information à lire.

Le fichier existe.

On peut l’ouvrir dans un navigateur.

C’est déjà autre chose qu’un papier plié.

Mais ce n’est pas encore vraiment le Web. Tant que le fichier reste sur notre ordinateur, personne dans la rue ne peut le trouver. Il faut lui donner une adresse.

On le place donc sur un petit hébergement.

Le navigateur peut maintenant demander cette adresse et recevoir la page.

Le stand a maintenant une première présence publique.

Il n’est pas encore connu.

Il n’est pas encore beau.

Il ne vend pas.

Mais il a une adresse.

On peut l’envoyer à quelqu’un, l’imprimer sur un carton, la transformer en QR code, la coller près du stand.

Le stand existe dans la rue.

La page existe à une adresse.

Mais accessible ne veut pas encore dire accueillant.

Une feuille punaisée au mur peut contenir la bonne information et pourtant ne donner envie à personne de s’approcher.

---

### 2. L’affiche donne soif — CSS

La page existe.

Elle affiche les bonnes informations.

Pourtant, quand le propriétaire la regarde sur son téléphone, il fronce un peu les sourcils.

— C’est bien ça, dit-il. Mais ça ressemble à un papier administratif.

Il n’a pas tort.

Le contenu est juste. Mais il arrive froidement. Le nom n’a pas de présence. L’adresse ne se détache pas. La page ne respire pas. Elle dit qu’il y a de la limonade, mais elle ne donne pas encore envie de s’arrêter.

Le problème n’est plus ce que la page contient.

Le problème est la manière dont elle le présente.

HTML garde la structure.

CSS prend en charge l’apparence.

On ajoute :

```html
<link rel="stylesheet" href="style.css">
```

Puis, dans `style.css`, on commence à donner de l’espace :

```css
body {
  font-family: Arial, sans-serif;
  line-height: 1.5;
}

main {
  max-width: 720px;
  margin: 0 auto;
  padding: 2rem;
}

.hero {
  padding: 2rem;
  border: 1px solid #ddd;
}
```

La page ne fait pas plus de choses qu’avant.

Elle ne vend pas.

Elle ne calcule pas.

Elle ne mémorise rien.

Mais elle présente mieux.

HTML annonce les citrons.

CSS donne soif.

Pour l’instant, cela suffit. Le stand n’a qu’une offre simple, quelques informations fixes, et un seul but : être trouvé.

Mais très vite, le propriétaire essaie autre chose.

---

### 3. La carte copiée à la main — HTML répété

La limonade classique fonctionne.

Les gens reviennent.

Un jour, le propriétaire ajoute quelques feuilles de menthe dans une carafe.

— On pourrait mettre aussi la menthe sur le site ?

Puis, quelques jours plus tard :

— J’ai essayé avec du gingembre. Ça plaît bien. On l’ajoute aussi ?

Le besoin reste simple : afficher trois variantes.

À ce stade, il n’y a pas encore de raison de construire un grand système. On peut encore écrire directement ce qui existe dans la page.

Dans `index.html`, on ajoute une petite carte :

```html
<section class="menu">
  <article class="juice-card">
    <h2>Limonade classique</h2>
    <p>Citron frais, eau fraîche, sucre.</p>
    <p>2 €</p>
  </article>

  <article class="juice-card">
    <h2>Limonade menthe</h2>
    <p>Citron frais, menthe, eau fraîche, sucre.</p>
    <p>2,50 €</p>
  </article>

  <article class="juice-card">
    <h2>Limonade gingembre</h2>
    <p>Citron frais, gingembre, eau fraîche, sucre.</p>
    <p>3 €</p>
  </article>
</section>
```

La page ne présente plus une seule limonade.

Elle présente une petite offre.

Cela fonctionne.

Mais quelque chose commence à se voir.

Les blocs se ressemblent.

Chaque carte a un nom.

Chaque carte a une description.

Chaque carte a un prix.

On n’a pas encore un problème grave.

On a un signe.

La répétition commence à montrer qu’il y a une forme cachée sous les textes.

---

### 4. Le motif — structure et valeurs

Le propriétaire regarde la carte imprimée depuis le site.

— C’est propre. On voit bien les trois.

Puis il ajoute :

— Si j’en ajoute une quatrième, on recopie encore le même bloc ?

Oui.

Pour l’instant, oui.

Mais en regardant les cartes, on voit mieux ce qui se passe.

Tout ne change pas.

La forme reste presque identique :

un nom,
une description,
un prix.

Ce qui change, ce sont les valeurs.

**Limonade classique**
Citron frais, eau fraîche, sucre
2 €

Puis :

**Limonade menthe**
Citron frais, menthe, eau fraîche, sucre
2,50 €

Puis :

**Limonade gingembre**
Citron frais, gingembre
3 €

Le HTML répété cache donc une structure.

On peut le dire autrement :

```text
Pour chaque limonade :
  afficher son nom
  afficher sa description
  afficher son prix
```

Ce moment est important.

On n’a pas encore besoin d’une base de données.

On n’a pas encore besoin d’un serveur.

On n’a même pas encore besoin d’un vrai espace d’administration.

Mais on a compris quelque chose : quand la forme reste stable et que seules les valeurs changent, les données commencent à apparaître.

La répétition n’est pas seulement pénible.

Elle révèle le modèle.

---

### 5. Le gabarit — déplacer la répétition ne suffit pas

Une quatrième limonade arrive.

Puis une cinquième est envisagée.

Le propriétaire ne fait rien de compliqué. Il teste seulement des recettes. Mais chaque recette oblige à toucher au HTML.

Si on change la forme d’une carte, il faut changer toutes les cartes.

Si on ajoute une information, il faut l’ajouter partout.

Si on oublie un `</article>`, la page peut se casser pour une raison idiote.

Le problème semble être la répétition.

Et, à ce moment-là, une solution technique existe.

On pourrait garder une liste de limonades dans le navigateur, puis demander à JavaScript de fabriquer les cartes avec une boucle.

La liste contiendrait les valeurs :

```js
const lemonades = [
  {
    name: "Limonade classique",
    description: "Citron frais, eau fraîche, sucre.",
    price: "2 €"
  },
  {
    name: "Limonade menthe",
    description: "Citron frais, menthe, eau fraîche, sucre.",
    price: "2,50 €"
  },
  {
    name: "Limonade gingembre",
    description: "Citron frais, gingembre.",
    price: "3 €"
  }
];
```

Puis JavaScript pourrait dire :

```text
Pour chaque limonade dans la liste :
  fabriquer une carte
  y placer le nom
  y placer la description
  y placer le prix
  ajouter la carte à la page
```

La forme serait écrite une seule fois.

Les cartes seraient produites automatiquement.

On aurait déplacé la répétition.

Mais on n’aurait pas encore résolu le vrai problème.

Car les données seraient toujours dans le code.

Au lieu d’être répétées dans `index.html`, elles seraient regroupées dans `script.js`. C’est plus propre, mais cela ne change pas la frontière du système.

Si le prix de la menthe change, il faut encore modifier un fichier.

Si le gingembre est indisponible, il faut encore toucher au code.

Si le propriétaire veut ajouter une recette, il doit encore passer par le développeur, faire attention aux guillemets, aux virgules, aux accolades, puis renvoyer le fichier.

Le gabarit JavaScript résout un problème d’écriture.

Il ne résout pas encore un problème de commerce.

Il dit :

je peux fabriquer plusieurs cartes depuis une même forme.

Mais il ne dit pas encore :

qui pourra modifier les valeurs,

ni où ces valeurs devront vivre si elles changent souvent.

Pour l’instant, on n’a pas encore assez de pression pour décider.

On a seulement appris à distinguer deux choses :

une forme stable,

des valeurs variables.

Ce moment reste utile.

Il montre que la répétition n’est pas seulement une gêne.

Elle révèle une structure.

Mais la vraie question n’est pas encore complètement là.

Elle arrive quand la vie du stand commence à changer sans attendre le développeur.

---

### 6. Les prix changent sans nous — sortir les données du code

Nous venons de voir qu’un gabarit pourrait éviter de recopier les cartes à la main.

Mais le problème qui arrive n’est pas seulement de fabriquer plus vite du HTML.

Le problème est que la vie du stand change sans attendre le développeur.

Un samedi, la menthe manque.

Le propriétaire appelle.

— Tu peux mettre la limonade menthe en indisponible ?

Le lendemain, le gingembre coûte plus cher.

— Tu peux changer le prix ?

Le mardi, le propriétaire appelle encore.

— Je voudrais pouvoir mettre à jour le stock moi-même, même quand tu n’es pas disponible.

Chaque demande est simple.

Aucune ne mérite de réveiller tout le code.

Mais pour l’instant, changer le commerce veut dire ouvrir un fichier, trouver la bonne ligne, modifier une valeur, faire attention à la syntaxe, enregistrer, renvoyer le fichier.

Que les informations soient dans `index.html` ou dans `script.js`, le problème reste le même.

Elles vivent dans le code.

Le site fonctionne encore.

Ce qui ne fonctionne plus, c’est sa frontière.

Le code devrait décrire la mécanique :

comment afficher,
comment parcourir,
comment réagir.

Les données devraient décrire l’état du commerce :

quel produit existe,
quel prix il a,
combien il en reste,
s’il est disponible.

Quand ces deux choses sont mélangées, le propriétaire dépend du développeur pour des gestes de commerce ordinaires.

Il faut donc séparer :

ce qui fait fonctionner la page,

et ce qui change dans la vie du stand.

La question devient concrète :

où mettre les faits du commerce ?

---

### 7. Le registre — base de données

Au début, un papier suffisait.

Puis une page suffisait.

Puis une liste dans JavaScript aurait pu suffire pour produire des cartes.

Mais maintenant, les prix changent, les stocks changent, les produits apparaissent et disparaissent. Le commerce a besoin d’une mémoire plus fiable qu’un fichier de code.

Il lui faut un registre.

Pas une réserve de citrons.

Une réserve contient des objets.

Une base de données contient des faits.

Elle garde des informations comme :

ce produit existe,
son prix est celui-ci,
il reste tant d’unités,
il est disponible ou non.

Ces faits doivent survivre aux jours qui passent. Ils doivent pouvoir être modifiés sans casser la page. Ils doivent pouvoir être relus par le site. Ils doivent rester organisés quand il y aura plus de produits, plus de stocks, plus de commandes.

On crée donc une base de données :

```text
le_stand_citronne
```

La base de données ne rend pas encore le site plus beau.

Elle ne vend pas encore.

Elle ne crée pas encore d’administration.

Mais elle change la nature du système.

Le site peut maintenant avoir une mémoire séparée de son code.

Il reste à décider comment écrire les limonades dans ce registre.

---

### 8. Les fiches de limonade — table et colonnes

Un registre vide ne sert à rien.

Il faut définir ce qu’est une limonade pour le système.

Avant, une limonade était un morceau de texte dans une carte.

Puis elle aurait pu devenir un objet dans une liste JavaScript.

Maintenant, elle devient une ligne dans une table.

On crée une table :

```text
lemonade
- id
- name
- description
- price
- stock
- is_available
```

Chaque ligne représente une limonade.

Chaque colonne représente une information importante.

```text
1 | Limonade classique | Citron frais, eau fraîche, sucre | 2.00 | 30 | true
2 | Limonade menthe    | Citron frais, menthe             | 2.50 | 18 | true
3 | Limonade gingembre | Citron frais, gingembre          | 3.00 | 0  | false
```

La page ne lit pas encore ces informations.

Mais le commerce est maintenant décrit dans un endroit organisé.

Avant, si on voulait savoir ce que vendait le stand, il fallait lire le HTML ou le JavaScript.

Maintenant, on peut consulter le registre.

Une limonade n’est plus seulement un bloc affiché.

C’est une donnée structurée.

La prochaine limite devient évidente : la page doit utiliser cette mémoire.

---

### 9. La page consulte le registre — PHP

Le visiteur ouvre le site.

Avant, le serveur envoyait une page déjà écrite.

La carte était dans le fichier.

Les prix étaient dans le fichier.

Les produits étaient dans le fichier.

Mais maintenant, les vrais faits vivent ailleurs : dans la base de données.

Le serveur ne peut plus simplement envoyer une vieille affiche. Il doit d’abord consulter le registre, récupérer les limonades du moment, puis fabriquer la page avec les vraies valeurs.

On remplace donc :

```text
index.html
```

par :

```text
index.php
```

Pour l’instant, on ne construit pas encore une grande organisation.

On fait la chose la plus directe.

Dans `index.php`, on se connecte à la base, on demande les limonades disponibles, puis on les affiche.

Au début du fichier, on peut avoir quelque chose comme :

```php
<?php

$pdo = new PDO(
    'mysql:host=localhost;dbname=le_stand_citronne;charset=utf8',
    'root',
    ''
);

$sql = '
    SELECT name, description, price
    FROM lemonade
    WHERE is_available = 1
';

$stmt = $pdo->query($sql);
$lemonades = $stmt->fetchAll(PDO::FETCH_ASSOC);

?>
```

Puis, plus bas dans la page :

```php
<section class="menu">
  <?php foreach ($lemonades as $lemonade): ?>
    <article class="juice-card">
      <h2><?= htmlspecialchars($lemonade['name']) ?></h2>
      <p><?= htmlspecialchars($lemonade['description']) ?></p>
      <p><?= htmlspecialchars($lemonade['price']) ?> €</p>
    </article>
  <?php endforeach; ?>
</section>
```

Le chemin devient :

```text
le visiteur demande la page
→ PHP reçoit la demande
→ PHP se connecte à la base
→ PHP demande les limonades disponibles
→ la base renvoie les lignes
→ PHP parcourt les lignes
→ PHP fabrique le HTML
→ le navigateur affiche la page
```

Le navigateur ne voit pas le PHP.

Il reçoit seulement le HTML produit.

Le visiteur ne voit pas forcément la différence.

Il voit toujours une carte.

Il voit toujours des noms, des descriptions et des prix.

Mais le système a changé.

La page n’est plus écrite une fois pour toutes.

Elle est produite à partir d’une mémoire.

Si un prix change dans la base, la prochaine page affichera ce nouveau prix.

On pourrait faire autrement.

On pourrait envoyer une page plus vide, laisser JavaScript demander les produits au serveur, puis fabriquer les cartes dans le navigateur.

Mais pour cela, il faudrait déjà construire une manière propre de fournir les données au navigateur.

Ce serait possible.

Ce n’est pas encore nécessaire.

Pour afficher une carte depuis une base, PHP est plus direct : le serveur lit, fabrique, envoie.

Ce n’est pas une obligation technique.

C’est un choix de simplicité.

Pour l’instant, tout cela vit encore dans `index.php`.

La connexion.

La requête.

La récupération des résultats.

La boucle d’affichage.

Ce n’est pas élégant.

Mais ce n’est pas encore le problème.

Le problème du moment est plus simple : la page doit lire le registre et afficher les vraies limonades.

Plus tard, ce mélange deviendra gênant.

Pas encore.

Pour l’instant, il répare exactement ce qui cassait : le site ne suivait plus l’état réel du commerce.

Mais une question reste ouverte.

Qui peut modifier cette mémoire ?

Pour l’instant, il faut encore passer par un outil technique. Le propriétaire ne veut pas gérer sa limonade dans phpMyAdmin.

Il lui faut une vraie porte d’entrée.

---

## Partie II — Gérer la boutique

### 10. Le petit bureau — administration minimale

Le stand a maintenant un registre.

Mais un registre sans bureau reste un outil de développeur.

Le propriétaire ne veut pas demander chaque changement.

Il veut pouvoir modifier un prix, corriger une description, marquer une limonade indisponible, ajouter une nouvelle variante, supprimer ce qu’il ne vend plus.

Il ne veut pas toucher au code.

Il ne veut pas comprendre les requêtes SQL.

Il veut gérer son commerce.

On ajoute donc une administration simple.

Mais ce bureau ne peut pas être une page publique.

Avant de l’exposer réellement, il faudra lui mettre une porte.

Pour l’instant, on commence par dessiner les gestes dont le propriétaire a besoin :

voir,

ajouter,

modifier,

supprimer.

Ces gestes décrivent le bureau.

La section suivante posera sa clé.

Ce n’est pas la vitrine publique.

C’est le petit bureau derrière le stand.

La vitrine dit aux visiteurs :

voici ce que nous vendons.

Le bureau dit au propriétaire :

voici ce que vous pouvez changer.

Au début, on ne crée pas encore un système propre de routes.

On crée quelques fichiers.

```text
admin/lemonades.php
admin/lemonade-create.php
admin/lemonade-edit.php?id=3
admin/lemonade-delete.php?id=3
```

Chaque fichier correspond à un geste simple.

`admin/lemonades.php` affiche les limonades existantes.

`admin/lemonade-create.php` permet d’en ajouter une.

`admin/lemonade-edit.php?id=3` permet de modifier la limonade numéro 3.

`admin/lemonade-delete.php?id=3` permet de supprimer la limonade numéro 3.

Dans le formulaire d’ajout ou de modification, on place les champs nécessaires :

```html
<input name="name">
<textarea name="description"></textarea>
<input name="price">
<input name="stock">

<label>
  <input type="checkbox" name="is_available">
  Disponible
</label>
```

Quand le propriétaire envoie un formulaire, le serveur traduit son geste.

Ajouter devient une requête `INSERT`.

Modifier devient une requête `UPDATE`.

Supprimer devient une requête `DELETE`.

Dans `admin/lemonade-create.php`, le fichier peut encore faire beaucoup de choses lui-même.

Il affiche le formulaire.

Puis, si le formulaire est envoyé, il lit les champs.

```php
$name = $_POST['name'] ?? '';
$description = $_POST['description'] ?? '';
$price = $_POST['price'] ?? '';
$stock = $_POST['stock'] ?? 0;
$isAvailable = isset($_POST['is_available']);
```

Même dans un bureau privé, le serveur ne croit pas aveuglément ce qui arrive d’un formulaire.

Le nom ne doit pas être vide.

Le prix doit être un nombre valide.

Le stock doit être un entier supérieur ou égal à zéro.

La disponibilité doit devenir une valeur claire : oui ou non.

Cette validation reste simple.

Mais elle existe déjà, parce qu’un formulaire est une entrée dans le système.

Puis le fichier écrit dans la base.

```php
$sql = '
    INSERT INTO lemonade (name, description, price, stock, is_available)
    VALUES (?, ?, ?, ?, ?)
';

$stmt = $pdo->prepare($sql);
$stmt->execute([
    $name,
    $description,
    $price,
    $stock,
    $isAvailable ? 1 : 0
]);
```

Ensuite, il renvoie vers la liste.

```php
header('Location: lemonades.php');
exit;
```

Ce n’est pas une architecture complète.

C’est un bureau simple.

Il y a des fichiers.

Il y a des formulaires.

Il y a des requêtes.

Il y a des redirections.

Le commerce peut maintenant être modifié sans ouvrir le code.

Le site cesse d’être seulement une vitrine.

Il devient un outil de gestion.

Mais cette administration est encore très simple.

Chaque fichier fait un peu tout lui-même.

Il se connecte à la base.

Il lit ou écrit des données.

Il affiche du HTML.

Il redirige parfois vers un autre fichier.

Ce n’est pas encore le problème le plus urgent.

La douleur du moment est donc immédiate.

Un bureau qui permet de changer les prix et les stocks ne peut pas rester ouvert à tout le monde.

---

### 11. La clé du bureau — accès privé

Avant que le petit bureau puisse être utilisé pour de vrai, il faut lui ajouter une clé.

La carte publique peut être vue par tous.

L’administration, non.

Si quelqu’un trouve l’adresse d’un fichier dans le dossier `admin`, il ne doit pas pouvoir changer les prix, vider les stocks ou supprimer une limonade.

Le système doit donc distinguer deux états :

visiteur inconnu,

personne connectée.

On ajoute une page de connexion :

```text
login.php
logout.php
admin/index.php
```

Et une table pour les utilisateurs :

```text
user
- id
- email
- password_hash
```

Le mot de passe n’est pas gardé tel quel.

On garde une empreinte.

Quand une personne tente de se connecter, le serveur cherche l’utilisateur par email, puis vérifie le mot de passe reçu avec l’empreinte enregistrée.

Si la connexion réussit, son identité est gardée en session :

```php
$_SESSION['user_id'] = $user['id'];
```

La session devient la petite clé du bureau.

Elle ne dit pas encore ce que la personne a le droit de faire en détail.

Elle dit seulement :

cette personne est entrée.

Dans les fichiers d’administration, on vérifie donc cette clé.

```php
<?php

session_start();

if (!isset($_SESSION['user_id'])) {
    header('Location: ../login.php');
    exit;
}

?>
```

On peut placer cette vérification au début de chaque fichier sensible :

```text
admin/lemonades.php
admin/lemonade-create.php
admin/lemonade-edit.php
admin/lemonade-delete.php
```

Pour l’instant, cette répétition est acceptable.

Elle n’est pas très propre.

Mais elle trace une première frontière.

Dehors.

Dedans.

Une partie du site devient privée.

Le système ne sait pas encore gérer des rôles différents.

Il ne sait pas encore dire :

toi, tu peux modifier les produits,

toi, tu peux seulement voir les commandes,

toi, tu peux gérer les employés.

Pour l’instant, il sait seulement distinguer visiteur inconnu et personne connectée.

C’est suffisant tant qu’une seule personne gère tout.

Mais pendant que le commerce gagne en autonomie, le code commence à s’encombrer.

---

### 12. L’atelier encombré — première séparation

Le site fonctionne.

Il affiche les limonades.

Il lit la base de données.

Il traite les formulaires.

Il protège l’administration.

Il écrit les changements.

Il génère le HTML.

Vu depuis la rue, tout semble correct.

Mais dans l’atelier, les outils traînent partout.

Le désordre a maintenant une forme précise.

Dans `index.php`, on trouve la connexion à la base, la requête SQL, la boucle PHP et le HTML de la carte.

Dans `admin/lemonades.php`, on retrouve une autre connexion, une autre requête, un autre affichage.

Dans `admin/lemonade-create.php`, on lit un formulaire, on valide quelques champs, on écrit un `INSERT`, puis on redirige.

Dans `admin/lemonade-edit.php`, on récupère un `id`, on charge une limonade, on affiche un formulaire, puis on écrit un `UPDATE`.

Dans `admin/lemonade-delete.php`, on récupère aussi un `id`, puis on supprime.

Dans plusieurs fichiers, on répète :

```php
session_start();

if (!isset($_SESSION['user_id'])) {
    header('Location: ../login.php');
    exit;
}
```

Le site marche.

Mais l’atelier commence à s’encombrer.

La même connexion à la base apparaît à plusieurs endroits.

Les requêtes SQL sont dispersées.

Les formulaires et les traitements vivent dans les mêmes fichiers.

Les redirections sont écrites à la main.

Le HTML est mélangé avec les décisions.

Changer une information simple oblige à se souvenir de plusieurs endroits.

Ajouter un champ à une limonade ne veut plus dire modifier un seul fichier.

Il faut penser à la page publique, à la liste d’administration, au formulaire d’ajout, au formulaire de modification, à l’insertion, à la mise à jour.

Le problème n’est pas que le site ne marche pas.

Le problème est qu’il devient difficile à modifier proprement.

On ne reconstruit pas tout.

On commence par ranger.

On sort les informations communes.

```text
config.php
```

On y met ce qui ne doit pas être répété partout :

```php
<?php

define('DB_HOST', 'localhost');
define('DB_NAME', 'le_stand_citronne');
define('DB_USER', 'root');
define('DB_PASS', '');

?>
```

On crée un fichier pour la connexion à la base :

```text
database.php
```

```php
<?php

require_once 'config.php';

$pdo = new PDO(
    'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8',
    DB_USER,
    DB_PASS
);

?>
```

On regroupe quelques fonctions communes :

```text
functions.php
```

On sort les morceaux d’interface qui reviennent souvent :

```text
partials/header.php
partials/footer.php
```

Une page peut alors commencer plus simplement :

```php
<?php

require_once 'database.php';
require_once 'functions.php';

?>
```

Et afficher les mêmes morceaux d’en-tête ou de pied de page sans les recopier partout.

```php
<?php require 'partials/header.php'; ?>

<!-- contenu de la page -->

<?php require 'partials/footer.php'; ?>
```

Ce rangement ne rend pas automatiquement le code parfait.

Il ne crée pas encore une vraie architecture.

Il ne décide pas encore où tout doit vivre.

Mais il rend le système moins confus.

La connexion n’est plus recopiée partout.

Certains morceaux communs ont un lieu.

Le projet devient un peu plus respirable.

À partir de là, une question devient centrale :

où doit vivre chaque responsabilité ?

---

### 13. Le responsable du registre — modèle

Les requêtes SQL se répètent.

Une page récupère toutes les limonades disponibles.

Une autre récupère toutes les limonades pour l’administration.

Une autre récupère une seule limonade pour la modifier.

Une autre crée une nouvelle limonade.

Une autre la met à jour.

Une autre la supprime.

Si chaque fichier parle directement à la base de données, la logique des données se disperse partout.

C’est comme si chaque employé écrivait dans le registre à sa manière.

L’un change les prix.

L’autre oublie le stock.

Un troisième utilise une condition différente pour la disponibilité.

Un quatrième écrit le nom des colonnes autrement.

Le registre existe, mais la manière de lui parler devient désordonnée.

On crée donc un endroit dédié à cette relation.

Cet endroit, c’est le modèle.

```text
models/lemonade.php
```

Au lieu de laisser chaque fichier écrire sa propre requête, on commence à regrouper les opérations liées aux limonades.

```php
<?php

function lemonade_get_all(PDO $pdo): array
{
    $sql = '
        SELECT id, name, description, price, stock, is_available
        FROM lemonade
        ORDER BY name
    ';

    $stmt = $pdo->query($sql);

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function lemonade_get_available(PDO $pdo): array
{
    $sql = '
        SELECT id, name, description, price
        FROM lemonade
        WHERE is_available = 1
        ORDER BY name
    ';

    $stmt = $pdo->query($sql);

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function lemonade_get_one(PDO $pdo, int $id): ?array
{
    $sql = '
        SELECT id, name, description, price, stock, is_available
        FROM lemonade
        WHERE id = ?
    ';

    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);

    $lemonade = $stmt->fetch(PDO::FETCH_ASSOC);

    return $lemonade ?: null;
}
```

On peut ajouter les gestes d’écriture au même endroit :

```php
function lemonade_create(PDO $pdo, array $data): void
{
    $sql = '
        INSERT INTO lemonade (name, description, price, stock, is_available)
        VALUES (?, ?, ?, ?, ?)
    ';

    $stmt = $pdo->prepare($sql);

    $stmt->execute([
        $data['name'],
        $data['description'],
        $data['price'],
        $data['stock'],
        $data['is_available'] ? 1 : 0
    ]);
}
```

Puis une page peut demander :

```php
$lemonades = lemonade_get_available($pdo);
```

Sans connaître la requête SQL précise.

Une autre peut demander :

```php
$lemonade = lemonade_get_one($pdo, $id);
```

Sans réécrire la condition.

Le modèle devient le responsable du registre.

Il ne décide pas quelle page afficher.

Il ne dessine pas les cartes.

Il ne choisit pas l’adresse.

Il protège une frontière : la base de données ne doit pas être appelée depuis partout.

Ce qui était d’abord écrit directement dans `index.php`, puis recopié dans les fichiers d’administration, devient une responsabilité séparée.

Le modèle n’apparaît donc pas parce que “c’est comme ça qu’on fait”.

Il apparaît parce que les requêtes directes ont commencé à se répéter et à diverger.

Les faits du commerce ont maintenant un lieu technique plus clair.

Mais une autre confusion reste présente : les décisions sont encore souvent mélangées avec l’affichage.

---

### 14. La vitrine propre — vue

Les données sont mieux rangées.

Mais l’affichage reste parfois collé aux traitements.

Quand on veut changer la forme d’une carte, on tombe sur du code qui charge les limonades.

Quand on veut modifier un titre, on traverse des conditions, des messages d’erreur et des redirections.

Quand on veut refaire le formulaire d’édition, on tombe sur le traitement du `POST`.

Ce n’est pas impossible.

Mais ce n’est pas propre.

Dans le monde du stand, cela reviendrait à devoir entrer dans le bureau, ouvrir le registre et vérifier la caisse simplement pour déplacer une affiche sur la vitrine.

La vitrine doit avoir son propre rôle.

Elle présente.

Elle ne décide pas.

Elle ne parle pas directement à la base.

Elle reçoit ce qu’on lui donne et l’affiche.

On ajoute donc des vues.

```text
views/lemonade/list.php
views/lemonade/card.php
views/admin/lemonade-form.php
```

La page qui prépare les données peut encore rester simple.

Par exemple, `menu.php` peut charger la base, appeler le modèle, puis donner les limonades à une vue.

```php
<?php

require_once 'database.php';
require_once 'models/lemonade.php';

$lemonades = lemonade_get_available($pdo);

require 'views/lemonade/list.php';

?>
```

Dans la vue, on affiche.

```php
<section class="menu">
  <?php foreach ($lemonades as $lemonade): ?>
    <?php require 'views/lemonade/card.php'; ?>
  <?php endforeach; ?>
</section>
```

Puis, dans `views/lemonade/card.php` :

```php
<article class="juice-card">
  <h2><?= htmlspecialchars($lemonade['name']) ?></h2>
  <p><?= htmlspecialchars($lemonade['description']) ?></p>
  <p><?= htmlspecialchars($lemonade['price']) ?> €</p>
</article>
```

La séparation devient plus claire.

Le modèle récupère ou modifie les données.

La vue présente les données.

La page qui les relie reste encore assez simple.

Elle dit :

j’ai besoin des limonades disponibles,

puis elle appelle l’affichage de la carte.

On peut faire la même chose dans l’administration.

Au lieu de mélanger le formulaire avec tout le traitement, on place le HTML du formulaire dans une vue :

```text
views/admin/lemonade-form.php
```

Le fichier d’ajout prépare les valeurs vides.

Le fichier de modification prépare les valeurs existantes.

La vue affiche le formulaire dans les deux cas.

Cela évite de recopier le même formulaire partout.

La vitrine devient plus propre.

Le bureau aussi.

Mais le site a maintenant beaucoup de portes.

Certaines sont publiques.

Certaines sont privées.

Certaines affichent.

Certaines enregistrent.

Certaines suppriment.

Et pour l’instant, ces portes ressemblent encore beaucoup aux fichiers du projet.

---

### 15. Le plan des portes — routes

Le site n’est plus une seule page.

Il y a maintenant une page d’accueil, une carte, une administration, une création de limonade, une modification, une suppression.

Au début, tout cela vivait dans des fichiers séparés :

```text
index.php
menu.php
admin/lemonades.php
admin/lemonade-create.php
admin/lemonade-edit.php?id=3
admin/lemonade-delete.php?id=3
```

Cela fonctionne.

Mais plus le site grandit, plus ces adresses ressemblent à l’organisation interne du code plutôt qu’à des portes pensées pour le visiteur ou pour le propriétaire.

L’adresse dit parfois le nom du fichier.

Parfois le geste.

Parfois un paramètre.

Parfois l’emplacement dans un dossier.

Le système commence à confondre deux choses :

où le fichier vit dans le projet,

et quelle intention l’utilisateur exprime.

Une URL devrait être une porte.

Pas forcément le nom d’un fichier.

Le visiteur ne devrait pas avoir besoin de connaître `menu.php`.

Le propriétaire ne devrait pas manipuler une adresse comme :

```text
admin/lemonade-edit.php?id=3
```

On aimerait pouvoir dire plus clairement :

```text
/menu
/admin/lemonades
/admin/lemonades/create
/admin/lemonades/3/edit
```

Ces adresses décrivent mieux l’intention.

Elles ne montrent pas forcément les fichiers derrière.

On ajoute donc un plan des portes.

Une route associe une adresse claire à une action.

```text
/                         → accueil
/menu                     → afficher la carte
/admin/lemonades          → afficher les limonades à gérer
/admin/lemonades/create   → ajouter une limonade
/admin/lemonades/3/edit   → modifier la limonade 3
```

Techniquement, on peut commencer avec un fichier qui reçoit les demandes et regarde le chemin demandé.

```php
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

if ($path === '/') {
    require 'pages/home.php';
} elseif ($path === '/menu') {
    require 'pages/menu.php';
} elseif ($path === '/admin/lemonades') {
    require 'pages/admin/lemonades.php';
} else {
    http_response_code(404);
    echo 'Page introuvable';
}
```

Plus tard, une nouvelle intention pourra créer une nouvelle porte.

Pour l’instant, personne n’a encore demandé à parler au site.

Il n’y a donc pas encore de route `/contact`.

Ce n’est pas encore parfait.

Mais une frontière importante vient d’apparaître.

L’adresse publique n’est plus obligée d’être le nom exact d’un fichier.

Le routing ne prépare pas les limonades.

Il ne lit pas directement la base.

Il ne dessine pas la page.

Il reconnaît la porte utilisée et envoie la demande vers l’action correspondante.

Pour l’instant, cette action peut encore être un fichier appelé par le routeur.

Ce n’est pas encore un contrôleur complet.

Mais le système a gagné quelque chose.

Il peut maintenant dire :

l’utilisateur demande `/menu`,

donc il veut voir la carte.

Il ne dit plus seulement :

l’utilisateur demande `menu.php`.

Une route traduit une adresse en intention.

Mais il faut encore organiser ce qui se passe après l’entrée.

Car une route dit quelle porte a été utilisée.

Elle ne suffit pas à organiser tout le travail derrière le comptoir.

---

### 16. Le comptoir — contrôleur

Les routes ont clarifié les portes.

Mais derrière chaque porte, le travail grandit.

Quand quelqu’un demande `/menu`, il faut récupérer les produits disponibles, préparer les données, puis appeler la vue de la carte.

Quand quelqu’un demande `/admin/lemonades`, il faut vérifier la session, récupérer les limonades, puis afficher l’interface.

Quand quelqu’un envoie le formulaire d’ajout, il faut lire les champs, valider, enregistrer, rediriger.

Quand quelqu’un demande une modification, il faut récupérer l’identifiant, charger la bonne limonade, vérifier qu’elle existe, afficher le formulaire, puis enregistrer les changements si le formulaire est envoyé.

Au début, ces actions peuvent vivre dans les fichiers appelés par le routeur.

Mais très vite, elles prennent trop de place.

Les routes ont clarifié les portes.

Mais derrière chaque porte, les fichiers appelés continuent à grossir.

`pages/menu.php` charge les limonades, prépare les données et appelle l’affichage.

`admin/lemonade-create.php` vérifie la session, lit le formulaire, valide les champs, appelle le modèle, redirige ou affiche le formulaire.

`admin/lemonade-edit.php` récupère un identifiant, charge une limonade, vérifie qu’elle existe, traite parfois un `POST`, affiche parfois une vue.

Le désordre n’est plus seulement dans les adresses.

Il est dans les actions derrière les adresses.

Une route ne devrait pas devenir le bureau entier.

Elle doit seulement reconnaître la porte utilisée.

Il manque le comptoir : l’endroit où la demande arrive, où l’on comprend ce qu’il faut faire, puis où l’on envoie chaque tâche au bon endroit.

On crée donc des contrôleurs.

```text
controllers/HomeController.php
controllers/LemonadeController.php
controllers/AdminLemonadeController.php
```

Un contrôleur reçoit une demande, appelle les bons modèles, puis transmet les données aux bonnes vues.

Par exemple, pour afficher la carte :

```php
function menu(PDO $pdo)
{
    $lemonades = lemonade_get_available($pdo);

    require 'views/lemonade/list.php';
}
```

Pour afficher l’administration :

```php
function admin_lemonades(PDO $pdo)
{
    require_login();

    $lemonades = lemonade_get_all($pdo);

    require 'views/admin/lemonades.php';
}
```

Pour créer une limonade :

```php
function admin_lemonade_create(PDO $pdo)
{
    require_login();

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $data = [
            'name' => $_POST['name'] ?? '',
            'description' => $_POST['description'] ?? '',
            'price' => $_POST['price'] ?? '',
            'stock' => $_POST['stock'] ?? 0,
            'is_available' => isset($_POST['is_available'])
        ];

        lemonade_create($pdo, $data);

        header('Location: /admin/lemonades');
        exit;
    }

    require 'views/admin/lemonade-form.php';
}
```

La route peut alors devenir plus légère.

Elle n’a plus besoin de contenir toute la logique.

Elle reconnaît l’adresse, puis appelle le bon comptoir.

```php
if ($path === '/menu') {
    menu($pdo);
} elseif ($path === '/admin/lemonades') {
    admin_lemonades($pdo);
} elseif ($path === '/admin/lemonades/create') {
    admin_lemonade_create($pdo);
}
```

La séparation devient plus stable :

```text
la route reconnaît la porte
le contrôleur organise la demande
le modèle lit ou modifie les données
la vue affiche
```

Le contrôleur ne remplace pas le modèle.

Il ne doit pas écrire toutes les requêtes SQL.

Le contrôleur ne remplace pas la vue.

Il ne doit pas contenir tout le HTML.

Il orchestre.

Il reçoit une demande complète et décide quelles parties du système doivent travailler.

Dans le monde du stand, la route est la porte utilisée.

Le contrôleur est le comptoir.

Le modèle est le registre.

La vue est la vitrine.

Le système n’est pas devenu plus complexe par goût de l’architecture.

Il s’est organisé parce que les responsabilités commençaient à se gêner.

À ce stade, le site est une vraie petite application.

Mais le commerce, lui, continue de grandir.

---

## Partie III — La boutique devient un vrai magasin

### 17. Plus seulement de la limonade — produits

Le Stand Citronné vend encore de la limonade.

Mais il ne vend plus seulement ça.

Un jour, le propriétaire pose quelques bouteilles de sirop de citron sur la table.

Puis des petits cakes.

Puis des packs famille.

Puis, parfois, des citrons frais de sa propre cagette.

La table `lemonade` devient trop étroite.

Elle a bien servi tant que le monde du commerce contenait une seule sorte de chose.

Mais maintenant, le système ne doit plus comprendre seulement des limonades.

Il doit comprendre une offre.

On remplace donc l’idée spécifique par une idée plus générale :

```text
product
- id
- name
- description
- price
- stock
- is_available
```

Exemples :

```text
Limonade classique
Sirop de citron
Cake citron
Pack famille
Citrons frais
```

Une limonade devient un produit parmi d’autres.

Ce changement n’est pas seulement un renommage.

C’est une transformation du modèle mental du système.

Avant, le site disait :

je gère des limonades.

Maintenant, il dit :

je gère des produits.

À ce stade, on ne cherche pas encore à classer finement.

On élargit seulement le mot principal du système.

Avant, il disait : limonade.

Maintenant, il dit : produit.

La question du rangement viendra quand la liste deviendra difficile à parcourir.

Cette généralisation ouvre de nouvelles possibilités.

Mais plus il y a de produits, plus il devient difficile de les retrouver.

Une vitrine pleine sans organisation devient vite une caisse de vrac.

---

### 18. Les rayons et les étiquettes — catégories et tags

La carte grossit.

Les visiteurs ne veulent plus seulement tout voir.

Ils veulent trouver.

Certains cherchent les boissons.

D’autres les gâteaux.

D’autres veulent savoir ce qui est sans sucre, ce qui est frais, ce qui est nouveau, ce qui convient à une famille.

Afficher tous les produits en une longue liste ne suffit plus.

Il faut organiser l’offre.

On ajoute d’abord des catégories.

Une catégorie ressemble à un rayon.

Un produit appartient à un rayon principal :

```text
category
- id
- name
- slug
```

Puis chaque produit peut être relié à une catégorie :

```text
product.category_id
```

Mais certaines informations ne sont pas des rayons.

“Sans sucre” n’est pas forcément une catégorie principale.

“Nouveauté” non plus.

“Famille” peut concerner une boisson, un pack ou un gâteau.

Pour ces informations plus souples, on ajoute des tags.

Un tag ressemble à une étiquette.

```text
tag
- id
- name
- slug
```

Comme un produit peut avoir plusieurs tags, et qu’un tag peut appartenir à plusieurs produits, il faut une table de liaison :

```text
product_tag
- product_id
- tag_id
```

Exemples de tags :

```text
sans sucre
frais
famille
nouveauté
édition limitée
```

On évite de mettre “disponible aujourd’hui” dans les tags.

Ce n’est pas une étiquette.

C’est un état.

Il doit venir du stock et de la disponibilité, pas d’une classification saisie à la main.

La classification n’est pas décorative.

Elle permet au visiteur de chercher, filtrer et comprendre.

Le système ne se contente plus d’afficher l’offre.

Il aide à s’orienter dans l’offre.

Mais le visiteur ne veut pas toujours seulement lire.

Parfois, il veut répondre.

---

### 19. Le visiteur prend la parole — formulaires publics

Jusqu’ici, le site parlait surtout dans un sens.

Il annonçait.

Il affichait.

Il présentait.

Il organisait.

Le visiteur regardait.

Mais un jour, quelqu’un veut poser une question.

Un autre veut réserver dix bouteilles pour samedi.

Un autre demande s’il est possible de préparer une limonade sans sucre.

Le site doit maintenant recevoir.

Une nouvelle porte apparaît donc :

```text
/contact
```

Avec un formulaire :

```html
<form method="POST" action="/contact">
  <input name="name" placeholder="Votre nom">
  <input name="email" placeholder="Votre email">
  <textarea name="message" placeholder="Votre message"></textarea>
  <button>Envoyer</button>
</form>
```

Le formulaire est une prise de parole.

Mais une parole reçue par un site ne doit jamais être acceptée sans vérification.

C’était déjà vrai dans l’administration.

Cela devient encore plus important ici, parce que l’entrée vient maintenant de n’importe quel visiteur.

Côté serveur, on lit les champs :

```php
$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$message = $_POST['message'] ?? '';
```

Puis on vérifie :

le nom est-il rempli ?

l’email a-t-il un format valide ?

le message existe-t-il ?

le contenu est-il acceptable ?

que fait-on si une information manque ?

Ensuite, le système peut envoyer un email, enregistrer une demande ou créer une entrée dans une table.

La page devient un échange.

Mais choisir un produit n’est pas encore commander.

Entre “ça m’intéresse” et “je confirme”, il manque un état intermédiaire.

---

### 20. Le panier — intention provisoire

Un visiteur ne veut pas toujours commander un seul produit.

Il ajoute une limonade.

Puis il hésite.

Il ajoute un cake.

Il retire le sirop.

Il change une quantité.

Il revient à la carte.

Il confirme plus tard.

Ce comportement ne correspond pas à une page fixe.

Il correspond à une intention en cours.

Le panier représente cette intention.

Il n’est pas encore une commande.

Il peut changer.

Il peut être vidé.

Il peut être abandonné.

Il peut disparaître si le visiteur ne revient pas.

Avec une session côté serveur, on peut mémoriser temporairement le panier :

```php
$_SESSION['cart'] = [
  [
    'product_id' => 3,
    'quantity' => 2
  ],
  [
    'product_id' => 7,
    'quantity' => 1
  ]
];
```

On ajoute des actions :

ajouter au panier,

retirer du panier,

modifier la quantité,

vider le panier.

Le panier est utile parce qu’il garde une décision qui n’est pas encore définitive.

Il appartient au moment de l’hésitation.

Mais quand le visiteur confirme, l’intention change de nature.

Elle doit devenir une trace durable.

---

### 21. Le bon de commande — état persistant

Le panier était provisoire.

La commande doit rester.

Quand le visiteur confirme, le stand doit savoir quoi préparer, pour qui, à quel prix, et à quel moment.

Une sélection gardée en session ne suffit plus.

Il faut écrire une trace durable dans le registre.

Mais le serveur ne doit pas simplement copier le panier.

Avant d’enregistrer la commande, il relit les produits.

Il vérifie les vrais prix.

Il vérifie la disponibilité.

Il vérifie le stock.

Le navigateur peut afficher une intention.

La session peut garder une hésitation.

Mais la confirmation appartient au serveur.

Dans cette première version simple, confirmer une commande décrémente les quantités disponibles.

Si la quantité demandée n’est plus disponible, la commande n’est pas enregistrée telle quelle. Le visiteur doit corriger son panier.

Si le stock suffit, le système écrit une commande.

On crée donc des tables de commande.

La commande elle-même :

```text
orders
- id
- customer_name
- customer_email
- total_price
- created_at
```

Puis les lignes de commande :

```text
order_item
- id
- order_id
- product_id
- quantity
- unit_price
```

Quand le visiteur confirme, le système écrit :

une commande,

plusieurs lignes de commande,

puis décrémente les quantités concernées.

Le prix unitaire est gardé dans la ligne de commande, même si le prix du produit change plus tard.

C’est important.

Si une limonade coûte 2 € aujourd’hui et 2,50 € demain, la commande d’aujourd’hui doit garder le prix d’aujourd’hui.

Le panier disait :

le visiteur pense acheter ceci.

La commande dit :

le visiteur a confirmé ceci.

Le site ne présente plus seulement l’offre.

Il enregistre une transaction.

Pour l’instant, cette transaction est seulement une trace durable.

Le propriétaire peut encore la lire et la traiter à la main.

Mais si les commandes deviennent nombreuses, une simple trace ne suffira plus.

Il faudra savoir où chaque commande en est.

Pas encore.

---

## Partie IV — Le système grandit

### 22. La vitrine qui répond — interactions avancées

Le site marche.

Mais certaines actions sont lourdes.

Quand le visiteur filtre les produits, toute la page recharge.

Quand il change une quantité, tout revient du serveur.

Quand il ajoute un produit, il aimerait voir le panier se mettre à jour tout de suite.

Le site fonctionne, mais il répond lentement à des gestes simples.

Jusqu’ici, JavaScript avait seulement été envisagé.

Au moment du gabarit, il aurait pu fabriquer des cartes depuis une liste. Mais cette solution avait été écartée, parce qu’elle ne résolvait pas le bon problème. Elle déplaçait les données dans un autre fichier de code, sans donner au commerce une vraie mémoire modifiable.

Cette fois, la contrainte est différente.

Il ne s’agit plus de décider où vivent les données.

Il s’agit de répondre aux gestes du visiteur pendant que la page est déjà ouverte.

C’est là que JavaScript arrive vraiment.

PHP s’exécute sur le serveur.

JavaScript s’exécute dans le navigateur.

Le navigateur ne voit jamais le PHP. Il reçoit le résultat du PHP : du HTML, du CSS, parfois du JavaScript.

Le serveur, lui, ne voit pas directement ce qui se passe dans la page à chaque instant. Il ne le sait que si le navigateur lui envoie une demande.

Cette frontière est importante.

JavaScript peut réagir tout de suite à ce qui se passe dans la page :

ouvrir ou fermer un panneau,

filtrer une liste déjà chargée,

mettre à jour un total affiché,

changer une quantité,

afficher une confirmation,

signaler qu’un produit a été ajouté.

Exemple :

```js
button.addEventListener('click', function () {
  cartCount.textContent = Number(cartCount.textContent) + 1;
});
```

La page répond mieux aux gestes du visiteur.

Elle semble moins figée.

Elle donne moins souvent l’impression de repartir de zéro.

Mais il faut garder une frontière claire.

Le navigateur peut améliorer l’expérience.

Il ne doit pas devenir la source de vérité.

Il peut afficher plus vite.

Il peut rendre l’interface plus fluide.

Mais il ne peut pas décider seul du vrai stock, du vrai prix ou de la vraie disponibilité.

Pour cela, il doit parler au serveur.

Même pendant que la page reste ouverte.

---

### 23. Le messager — fetch et API

Le navigateur a parfois besoin de demander quelque chose au serveur sans recharger toute la page.

Ajouter au panier.

Vérifier un stock.

Filtrer les produits disponibles.

Mettre à jour une quantité.

Ces actions ne nécessitent pas toujours de renvoyer une page complète.

Le navigateur peut envoyer un messager.

En technique, ce messager est souvent une requête `fetch`.

Le serveur répond avec des données, souvent au format JSON.

On ajoute des routes API :

```text
/api/products
/api/cart/add
/api/cart/update
/api/stock/check
```

JavaScript envoie une demande :

```js
fetch('/api/cart/add', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    product_id: 3,
    quantity: 1
  })
});
```

Le serveur répond :

```json
{
  "success": true,
  "cart_count": 4,
  "total": 18.5
}
```

La page reste ouverte.

Le visiteur ne voit pas tout le trajet.

Il voit seulement que le panier se met à jour.

Mais dans le système, les rôles sont clairs :

le navigateur envoie une demande,

le serveur vérifie les règles,

la base garde les faits,

le serveur renvoie une réponse,

la page se met à jour.

Le navigateur devient plus actif.

Mais le serveur reste responsable des vraies règles : stock, prix, disponibilité, sécurité.

À ce stade, le système est utile pour le client et pour les visiteurs.

Puis le nombre de personnes qui agissent dedans augmente.

---

### 24. Les badges — rôles et permissions

Jusqu’ici, une seule personne possédait la clé du bureau : le propriétaire.

Dans ce monde simple, être connecté suffisait.

Il n’y avait pas encore de différence à faire entre voir, modifier, supprimer ou préparer.

Une seule personne faisait tout.

Cette simplification tient tant que le système n’a qu’un seul acteur interne.

Puis Le Stand Citronné n’est plus géré par une seule personne.

Une personne prépare les commandes.

Une autre modifie les produits.

Une autre regarde les ventes.

Une autre aide seulement dans une boutique.

Une autre ne doit jamais pouvoir supprimer un produit.

La question n’est plus seulement :

cette personne est-elle connectée ?

Elle devient :

qu’a-t-elle le droit de faire ?

La connexion donne une identité.

Le rôle donne une autorisation.

On ajoute des rôles :

```text
role
- id
- name
```

Puis on relie chaque utilisateur à un rôle :

```text
user.role_id
```

Exemples :

```text
admin
manager
employee
viewer
```

Certaines actions deviennent protégées :

```php
if ($user['role'] !== 'admin') {
    deny_access();
}
```

Le système ne protège plus seulement des pages.

Il protège des actions.

Voir une commande n’est pas la même chose que l’annuler.

Modifier un stock n’est pas la même chose que supprimer un produit.

Lire les ventes n’est pas la même chose que gérer les employés.

Dans le monde du stand, tout le monde peut entrer dans la boutique.

Mais tout le monde n’a pas le même badge.

Et tous les badges n’ouvrent pas les mêmes portes.

C’est suffisant tant que tout se passe au même endroit.

Mais le commerce commence à exister dans plusieurs lieux.

---

### 25. Plusieurs boutiques — lieux et relations

Le stand initial n’est plus seul.

Il y a une première boutique.

Puis une deuxième.

Bientôt une troisième.

Chaque lieu a ses horaires, ses stocks, ses employés, ses commandes.

Le système ne peut plus supposer qu’un produit disponible quelque part est disponible partout.

Le champ `product.stock` ne suffit plus.

Tant qu’il y avait un seul lieu, il pouvait représenter le stock du stand.

Avec plusieurs boutiques, il devient ambigu.

Stock de quelle boutique ?

Stock total ?

Stock disponible pour le client ?

Stock réservé ?

Le produit garde son identité.

Le stock, lui, devient une relation entre un produit et un lieu.

Une limonade menthe peut être disponible rue des Tilleuls et épuisée près de la gare.

Un employé peut travailler dans une boutique mais pas dans l’autre.

Une commande peut être préparée dans un lieu précis.

On ajoute les lieux :

```text
store
- id
- name
- address
- opening_hours
```

Puis les stocks par lieu :

```text
stock
- store_id
- product_id
- quantity
```

Dans cette nouvelle forme, `product.stock` disparaît ou devient une valeur calculée.

Le vrai stock n’est plus une propriété simple du produit.

Il vit dans la relation entre le produit et le magasin.

Les commandes doivent être reliées à un lieu :

```text
orders.store_id
```

Les employés aussi :

```text
employee_store
- employee_id
- store_id
```

Le système peut maintenant répondre à des questions plus précises :

quel stock reste-t-il dans cette boutique ?

quelles commandes sont à préparer ici ?

qui travaille dans ce lieu aujourd’hui ?

quel produit est disponible dans quel magasin ?

quelle boutique doit recevoir plus de citrons ?

À ce stade, les relations deviennent aussi importantes que les objets.

Le produit seul ne suffit plus.

La commande seule ne suffit plus.

Le lieu, le stock, l’employé et le moment font partie de la réponse.

Le système ne décrit plus seulement ce qui existe.

Il décrit où cela existe, pour qui, et dans quel état.

Mais suivre des objets ne suffit pas encore.

Il faut suivre leur progression.

---

### 26. La chaîne de préparation — workflows

Jusqu’ici, une commande enregistrée était une trace durable.

Elle disait :

quelqu’un a confirmé ceci.

Mais elle ne racontait pas encore son avancement.

Quand les commandes étaient rares, le propriétaire pouvait les suivre à la main.

Puis les commandes arrivent plus nombreuses.

Certaines viennent d’être reçues.

Certaines sont validées.

Certaines sont en préparation.

Certaines sont prêtes.

Certaines ont été livrées.

Certaines sont annulées.

Le client ne veut plus seulement voir les commandes.

Il veut savoir où elles en sont.

L’employé ne veut pas seulement lire une liste.

Il veut savoir quoi faire maintenant.

Le système doit donc suivre des états.

On ajoute donc un état à la commande :

```text
orders.status
```

Cet état peut prendre plusieurs valeurs :

```text
received
validated
preparing
ready
delivered
cancelled
```

Mais si le suivi devient important, l’état actuel ne suffit plus.

Il faut aussi savoir ce qui s’est passé avant.

Qui a validé la commande ?

Quand est-elle passée en préparation ?

Pourquoi a-t-elle été annulée ?

On ajoute alors un historique :

```text
order_status_history
- id
- order_id
- old_status
- new_status
- changed_by
- changed_at
```

Une commande peut traverser une séquence :

```text
reçue
→ validée
→ en préparation
→ prête
→ livrée
```

Le système ne stocke plus seulement des choses.

Il suit des transformations.

Une commande n’est plus seulement une ligne dans une table.

C’est un objet qui avance dans le temps.

À ce stade, le site est devenu un outil de pilotage.

Il ne sert plus seulement à montrer le commerce.

Il aide le commerce à se tenir.

---

## Conclusion — L’ordre des contraintes

Des années ont passé depuis la première limonade.

La petite table du début n’est plus seule au coin de la rue. Le Stand Citronné a plusieurs lieux, des employés, des produits, des stocks, des commandes, des rôles, des historiques et des workflows.

Pourtant, rien n’est apparu d’un seul coup.

Rien n’a été ajouté parce que “ça se fait”.

Chaque morceau est arrivé le jour où ne pas l’ajouter coûtait plus cher que l’ajouter.

C’est la seule règle.

Tout le reste découle d’elle.

Tant qu’il faut seulement écrire une information lisible, HTML suffit.

Quand cette information doit être trouvée par d’autres, la page reçoit une adresse.

Quand être lisible ne donne plus envie de s’arrêter, CSS apparaît.

Tant qu’écrire trois cartes à la main reste indolore, on les écrit à la main.

Quand la répétition révèle une forme stable, le motif apparaît.

Quand seules les valeurs changent, le gabarit devient pensable.

Mais tant que ces valeurs changent encore rarement, elles peuvent rester dans le code.

Quand la vie du commerce change sans attendre le développeur, les données sortent du code.

Tant qu’une liste en mémoire suffit, la liste suffit.

Quand les faits doivent durer, la base de données apparaît.

Tant que la page peut être écrite une fois pour toutes, elle l’est.

Quand elle doit refléter une mémoire qui change, PHP apparaît.

Tant que le développeur peut modifier la base, l’administration n’existe pas.

Quand le propriétaire doit agir seul, l’administration apparaît.

Mais dès que l’administration existe, elle doit avoir une porte fermée.

Tant qu’une seule personne possède la clé, l’authentification suffit.

Tant qu’un seul fichier reste lisible, il reste seul.

Quand les responsabilités se gênent, on les sépare — modèles, vues, routes, contrôleurs.

Tant que l’offre tient dans un seul mot, le système parle de limonades.

Quand l’offre déborde, il parle de produits.

Tant qu’une liste plate reste navigable, elle reste plate.

Quand le visiteur ne trouve plus, les catégories et les tags apparaissent.

Tant que le visiteur lit, il n’y a pas de formulaire public.

Quand il veut répondre, le formulaire apparaît.

Tant qu’il commande un seul produit immédiatement, il n’y a pas de panier.

Quand il hésite entre plusieurs, le panier apparaît.

Tant que l’intention reste provisoire, la session suffit.

Quand elle devient un engagement, la commande apparaît.

Quand la commande touche au stock, le serveur vérifie et décrémente ce qui peut l’être.

Tant que recharger la page reste acceptable, JavaScript reste discret.

Quand chaque geste doit répondre tout de suite, JavaScript revient.

Tant que la page peut tout demander en se rechargeant, il n’y a pas d’API.

Quand le navigateur doit dialoguer pendant que la page reste ouverte, l’API apparaît.

Tant qu’une seule personne agit dans le système, l’identité suffit.

Quand plusieurs personnes y agissent, les rôles apparaissent.

Tant qu’il y a un seul lieu, le stock peut vivre avec le produit.

Quand il y a plusieurs lieux, le stock quitte le produit et devient une relation.

Tant qu’une commande est seulement une trace durable, les tables de commande suffisent.

Quand son avancement doit être suivi, le statut apparaît.

Quand son passé doit être compris, l’historique apparaît.

Quand l’activité elle-même doit être pilotée, le workflow apparaît.

À chaque étape, la question n’a pas été :

*que faut-il ajouter ensuite ?*

Elle a été :

*qu’est-ce qui ne tient plus ?*

Tant que rien ne casse, on n’ajoute rien.

Quand quelque chose casse, on ajoute la plus petite chose qui répare.

Ce n’est pas une architecture qu’on déploie.

C’est une réponse qu’on donne, une fois, à une douleur précise.

Le premier jour, le client avait seulement des citrons.

Nous avons demandé une limonade.

Il nous a montré son problème.

Et nous avons répondu :

— Oui, bien sûr, je peux te faire ça.

Rien de plus.

C’est par là que tout commence, et c’est par là que tout continue.
