local ox_inventory = exports.ox_inventory

RegisterNetEvent('ttyy_butcher:Catch')
AddEventHandler('ttyy_butcher:Catch', function(item, count)
    if ox_inventory:CanCarryItem(source, item, count) then
        ox_inventory:AddItem(source, item, count)
    else
        RNRFunctions.Notify('Inventory Full', 'error')
    end
end)

RegisterNetEvent('ttyy_butcher:Process')
AddEventHandler('ttyy_butcher:Process', function()
    -- local slaughtered = xPlayer.canCarryItem('slaughtered_chicken', 1)
    if ox_inventory:canCarryItem('ayam', 5) then
        ox_inventory:AddItem('ayampotong', 5)
        ox_inventory:AddItem('buluayam', 2)
        ox_inventory:RemoveItem('ayam', 1)
    else
        RNRFunctions.Notify('Inventory Full', 'error')
    end
end)

RegisterNetEvent('ttyy_butcher:Pack')
AddEventHandler('ttyy_butcher:Pack', function()
    -- math.randomseed(os.time())
	-- local xPlayer = ESX.GetPlayerFromId(source)
	-- local luck = math.random(1, 100)
	-- local grade = 0

    if ox_inventory:canCarryItem('paketayam', 1) then
		ox_inventory:addInventoryItem('paketayam', 1)
        ox_inventory:removeInventoryItem('ayampotong', 2)
    else
        RNRFunctions.Notify('Inventory Full', 'error')
    end
end)