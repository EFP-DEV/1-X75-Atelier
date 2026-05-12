```php
<?php

/*
    core/html.php

    Proof of concept pédagogique.

    Ce fichier contient les utilitaires minimaux pour produire du HTML.

    Fonctions nécessaires :
    - render()
    - escape()

    Ce n'est pas un moteur de template complet.

    Le but est de montrer le passage entre :

        fichier de vue
            ↓
        données fournies par le controller
            ↓
        HTML produit
            ↓
        chaîne de caractères retournée

    Les vues peuvent afficher du HTML.
    Les controllers préparent les données.
    render() relie les deux.

    La fonction render() ne fait pas echo.
    Elle retourne le HTML pour que le front controller
    puisse ensuite l'envoyer avec http_out().
*/

function render(string $filepath, array $data = []): string
{
    // Une vue doit être un vrai fichier existant.
    if (!is_file($filepath)) {
        throw new RuntimeException('View not found: ' . $filepath);
    }

    // Les clés du tableau deviennent des variables disponibles dans la vue.
    // Exemple : ['title' => 'Accueil'] devient $title dans le fichier.
    extract($data);

    // On démarre une mémoire temporaire pour capturer ce que la vue affiche.
    ob_start();

    // La vue est exécutée ici.
    // Son HTML est capturé au lieu d'être envoyé directement au navigateur.
    require $filepath;

    // Le HTML capturé est récupéré sous forme de chaîne de caractères.
    return ob_get_clean();
}

function escape(string $value): string
{
    // Convertit les caractères spéciaux pour éviter qu'une valeur devienne du HTML actif.
    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}
```
