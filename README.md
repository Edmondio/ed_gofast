
# ED GoFast

Voici un Gofast pour Fivem avec menu en RageUI Entièrement personnalisable graçe au config. Developper et tester sous la version ESX 1.9.4




## Preview




![Logo](https://i.imgur.com/3rGJJFD.png)
https://www.youtube.com/watch?v=YQeKz-PC438



## Installation


```bash
  Télécharge la dernière Releases
  Configure le config.lua
  ensure ed_gofast
  
```
    
## Fonctionnement

Fonctionnement :

    Maximum de 10 Gofast disponibles, variable incrémentée ou soustraite depuis la BDD.

    Choix de 4 drogues différentes.

    Pour prendre le Gofast, il faut de l'argent sale ou propre et le prix est configurable.

    Une fois le GF lancé, le joueur reçoit un objet en fonction de la drogue choisie. (Attention, ajoutez les objets correspondants dans la BDD.)

    Les informations de la police sont fournies par des blips avec un temps configurable entre chaque blip.

    La durée du GF est configurable (deux valeurs pour ajouter un peu d'aléatoire)

    Un blip de livraison est fourni quand il reste moins de 30 secondes au temps.

    Le temps pour livrer le GF une fois que le GPS est brouillé est configurable.

    La livraison enlève l'objet (qui doit être dans l'inventaire du joueur) et donne de l'argent (configurable de manière aléatoire).

Extra :

    Vérifie pendant le GoFast que le joueur est toujours dans le véhicule avant d'envoyer une notification.

    Si le véhicule est détruit ou n'existe plus dans le monde, arrêtez l'envoi du blip pour la police.

    La liste des véhicules est configurable.

    Un PNJ permet de racheter les sacs sans avoir nécessairement pris part à un GoFast (en cas de vol par d'autres joueurs). Le prix de revente est basé sur le prix de la weed (-100 + 100) et est déterminé aléatoirement (vendeur 5 dans la configuration).

    Il y a 4 vendeurs avec un emplacement configurable.

    Les jobs de la police BCSO sont configurables.

    Le temps entre chaque GoFast est configurable pour éviter le spam de GoFast par un même joueur.

    Si le véhicule est déjà présent sur l'emplacement de spawn, la suppression du spawn est impossible.

    Cette fonctionnalité est compatible avec Ox_inventory.

    Elle prend également en charge LegacyFuel (défini dans la configuration).





## License

MIT License

Copyright (c) 2023 Edmondio

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

