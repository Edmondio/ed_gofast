# ed_gofast
Gofast for Fivem ESX 1.9


FR : 

Voici un Gofast pour Fivem avec menu en RageUI
Entièrement personnalisable graçe au config.
Developper et tester sous la version ESX 1.9.4

Je vous présente mon premier script.
C'est un GoFast développé et testé avec la dernière version de ESX 1.9.4.

Fonctionnement :

* Maximum de 10 Gofast disponibles, variable incrémentée ou soustraite depuis la BDD.

* Choix de 4 drogues différentes.

* Pour prendre le Gofast, il faut de l'argent sale ou propre et le prix est configurable.

* Une fois le GF lancé, le joueur reçoit un objet en fonction de la drogue choisie. (Attention, ajoutez les objets correspondants dans la BDD.)

* Les informations de la police sont fournies par des blips avec un temps configurable entre chaque blip.

* La durée du GF est configurable (deux valeurs pour ajouter un peu d'aléatoire)

.

* Un blip de livraison est fourni quand il reste moins de 30 secondes au temps.

* Le temps pour livrer le GF une fois que le GPS est brouillé est configurable.

* La livraison enlève l'objet (qui doit être dans l'inventaire du joueur) et donne de l'argent (configurable de manière aléatoire).

Extra :

* Vérifie pendant le GoFast que le joueur est toujours dans le véhicule avant d'envoyer une notification.

* Si le véhicule est détruit ou n'existe plus dans le monde, arrêtez l'envoi du blip pour la police.

* La liste des véhicules est configurable.

* Un PNJ permet de racheter les sacs sans avoir nécessairement pris part à un GoFast (en cas de vol par d'autres joueurs). Le prix de revente est basé sur le prix de la weed (-100 + 100) et est déterminé aléatoirement (vendeur 5 dans la configuration).

* Il y a 4 vendeurs avec un emplacement configurable.

* Les jobs de la police BCSO sont configurables.

* Le temps entre chaque GoFast est configurable pour éviter le spam de GoFast par un même joueur.

* Si le véhicule est déjà présent sur l'emplacement de spawn, la suppression du spawn est impossible.

* Cette fonctionnalité est compatible avec Ox_inventory.

* Elle prend également en charge LegacyFuel (défini dans la configuration).


Here is a Gofast for Fivem with RageUI menu
Fully customizable thanks to the config.
Developed and tested under ESX 1.9.4

I present you my first script.
This is a GoFast developed and tested with the latest version of ESX 1.9.4.

How it works:

* Maximum of 10 Gofast available, variable incremented or subtracted from the DB.

* Choice of 4 different drugs.

* To take the Gofast, you need dirty or clean money and the price is configurable.

* Once the GF is launched, the player receives an item according to the chosen drug. (Be careful, add the corresponding items in the DB).

* The information of the policy is provided by blips with a configurable time between each blip.

* The duration of the GF is configurable (two values to add some randomness)

.

* A delivery blip is provided when there is less than 30 seconds of time left.

* The time to deliver the GF once the GPS is scrambled is configurable.

* Delivery removes the item (which must be in the player's inventory) and gives money (randomly configurable).

Extra:

* Checks during the GoFast that the player is still in the vehicle before sending a notification.

* If the vehicle is destroyed or no longer exists in the world, stop sending the blip to the police.

* The list of vehicles is configurable.

* An NPC can buy back the bags without necessarily having taken part in a GoFast (in case of theft by other players). The resale price is based on the price of weed (-100 + 100) and is determined randomly (seller 5 in the configuration).

* There are 4 vendors with a configurable location.

* The jobs of the BCSO policy are configurable.

* The time between each GoFast is configurable to avoid GoFast spam by the same player.

* If the vehicle is already present on the spawn location, the spawn cannot be deleted.

* This feature is compatible with Ox_inventory.

* It also supports LegacyFuel (defined in the configuration).
