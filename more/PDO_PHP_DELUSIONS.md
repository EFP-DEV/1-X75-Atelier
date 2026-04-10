# (The only proper) PDO tutorial

Adapté de [PHPDelusions.net](https://phpdelusions.net/pdo), réécrit en français, mis à jour et corrigé.

## Introduction

### Pourquoi PDO ?

PDO fournit une interface cohérente pour accéder à une base de données en PHP, à condition d’utiliser le driver correspondant (`pdo_mysql`, `pdo_pgsql`, `pdo_sqlite`, etc.). Son intérêt principal, en pratique, n’est pas de “masquer totalement” les différences entre moteurs, mais d’offrir une API uniforme, des requêtes préparées et une gestion d’erreurs propre. Certaines capacités restent toutefois dépendantes du driver et de la base utilisée. ([PHP][1])

Pour du code applicatif PHP moderne, PDO reste le bon choix lorsqu’on veut écrire du SQL explicitement. Un ORM peut être utile plus haut dans la pile, mais PDO est la base saine pour tout accès SQL direct.

## Premiers pas

### Connexion avec DSN

Le DSN dépend du driver. Pour MySQL, les éléments usuels sont `host`, `port`, `dbname`, `unix_socket` et `charset`. Avec PDO MySQL, `localhost` passe par le socket Unix, alors que `127.0.0.1` force TCP. Par ailleurs, sur PHP 8+, `PDO::ERRMODE_EXCEPTION` est déjà le mode d’erreur par défaut, mais le définir explicitement reste utile pour rendre le code lisible et prévisible. Enfin, PDO MySQL utilise les requêtes préparées émulées par défaut. ([PHP][2])

```php
<?php

$host = 'localhost';
$db   = 'nom';
$user = 'nom'; 
$pass = 'secret';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

$pdo = new PDO($dsn, $user, $pass, $options);
```

Définir le jeu de caractères dans le DSN est la bonne approche pour MySQL. ([PHP][2])

### Exécuter des requêtes simples avec `PDO::query()`

`PDO::query()` sert aux requêtes sans placeholders. Si la requête contient des variables, il faut passer par `prepare()` puis `execute()`. Si vous réutilisez souvent la même requête, `prepare()` est également préférable. Enfin, si vous n’avez pas consommé tout le jeu de résultats d’un `query()`, il peut être nécessaire d’appeler `closeCursor()` avant une autre requête. ([PHP][3])

```php
$stmt = $pdo->query('SELECT id, name FROM users ORDER BY name');

foreach ($stmt as $row) {
    echo $row['id'] . ' - ' . $row['name'] . PHP_EOL;
}
```

## Sécurité et requêtes préparées

### Requêtes préparées et protection contre les injections SQL

Dès qu’une requête contient des données variables, utilisez des requêtes préparées. PDO accepte soit des placeholders positionnels (`?`), soit des placeholders nommés (`:email`). On ne mélange pas les deux dans une même requête. En outre, un marqueur nommé ne peut pas être réutilisé plusieurs fois dans la même requête, sauf en mode émulé. ([PHP][4])

```php
// Positionnels
$stmt = $pdo->prepare('SELECT * FROM users WHERE email = ? AND status = ?');
$stmt->execute(['alice@example.com', 'active']);
$user = $stmt->fetch();
```

```php
// Nommés
$stmt = $pdo->prepare('SELECT * FROM users WHERE email = :email AND status = :status');
$stmt->execute([
    'email'  => 'alice@example.com',
    'status' => 'active',
]);
$user = $stmt->fetch();
```

Les requêtes préparées protègent les valeurs liées. En revanche, si vous continuez à concaténer des fragments SQL non contrôlés, vous pouvez quand même introduire une injection. ([PHP][4])

### Méthodes de liaison

La méthode la plus simple reste `execute([...])`. C’est celle à privilégier dans la majorité des cas. Quand vous passez un tableau à `execute()`, les valeurs sont traitées comme `PDO::PARAM_STR`. Si vous avez besoin d’un type explicite, utilisez `bindValue()`. Si vous avez besoin d’une liaison par référence, utilisez `bindParam()`. `bindParam()` est aussi la méthode concernée par les paramètres `INOUT/OUT` des procédures stockées. ([PHP][5])

```php
$stmt = $pdo->prepare(
    'SELECT id, name FROM users LIMIT :limit OFFSET :offset'
);

$stmt->bindValue(':limit',  20, PDO::PARAM_INT);
$stmt->bindValue(':offset', 40, PDO::PARAM_INT);
$stmt->execute();

$rows = $stmt->fetchAll();
```

```php
$status = 'active';

$stmt = $pdo->prepare('SELECT * FROM users WHERE status = :status');
$stmt->bindParam(':status', $status, PDO::PARAM_STR);
$stmt->execute();
```

En pratique, `bindValue()` est souvent plus simple et plus sûr à lire, parce qu’il lie une valeur immédiatement, alors que `bindParam()` lie une variable par référence. ([PHP][6])

### Ce que vous pouvez lier

Un placeholder représente un littéral complet. Vous pouvez donc lier une valeur complète, mais pas un morceau de chaîne SQL, ni un mot-clé, ni un identifiant, ni une liste entière pour `IN (...)`. Autrement dit, on ne lie pas directement un nom de table, un nom de colonne, `ASC/DESC`, ou une liste `1,2,3` dans un seul placeholder. ([PHP][4])

Incorrect :

```php
// Faux : on ne peut pas lier un identifiant
$stmt = $pdo->prepare('SELECT * FROM :table');
```

Correct avec liste blanche :

```php
$allowedSort = ['name', 'created_at', 'email'];
$sort = $_GET['sort'] ?? 'name';

if (!in_array($sort, $allowedSort, true)) {
    throw new InvalidArgumentException('Tri invalide');
}

$sql = "SELECT id, name, email FROM users ORDER BY $sort";
$stmt = $pdo->query($sql);
```

La règle est simple : les valeurs se lient, la structure SQL se contrôle par validation stricte ou liste blanche. ([PHP][4])

### Réexécuter une requête préparée

Une requête préparée peut être exécutée plusieurs fois avec des jeux de paramètres différents. C’est l’un des intérêts de `prepare()`: la même requête peut être préparée une fois puis réutilisée, souvent avec un meilleur coût que plusieurs `query()` ou concaténations successives. Ce comportement n’est pas réservé au mode d’émulation désactivé. ([PHP][7])

```php
$stmt = $pdo->prepare('UPDATE users SET bonus = bonus + ? WHERE id = ?');

$stmt->execute([100, 1]);
$stmt->execute([250, 5]);
$stmt->execute([300, 9]);
```

## Opérations de base sur la base de données

### Exécuter `SELECT`, `INSERT`, `UPDATE` ou `DELETE`

Le schéma de base est toujours le même : `prepare()` puis `execute()`. Pour une instruction sans résultat que vous n’exécutez qu’une seule fois et sans variable, `PDO::exec()` peut convenir ; il renvoie le nombre de lignes affectées. En revanche, `exec()` ne renvoie jamais de résultats de `SELECT`. ([PHP][8])

```php
$sql = 'UPDATE users SET name = ? WHERE id = ?';
$pdo->prepare($sql)->execute(['Alice Martin', 42]);
```

```php
$sql = 'INSERT INTO users (name, email) VALUES (?, ?)';
$pdo->prepare($sql)->execute(['Bob', 'bob@example.com']);
```

### Lignes affectées et ID d’insertion

`rowCount()` est fiable pour `DELETE`, `INSERT` et `UPDATE`. En revanche, pour un `SELECT`, son comportement est non portable et ne doit pas être utilisé pour compter des lignes. Pour les identifiants auto-générés, utilisez `lastInsertId()`, en gardant à l’esprit que le résultat dépend du driver ; par exemple, PostgreSQL peut nécessiter le nom d’une séquence. ([PHP][9])

```php
$stmt = $pdo->prepare('DELETE FROM sessions WHERE expires_at < NOW()');
$stmt->execute();
$deleted = $stmt->rowCount();
```

```php
$stmt = $pdo->prepare('INSERT INTO posts (title) VALUES (?)');
$stmt->execute(['Bonjour']);
$postId = $pdo->lastInsertId();
```

### Transactions

PDO démarre en mode auto-commit. Si vous avez plusieurs écritures qui doivent réussir ou échouer ensemble, utilisez `beginTransaction()`, `commit()` et `rollBack()`. `beginTransaction()` lève une exception si une transaction est déjà active ou si le driver ne supporte pas les transactions. PDO ne gère pas des “transactions imbriquées” automatiquement ; si vous avez besoin d’un comportement de ce type, il faut passer par des `SAVEPOINT` là où la base le permet. Certaines bases, notamment MySQL et Oracle, effectuent en plus un `COMMIT` implicite sur des instructions DDL comme `CREATE TABLE` ou `DROP TABLE`. ([PHP][10])

```php
try {
    $pdo->beginTransaction();

    $stmt = $pdo->prepare('INSERT INTO users (name) VALUES (?)');
    $stmt->execute(['Alice']);
    $stmt->execute(['Bob']);

    $pdo->commit();
} catch (Throwable $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    throw $e;
}
```

Si le script se termine alors qu’une transaction démarrée par `PDO::beginTransaction()` est encore ouverte, PDO effectue un rollback automatique. ([PHP][10])

## Récupération de données

### Obtenir des données avec `foreach()`

Itérer directement sur un `PDOStatement` est très pratique :

```php
$stmt = $pdo->query('SELECT id, name FROM users');

foreach ($stmt as $row) {
    echo $row['name'] . PHP_EOL;
}
```

Côté PHP, vous traitez une ligne à la fois. Mais attention : avec MySQL, les requêtes sont bufferisées par défaut, donc tout le résultat peut déjà être chargé côté client avant la boucle. Pour de très gros jeux de résultats, il faut regarder le mode non bufferisé. ([PHP][11])

### Obtenir des données avec `fetch()`

`fetch()` récupère une ligne à la fois. Le mode par défaut est celui de `PDO::ATTR_DEFAULT_FETCH_MODE`, sinon `PDO::FETCH_BOTH`. Les modes les plus utilisés sont `FETCH_ASSOC`, `FETCH_NUM`, `FETCH_BOTH`, `FETCH_OBJ` et `FETCH_CLASS`. Avec `FETCH_CLASS`, les propriétés sont remplies avant l’appel du constructeur, sauf si vous utilisez `PDO::FETCH_PROPS_LATE`. ([PHP][12])

```php
$stmt = $pdo->prepare('SELECT id, name, email FROM users WHERE id = ?');
$stmt->execute([42]);

$row = $stmt->fetch(PDO::FETCH_ASSOC);

if ($row !== false) {
    echo $row['email'];
}
```

```php
class UserRow
{
    public int $id;
    public string $name;
    public string $email;
}

$stmt = $pdo->query('SELECT id, name, email FROM users');
$users = $stmt->fetchAll(PDO::FETCH_CLASS, UserRow::class);
```

### Types retournés

Le type réellement renvoyé par PDO dépend du driver, de la version de PHP et des options actives. `PDO::ATTR_STRINGIFY_FETCHES` force les valeurs récupérées (sauf `null`) à être converties en chaînes. Depuis PHP 8.1, le driver MySQL renvoie les entiers et flottants avec leurs types natifs même lors de requêtes préparées émulées, et SQLite fait de même pour ses résultats numériques. Malgré cela, il reste prudent de ne pas dépendre d’un typage identique sur tous les drivers : quand le type métier compte, convertissez explicitement au bord de votre application. ([PHP][13])

```php
$pdo->setAttribute(PDO::ATTR_STRINGIFY_FETCHES, true);
```

### Obtenir des données avec `fetchColumn()`

`fetchColumn()` renvoie une seule colonne de la ligne suivante, ou `false` s’il n’y a plus de ligne. C’est très pratique pour `COUNT(*)`, `SUM(...)`, ou pour lire une seule valeur. En revanche, ce n’est pas adapté aux colonnes booléennes, car `false` devient ambigu : “valeur booléenne false” ou “plus de ligne”. ([PHP][14])

```php
$stmt = $pdo->prepare('SELECT name FROM users WHERE id = ?');
$stmt->execute([42]);
$name = $stmt->fetchColumn();
```

```php
$count = $pdo->query('SELECT COUNT(*) FROM users')->fetchColumn();
```

### Obtenir des données avec `fetchAll()`

`fetchAll()` renvoie toutes les lignes restantes d’un coup. C’est très pratique, mais coûteux en mémoire sur de gros résultats. En PHP 8+, cette méthode renvoie toujours un tableau ; si aucun enregistrement n’est trouvé, c’est un tableau vide. ([PHP][15])

```php
$data = $pdo->query('SELECT id, name FROM users')->fetchAll(PDO::FETCH_ASSOC);
```

Quelques formats utiles :

```php
// Une seule colonne
$names = $pdo->query('SELECT name FROM users')
             ->fetchAll(PDO::FETCH_COLUMN);
```

`PDO::FETCH_COLUMN` peut aussi viser une autre colonne via le second argument de `fetchAll()`. ([PHP][16])

```php
// Paires clé => valeur, exactement 2 colonnes
$pairs = $pdo->query('SELECT id, name FROM users')
             ->fetchAll(PDO::FETCH_KEY_PAIR);
```

`PDO::FETCH_KEY_PAIR` exige exactement deux colonnes ; si la première n’est pas unique, des valeurs seront perdues. ([PHP][16])

```php
// Regroupement par la première colonne
$grouped = $pdo->query('SELECT role, id, name FROM users')
               ->fetchAll(PDO::FETCH_GROUP | PDO::FETCH_ASSOC);
```

```php
// Indexation unique par la première colonne
$indexed = $pdo->query('SELECT id, name, email FROM users')
               ->fetchAll(PDO::FETCH_UNIQUE | PDO::FETCH_ASSOC);
```

`FETCH_GROUP` et `FETCH_UNIQUE` sont des modes propres à `fetchAll()`. ([PHP][16])

### Obtenir le nombre de lignes

Pour compter les lignes affectées par un `INSERT`, `UPDATE` ou `DELETE`, utilisez `rowCount()`. Pour connaître le nombre de résultats d’un `SELECT`, exécutez un `SELECT COUNT(*) ...` séparé. `columnCount()`, lui, renvoie le nombre de colonnes du résultat, pas le nombre de lignes. ([PHP][9])

```php
$total = $pdo->query('SELECT COUNT(*) FROM users WHERE active = 1')
             ->fetchColumn();
```

## Gestion des erreurs

### Gestion des erreurs et exceptions

Depuis PHP 8.0, `PDO::ERRMODE_EXCEPTION` est le mode par défaut. C’est le mode recommandé : les erreurs remontent immédiatement sous forme de `PDOException`, ce qui simplifie fortement le code, en particulier avec les transactions. Le constructeur `PDO::__construct()` lève de toute façon une exception en cas d’échec de connexion, quel que soit le mode d’erreur. Si vous avez besoin des détails bas niveau, `errorCode()` et `errorInfo()` restent disponibles. ([PHP][17])

```php
try {
    $stmt = $pdo->query('SELECT missing_column FROM users');
} catch (PDOException $e) {
    error_log($e->getMessage());
    throw $e;
}
```

## Défis courants et solutions

### Clause `LIKE` avec requêtes préparées

Le placeholder doit représenter la valeur entière. On ne fait donc pas ceci :

```php
// Incorrect
$stmt = $pdo->prepare("SELECT * FROM users WHERE name LIKE '%:term%'");
```

On construit le motif côté PHP, puis on le lie :

```php
$term = 'ali';
$pattern = '%' . $term . '%';

$stmt = $pdo->prepare('SELECT * FROM users WHERE name LIKE :pattern');
$stmt->execute(['pattern' => $pattern]);
$rows = $stmt->fetchAll();
```

C’est exactement le bon modèle pour `LIKE`, parce qu’un placeholder représente un littéral complet. ([PHP][4])

Si vous voulez traiter `%` et `_` comme des caractères littéraux saisis par l’utilisateur, il faut les échapper dans la valeur et prévoir une clause `ESCAPE` adaptée à votre moteur SQL.

### Clause `IN` avec requêtes préparées

On ne peut pas lier plusieurs valeurs à un seul placeholder. Il faut générer autant de placeholders qu’il y a d’éléments dans la liste. ([PHP][4])

```php
$ids = [3, 5, 9];

$placeholders = implode(',', array_fill(0, count($ids), '?'));
$sql = "SELECT id, name FROM users WHERE id IN ($placeholders)";

$stmt = $pdo->prepare($sql);
$stmt->execute($ids);

$rows = $stmt->fetchAll();
```

Cas important : si le tableau est vide, ne générez pas `IN ()`. Gérez ce cas avant de construire la requête.

### Protection des noms de tables et de champs

Les identifiants SQL ne se lient pas. Il faut les choisir depuis une liste blanche :

```php
$allowedColumns = [
    'name'       => 'name',
    'email'      => 'email',
    'created_at' => 'created_at',
];

$column = $_GET['column'] ?? 'name';

if (!isset($allowedColumns[$column])) {
    throw new InvalidArgumentException('Colonne invalide');
}

$sql = 'SELECT ' . $allowedColumns[$column] . ' FROM users';
$stmt = $pdo->query($sql);
```

La bonne stratégie est donc : valeurs via placeholders, structure SQL via validation stricte. ([PHP][4])

### Considérations sur la clause `LIMIT`

Comme les valeurs passées à `execute([...])` sont traitées comme `PDO::PARAM_STR`, il est préférable de lier explicitement `LIMIT` et `OFFSET` avec `PDO::PARAM_INT` lorsqu’un entier est attendu. ([PHP][5])

```php
$stmt = $pdo->prepare(
    'SELECT id, name FROM users ORDER BY id DESC LIMIT :limit OFFSET :offset'
);

$stmt->bindValue(':limit', 10, PDO::PARAM_INT);
$stmt->bindValue(':offset', 20, PDO::PARAM_INT);
$stmt->execute();

$rows = $stmt->fetchAll();
```

## Fonctionnalités avancées

### Procédures stockées

PDO peut appeler des procédures stockées. Si une procédure renvoie plusieurs jeux de résultats, utilisez `nextRowset()` pour les parcourir. PDO prévoit aussi `PDO::PARAM_INPUT_OUTPUT` pour les paramètres `INOUT/OUT`, mais le driver MySQL ne met pas correctement à jour les paramètres de sortie liés par `bindParam()`. Avec MySQL, il est donc souvent plus simple de renvoyer des jeux de résultats ou d’utiliser des variables de session SQL si nécessaire. ([PHP][18])

```php
$stmt = $pdo->query('CALL multiple_rowsets()');

do {
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if ($rows) {
        var_dump($rows);
    }
} while ($stmt->nextRowset());
```

### Requêtes multiples

Envoyer plusieurs instructions SQL dans une seule chaîne est une fonctionnalité très dépendante du driver. Avec le driver MySQL moderne, il existe un attribut spécifique pour désactiver l’exécution multi-statements dès la connexion. Dans un tutoriel général, la meilleure règle reste simple : évitez les requêtes multiples concaténées ; préférez des requêtes séparées, ou une transaction si le besoin est atomique. ([PHP][19])

### Mode d’émulation

`PDO::ATTR_EMULATE_PREPARES` n’est disponible que pour certains drivers, notamment MySQL, OCI et Firebird. S’il est activé, PDO émule les requêtes préparées ; s’il est désactivé, PDO tente d’utiliser des requêtes préparées natives, avec possibilité de repli si le driver ne peut pas préparer la requête courante. Pour PDO MySQL, l’émulation est activée par défaut. Le parseur utilisé en mode émulé a aussi des cas limites autour des antislashs dans les chaînes SQL. Dans du code MySQL applicatif, définir explicitement `ATTR_EMULATE_PREPARES => false` reste donc un choix raisonnable et lisible. ([PHP][20])

### Requêtes bufferisées et grands ensembles de données

Avec MySQL, les requêtes sont bufferisées par défaut. Cela facilite certaines opérations, mais consomme plus de mémoire. Le mode non bufferisé réduit la mémoire utilisée côté PHP, mais tant que vous n’avez pas consommé toutes les lignes — ou appelé `closeCursor()` — vous ne pourrez pas lancer librement une autre requête sur la même connexion. ([PHP][11])

Pour de très gros exports, la bonne approche est généralement : lecture séquentielle, traitement ligne par ligne, pas de `fetchAll()`.

---

## Changements majeurs apportés

* Correction de l’erreur la plus grave : `rowCount()` ne doit pas être présenté comme une manière fiable de compter les lignes d’un `SELECT`.
* Suppression de l’affirmation fausse sur les “transactions imbriquées” supportées par PDO. PDO lève une exception si une transaction est déjà ouverte ; il faut des `SAVEPOINT` si l’on veut simuler un comportement imbriqué.
* Correction de la section `PDO::query()`, qui parlait en réalité de réexécution de requêtes préparées.
* Correction de l’affirmation fausse selon laquelle la réexécution d’une requête préparée ne serait disponible qu’avec l’émulation désactivée.
* Correction du passage sur les types retournés : la situation dépend du driver et a changé dès PHP 8.1 pour MySQL/SQLite, pas “à partir de PHP 8.3” au sens large.
* Correction du passage sur ce qui peut être lié : on ne lie pas “seulement des chaînes et nombres”, mais des littéraux complets ; on ne lie jamais des identifiants ni une liste entière pour `IN (...)`.
* Correction de l’idée trompeuse selon laquelle `foreach` serait toujours “efficace en mémoire” : avec MySQL bufferisé, le résultat peut déjà être chargé en mémoire côté client.
* Correction de la partie transactions avec les vrais pièges : DDL = `COMMIT` implicite possible, moteur non transactionnel côté MySQL, rollback automatique seulement pour les transactions ouvertes via `PDO::beginTransaction()`.
* Remplacement de plusieurs exemples absurdes ou incohérents par des exemples réalistes.
* Allègement des tableaux de compatibilité erronés ou trop affirmatifs, remplacés par des notes de comportement réellement utiles.

[1]: https://www.php.net/manual/en/book.pdo.php?utm_source=chatgpt.com "PHP: PDO - Manual"
[2]: https://www.php.net/manual/en/ref.pdo-mysql.connection.php?utm_source=chatgpt.com "PDO_MYSQL DSN - Manual"
[3]: https://www.php.net/manual/en/pdo.query.php "PHP: PDO::query - Manual"
[4]: https://www.php.net/manual/en/pdo.prepare.php "PHP: PDO::prepare - Manual"
[5]: https://www.php.net/manual/en/pdostatement.execute.php "PHP: PDOStatement::execute - Manual"
[6]: https://www.php.net/manual/en/pdostatement.bindvalue.php "PHP: PDOStatement::bindValue - Manual"
[7]: https://www.php.net/manual/en/pdo.prepared-statements.php "PHP: Prepared statements and stored procedures - Manual"
[8]: https://www.php.net/manual/en/pdo.exec.php?utm_source=chatgpt.com "PDO::exec - Manual"
[9]: https://www.php.net/manual/en/pdostatement.rowcount.php "PHP: PDOStatement::rowCount - Manual"
[10]: https://www.php.net/manual/en/pdo.transactions.php "PHP: Transactions and auto-commit - Manual"
[11]: https://www.php.net/manual/en/mysqlinfo.concepts.buffering.php?utm_source=chatgpt.com "Buffered and Unbuffered queries - Manual"
[12]: https://www.php.net/manual/en/pdostatement.fetch.php "PHP: PDOStatement::fetch - Manual"
[13]: https://www.php.net/manual/en/migration81.incompatible.php "PHP: Backward Incompatible Changes - Manual"
[14]: https://www.php.net/manual/en/pdostatement.fetchcolumn.php "PHP: PDOStatement::fetchColumn - Manual"
[15]: https://www.php.net/manual/en/pdostatement.fetchall.php?utm_source=chatgpt.com "PDOStatement::fetchAll - Manual"
[16]: https://www.php.net/manual/en/pdo.constants.fetch-modes.php "PHP: Fetch Modes - Manual"
[17]: https://www.php.net/manual/en/pdo.error-handling.php "PHP: Errors and error handling - Manual"
[18]: https://www.php.net/manual/en/pdostatement.nextrowset.php "PHP: PDOStatement::nextRowset - Manual"
[19]: https://www.php.net/manual/en/class.pdo-mysql.php "PHP: Pdo\Mysql - Manual"
[20]: https://www.php.net/manual/en/ref.pdo-mysql.php "PHP: MySQL PDO Driver - Manual"
