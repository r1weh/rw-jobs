-- Added Wool
-- RegisterNetEvent("dn-penjahit:Server:AddedWool", function()
--     local Source = source
--     local woolAmount = 2

--     -- Check if player can carry the wool
--     if not exports.ox_inventory:CanCarryItem(Source, 'wool', woolAmount) then
--         -- Notify player that they can't carry more wool
--         TriggerClientEvent('QBCore:Notify', Source, "You cannot carry more wool.", "error")
--         return
--     end

--     exports.ox_inventory:AddItem(Source, 'wool', woolAmount)
-- end)
local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory
lib.callback.register('dn-penjahit:Server:Addeditemnya', function(source, data)
    local source = source
    if ox_inventory:CanCarryItem(source, data.item, data.amount) then
        ox_inventory:AddItem(source, data.item, data.amount)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Inventory Full', 'error')
    end
end)

lib.callback.register('item:penjahitremove', function (source, data)
    local src = source
    if not data then return end
    ox_inventory:RemoveItem(src, data.item, data.amount)
    return
end)

-- Added Cloth
RegisterNetEvent("dn-penjahit:Server:AddedCloth", function()
    local Source = source
    local kainAmount = 1
    local woolRequired = 2

    -- Check if player can carry the cloth
    if not exports.ox_inventory:CanCarryItem(Source, 'kain', kainAmount) then
        -- Notify player that they can't carry more cloth
        TriggerClientEvent('QBCore:Notify', Source, "You cannot carry more cloth.", "error")
        return
    end

    -- Check if player has enough wool
    if exports.ox_inventory:GetItemCount(Source, 'wool') < woolRequired then
        -- Notify player that they don't have enough wool
        TriggerClientEvent('QBCore:Notify', Source, "You don't have enough wool.", "error")
        return
    end

    -- Remove wool and add cloth
    exports.ox_inventory:RemoveItem(Source, 'wool', woolRequired)
    exports.ox_inventory:AddItem(Source, 'kain', kainAmount)
end)

-- Added Clothes
RegisterNetEvent("dn-penjahit:Server:AddedClothes", function()
    local Source = source
    local pakaianAmount = 1
    local kainRequired = 2

    -- Check if player can carry the clothing
    if not exports.ox_inventory:CanCarryItem(Source, 'pakaian', pakaianAmount) then
        -- Notify player that they can't carry more clothes
        TriggerClientEvent('QBCore:Notify', Source, "You cannot carry more clothes.", "error")
        return
    end

    -- Check if player has enough kain
    if exports.ox_inventory:GetItemCount(Source, 'kain') < kainRequired then
        -- Notify player that they don't have enough kain
        TriggerClientEvent('QBCore:Notify', Source, "You don't have enough kain.", "error")
        return
    end

    -- Remove kain and add pakaian
    exports.ox_inventory:RemoveItem(Source, 'kain', kainRequired)
    exports.ox_inventory:AddItem(Source, 'pakaian', pakaianAmount)
end)

RegisterNetEvent("dn-penjahit:Server:SellClothes", function(Item)
    local Source = source

    local Price = 0
    local Player = exports.qbx_core:GetPlayer(Source)
    local ItemCount = exports.ox_inventory:GetItemCount(Source, Item)
    
    Price = Price + (Config.Penjahit.ItemSale[Item].Price * ItemCount)
    exports.ox_inventory:RemoveItem(Source, Item, ItemCount)
    Player.Functions.AddMoney('cash', tonumber(Price))
end)