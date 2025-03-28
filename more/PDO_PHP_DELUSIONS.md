# (The only proper) PDO tutorial
Traduis de [PHPDelusions.net](https://phpdelusions.net/pdo) en français par IA, mis a jour, adapté et aggremente d'exemples et de notes

## Introduction
- [Pourquoi PDO ?](#pourquoi-pdo)

## Premiers pas
- [Connexion avec DSN](#connexion-avec-dsn)
- [Exécuter des requêtes simples avec PDO::query()](#exécuter-des-requêtes-avec-pdoquery)

## Sécurité et requêtes préparées
- [Requêtes préparées et protection contre les injections SQL](#requêtes-préparées-et-protection-contre-les-injections-sql)
- [Méthodes de liaison](#méthodes-de-liaison)
- [Parties de requête que vous pouvez lier](#parties-de-requête-que-vous-pouvez-lier)
- [Exécution multiple des requêtes préparées](#exécution-multiple-des-requêtes-préparées)

## Opérations de base sur la base de données
- [Exécuter SELECT, INSERT, UPDATE, ou DELETE](#exécuter-select-insert-update-ou-delete)
- [Lignes affectées et ID d'insertion](#lignes-affectées-et-id-dinsertion)
- [Transactions](#transactions)

## Récupération de données
- [Obtenir des données avec foreach()](#obtenir-des-données-avec-foreach)
- [Obtenir des données avec fetch()](#obtenir-des-données-avec-fetch)
- [Types de retour](#types-de-retour)
- [Obtenir des données avec fetchColumn()](#obtenir-des-données-avec-fetchcolumn)
- [Obtenir des données avec fetchAll()](#obtenir-des-données-avec-fetchall)
- [Obtenir le nombre de lignes](#obtenir-le-nombre-de-lignes)

## Gestion des erreurs
- [Gestion des erreurs et exceptions](#gestion-des-erreurs-et-exceptions)

## Défis courants et solutions
- [Clause LIKE avec requêtes préparées](#clause-like-avec-requêtes-préparées)
- [Clause IN avec requêtes préparées](#clause-in-avec-requêtes-préparées)
- [Protection des noms de tables et de champs](#protection-des-noms-de-tables-et-de-champs)
- [Considérations sur la clause LIMIT](#considérations-sur-la-clause-limit)

## Fonctionnalités avancées
- [Procédures stockées](#procédures-stockées)
- [Requêtes multiples](#requêtes-multiples)
- [Mode d'émulation](#mode-démulation)
- [Requêtes bufferisées et grands ensembles de données](#requêtes-bufferisées-et-grands-ensembles-de-données)

---

## Introduction

### Pourquoi PDO ?

PDO est une couche d'abstraction d'accès à la base de données qui offre deux types d'abstraction clés :

1. **API unifiée pour plusieurs bases de données** : Bien qu'avantageux, ceci est moins significatif pour les applications n'utilisant qu'un seul backend de base de données.

2. **Abstraction des opérations de base** : PDO automatise les opérations routinières qui, autrement, seraient répétées dans tout votre code.

Les véritables avantages de PDO sont :
- **Sécurité** (requêtes préparées utilisables)
- **Facilité d'utilisation** (fonctions d'aide pour les opérations routinières)
- **Réutilisabilité** (API unifiée pour diverses bases de données)

Pour les applications web modernes, envisagez d'utiliser un ORM avec un constructeur de requêtes (comme Doctrine, Eloquent, RedBean ou Yii::AR) ou une autre bibliothèque d'abstraction de plus haut niveau, avec un recours occasionnel à PDO vanilla si nécessaire.

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ | PHP 8.3+ |
|----------------|---------|----------|----------|----------|
| PDO de base | ✓ | ✓ | ✓ | ✓ |
| Types de retour natifs | Partiellement* | Partiellement* | Partiellement* | ✓ |
| Transactions imbriquées | ✗ | ✗ | ✓ | ✓ |

\* *Nécessite le mode d'émulation désactivé et mysqlnd*

#### Résumé de la section
**Pourquoi utiliser PDO?** PDO offre une API unifiée pour travailler avec différentes bases de données, automatise les opérations de routine, et fournit une meilleure sécurité grâce aux requêtes préparées bien implémentées. C'est le choix recommandé pour tout nouveau développement PHP nécessitant un accès direct à la base de données.

---

## Premiers pas

### Connexion avec DSN

PDO utilise une méthode de connexion DSN (Data Source Name) qui nécessite une configuration à trois endroits :

1. **Chaîne DSN** : Contient le pilote de base de données, l'hôte, le nom de la base de données, le jeu de caractères, et éventuellement le port et le socket unix
2. **Paramètres du constructeur** : Nom d'utilisateur et mot de passe
3. **Tableau d'options** : Toutes les autres options de configuration

Exemple pour MySQL :

```php
$host = '127.0.0.1';
$db   = 'test';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];
$pdo = new PDO($dsn, $user, $pass, $options);
```

Remarques importantes :
- Contrairement aux anciennes fonctions `mysql_*`, les instances PDO sont stockées dans des variables, nécessitant une portée appropriée.
- Créez une seule connexion par exécution de script pour éviter de surcharger votre serveur de base de données.
- Définir le jeu de caractères via DSN est l'approche correcte (oubliez les requêtes manuelles `SET NAMES`).

#### Messages d'erreur courants

| Erreur | Cause probable | Solution |
|--------|----------------|----------|
| `SQLSTATE[HY000] [1045] Access denied for user` | Identifiants de connexion incorrects | Vérifier le nom d'utilisateur/mot de passe |
| `SQLSTATE[HY000] [2002] No such file or directory` | Mauvaise adresse du serveur | Vérifier l'hôte (utiliser '127.0.0.1' au lieu de 'localhost') |
| `SQLSTATE[HY000] [2002] Connection refused` | Serveur MySQL non démarré | Démarrer le serveur MySQL |
| `SQLSTATE[HY000] [1049] Unknown database` | Base de données inexistante | Créer la base de données ou corriger le nom |
| `could not find driver` | Extension PDO pour le driver spécifique non installée | Installer l'extension (ex: `php-mysql`) |

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| DSN avec charset | ≥ 5.3.6 | ✓ | ✓ |
| Support utf8mb4 | ✓* | ✓ | ✓ |

\* *Nécessite MySQL 5.5.3+*

#### Résumé de la section
**Connexion à la base de données avec DSN:** PDO utilise une chaîne DSN qui contient les informations de connexion essentielles comme le pilote, l'hôte et le nom de la base de données. Les options supplémentaires permettent de personnaliser le comportement, comme la gestion des erreurs et les modes de récupération de données. Une connexion par script est suffisante et devrait être réutilisée dans toute l'application.

### Exécuter des requêtes avec PDO::query()

Pour les requêtes sans variables, utilisez la méthode `PDO::query()`, qui retourne un objet PDOStatement :

```php
$stmt = $pdo->query('SELECT name FROM users');
while ($row = $stmt->fetch())
{
    echo $row['name'] . "\n";
}
```

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| Exécution multiple | ✓* | ✓* | ✓* |

\* *Nécessite que le mode d'émulation soit désactivé*

#### Résumé de la section
**Exécution multiple des requêtes préparées:** La capacité à exécuter plusieurs fois la même requête préparée avec différentes données constitue un léger avantage en performance. Cependant, cette fonctionnalité n'est disponible qu'avec le mode d'émulation désactivé et son utilité est généralement limitée aux opérations répétitives comme les insertions ou mises à jour en masse.

#### Messages d'erreur courants
| Erreur | Cause probable | Solution |
|--------|----------------|----------|
| `SQLSTATE[42S02]: Base table or view not found` | Table inexistante | Vérifier le nom de la table |
| `SQLSTATE[42S22]: Column not found` | Colonne inexistante | Vérifier le nom de la colonne |
| `SQLSTATE[42000]: Syntax error or access violation` | Erreur de syntaxe SQL | Vérifier la syntaxe de la requête |

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| `PDO::query()` | ✓ | ✓ | ✓ |
| Itération directe sur PDOStatement | ✓ | ✓ | ✓ |

#### Résumé de la section
**Exécution de requêtes simples:** Pour les requêtes sans variables (donc sans risque d'injection SQL), `PDO::query()` offre une méthode simple et directe. Cette méthode retourne un objet PDOStatement qui peut être utilisé pour accéder aux résultats. Elle convient parfaitement pour les requêtes statiques, mais ne doit jamais être utilisée avec des données provenant de l'utilisateur.

---

## Sécurité et requêtes préparées

### Requêtes préparées et protection contre les injections SQL

Pour toute requête incluant des variables, utilisez des requêtes préparées pour prévenir les injections SQL :

1. Remplacez les variables par des placeholders (soit positionnels `?` soit nommés `:placeholder`)
2. Préparez la requête à l'aide de `PDO::prepare()`
3. Exécutez avec des variables séparées en utilisant `execute()`

Exemple avec des placeholders positionnels :
```php
$stmt = $pdo->prepare('SELECT * FROM users WHERE email = ? AND status = ?');
$stmt->execute(['rasmus@php.net', 'active']); // Utilisation de chaînes littérales
$user = $stmt->fetch();
```

Exemple avec des placeholders nommés :
```php
$stmt = $pdo->prepare('SELECT * FROM users WHERE email = :email AND status = :status');
$stmt->execute(['email' => 'zeev@php.net', 'status' => 'premium']); // Paramètres nommés
$user = $stmt->fetch();
```

Remarque :
- Les placeholders positionnels utilisent un tableau régulier avec des valeurs.
- Les placeholders nommés utilisent un tableau associatif où les clés correspondent aux noms des placeholders.
- Vous ne pouvez pas mélanger les placeholders positionnels et nommés dans la même requête.
- Aucun ":" n'est requis dans les clés du tableau associatif pour les placeholders nommés.

#### Messages d'erreur courants
| Erreur | Cause probable | Solution |
|--------|----------------|----------|
| `SQLSTATE[HY093]: Invalid parameter number` | Nombre de paramètres dans `execute()` ne correspond pas au nombre de placeholders | Corriger le nombre de paramètres |
| `SQLSTATE[HY000]: General error: 2031 Named placeholders` | Mélange de placeholders nommés et positionnels | Utiliser un seul type de placeholder |
| `Undefined index in ...` | Clé manquante dans le tableau associatif pour les placeholders nommés | Vérifier que toutes les clés correspondent aux placeholders |

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| Requêtes préparées | ✓ | ✓ | ✓ |
| Array shorthand `[]` | ≥ 5.4 | ✓ | ✓ |
| Protection injection SQL | ✓ | ✓ | ✓ |

#### Résumé de la section
**Requêtes préparées et protection contre les injections SQL:** Les requêtes préparées sont le mécanisme de défense principal contre les injections SQL. Elles permettent de séparer le code SQL des données, empêchant ainsi toute manipulation malveillante de la structure de la requête. Il est essentiel d'utiliser des requêtes préparées pour toute requête incluant des variables, en particulier celles provenant des entrées utilisateur.

### Méthodes de liaison

Bien que passer des données directement à `execute()` soit recommandé, parfois vous devez définir explicitement les types de données en utilisant `bindValue()` ou `bindParam()`. Utilisez `bindValue()` quand c'est possible car il n'a pas d'effets secondaires.

Scénarios où la liaison explicite est utile :
- Clause LIMIT avec mode d'émulation activé
- Requêtes complexes avec un plan de requête affecté par les types d'opérandes
- Types de colonnes spéciaux comme BIGINT ou BOOLEAN

#### Messages d'erreur courants
| Erreur | Cause probable | Solution |
|--------|----------------|----------|
| `Warning: PDOStatement::bindParam(): SQLSTATE[HY093]` | Paramètre avec un index incorrect | Vérifier les indices des paramètres |
| `Type mismatch error` | Type de données incompatible | Utiliser le type PDO approprié |

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| `bindValue()` | ✓ | ✓ | ✓ |
| `bindParam()` | ✓ | ✓ | ✓ |
| Support BIGINT | Partiel* | ✓** | ✓ |

\* *Pas de support natif pour les grands entiers*
\** *Nécessite mysqlnd*

#### Résumé de la section
**Méthodes de liaison:** Bien que passer les données directement à `execute()` soit la méthode recommandée dans la plupart des cas, les méthodes `bindValue()` et `bindParam()` offrent un contrôle plus précis sur les types de données. Utilisez `bindValue()` de préférence pour éviter les effets secondaires, et réservez ces méthodes pour les cas spécifiques où le typage explicite est nécessaire.

### Parties de requête que vous pouvez lier

Seuls les littéraux de chaîne et numériques peuvent être liés dans les requêtes préparées. Vous ne pouvez pas lier des identifiants, des listes séparées par des virgules ou des parties arbitraires de requête.

#### Messages d'erreur courants
| Erreur | Cause probable | Solution |
|--------|----------------|----------|
| `SQLSTATE[42000]: Syntax error` | Tentative de lier un identifiant (nom de table/colonne) | Filtrer les identifiants manuellement avec une liste blanche |
| `SQLSTATE[42000]: Syntax error` | Tentative de lier une liste (clause IN) | Créer dynamiquement les placeholders pour chaque élément de la liste |

#### Résumé de la section
**Parties de requête que vous pouvez lier:** Les requêtes préparées ont des limitations importantes - elles ne peuvent lier que des littéraux de chaîne et numériques. Les noms de tables, de colonnes, les clauses complètes ou les listes de valeurs ne peuvent pas être liés directement et nécessitent des techniques spécifiques, comme le filtrage par liste blanche ou la génération dynamique de placeholders.

### Exécution multiple des requêtes préparées

Vous pouvez exécuter la même requête préparée plusieurs fois avec des données différentes :

```php
// Traiter plusieurs enregistrements systématiquement
$stmt = $pdo->prepare('UPDATE users SET bonus = bonus + ? WHERE id = ?');
// Exécuter plusieurs fois avec différentes valeurs littérales
$stmt->execute([1000, 1]); // Ada Lovelace
$stmt->execute([300, 5]);  // Grace Hopper
$stmt->execute([200, 9]);  // Tim Berners-Lee
```

## Opérations de base sur la base de données

### Exécuter SELECT, INSERT, UPDATE, ou DELETE

Les requêtes DML fonctionnent de manière similaire à SELECT. Préparez avec des placeholders et exécutez avec des variables :

```php
$sql = "UPDATE users SET name = ? WHERE id = ?";
$pdo->prepare($sql)->execute(['Andi Gutmans', 42]); // Mettre à jour l'enregistrement
```

Pour obtenir le nombre de lignes affectées :
```php
$stmt = $pdo->prepare("DELETE FROM goods WHERE category = ?");
$stmt->execute(['Linus Torvalds']); // Suppression propre
$deleted = $stmt->rowCount();
```

#### Messages d'erreur courants
| Erreur | Cause probable | Solution |
|--------|----------------|----------|
| `SQLSTATE[HY000]: General error: 2014 Cannot execute queries` | Une requête non bufferisée précédente n'a pas été terminée | Récupérer tous les résultats ou utiliser `closeCursor()` |
| `SQLSTATE[42000]: Syntax error` | Erreur dans la syntaxe SQL | Vérifier la requête SQL |

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| Chaînage de méthodes | ✓ | ✓ | ✓ |
| `rowCount()` | ✓ | ✓ | ✓ |

#### Résumé de la section
**Exécution de requêtes SELECT, INSERT, UPDATE ou DELETE:** Toutes les requêtes DML (Data Manipulation Language) suivent le même modèle avec PDO : préparer avec des placeholders et exécuter avec des variables. Pour les opérations comme INSERT, UPDATE ou DELETE, la méthode `rowCount()` permet de connaître le nombre de lignes affectées. Le chaînage de méthodes peut également être utilisé pour simplifier le code.

### Lignes affectées et ID d'insertion

Utilisez `PDOstatement::rowCount()` pour obtenir le nombre de lignes affectées par les requêtes DML.

Pour les ID générés automatiquement, utilisez `PDO::lastInsertId()`, qui est sûr dans des environnements concurrents.

### Transactions

Pour utiliser les transactions, définissez le mode d'erreur sur exceptions et utilisez ces méthodes :
- `beginTransaction()` pour démarrer une transaction
- `commit()` pour valider les modifications
- `rollback()` pour annuler les modifications

```php
try {
    // Démarrer une transaction
    $pdo->beginTransaction();
    $stmt = $pdo->prepare("INSERT INTO users (name) VALUES (?)");
    
    // Insérer avec des valeurs littérales
    $stmt->execute(['Larry Page']);
    $stmt->execute(['Sergey Brin']);
    $stmt->execute(['Vint Cerf']);
    
    $pdo->commit(); // Valider la transaction
} catch (\Throwable $e) {
    $pdo->rollback(); // Annuler en cas d'erreur
    throw $e;
}
```

Remarques importantes :
- Assurez-vous que votre moteur de table supporte les transactions (InnoDB, pas MyISAM pour MySQL)
- Évitez les instructions DDL (modifications de schéma) dans les transactions car elles provoquent des validations implicites
- Relancez toujours les exceptions après un rollback pour maintenir un rapport d'erreur approprié

#### Messages d'erreur courants
| Erreur | Cause probable | Solution |
|--------|----------------|----------|
| `SQLSTATE[HY000]: General error: 1205 Lock wait timeout` | Conflit de verrouillage entre transactions | Optimiser les transactions pour qu'elles soient plus courtes |
| `SQLSTATE[25P02]: In failed sql transaction` | Tentative d'opération après échec d'une transaction | Effectuer un rollback avant de continuer |
| `SQLSTATE[HY000]: General error: 2014 Cannot execute queries` | Requête pendant une transaction active | Terminer toutes les lectures de résultats précédentes |

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| Transactions de base | ✓ | ✓ | ✓ |
| Transactions imbriquées | ✗ | ✗ | Partiel* |

\* *Dépend du support de la base de données*

#### Résumé de la section
**Transactions:** Les transactions sont essentielles pour maintenir l'intégrité des données lors de l'exécution d'opérations multiples qui doivent réussir ou échouer ensemble. PDO simplifie leur utilisation avec trois méthodes claires : `beginTransaction()`, `commit()` et `rollback()`. L'utilisation du mode exception est cruciale pour les transactions, car elle permet d'attraper les erreurs et d'effectuer un rollback automatique. Assurez-vous toujours que votre moteur de table (comme InnoDB pour MySQL) supporte les transactions.

## Récupération de données

### Obtenir des données avec foreach()

La façon la plus simple de récupérer plusieurs lignes est d'utiliser une boucle foreach sur le PDOStatement :

```php
$stmt = $pdo->query('SELECT name FROM users');
foreach ($stmt as $row)
{
    echo $row['name'] . "\n";
}
```

Ceci est efficace en mémoire car les résultats sont livrés un par un.

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| Itération avec `foreach` | ✓ | ✓ | ✓ |

#### Résumé de la section
**Récupération de données avec foreach():** L'utilisation de la boucle `foreach` directement sur un objet PDOStatement est la méthode la plus simple et la plus efficace en termes de mémoire pour traiter de multiples enregistrements. Comme les résultats sont récupérés un par un, cette approche est particulièrement adaptée pour les grands ensembles de données.

### Obtenir des données avec fetch()

La méthode `fetch()` récupère une seule ligne et déplace le pointeur interne vers la ligne suivante. Elle accepte un paramètre pour spécifier le format de retour :

- `PDO::FETCH_NUM` : Retourne un tableau énuméré
- `PDO::FETCH_ASSOC` : Retourne un tableau associatif (par défaut dans notre configuration)
- `PDO::FETCH_BOTH` : Retourne à la fois des tableaux numériques et associatifs
- `PDO::FETCH_OBJ` : Retourne un objet
- `PDO::FETCH_LAZY` : Permet les trois méthodes d'accès avec une surcharge minimale

Utilisez `fetch()` quand :
- Une seule ligne est attendue
- Vous devez traiter les données retournées avant de les utiliser

Un autre mode utile est `PDO::FETCH_CLASS` :

```php
$news = $pdo->query('SELECT * FROM news')->fetchAll(PDO::FETCH_CLASS, 'News');
```

Cela retourne un tableau d'objets de la classe News, en définissant les propriétés de classe à partir des valeurs retournées.

#### Messages d'erreur courants
| Erreur | Cause probable | Solution |
|--------|----------------|----------|
| `Warning: PDOStatement::fetch(): FETCH_CLASS` | Classe spécifiée n'existe pas | Vérifier que la classe est définie et correctement orthographiée |
| `Fatal error: Cannot access private property` | Tentative d'accéder aux propriétés privées | Utiliser des propriétés publiques ou définir des méthodes d'accès |

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| Modes de récupération de base | ✓ | ✓ | ✓ |
| `PDO::FETCH_CLASS` | ✓ | ✓ | ✓ |
| `PDO::FETCH_INTO` | ✓ | ✓ | ✓ |

#### Résumé de la section
**Récupération de données avec fetch():** La méthode `fetch()` permet de récupérer une ligne à la fois et offre une grande flexibilité grâce à ses différents modes de récupération. Elle est particulièrement utile lorsqu'on attend un seul résultat ou quand on a besoin de traiter chaque ligne avant de passer à la suivante. Le mode `PDO::FETCH_CLASS` est particulièrement puissant pour l'intégration avec des modèles orientés objet.

### Types de retour

À partir de PHP 8.3, PDO retourne les types de données appropriés (les valeurs int et float sont retournées en tant que types respectifs). Avant cela, un typage correct nécessitait que le mode d'émulation soit désactivé avec le pilote mysqlnd.

Si vous préférez l'ancien comportement avec uniquement des chaînes, utilisez :
```php
$pdo->setAttribute(PDO::ATTR_STRINGIFY_FETCHES, true);
```

Remarque : Le type DECIMAL est toujours retourné sous forme de chaîne pour préserver la précision.

#### Messages d'erreur courants
| Erreur | Cause probable | Solution |
|--------|----------------|----------|
| `TypeError: ... expects type X, got string` | PDO retourne une chaîne au lieu d'un type numérique | Convertir explicitement la valeur ou utiliser mysqlnd avec émulation désactivée |

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ | PHP 8.3+ |
|----------------|---------|----------|----------|----------|
| Types numériques natifs | ✗* | ✓* | ✓* | ✓ |
| `PDO::ATTR_STRINGIFY_FETCHES` | ✓ | ✓ | ✓ | ✓ |

\* *Seulement avec mysqlnd et mode d'émulation désactivé*

#### Résumé de la section
**Types de retour:** La manière dont PDO retourne les types de données a évolué au fil des versions de PHP. Depuis PHP 8.3, PDO retourne correctement les types numériques sans configuration particulière. Pour les versions antérieures, le comportement dépend du driver (mysqlnd) et du mode d'émulation. Le type DECIMAL est toujours retourné sous forme de chaîne pour préserver la précision décimale.

### Obtenir des données avec fetchColumn()

Pour récupérer la valeur d'une seule colonne d'une ligne, utilisez `fetchColumn()` :

```php
// Obtenir un nom par ID
$stmt = $pdo->prepare("SELECT name FROM table WHERE id = ?");
$stmt->execute(['Dennis Ritchie']); // Une valeur spécifique
$name = $stmt->fetchColumn();

// Obtenir le nombre de lignes
$count = $pdo->query("SELECT count(*) FROM table")->fetchColumn();
```

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| `fetchColumn()` | ✓ | ✓ | ✓ |

#### Résumé de la section
**Récupération de données avec fetchColumn():** La méthode `fetchColumn()` est une solution élégante pour récupérer une seule valeur d'une requête. Elle est particulièrement utile pour les requêtes d'agrégation comme COUNT, SUM, ou pour obtenir une valeur spécifique basée sur un ID. Cette méthode simplifie le code en évitant d'avoir à extraire la valeur d'un tableau associatif.

### Obtenir des données avec fetchAll()

`PDO::fetchAll()` retourne un tableau contenant toutes les lignes d'un jeu de résultats. C'est utile quand vous avez besoin de toutes les données en une fois, en particulier lors du passage à des modèles.

#### Divers formats avec fetchAll()

##### Tableau simple
```php
$data = $pdo->query('SELECT name FROM users')->fetchAll(PDO::FETCH_ASSOC);
/* array (
  0 => array('name' => 'John'),
  1 => array('name' => 'Mike'),
  2 => array('name' => 'Mary'),
  3 => array('name' => 'Kathy'),
)*/
```

##### Tableau à colonne unique
```php
$data = $pdo->query('SELECT name FROM users')->fetchAll(PDO::FETCH_COLUMN);
/* array (
  0 => 'John',
  1 => 'Mike',
  2 => 'Mary',
  3 => 'Kathy',
)*/
```

##### Paires clé-valeur
```php
$data = $pdo->query('SELECT id, name FROM users')->fetchAll(PDO::FETCH_KEY_PAIR);
/* array (
  104 => 'John',
  110 => 'Mike',
  120 => 'Mary',
  121 => 'Kathy',
)*/
```
Remarque : Vous devez sélectionner uniquement deux colonnes, la première devant être unique.

##### Lignes indexées par un champ unique
```php
$data = $pdo->query('SELECT * FROM users')->fetchAll(PDO::FETCH_UNIQUE);
/* array (
  104 => array (
    'name' => 'John',
    'car' => 'Toyota',
  ),
  ... etc.
)*/
```

##### Lignes regroupées par un champ
```php
$data = $pdo->query('SELECT sex, name, car FROM users')->fetchAll(PDO::FETCH_GROUP);
/* array (
  'male' => array (
    0 => array (
      'name' => 'John',
      'car' => 'Toyota',
    ),
    ... etc.
  ),
  'female' => array ( ... )
)*/
```

#### Messages d'erreur courants
| Erreur | Cause probable | Solution |
|--------|----------------|----------|
| `Out of memory error` | Tentative de charger trop de données avec `fetchAll()` | Utiliser `fetch()` dans une boucle ou requêtes avec LIMIT |
| `SQLSTATE[HY000]: General error: Out of sort memory` | Trop de données à trier | Ajouter des index ou utiliser LIMIT |

#### Compatibilité des versions
| Fonctionnalité | PHP 5.x | PHP 7.0+ | PHP 8.0+ |
|----------------|---------|----------|----------|
| `PDO::FETCH_COLUMN` | ✓ | ✓ | ✓ |
| `PDO::FETCH_KEY_PAIR` | ✓ | ✓ | ✓ |
| `PDO::FETCH_UNIQUE` | ✓ | ✓ | ✓ |
| `PDO::FETCH_GROUP` | ✓ | ✓ | ✓ |

#### Résumé de la section
**Récupération de données avec fetchAll():** La méthode `fetchAll()` est extrêmement polyvalente grâce à ses nombreux modes de récupération. Elle permet de formater les données directement depuis la base de données dans la structure exacte dont vous avez besoin pour votre application. Cependant, elle doit être utilisée avec précaution pour les grands ensembles de données en raison de sa consommation de mémoire. Les différents modes comme FETCH_COLUMN, FETCH_KEY_PAIR, et FETCH_GROUP sont particulièrement utiles pour créer des structures de données adaptées aux besoins spécifiques.