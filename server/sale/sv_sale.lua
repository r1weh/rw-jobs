RegisterNetEvent('rnr_jobs:server:salechicken', function(item)
    local Source = source

    local Price = 0
    local Player = RNRFunctions.GetPlayerFromId(Source)
    local PlayerItems = RNRFunctions.getInventoryItem(Source)

    if PlayerItems and next(PlayerItems) ~= nil then
        for _, Item in pairs(PlayerItems) do
            if Config.SaleItem.itemchicken[Item.name] ~= nil then
                Price = Price + (Config.SaleItem.itemchicken[Item.name].Price * Item.count)
                Player.Functions.RemoveItem(Item.name, Item.count)
                Player.Functions.AddMoney("cash", Price)
                RNRFunctions.Notify(source, Config.Locales.Alerts["successfully_sold"])
            else
                RNRFunctions.Notify(source, Config.Locales.Alerts["error_sold"])
            end
        end
    else
        RNRFunctions.Notify(source, Config.Locales.Alerts["error_sold"])
    end
end)

RegisterNetEvent('rnr_jobs:server:salecabe', function(item)
    local Source = source

    local Price = 0
    local Player = RNRFunctions.GetPlayerFromId(Source)
    local PlayerItems = RNRFunctions.getInventoryItem(Source)

    if PlayerItems and next(PlayerItems) ~= nil then
        for _, Item in pairs(PlayerItems) do
            if Config.SaleItem.itemcabe[Item.name] ~= nil then
                Price = Price + (Config.SaleItem.itemcabe[Item.name].Price * Item.count)
                Player.Functions.RemoveItem(Item.name, Item.count)
                Player.Functions.AddMoney("cash", Price)
                RNRFunctions.Notify(source, Config.Locales.Alerts["successfully_sold"])
            else
                RNRFunctions.Notify(source, Config.Locales.Alerts["error_sold"])
            end
        end
    else
        RNRFunctions.Notify(source, Config.Locales.Alerts["error_sold"])
    end
end)

RegisterNetEvent('rnr_jobs:server:salegaram', function(item)
    local Source = source

    local Price = 0
    local Player = RNRFunctions.GetPlayerFromId(Source)
    local PlayerItems = RNRFunctions.getInventoryItem(Source)

    if PlayerItems and next(PlayerItems) ~= nil then
        for _, Item in pairs(PlayerItems) do
            if Config.SaleItem.itemgaram[Item.name] ~= nil then
                Price = Price + (Config.SaleItem.itemgaram[Item.name].Price * Item.count)
                Player.Functions.RemoveItem(Item.name, Item.count)
                Player.Functions.AddMoney("cash", Price)
                RNRFunctions.Notify(source, Config.Locales.Alerts["successfully_sold"])
            else
                RNRFunctions.Notify(source, Config.Locales.Alerts["error_sold"])
            end
        end
    else
        RNRFunctions.Notify(source, Config.Locales.Alerts["error_sold"])
    end
end)

RegisterNetEvent('rnr_jobs:server:salepadi', function(item)
    local Source = source

    local Price = 0
    local Player = RNRFunctions.GetPlayerFromId(Source)
    local PlayerItems = RNRFunctions.getInventoryItem(Source)

    if PlayerItems and next(PlayerItems) ~= nil then
        for _, Item in pairs(PlayerItems) do
            if Config.SaleItem.itempadi[Item.name] ~= nil then
                Price = Price + (Config.SaleItem.itempadi[Item.name].Price * Item.count)
                Player.Functions.RemoveItem(Item.name, Item.count)
                Player.Functions.AddMoney("cash", Price)
                RNRFunctions.Notify(source, Config.Locales.Alerts["successfully_sold"])
            else
                RNRFunctions.Notify(source, Config.Locales.Alerts["error_sold"])
            end
        end
    else
        RNRFunctions.Notify(source, Config.Locales.Alerts["error_sold"])
    end
end)

RegisterNetEvent('rnr_jobs:server:salekopi', function(item)
    local Source = source

    local Price = 0
    local Player = RNRFunctions.GetPlayerFromId(Source)
    local PlayerItems = RNRFunctions.getInventoryItem(Source)

    if PlayerItems and next(PlayerItems) ~= nil then
        for _, Item in pairs(PlayerItems) do
            if Config.SaleItem.itemkopi[Item.name] ~= nil then
                Price = Price + (Config.SaleItem.itemkopi[Item.name].Price * Item.count)
                Player.Functions.RemoveItem(Item.name, Item.count)
                Player.Functions.AddMoney("cash", Price)
                RNRFunctions.Notify(source, Config.Locales.Alerts["successfully_sold"])
            else
                RNRFunctions.Notify(source, Config.Locales.Alerts["error_sold"])
            end
        end
    else
        RNRFunctions.Notify(source, Config.Locales.Alerts["error_sold"])
    end
end)