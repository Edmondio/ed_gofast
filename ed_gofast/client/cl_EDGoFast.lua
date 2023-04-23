---- DEV EDMONDIO ---- https://edmondio.info


local ESX = exports["es_extended"]:getSharedObject()
Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
    end
end)

-- Declaration des variables local ---

local SpawnVehicule = vector3(Config.SpawnVehicule.x, Config.SpawnVehicule.y, Config.SpawnVehicule.z)
local SpawnHeading = Config.SpawnVehicule.heading
local lancer = false
local count = 0
local nogofast = 1
local listdrugs = 1
local vente = false
local blip = nil
local emplacement_vente = ""
local type_drogue = nil
local isDrogueGiven = false
local erreur_spaw_veh = 0
local vente_possible = false
--- Menu
local listactive = true
local buttonactive = false
local mainMenu = RageUI.CreateMenu('Illegal', 'interaction')
local mainMenu2 = RageUI.CreateMenu('Acheteur', 'interaction')
local SubMenu = RageUI.CreateSubMenu(mainMenu, "Quantité", "choisissez la cocaine")

-- Declaration des variables local ---

-- Compte le nombre de police --

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	TriggerServerEvent("ed_gofast:countcops", source, cb)
	canRob = cb

end)

-- Fin Compte le nombre de police --

-- Gestion des PNJS --

