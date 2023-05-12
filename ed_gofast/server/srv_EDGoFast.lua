---- DEV EDMONDIO ---- https://edmondio.info

local ESX = exports["es_extended"]:getSharedObject()
local count = 0 -- Intialise la variable count à 0 pour eviter tout problème 
local countpolice = 0
local emp_vente = "Inconnu"

ESX.RegisterServerCallback("ed_gofast:countcops", function(source, cb)
     local countpolice = 0
     local xPlayers = ESX.GetPlayers()   
     for i = 1, #Config.JobsPolice do
         local job = Config.JobsPolice[i]      
         for j = 1, #xPlayers do
             local xPlayer = ESX.GetPlayerFromId(xPlayers[j])          
             if xPlayer.job.name == job then
                 countpolice = countpolice + 1
             end
         end
     end    
     if countpolice >= Config.PoliceMinimum then
         cb(true)
     else
         cb(false)
     end
 end)

RegisterServerEvent("ed_gofast:messagelspd")
AddEventHandler("ed_gofast:messagelspd", function(coords)
    local xPlayers = ESX.GetPlayers() 
    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])      
        for j = 1, #Config.JobsPolice do
            local job = Config.JobsPolice[j]           
            if thePlayer.job.name == job then
                TriggerClientEvent('ed_gofast:setBlip', xPlayers[i], coords)
                break
            end
        end
    end
end)

