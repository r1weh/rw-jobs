RegisterNetEvent('rnr_jobs:server:salechicken', function(item)
    local Source = source

    local Price = 0
    local Player = exports.qbx_core:GetPlayer(Source)
    local PlayerItems = exports.ox_inventory:GetInventoryItems(Source)

    if PlayerItems and next(PlayerItems) ~= nil then
        for _, Item in pairs(PlayerItems) do
            if Config.SaleItem.itemsale[Item.name] ~= nil then
                Price = Price + (Config.SaleItem.itemsale[Item.name].Price * Item.count)
                Player.Functions.RemoveItem(Item.name, Item.count)
                Player.Functions.AddMoney("cash", Price)
                RNRFunctions.Notify(source, Config.Lumberjack.Alerts["successfully_sold"])
            else
                RNRFunctions.Notify(source, Config.Lumberjack.Alerts["error_sold"])
            end
        end
    else
        RNRFunctions.Notify(source, Config.Lumberjack.Alerts["error_sold"])
    end
end)