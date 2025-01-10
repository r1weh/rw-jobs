local ox_inventory = exports.ox_inventory

RegisterNetEvent('ttyy_butcher:Catch')
AddEventHandler('ttyy_butcher:Catch', function(item, count)
    if RNRFunctions.CanCarryItem(source, item, count) then
        RNRFunctions.AddItem(source, item, count)
    else
        RNRFunctions.Notify('Inventory Full', 'error')
    end
end)

RegisterNetEvent('ttyy_butcher:Process')
AddEventHandler('ttyy_butcher:Process', function()
    -- local slaughtered = xPlayer.canCarryItem('slaughtered_chicken', 1)
    if RNRFunctions.CanCarryItem('ayam', 5) then
        RNRFunctions.AddItem('ayampotong', 5)
        RNRFunctions.AddItem('buluayam', 2)
        RNRFunctions.Removeitem('ayam', 1)
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

    if RNRFunctions.CanCarryItem('paketayam', 1) then
		RNRFunctions.AddItem('paketayam', 1)
        RNRFunctions.Removeitem('ayampotong', 2)
    else
        RNRFunctions.Notify('Inventory Full', 'error')
    end
end)