ESX.RegisterServerCallback('ed_gofast:checkMoney', function(source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
     if xPlayer.getAccount(Config.TypeArgent).money >= price then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('ed_gofast:takeMoney')
AddEventHandler('ed_gofast:takeMoney', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
     if xPlayer.getAccount(Config.TypeArgent).money >= price then
          xPlayer.removeAccountMoney(Config.TypeArgent, price)
	end
end)



RegisterServerEvent('ed_gofast:giveDrogue')
AddEventHandler('ed_gofast:giveDrogue', function(type_drogue)
    local xPlayer = ESX.GetPlayerFromId(source)
    -- Vérifie si le joueur a assez de place dans son inventaire pour ajouter l'objet
    if xPlayer.canCarryItem(type_drogue) then
        xPlayer.addInventoryItem(type_drogue, 1)
        TriggerClientEvent('ed_gofast:giveDrogueSuccess', source, true)
    end
end)


ESX.RegisterServerCallback('ed_gofast:checkDeleteDrogue', function(source, callback, type_drogue)
     local xPlayer = ESX.GetPlayerFromId(source)
     local playerInventory = xPlayer.getInventoryItem(type_drogue)
     if playerInventory.count >= 1 then
         callback(true) -- l'objet a été supprimé avec succès de l'inventaire du joueur
     else
         callback(false) -- l'objet n'a pas été supprimé de l'inventaire du joueur
     end
 end)

RegisterServerEvent('ed_gofast:deleteDrogue')
AddEventHandler('ed_gofast:deleteDrogue', function(type_drogue)
	local xPlayer = ESX.GetPlayerFromId(source)
     xPlayer.removeInventoryItem(type_drogue, 1)
end)

RegisterServerEvent("ed_gofast:venteduvehicle")
AddEventHandler("ed_gofast:venteduvehicle", function(vehe,  price)
     local xPlayer = ESX.GetPlayerFromId(source)
     local total = 0
     local prixWeed = math.random(Config.PrixRevente.weed_minimum, Config.PrixRevente.weed_maximum)
     local prixCoke = math.random(Config.PrixRevente.coke_minimum, Config.PrixRevente.coke_maximum)
     local prixMeth = math.random(Config.PrixRevente.meth_minimum, Config.PrixRevente.meth_maximum)
     local prixOpium = math.random(Config.PrixRevente.opium_minimum, Config.PrixRevente.opium_maximum)    
     if price == Config.PrixAchat.weed then
          total = prixWeed + price
     elseif price == Config.PrixAchat.coke then
          total = prixCoke + price
     elseif price == Config.PrixAchat.meth then
          total = prixMeth + price
     elseif price == Config.PrixAchat.opium then
          total = prixOpium + price
     end
     xPlayer.addAccountMoney(Config.TypeArgent, total)
     TriggerClientEvent('esx:showAdvancedNotification', source, 'GoFast', '~b~Inconnu', 'Vous avez gagné ~r~'..total..'$ ~w~ grâce a la drogue transporté', 'CHAR_MULTIPLAYER', 3)
end)

RegisterServerEvent('ed_gofast:renfort')
AddEventHandler('ed_gofast:renfort', function()
    local _raison = raison
    local _source = source
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        for j = 1, #Config.JobsPolice do
            if thePlayer.job.name == Config.JobsPolice[j] then
                TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LSPD INFORMATIONS', '~r~GoFast en cours', 'D\'après notre indic un Gofast est en cours, envoie du signal GPS', 'CHAR_ABIGAIL', 8)
                break
            end
        end
    end
end)

RegisterServerEvent('ed_gofast:stoprenfort')
AddEventHandler('ed_gofast:stoprenfort', function()
     local _raison = raison
     local _source = source
     local xPlayers = ESX.GetPlayers()
     for i = 1, #xPlayers, 1 do
          local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
          for j = 1, #Config.JobsPolice do
               if thePlayer.job.name == Config.JobsPolice[j] then
                    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LSPD INFORMATIONS', '~r~Perte GoFast en cours', 'On a perdu le signal GPS ! '.. emp_vente, 'CHAR_ABIGAIL', 8)
                    break
               end
          end
     end
end)


 
 ESX.RegisterServerCallback('ed_gofast:getCount', function(source, cb)
     MySQL.Async.fetchScalar('SELECT count FROM ed_gofast', {}, function(count)
       cb(count)
     end)
   end)
   
   RegisterServerEvent("ed_gofast:takeGofastCount")
   AddEventHandler("ed_gofast:takeGofastCount", function()
     local playerId = source
     local xPlayer = ESX.GetPlayerFromId(playerId)
   
     MySQL.Async.fetchScalar('SELECT count FROM ed_gofast', {}, function(count)
       if count > 0 then
         MySQL.Async.execute('UPDATE ed_gofast SET count = count - 1', {}, function(rowsChanged)

         end)
       end
     end)
   end)
   
Citizen.CreateThread(function()
     while true do
       Citizen.Wait(Config.Duree.GFsupplementaire * 60000) -- attendre le temps en minutes defini dans le config
       MySQL.Async.fetchScalar('SELECT count FROM ed_gofast', {}, function(count)
          if count < 10 then
            MySQL.Async.execute('UPDATE ed_gofast SET count = count + 1', {}, function(rowsChanged)

            end)
          end
       end)
     end
   end)

RegisterServerEvent('emplacement_vente')
AddEventHandler('emplacement_vente', function(emplacement_vente)
     emp_vente = emplacement_vente  
end)

RegisterServerEvent('ed_gofast:venteDrogueSeul')
AddEventHandler('ed_gofast:venteDrogueSeul', function(itemName, saleQty)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pricemin = Config.PrixAchat.weed - 100
    local pricemax = Config.PrixAchat.weed + 100
    local price = math.random(pricemin, pricemax)
    local amount = 0

    if itemName == 'sac_weed' then
        amount = xPlayer.getInventoryItem(itemName).count
    elseif itemName == 'sac_meth' then
        amount = xPlayer.getInventoryItem(itemName).count
    elseif itemName == 'sac_coke' then
        amount = xPlayer.getInventoryItem(itemName).count
    elseif itemName == 'sac_opium' then
        amount = xPlayer.getInventoryItem(itemName).count
    end

    if amount < saleQty then
        TriggerClientEvent('esx:showNotification', source, 'Quantité insuffisante !')
    else
        local totalPrice = price * saleQty
        xPlayer.removeInventoryItem(itemName, saleQty)
        xPlayer.addAccountMoney(Config.TypeArgent, totalPrice)
    end
end)