local npcs = {
	{
	  model = "s_m_y_dockwork_01",
	  coords = Config.Achat,
	  frozen = true, --PNJ toujours activer (c'est le vendeur en même temps)
	  reference = "Fournisseur",
	  active = true,
	  interaction = function()
		ESX.TriggerServerCallback("ed_gofast:countcops", function(canRob)
			ESX.TriggerServerCallback('ed_gofast:getCount', function(countFromServer)
				Wait(10)
				count = countFromServer
				if canRob and count > 0 then
					if nogofast == 1 then
						gofastmenu()
					else
						ESX.ShowAdvancedNotification("", "~b~Inconnu", "Tu te fous de moi ? Termine le boulot avant !", "CHAR_MULTIPLAYER", 7)
					end
				else
					ESX.ShowAdvancedNotification("", "~b~Inconnu", "Pas de stock reviens plus tard", "CHAR_MULTIPLAYER", 7)
				end
			end)
		end)
	end
	},
	{
	  model = "s_m_y_dockwork_01",
	  coords = Config.Vente1,
	  frozen = true,
	  reference = "Vendeur1",
	  active = true, -- 
	  interaction = function()
			gofastventemenu()
		end
	},
	{
		model = "s_m_y_dockwork_01",
		coords = Config.Vente2,
		frozen = true,
		reference = "Vendeur2",
		active = true,
		interaction = function()
			gofastventemenu()
		end
	},
	{
		model = "s_m_y_dockwork_01",
		coords = Config.Vente3,
		frozen = true,
		reference = "Vendeur3",
		active = true,
		interaction = function()
			gofastventemenu()
		end
	  },
	  {
		model = "s_m_y_dockwork_01",
		coords = Config.Vente4,
		frozen = true,
		reference = "Vendeur4",
		active = true,
		interaction = function()
			gofastventemenu()
		end
	  },
	  {
		model = "s_m_y_dockwork_01",
		coords = Config.Vente5,
		frozen = true,
		reference = "Vendeur5",
		active = true,
		interaction = function()
			SellDrogueOnly()
		end
	  }
  }

  -- Crer les pnjs --

  Citizen.CreateThread(function()
    for i, npc in ipairs(npcs) do
        if npc.active then -- Vérifier si l'attribut "active" est true
            local npcHash = GetHashKey(npc.model)
            while not HasModelLoaded(npcHash) do
                RequestModel(npcHash)
                Citizen.Wait(10)
            end
            local npcPed = CreatePed(4, npcHash, npc.coords.x, npc.coords.y, npc.coords.z, npc.coords.heading, npc.frozen, true)
            SetEntityInvincible(npcPed, true) -- rendre le PNJ invincible
            FreezeEntityPosition(npcPed, npc.frozen) -- geler la position du PNJ
            SetPedCanBeTargetted(npcPed, false) -- Empecher le PNJ d'être cilbé par les joueurs
            SetPedCanRagdoll(npcPed, false) -- désactiver la possibilité que le PNJ tombe au sol ou soit étourdi
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskPlayAnim(ped, animation, "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        end
    end
end)
  -- fin crer pnj --
  
  -- Ajouter l'interaction avec les PNJ

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  local playerPed = PlayerPedId()
	  local playerCoords = GetEntityCoords(playerPed)
	  for i, npc in ipairs(npcs) do
		if npc.active then -- Vérifier si l'attribut "active" est true
		  local distance = #(playerCoords - vector3(npc.coords.x, npc.coords.y, npc.coords.z))
		  if distance < 3 then
			--ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~", 2000)
			if IsControlJustReleased(0, Config.KeyIntercation) then
			  npc.interaction() -- Appeler l'interaction spécifique du PNJ
			end
		  end
		end
	  end
	end
  end)


-- -- Gestion des PNJS --

-- MENU ACHAT --

mainMenu.Closed = function()
	lancer = false
end

function gofastmenu()
	local playerPed = PlayerPedId()
	local playerMoney = ESX.GetPlayerData().dirtyMoney -- récupère l'argent sale du joueur du joueur
	ESX.TriggerServerCallback('ed_gofast:getCount', function(countFromServer)
		Wait(10)
		count = countFromServer
	end)

    if lancer then 
        lancer = false
        RageUI.Visible(mainMenu, false)
        return
    else
        lancer = true 
        RageUI.Visible(mainMenu, true)
        CreateThread(function()
       		while lancer and count > 0 do 
           		RageUI.IsVisible(mainMenu,function() 
					RageUI.List("Type de drogue", {"Weed (~r~$" .. Config.PrixAchat.weed .. ")~s~", "Coke (~r~$" .. Config.PrixAchat.coke .. ")~s~", "Opium (~r~$" .. Config.PrixAchat.opium .. ")~s~",	"Meth (~r~$" .. Config.PrixAchat.meth .. ")~s~"}, listdrugs, nil, {}, listactive, {
						onListChange = function(list) listdrugs = list end,
						onSelected = function(list)
							if list == 1 then
								price = Config.PrixAchat.weed
								listactive = false
								buttonactive = true
								type_drogue = 'sac_weed'
							elseif list == 2 then
								price = Config.PrixAchat.coke
								listactive = false
								buttonactive = true
								type_drogue = 'sac_coke'
							elseif list == 3 then
								price = Config.PrixAchat.opium
								listactive = false
								buttonactive = true
								type_drogue = 'sac_opium'
							elseif list == 4 then
								price = Config.PrixAchat.meth
								listactive = false
								buttonactive = true
								type_drogue = 'sac_meth'
							end
						end
					})

					if count > 0 then
						argentOk = false
						RageUI.Button("Lancer le GoFast", "Nombre de Gofast disponible : ~b~"..count.."", {RightLabel = "→"}, buttonactive, {
							onSelected = function()
								SpawnDuVehicule(price)
								Wait(2000)
								if erreur_spaw_veh == 0 then
									TriggerServerEvent('ed_gofast:takeGofastCount')
									RageUI.CloseAll()
									lancer = false
									ESX.ShowAdvancedNotification("Complice", "~r~Message du Complice", "Je te contact rapidement pour te fournir les coordonées GPS de la livraison, fait gaffe à la caisse", "CHAR_MP_ROBERTO", 7)
									Citizen.Wait(15*1000)
									ESX.ShowAdvancedNotification("Complice", "~r~Message du Complice", "Une taupe t'as balancé aux poulets ! ~r~Ils ont ton signal GPS ! Je reviens vers toi ! ", "CHAR_MP_ROBERTO", 7)
									TriggerServerEvent('ed_gofast:renfort')
									Wait(Config.Duree.EntreGF*60000) -- Temps avant de pouvoir reprendre un GF defini dans le config
									nogofast = 1
									lancer = true
									buttonactive = false
								end
							end
						})
					else
						ESX.ShowAdvancedNotification("", "~b~Inconnu", "Revient plus tard", "CHAR_MULTIPLAYER", 7)
					end
					Wait(0)
           		end)
        	end			
     	end)
  	end
end




-- FIN MENU ACHAT --

-- MENU VENTE --

mainMenu2.Closed = function()
	vente = false
end

function gofastventemenu()
    if vente then 
        vente = false
        RageUI.Visible(mainMenu2, false)
        return
    else
        vente = true
        RageUI.Visible(mainMenu2, true)
        CreateThread(function()
        	while vente do 
           		RageUI.IsVisible(mainMenu2,function() 
            		RageUI.Button("Vendre", nil, {RightLabel = "→"}, true , {
               			onSelected = function()	
							time = 1
							local veh = GetVehiclePedIsIn(ped, false)
							RageUI.CloseAll()
							Wait(500)
							FinDeGoFast(price)
							lancer = true
               			end
            		})  
           		end)
         	Wait(0)
        	end
    	end)
  	end
end

function SellDrogueOnly()
    if vente then 
        vente = false
        RageUI.Visible(mainMenu2, false)
        return
    else
        vente = true
        RageUI.Visible(mainMenu2, true)
        CreateThread(function()
            while vente do 
                RageUI.IsVisible(mainMenu2,function() 
                    RageUI.Button("Vendre", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                            RageUI.CloseAll()
                            Wait(500)
                            Vente_drogue_seul()
                            lancer = true
                        end
                    })  
                end)
                Wait(0)
            end
        end)
    end
