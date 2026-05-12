<?php

function render(string $filepath, array $data = []): string
{
    if (!is_file($filepath)) {
        throw new RuntimeException('View not found: ' . $filepath);
    }

    extract($data);

    ob_start();

    require $filepath;

    return ob_get_clean();
}

function escape(string $value): string
{
    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}
