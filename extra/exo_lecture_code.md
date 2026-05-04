# Exercice — Lecture de code PHP / JavaScript

## Contexte

Vous recevez un mini-projet PHP / JavaScript déjà écrit.

Le code affiche une mission aléatoire à l’utilisateur. Ensuite, deux boutons permettent d’interagir avec cette mission.

Le code contient volontairement plusieurs bugs.

Votre travail est de :

1. lire le code ;
2. comprendre l’intention ;
3. exécuter le projet si possible ;
4. observer les bugs ;
5. corriger le code ;
6. expliquer vos corrections.

L’exercice peut être fait uniquement par lecture, mais l’exécution permet de mieux observer certains bugs.

Attention : la page à ouvrir est `index.php`, pas `render.html`. Le fichier `render.html` sert de modèle HTML utilisé par PHP.

---

# Fichiers fournis

```txt
mission/
├── index.php
├── missions.php
├── render.html
└── app.js
```

---

# `missions.php`

```php
<?php

$missions = [
    [
        'id' => 1,
        'title' => 'Réparer le formulaire de contact',
        'level' => 'normal',
        'reward' => 120,
        'active' => true
    ],
    [
        'id' => 2,
        'title' => 'Retrouver le div perdu',
        'level' => 'silly',
        'reward' => 5,
        'active' => true
    ],
    [
        'id' => 3,
        'title' => 'Optimiser les images du site',
        'level' => 'normal',
        'reward' => 200,
        'active' => false
    ],
    [
        'id' => 4,
        'title' => 'Convaincre un tableau HTML de devenir responsive',
        'level' => 'danger',
        'reward' => 80,
        'active' => true
    ],
    [
        'id' => 5,
        'title' => 'Supprimer le dernier console.log du monde',
        'level' => 'legendary',
        'reward' => 999,
        'active' => true
    ]
];

function get_active_missions($missions)
{
    $result = [];

    foreach ($missions as $mission) {
        if ($mission['active'] === true) {
            $result[] = $mission;
        }
    }

    return $result;
}

function get_random_mission($missions)
{
    $index = rand(0, count($missions));

    return $missions[$index];
}
```

---

# `index.php`

```php
<?php

require 'missions.php';

$active_missions = get_active_missions($missions);
$mission = get_random_mission($active_missions);

require 'render.html';
```

---

# `render.html`

```php
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Distributeur de missions</title>
</head>
<body>

    <h1>Mission du jour</h1>

    <article id="mission-card"
        data-id="<?= $mission['id'] ?>"
        data-level="<?= $mission['level'] ?>"
        data-reward="<?= $mission['reward'] ?>"
    >
        <h2><?= $mission['title'] ?></h2>

        <p>
            Niveau :
            <strong id="mission-level">
                <?= $mission['level'] ?>
            </strong>
        </p>

        <p>
            Récompense :
            <strong id="mission-reward">
                <?= $mission['reward'] ?>
            </strong>
            crédits
        </p>

        <button id="accept-button">Accepter la mission</button>
        <button id="panic-button">Panique pédagogique</button>
    </article>

    <p id="message"></p>

    <script src="app.js"></script>
</body>
</html>
```

---

# `app.js`

```js
const card = document.querySelector('#mission-card');
const acceptButton = document.querySelector('#accept-button');
const panicButton = document.querySelector('#panic-button');
const message = document.querySelector('#message');

let reward = card.dataset.reward;
let level = card.dataset.level;
let accepted = false;

acceptButton.addEventListener('click', function () {
    accepted = true;

    message.textContent = 'Mission acceptée. Récompense prévue : ' + reward + 50 + ' crédits.';
});

panicButton.addEventListener('click', function () {
    if (level = 'danger') {
        message.textContent = 'Panique activée. Le tableau HTML refuse toujours de coopérer.';
    } else {
        message.textContent = 'Tout va bien. Enfin presque.';
    }
});
```

---

# Partie 1 — Comprendre le projet

Répondez aux questions suivantes.

1. Quel est le rôle de `missions.php` ?
2. Quel est le rôle de `index.php` ?
3. Quel est le rôle de `render.html` ?
4. Quel est le rôle de `app.js` ?
5. Quel code est exécuté côté serveur ?
6. Quel code est exécuté côté navigateur ?
7. Que permet `require 'missions.php';` ?
8. Que permet `require 'render.html';` ?
9. Pourquoi faut-il ouvrir `index.php` et pas directement `render.html` ?
10. Comment les données PHP arrivent-elles jusqu’au JavaScript ?

---

# Partie 2 — Lire le PHP

Observez le tableau `$missions` et les deux fonctions.

Répondez aux questions suivantes.

1. Combien de missions sont définies ?
2. Quelles informations contient une mission ?
3. Quelle mission est inactive ?
4. Pourquoi cette mission ne devrait-elle pas apparaître ?
5. Que fait `get_active_missions()` ?
6. Que fait `get_random_mission()` ?
7. Que contient `$active_missions` dans `index.php` ?
8. Que contient `$mission` dans `index.php` ?
9. Si un tableau contient 4 éléments, quels sont ses index possibles ?
10. Quelle ligne du PHP peut parfois produire une erreur ?
11. Pourquoi ce bug n’apparaît-il pas à chaque chargement de page ?