end

function Vente_drogue_seul()
	local inventory = ESX.GetPlayerData().inventory
	local nbSacWeed = 0
	local nbSacMeth = 0
	local nbSacCoke = 0
	local nbSacOpium = 0
	local prixSac = Config.PrixAchat.weed

	for i=1, #inventory, 1 do
		if inventory[i].name == 'sac_weed' then -- On regarde combien de sac à le joueur 
			nbSacWeed = inventory[i].count
        elseif inventory[i].name == 'sac_meth' then
			nbSacMeth = inventory[i].count
		elseif inventory[i].name == 'sac_coke' then
			nbSacCoke = inventory[i].count
		elseif inventory[i].name == 'sac_opium' then
			nbSacOpium = inventory[i].count
		end
    end
	if nbSacWeed > 0 then
		TriggerServerEvent('ed_gofast:venteDrogueSeul', 'sac_weed', nbSacWeed, prixSac) -- On vend les sac de weed
	end
	if nbSacMeth > 0 then
		TriggerServerEvent('ed_gofast:venteDrogueSeul', 'sac_meth', nbSacMeth, prixSac) -- On vend les sac de meth
	end	
	if nbSacCoke > 0 then
		TriggerServerEvent('ed_gofast:venteDrogueSeul', 'sac_coke', nbSacCoke, prixSac) -- pareil coke
	end	
	if nbSacOpium > 0 then
		TriggerServerEvent('ed_gofast:venteDrogueSeul', 'sac_opium', nbSacOpium, prixSac) -- pareil  opium
	end
	if nbSacWeed + nbSacMeth + nbSacCoke + nbSacOpium == 0 then
		ESX.ShowAdvancedNotification("", "~b~Inconnu", "Rien à acheter", "CHAR_MULTIPLAYER", 7)
	end
end

-- FIN MENU VENTE --

-- GESTION VEHICULE SPAW --

