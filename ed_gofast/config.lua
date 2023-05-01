---- DEV EDMONDIO ---- https://edmondio.info

----- CONFIG GENERAL ---------

Config = {
    PoliceMinimum = 1, -- Nombre de policier / (LSPD et BCSO) qui doivent être en ligne pour pouvoir lancer un Gofast
    LegacyFuel = false, -- Mettre sur true si vous utiliez legacyfuel pour gérer l'essence des vehciules
    KeyIntercation = 38, -- Touche utiliser pour interagir avec les pnj (par defaut E) 
    TypeArgent = 'black_money', -- Ici pour change quel type d'argent vous voulez pour payer et pour etre payer argent sale = black_money | argent propre = money
    GKSphone = false, -- True si vous voulez envoyé la notification aux jobs police
    GKSJobs = "['police' , 'bcso']"
 }

 Config.JobsPolice = { 'police', 'bcso' } -- Liste des jobs pour pouvoir lancer le GoFast

 Config.Duree = {

    VisibleMin = 60, -- [EN SECONDE] C'est la durée MINIMUM pendant lequel le joueur va être visible par la police ----| SI VOUS VOULEZ UNE DUREE FIXE 
    VisibleMax = 90, -- [EN SECONDE] C'est la durée MAXIMUM pendant lequel le joueur va être visible par la police ----| METTRE LA MEME VALEUR 
    Blips = 10, -- [EN SECONDE] Durée entre chaque Blips pour la police par defaut 10 secondes
    EntreGF = 20, -- [EN MINUTES] Durée pendant lequel le joueur ne peut pas prendre de Gofast après en avoir pris un 
    GFsupplementaire = 10, -- [EN MINUTES] Incremente la varaible de la BDD de +1 toutes les X minutes (MAX 10 GF)
    BlipsVendeur = 10 -- [EN MINUTES] Durée pendant laquel le blips qui affiche le vendeur reste actif.
 }

----- CONFIG PRIX ---------

 Config.PrixAchat = {
    weed = 500,
    coke = 1000,
    meth = 2000,
    opium = 3000
    
 }

 -- Choisi un nombre aléatoire entre le minimum et le max pour un prix toujours le même mettre deux fois la même valeur
 Config.PrixRevente = {
    weed_minimum = 1000,
    weed_maximum = 2000,
    coke_minimum = 2000,
    coke_maximum = 4000,
    meth_minimum = 3000,
    meth_maximum = 5000,
    opium_minimum = 4000,
    opium_maximum = 6000
 }


----- CONFIG EMPLACEMENT ---------

Config.SpawnVehicule = { -- Emplacement du spawn du vehicule
    x = 836.54,
    y = -1155.48,
    z = 25.27,
    heading = 282.29
}

 Config.Achat = { -- Emplacement ou vous prenez le Gofast
    x = 833.89,
    y = -1168.54,
    z = 24.68,
    heading = 105.07
}

Config.Vente1 = { --Emplacement de vente
    x = -827.78,
    y = -2919.66,
    z = 12.97,
    heading = 270.77,
    emplacement = 'il ce dirige vers les docks'
}

Config.Vente2 = { --Emplacement de vente 2
    x = 3808.16,
    y = 4475.83,
    z = 3.54,
    heading = 186.64,
    emplacement = 'il ce dirige vers la côte Est'
}

Config.Vente3 = { --Emplacement de vente 3
    x = 1646.8,
    y = 4839.7,
    z = 41.03,
    heading = 103.64,
    emplacement = 'il ce dirige vers Grapseed'
}

Config.Vente4 = { --Emplacement de vente 4 
    x = -50.17,
    y = 1950.05,
    z = 189.19,
    heading = 118.39,
    emplacement = 'il ce dirige vers le nord de la ville'
}

Config.Vente5 = { --Emplacement de vente 4 ACHETE TOUT TYPE DE DROGUE point jamais envoyé lors d'un Gofast (Utile en cas de vol de drogue entre les joueurs)
    x = -474.08,
    y = 6285.35,
    z = 12.61,
    heading = 322.45
}


----- CONFIG TYPE DE VEHICULE DISPO ---------
-- Vous pouvez ajouter autant de vehicule que vous voulez :)

Config.Vehicules = {
    "GB200", 
    "NOVAK", 
    "REBLA", 
    "IWAGEN", 
    "ASTRON", 
    "BALLER7", 
    "TOROS"
}