<?php

/*
    core/http.php

    Proof of concept pédagogique.

    Ce fichier contient les utilitaires HTTP minimaux du projet.

    Fonctions nécessaires :
    - http_in()
    - http_out()

    Fonctions ergonomiques :
    - redirect()
    - is_post()

    Ce n'est pas un outil de production.

    Le but est de montrer le cycle HTTP de base :

        requête entrante
            ↓
        traitement PHP
            ↓
        réponse sortante

    Les chemins sont pensés depuis la racine du projet,
    parce que toutes les requêtes passent par index.php.
*/

function http_in(string $request_uri): array
{
    // La query string n'identifie pas la route.
    $position = strpos($request_uri, '?');

    if ($position !== false) {
        $path = substr($request_uri, 0, $position);
    } else {
        $path = $request_uri;
    }

    // Les doubles slash sont du bruit de format.
    while (str_contains($path, '//')) {
        $path = str_replace('//', '/', $path);
    }

    // Les slash et espaces aux frontières ne sont pas des segments.
    $path = trim($path, ' /');

    // Une route vide représente l'accueil.
    if ($path === '') {
        return [];
    }

    // La casse ne doit pas créer une autre route.
    $path = strtolower($path);

    // Un chemin sans slash contient un seul segment.
    if (strpos($path, '/') === false) {
        return [$path];
    }

    // Les slash internes séparent les segments.
    return explode('/', $path);
}

function http_out(int $code, string $body, array $headers = []): void
{
    // Le code HTTP appartient à la réponse, pas au HTML.
    http_response_code($code);

    // Les headers doivent être envoyés avant le body.
    foreach ($headers as $name => $value) {
        header($name . ': ' . $value);
    }

    // Le body est le contenu envoyé au client.
    echo $body;
}

function redirect(string $url): void
{
    // Version ergonomique de http_out() pour le cas fréquent de la redirection.
    http_out(302, '', ['Location' => $url]);
    exit;
}

function is_post(): bool
{
    // Version ergonomique pour éviter de lire $_SERVER directement dans les controllers.
    return ($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'POST';
}
