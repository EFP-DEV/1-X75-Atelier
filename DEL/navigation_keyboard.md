# Navigation au clavier

> **Pourquoi c’est important ?**  
> La navigation au clavier permet à toute personne qui ne peut pas (ou ne souhaite pas) utiliser une souris de parcourir et d’interagir avec votre site. Cela inclut :  
> - Les utilisateurs à mobilité réduite.  
> - Les personnes malvoyantes utilisant un lecteur d’écran.  
> - Les utilisateurs avancés qui préfèrent les raccourcis clavier pour aller plus vite.  

---

## 1. L’ordre de tabulation : logique et naturel  
1. **Suivre l’ordre visuel**  
   - Les éléments focusables doivent apparaître dans le même ordre que dans le rendu visuel.  
   - **Exemple** : si le champ “Nom” est au-dessus de “Email” dans le formulaire, il doit aussi être tabulé avant.  

2. **Éviter les `tabindex` non nuls**  
   - N’utilisez `tabindex="1"` (ou plus) que si vous repensez entièrement l’ordre — c’est rarement nécessaire.  
   - Préférez `tabindex="0"` pour rendre focusable un élément non-focusable par défaut (p. ex. un `<div>` qui agit comme un bouton).  
   - **Ne jamais** utiliser `tabindex="-1"` sur un élément que l’on veut atteindre au clavier.  

```html
<!-- Bon exemple : le bouton est naturellement focusable -->
<button>Envoyer</button>

<!-- Pour un div personnalisé, on ajoute tabindex="0" -->
<div role="button" tabindex="0">Lire la suite</div>
```

---

## 2. Visibilité du focus : guider le regard  
- **Styles CSS** :  
  - Gardez le contour de focus (`:focus`) ou personnalisez-le (couleur vive, e.g. une bordure épaisse).  
  - Évitez `outline: none;` sans remplacement visible.  

```css
/* Exemple de focus visible */
.button:focus {
  outline: 3px dashed #0066cc;
  outline-offset: 2px;
}
```

---

## 3. Composants riches : règles dédiées  
| Composant    | Actions clavier                            | Rôles ARIA                                      |
|--------------|--------------------------------------------|--------------------------------------------------|
| Menu déroulant | `Enter`/`Space` pour ouvrir/fermer<br>`↑`/`↓` pour naviguer<br>`Esc` pour fermer | `role="menubar"` + `role="menuitem"`             |
| Onglets      | `Tab` pour passer à la barre d’onglets<br>`←`/`→` pour changer d’onglet | `role="tablist"` + `role="tab"` + `aria-selected` |
| Modal/dialogue | `Tab` cyclique à l’intérieur<br>`Esc` pour fermer | `role="dialog"` + `aria-modal="true"`            |

---

## 4. Lien « Aller au contenu »  
- Placez tout en haut de la page un lien “skip link” qui devient visible au focus :  

```html
<a href="#main-content" class="skip-link">Aller au contenu</a>
<main id="main-content">
  <!-- ... -->
</main>
```

- **CSS** pour n’afficher que lorsqu’on tabule :  

```css
.skip-link {
  position: absolute;
  left: -999px;
  top: auto;
  width: 1px;
  height: 1px;
}
.skip-link:focus {
  left: 0;
  width: auto;
  height: auto;
  padding: 8px;
  background: #000;
  color: #fff;
}
```

---

## 5. Tester et valider  
1. **Manuellement**  
   - Parcourez votre site uniquement au clavier : Tab, Shift+Tab, Enter, Space, Esc.  
   - Vérifiez que tous les éléments interactifs sont accessibles et que l’ordre fait sens.  
2. **Outils automatisés**  
   - **Lighthouse** (onglet Accessibilité).  
   - **axe-core** (extension Chrome/Firefox).  
   - **NVDA** (lecteur d’écran gratuit sous Windows).  

---

> 💡 **Astuce pédagogique :**  
> Organisez une session « audit clavier » avec un collègue : l’un navigue à la souris, l’autre au clavier, et comparez vos parcours !  
```
