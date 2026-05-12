<?php

// Router.php

function route(array $http_segments): array
{
    foreach ($http_segments as $segment) {
        if ($segment !== null && !is_safe_segment($segment)) {
            throw new InvalidArgumentException('Invalid route segment: ' . $segment);
        }
    }

    $route = [];

    $route['entity'] = $http_segments[0] ?? 'home';
    $route['action'] = $http_segments[1] ?? 'index';
    $route['id']     = $http_segments[2] ?? null;

    return $route;
}

function run(array $route): string
{
    $controller_filepath = __DIR__ . '/controllers/' . $route['entity'] . '.php';
    $function_name = $route['entity'] . '_' . $route['action'];

    if (!is_file($controller_filepath)) {
        throw new RuntimeException('Controller not found: ' . $route['entity']);
    }

    require_once $controller_filepath;

    if (!function_exists($function_name)) {
        throw new RuntimeException('Controller function not found: ' . $function_name);
    }

    if ($route['id'] !== null) {
        return $function_name($route['id']);
    }

    return $function_name();
}

function is_safe_segment(string $part): bool
{
    if ($part === '') {
        return false;
    }

    $allowed = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-';
    $length = strlen($part);

    for ($i = 0; $i < $length; $i++) {
        if (strpos($allowed, $part[$i]) === false) {
            return false;
        }
    }

    return true;
}


