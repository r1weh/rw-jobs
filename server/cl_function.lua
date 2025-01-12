Framework = nil
RNRFunctions = {}

if Config.Framework == 'esx' then
	Framework = exports[Config.NameResourceCore]:getSharedObject()
elseif Config.Framework == 'qb' then
	Framework = exports[Config.NameResourceCore]:GetCoreObject()
end

RNRFunctions.RegisterServerCallback = function(name, cb, ...)
	if Config.Framework == 'esx' then
		Framework.RegisterServerCallback(name, cb, ...)
	elseif Config.Framework == 'qb' then
		Framework.Functions.CreateCallback(name, cb, ...)
	end
end

RNRFunctions.GetPlayerFromId = function(source)
	if Config.Framework == 'esx' then
		return Framework.GetPlayerFromId(source)
	elseif Config.Framework == 'qb' then
		return Framework.Functions.GetPlayer(source)
	end
end

RNRFunctions.Notify = function(msg, info)
	if Config.Framework == 'esx' then
        TriggerClientEvent('esx:showNotification', source, msg)
    elseif Config.Framework == 'qb' then
        TriggerClientEvent('QBCore:Notify', source, msg, info)
	end
end

RNRFunctions.AddItem = function(source, item, amount)
    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:AddItem(source, item, amount)
    elseif Config.Inventory == 'qb-inventory' then
        local Player = Framework.Functions.GetPlayer(source)
		Player.Functions.AddItem(item, amount)
    elseif Config.Inventory == 'esx-default' then
        local xPlayer = Framework.GetPlayerFromId(source)
		xPlayer.addInventoryItem(item, amount)
    else
        print('Error: Sistem inventaris tidak valid yang ditentukan dalam Config.Inventory!')
    end
end

RNRFunctions.Removeitem = function(source, item, amount)
    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:RemoveItem(source, item, amount)
    elseif Config.Inventory == 'qb-inventory' then
        local Player = Framework.Functions.GetPlayer(source)
		Player.Functions.RemoveItem(item, amount)
    elseif Config.Inventory == 'esx-default' then
        local xPlayer = Framework.GetPlayerFromId(source)
		xPlayer.removeInventoryItem(item, amount)
    else
        print('Error: Sistem inventaris tidak valid yang ditentukan dalam Config.Inventory!')
    end
end

RNRFunctions.CanCarryItem = function(source, item, amount)
    if Config.Inventory == 'ox_inventory' then
        return exports.ox_inventory:CanCarryItem(source, item, amount)
    elseif Config.Inventory == 'qb-inventory' then
        local Player = Framework.Functions.GetPlayer(source)
        if Player then
            return Player.Functions.CanCarryItem(item, amount)
        else
            print('Error: Player not found for source', source)
            return false
        end
    elseif Config.Inventory == 'esx-default' then
        local xPlayer = Framework.GetPlayerFromId(source)
        if xPlayer then
            local currentWeight = xPlayer.getWeight()
            local itemWeight = Framework.Items[item].weight -- Pastikan ini sesuai dengan implementasi item di ESX
            local maxWeight = Config.MaxWeight or xPlayer.maxWeight
            return (currentWeight + (itemWeight * amount)) <= maxWeight
        else
            print('Error: Player not found for source', source)
            return false
        end
    else
        print('Error: Sistem inventaris tidak valid yang ditentukan dalam Config.Inventory!')
        return false
    end
end

RNRFunctions.getInventoryItem = function(source, item)
    if Config.Framework == 'esx' then
        local xPlayer = Framework.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.getInventoryItem(item) -- Mengembalikan data item
        end
    elseif Config.Framework == 'qb' then
        local Player = RNRFunctions.GetPlayerFromId(source)
        if Player then
            return Player.Functions.GetItemByName(item) -- Mengembalikan data item
        end
    end
    return nil -- Mengembalikan nilai nil jika pemain tidak ditemukan atau framework salah
end
