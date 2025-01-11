local ox_inventory = exports.ox_inventory

RegisterNetEvent('rnr_chicken:Catch')
AddEventHandler('rnr_chicken:Catch', function(item, count)
    if RNRFunctions.CanCarryItem(source, item, count) then
        RNRFunctions.AddItem(source, item, count)
    else
        RNRFunctions.Notify('Inventory Full', 'error')
    end
end)

RegisterNetEvent('rnr_chicken:Process')
AddEventHandler('rnr_chicken:Process', function()
    -- local slaughtered = xPlayer.canCarryItem('slaughtered_chicken', 1)
    if RNRFunctions.CanCarryItem('ayam', 5) then
        RNRFunctions.AddItem('ayampotong', 5)
        RNRFunctions.AddItem('buluayam', 2)
        RNRFunctions.Removeitem('ayam', 1)
    else
        RNRFunctions.Notify('Inventory Full', 'error')
    end
end)

RegisterNetEvent('rnr_chicken:Pack')
AddEventHandler('rnr_chicken:Pack', function()
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