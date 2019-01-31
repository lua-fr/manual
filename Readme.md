# Traduction non officielle du manuel Lua

Ce dépôt contient le début (pour le moment) de la traduction du manuel
Lua disponible en suivant ce lien http://www.lua.org/manual/.
La traduction se fait à partir du fichier `manual.of` disponible
[ici](https://github.com/lua/manual) afin de profiter d'un format structuré
exportable en html (et peut être en markdown).

## Consignes

Le format .of est un format propre aux mainteneurs de Lua.
Il contient différentes balises qui structurent le contenu mais aussi donne
des indications sur sa forme.
Aussi ces balises doivent être conservées autant que possible lors de la traduction.
Voici une liste non-exhaustive des balises dont le contenu peut être traduit.
(Cette liste est aussi un rappel de l'utilité des balise et de leur impact notamment
sur le rendu html espéré)

  - `@sect` : début de section (doit contenir une balise `title`)
  - `@APIEntry`, `@LibEntry` : création d'une entrée pour une fonction de l'API C ou de la lib standard de Lua
  - `@title`  : titre de section
  - `@Q` : entoure le contenu de guillemet (citation peut être)
  - `@N` : remplace les espaces par des espaces insécables
  - `@def`, `@emph`, `@emphx` : mets en italique
  - `@x` : ne fait rien

La balise `@C` permet d'insérer des commentaires dans le .of

## Termes techniques, formulations bancales et remarques en vrac

Nous n'avons pas encore décidé si oui ou non nous devions traduire les termes techniques.
Parmi ces termes se trouvent `chunk`, `string`, `upvalue`, `metamethod`, `metatable`, `garbage collector`, `long bracket`…

Le terme `upvalue` est utilisé plusieurs fois avant d'être défini dans le manuel, il s'agit d'une variable locale externe au scope d'une fonction. À voir s'il faut donner le sens la première fois qu'on le rencontre.

Le rôle du `step multiplier` est pas très clair pour le garbage collector. Le découpage d'un cycle en plusieurs étapes non plus.

## Outils

En attendant d'avoir une première version complète, nous utilisons plusieurs outils :

 - [Framapad](https://framapad.org/) pour faire la traduction collaborative
 - [po4a](http://po4a.alioth.debian.org/) qui permet d'isoler le fond de la forme
 - [poedit](https://poedit.net/) pour traduire le fond
 - un [script maison](./tools/of_to_html.lua) pour traduire le .of en .html