function SpawnDuVehicule(price)
	local ped = PlayerPedId()
	-- Liste des vehicules du spawn
	local list = Config.Vehicules -- Utilisation de la liste de véhicules du fichier de configuration
	local index = list[math.random(1,#list)] -- Utilisation de #list pour obtenir la longueur de la liste
	local vehicle = GetHashKey(index)
	local spawn = ESX.Game.IsSpawnPointClear(SpawnVehicule, 2.0)
	local time = 0
	if spawn then
		ESX.TriggerServerCallback('ed_gofast:checkMoney', function(argentOk)
			if argentOk then
				TriggerServerEvent('ed_gofast:giveDrogue', type_drogue)
				Wait(500)
				if isDrogueGiven then
					erreur_spaw_veh = 0
					TriggerServerEvent('ed_gofast:takeMoney', price)
					local plateModele = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
					local plaque = ""
					-- Génération de la plaque d'immatriculation aléatoire
					for i = 1, 7 do
						local rand = math.random(1, #plateModele)
						plaque = plaque .. string.sub(plateModele, rand, rand)
					end
					ESX.Game.SpawnVehicle(vehicle, SpawnVehicule, SpawnHeading, function(veh)
						RequestModel(vehicle)
						SetVehicleNumberPlateText(veh, plaque)
						SetModelAsNoLongerNeeded(veh) -- Libère la mémoire du modèle chargé en mémoire opitmisation
						SetVehicleAsNoLongerNeeded(veh) -- Libère la mémoire du veh specifié en tant qu'objet chargé en mémoire opitmisation
						SetVehicleColours(veh, 0, 0) -- Couleur noire
						SetVehicleWindowTint(veh, 5) -- Vitres teintées
						SetVehicleMod(veh, 11, 3, false) -- turbo
						SetVehicleMod(veh, 12, 2, false) -- transmission de course
						SetVehicleMod(veh, 15, 3, false) -- freins de course
						if Config.LegacyFuel then
							exports["LegacyFuel"]:SetFuel(veh, 100)
						end
						nogofast = 0
						message(veh)
					end)
					vehiclePlate = plaque
				else
					ESX.ShowNotification("Pas de place sur toi pour prendre la dope")
					erreur_spaw_veh = 1
				end
			else
				ESX.ShowAdvancedNotification("", "~b~Inconnu", "Tu crois que c'est gratos ?", "CHAR_MULTIPLAYER", 7)
				erreur_spaw_veh = 1
			end
		end, price)
	else
		ESX.ShowNotification("Il y a déjà un véhicule")
		erreur_spaw_veh = 1
	end
end

-- FIN Gestion du spaw veh --

-- Gestion du Go Fast --

function message(veh)
	Citizen.CreateThread(function()
		local dureeVisible = math.random(Config.Duree.VisibleMin, Config.Duree.VisibleMax) -- Faire un random entre la durée min et la durée maximum
		local executedScript = false -- variable pour savoir si le script a déjà été exécuté
		local executedScript2 = false -- variable pour savoir si le script a déjà été exécuté
		dureeVisible = dureeVisible + (10 - dureeVisible % 10) % 10 -- Utilise la fonction modulo (%) permet d'arrondir au multiple de 10 superieur (exemple : va voir sur google)
		dureeTotal = dureeVisible 
		Citizen.Wait(15*1000) -- Attente de 15 secondes
		while dureeVisible > 0 do
			Citizen.Wait(Config.Duree.Blips*1000) -- Attente entre chaque blips 10 secondes par defaut
			if not DoesEntityExist(veh) then -- Vérifier si le véhicule existe encore ou détruit
				TriggerServerEvent('ed_gofast:stoprenfort') -- On stop le blip si plus de voiture
				break
			end
			local coords = GetEntityCoords(veh)
			TriggerServerEvent("ed_gofast:messagelspd", coords) -- on envoi que on flic 
			if not executedScript and dureeVisible <= (dureeTotal / 2) then -- Vérifier si la moitié du temps est écoulée et si le script n'a pas été exécuté
				executedScript = true -- passe en vrai pour faire le script qu'une seule fois
				if IsPedInVehicle(PlayerPedId(), veh, false) then
					ESX.ShowAdvancedNotification("Complice", "~r~Message du Complice", "J'y suis presque tient bon !", "CHAR_MP_ROBERTO", 7)				
				end 							
			end
			if not executedScript2 and dureeVisible <= 30 then -- Vérifier si la moitié du temps est écoulée et si le script n'a pas été exécuté
				executedScript2 = true -- passe en vrai pour faire le script qu'une seule fois
				if IsPedInVehicle(PlayerPedId(), veh, false) then
					ESX.ShowAdvancedNotification("Complice", "~r~Message du Complice", "Donne moi encore un peu de temps, voilà les coordonées de livraison", "CHAR_MP_ROBERTO", 7)
					gofastvente()
					vente_possible = true
				end
			end

			dureeVisible = dureeVisible - Config.Duree.Blips
		end
		if dureeVisible <= 0 then -- Execute si la boucle à terminer donc que duree envoi est = 0 et le temps terminer
			if IsPedInVehicle(PlayerPedId(), veh, false) then
				ESX.ShowAdvancedNotification("Complice", "~r~Message du Complice", "C'est bon j'ai réussi à brouiller ton signal GPS, dépêche-toi il te reste "..Config.Duree.BlipsVendeur.." minutes", "CHAR_MP_ROBERTO", 7)	
				RemoveBlipVente(blip)
			end			
		end
		TriggerServerEvent('ed_gofast:stoprenfort')
	end)
end

function gofastvente()
	local random = math.random(1,4)
	if random == 1 then
		blip = AddBlipForCoord(Config.Vente1.x, Config.Vente1.y, Config.Vente1.z)
		SetBlipSprite(blip, 1)
		SetBlipColour(blip, 66)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vendeur")
		EndTextCommandSetBlipName(blip)
		emplacement_vente = Config.Vente1.emplacement
		TriggerServerEvent('emplacement_vente', emplacement_vente)
	elseif random == 2  then
		blip = AddBlipForCoord(Config.Vente2.x, Config.Vente2.y, Config.Vente2.z)
		SetBlipSprite(blip, 1)
		SetBlipColour(blip, 66)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vendeur")
		EndTextCommandSetBlipName(blip)
		emplacement_vente = Config.Vente2.emplacement

		TriggerServerEvent('emplacement_vente', emplacement_vente)
	elseif random == 3  then
		blip = AddBlipForCoord(Config.Vente3.x, Config.Vente3.y, Config.Vente3.z)
		SetBlipSprite(blip, 1)
		SetBlipColour(blip, 66)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vendeur")
		EndTextCommandSetBlipName(blip)
		emplacement_vente = Config.Vente3.emplacement
		TriggerServerEvent('emplacement_vente', emplacement_vente)
	elseif random == 4  then
		blip = AddBlipForCoord(Config.Vente4.x, Config.Vente4.y, Config.Vente4.z)
		SetBlipSprite(blip, 1)
		SetBlipColour(blip, 66)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vendeur")
		EndTextCommandSetBlipName(blip)
		emplacement_vente = Config.Vente4.emplacement
		TriggerServerEvent('emplacement_vente', emplacement_vente)
	else 
		ESX.ShowNotification("Valeur invalide")
		emplacement_vente = "Inconnu"
		TriggerServerEvent('emplacement_vente', emplacement_vente)	
	end
end

function FinDeGoFast(price)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn( ped, false )
	local plate = GetVehicleNumberPlateText(vehicle)
	if plate ~= nil and vehiclePlate ~= nil then
		plate = string.gsub(plate, "%s", "")
		vehiclePlate = string.gsub(vehiclePlate, "%s", "")
		if plate == vehiclePlate and vente_possible then
			ESX.TriggerServerCallback('ed_gofast:checkDeleteDrogue', function(isDeleted)
				Citizen.Wait(1000)
				if isDeleted then
					TriggerServerEvent('ed_gofast:deleteDrogue', type_drogue)
					--ESX.Game.DeleteVehicle(vehicle)
					RemoveBlip(blip)
					ESX.ShowAdvancedNotification("GoFast", "~b~Inconnu", "C'est ok voilà la thunes, débrouille toi avec le vehicule", "CHAR_MULTIPLAYER", 7)
					Wait(500)
					TriggerServerEvent("ed_gofast:venteduvehicle", vehe, price)
				else
					ESX.ShowAdvancedNotification("", "~b~Inconnu", "Tu as pas la drogue, dégage", "CHAR_MULTIPLAYER", 7)
				end
			end, type_drogue, 1)
		else
			ESX.ShowAdvancedNotification("", "~b~Inconnu", "Pas intéressé ", "CHAR_MULTIPLAYER", 7)
		end
	else
		ESX.ShowAdvancedNotification("", "~b~Inconnu", "Pas intéressé ", "CHAR_MULTIPLAYER", 7)
	end
end

RegisterNetEvent('ed_gofast:argentOk') --Recupere la vraiable argent ok en true ou false pour le lancement GOFAST
AddEventHandler('ed_gofast:argentOk', function(argentOkServer)
    argentOk = argentOkServer
end)


-- FIN Gestion du Go Fast --

-- Gestion des BLIPS --

function RemoveBlipVente(blip) -- Permet de supprimer le Blips au bout de 20 minutes
	Citizen.CreateThread(function()
	  Citizen.Wait(Config.Duree.BlipsVendeur * 60 * 1000) -- Attends 20 minutes
	  vente_possible = false
	  if DoesBlipExist(blip) then
		RemoveBlip(blip)
	  end
	end)
end


RegisterNetEvent('ed_gofast:setBlip')
AddEventHandler('ed_gofast:setBlip', function(coords)
	CreateThread(function()
		if not (coords == nil) then
			local blip = AddBlipForCoord(coords)
			SetBlipSprite(blip, 161)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 1)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString("GOFAST")
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip, true)
			PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
			SetTimeout(20000, function()
				RemoveBlip(blip)
			end)
		else
			RemoveBlip(blip)
		end
	end)
end)

-- FIN Gestion des BLIPS --

-- Gestion de verification inventaire -- 

RegisterNetEvent('ed_gofast:giveDrogueSuccess')
AddEventHandler('ed_gofast:giveDrogueSuccess', function(success)
    isDrogueGiven = success
end)