lib.callback.register('rnr_jobs:server:item_add', function (source, data)
    local src = source
    if not data then return end
    if RNRFunctions.CanCarryItem(src, data.item, data.amount) then
        RNRFunctions.AddItem(src, data.item, data.amount)
        return
    else
        RNRFunctions.Notify(Config.Locales.Notify['inventory_full'], 'error')
    end
end)

lib.callback.register('rnr_jobs:server:item_remove', function (source, data)
    local src = source
    if not data then return end
    RNRFunctions.Removeitem(src, data.item, data.amount)
end)