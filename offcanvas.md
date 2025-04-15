# Mail de ton mentor

Salut mandaï,

Tu vas reprendre la main sur un vieux backend basé sur Bootstrap, chezfernande, dont le développeur original n'est plus dans la boîte. L'idée est d'ajouter un menu latéral accessible rapidement pour faciliter le travail quotidien de la secrétaire, qui utilise un lecteur d'écran. Vu que c’est un ancien projet, ne touche surtout à rien dans l’existant : tu peux uniquement ajouter du code HTML juste avant la fermeture de la balise `</body>`. Évite absolument d’intégrer de nouvelles librairies, et garde ton code aussi minimal que possible.

Si tu es à l'aise avec Bootstrap (version ?), n'hésite pas à l'utiliser pour alléger ton CSS, mais attention : ne prends pas l'offcanvas natif de Bootstrap. Il faut absolument une solution personnalisée pour respecter au mieux l'accessibilité.

Pour que tu puisses avancer tranquillement, j'ai préparé une découpe claire du travail avec des étapes précises. Chaque étape a une durée indicative et un message de commit Git explicite pour bien garder les bonnes habitudes.

Voici les raccourcis que le menu devra intégrer :
```
Accueil
Messages
Paiements
-------------
Collection classique
Collection limitée
Guide des tailles
-------------
Clients
Ventes
Fournisseurs
Livreurs
```

Avec ça, tu devrais pouvoir avancer sans souci, en gardant en tête l'accessibilité, la robustesse et une bonne gestion du versionnement avec Git. Bon courage !

Ah oui, petite précision : le client ne veut pas nous donner accès à son backend, donc pour que tu puisses travailler tranquillement, j'ai préparé une version statique de l'admin avec un outil de scrapping. Tu la trouveras sur le repo [OffCanvas](https://github.com/EFP-DEV/1-X75-Atelier-OffCanvas).

Et.. si tu pouvais mettre un bouton-a-chat, ce serait genial (click, chat au milieu de lecran pour 4-5 sec, fade away)
Le chat doit absolument etre different a chaque fois, alors utilise thecatapi.com ou cataas.com