---

# Partie 3 — Lire le rendu HTML

Observez le fichier `render.html`.

Répondez aux questions suivantes.

1. Quel est l’`id` de l’élément `<article>` ?
2. Quels attributs `data-*` sont ajoutés à cet élément ?
3. D’où viennent les valeurs de `data-id`, `data-level` et `data-reward` ?
4. À quoi sert `<?= $mission['title'] ?>` ?
5. Pourquoi le fichier `render.html` peut-il utiliser la variable `$mission` ?
6. Est-ce que `render.html` choisit lui-même la mission ?
7. Quel fichier choisit la mission avant l’affichage ?
8. À quoi servent les attributs `data-*` pour JavaScript ?

---

# Partie 4 — Lire le JavaScript

Observez le fichier `app.js`.

Répondez aux questions suivantes.

1. Que sélectionne `document.querySelector('#mission-card')` ?
2. Que contient `card.dataset.reward` ?
3. Cette valeur est-elle un nombre ou une chaîne de caractères ?
4. Que contient `card.dataset.level` ?
5. Que vaut `accepted` au chargement de la page ?
6. Que se passe-t-il quand on clique sur “Accepter la mission” ?
7. Que devrait afficher le message si la récompense vaut `120` ?
8. Que risque d’afficher le code actuel ?
9. Que se passe-t-il quand on clique sur “Panique pédagogique” ?
10. Que veut probablement tester la condition `if` ?
11. Quelle différence y a-t-il entre affecter une valeur et comparer une valeur ?

---

# Partie 5 — Exécuter et observer

Lancez le projet dans le navigateur en ouvrant `index.php`.

Testez les actions suivantes :

1. rafraîchir la page plusieurs fois ;
2. cliquer sur “Accepter la mission” ;
3. cliquer sur “Panique pédagogique” ;
4. inspecter l’élément `<article id="mission-card">` ;
5. regarder la console du navigateur.

Répondez aux questions suivantes.

1. La page fonctionne-t-elle à chaque rafraîchissement ?
2. Observez-vous une erreur parfois ?
3. Si une erreur apparaît, vient-elle plutôt du PHP ou du JavaScript ?
4. Le bouton “Accepter la mission” affiche-t-il un calcul correct ?
5. Le bouton “Panique pédagogique” dépend-il réellement du niveau de la mission ?
6. Que contiennent les attributs `data-*` dans le HTML généré ?
7. Les bugs observés correspondent-ils à ce que vous aviez prévu en lisant le code ?
8. Que se passe-t-il si vous ouvrez directement `render.html` au lieu de `index.php` ?

---

# Partie 6 — Identifier les bugs

Complétez le tableau.

| Bug   | Fichier | Ligne ou zone suspecte | Comportement attendu | Comportement réel | Cause probable |
| ----- | ------- | ---------------------- | -------------------- | ----------------- | -------------- |
| Bug 1 |         |                        |                      |                   |                |
| Bug 2 |         |                        |                      |                   |                |
| Bug 3 |         |                        |                      |                   |                |

Pour chaque bug, vous devez être capable d’expliquer :

* ce que le code voulait faire ;
* ce que le code fait réellement ;
* pourquoi le problème se produit.

---

# Partie 7 — Corriger le code

Corrigez les bugs un par un.

Ordre conseillé :

1. corriger le choix aléatoire de la mission ;
2. corriger le calcul de la récompense ;
3. corriger la condition du bouton “Panique pédagogique”.

Après chaque correction, testez à nouveau le projet.

Pour chaque correction, écrivez une courte explication :

```txt
J’ai corrigé ________ dans le fichier ________.
Le problème venait de ________.
La correction permet de ________.
```

---

# Partie 8 — Ajouter une règle spéciale

Ajoutez maintenant une règle supplémentaire.

Quand l’utilisateur clique sur “Accepter la mission”, si la mission est de niveau `legendary`, le message affiché doit être :

```txt
Mission trop puissante. Veuillez boire un café avant de continuer.
```

Pour les autres missions, le comportement normal doit continuer.

Répondez avant de coder.

1. Dans quel fichier faut-il ajouter cette règle ?
2. Quelle variable contient le niveau de la mission ?
3. Où faut-il ajouter la condition ?
4. Que doit-il se passer si la mission n’est pas `legendary` ?
5. Cette règle concerne-t-elle PHP, HTML ou JavaScript ?
6. Pourquoi ?

---

# Tests finaux

Complétez le tableau après correction.

| Test                                  | Résultat attendu                          | Résultat observé |
| ------------------------------------- | ----------------------------------------- | ---------------- |
| Ouvrir `index.php`                    | La mission s’affiche                      |                  |
| Rafraîchir plusieurs fois             | Pas d’erreur PHP                          |                  |
| Mission inactive                      | Elle n’apparaît jamais                    |                  |
| Attributs `data-*`                    | Ils contiennent les données de la mission |                  |
| Bouton “Accepter”                     | Le calcul de récompense est correct       |                  |
| Mission `legendary` acceptée          | Message spécial café                      |                  |
| Bouton “Panique” avec niveau `danger` | Message de panique                        |                  |
| Bouton “Panique” avec autre niveau    | Message normal                            |                  |
