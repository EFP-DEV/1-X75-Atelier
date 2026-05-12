<?php

/*
    core/router.php

    Proof of concept pédagogique.

    Ce fichier transforme les segments HTTP en appel de controller.

    Fonctions nécessaires :
    - route()
    - run()

    Fonction de sécurité :
    - is_safe_segment()

    Ce n'est pas un routeur complet.

    Le but est de montrer le passage entre :

        chemin HTTP
            ↓
        route structurée
            ↓
        fichier controller
            ↓
        fonction à exécuter
            ↓
        contenu HTML retourné

    Le routeur ne produit pas directement de HTML.
    Il choisit seulement quel controller doit répondre.

    Les controllers doivent retourner une chaîne de caractères,
    généralement produite par render().
*/

function route(array $http_segments): array
{
    // Chaque segment de l'URL doit être vérifié avant d'être utilisé dans un chemin de fichier.
    foreach ($http_segments as $segment) {
        if ($segment !== null && !is_safe_segment($segment)) {
            throw new InvalidArgumentException('Invalid route segment: ' . $segment);
        }
    }

    // La route est une version nommée des segments HTTP.
    $route = [];

    // Premier segment : l'entité à manipuler.
    // Exemple : /item/show/3 → item
    $route['entity'] = $http_segments[0] ?? 'home';

    // Deuxième segment : l'action à exécuter.
    // Exemple : /item/show/3 → show
    $route['action'] = $http_segments[1] ?? 'index';

    // Troisième segment : l'identifiant éventuel.
    // Exemple : /item/show/3 → 3
    $route['id']     = $http_segments[2] ?? null;

    return $route;
}
function run(array $route, string $base_path): string
{
    // Le front controller connaît la racine du projet.
    $base_path = rtrim($base_path, '/');

    // Le nom de l'entité détermine le fichier controller à charger.
    // Exemple : item → controllers/item.php
    $controller_filepath = $base_path . '/controllers/' . $route['entity'] . '.php';

    // Le nom de l'entité et le nom de l'action déterminent la fonction à appeler.
    // Exemple : item + show → item_show()
    $function_name = $route['entity'] . '_' . $route['action'];

    // Si le fichier controller n'existe pas, la route ne peut pas être traitée.
    if (!is_file($controller_filepath)) {
        throw new RuntimeException('Controller not found: ' . $route['entity']);
    }

    // Le fichier est chargé seulement après vérification de son existence.
    require_once $controller_filepath;

    // Si la fonction attendue n'existe pas, le controller ne peut pas traiter cette action.
    if (!function_exists($function_name)) {
        throw new RuntimeException('Controller function not found: ' . $function_name);
    }

    // Si un identifiant existe dans la route, il est transmis au controller.
    if ($route['id'] !== null) {
        return $function_name($route['id']);
    }

    // Sinon, le controller est appelé sans argument.
    return $function_name();
}


function is_safe_segment(string $part): bool
{
    // Un segment vide ne doit pas être utilisé comme nom de fichier ou de fonction.
    if ($part === '') {
        return false;
    }

    // Liste volontairement limitée de caractères autorisés dans les routes.
    $allowed = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-';
    $length = strlen($part);

    // Chaque caractère est vérifié séparément, sans expression régulière.
    for ($i = 0; $i < $length; $i++) {
        if (strpos($allowed, $part[$i]) === false) {
            return false;
        }
    }

    return true;
}
