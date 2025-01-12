RegisterServerEvent('rw:pickedUpCannabis')
AddEventHandler('rw:pickedUpCannabis', function()
	local xItem = RNRFunctions.getInventoryItem('wood')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify(Config.Locales.Notify['inventory_full'], "error")
	end
end)

RegisterServerEvent('rw:pickedUpBatu')
AddEventHandler('rw:pickedUpBatu', function()
	local xItem = RNRFunctions.getInventoryItem('stone')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify(Config.Locales.Notify['inventory_full'], "error")
	end
end)

RegisterServerEvent('rw:pickedUpCabe')
AddEventHandler('rw:pickedUpCabe', function()
	local xItem = RNRFunctions.getInventoryItem('cabe')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify(Config.Locales.Notify['inventory_full'], "error")
	end
end)

RegisterServerEvent('rw:pickedUpCoklat')
AddEventHandler('rw:pickedUpCoklat', function()
	local xItem = RNRFunctions.getInventoryItem('bubuk_coklat')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify(Config.Locales.Notify['inventory_full'], "error")
	end
end)

RegisterServerEvent('rw:pickedUpGaram')
AddEventHandler('rw:pickedUpGaram', function()
	local xItem = RNRFunctions.getInventoryItem('garam')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify(Config.Locales.Notify['inventory_full'], "error")
	end
end)

RegisterServerEvent('rw:pickedUpKopi')
AddEventHandler('rw:pickedUpKopi', function()
	local xItem = RNRFunctions.getInventoryItem('biji_kopi')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify(Config.Locales.Notify['inventory_full'], "error")
	end
end)

RegisterServerEvent('rw:pickedUpPadi')
AddEventHandler('rw:pickedUpPadi', function()
	local xItem = RNRFunctions.getInventoryItem('padi')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify(Config.Locales.Notify['inventory_full'], "error")
	end
end)

RegisterServerEvent('rw:pickedUpTebu')
AddEventHandler('rw:pickedUpTebu', function()
	local xItem = RNRFunctions.getInventoryItem('tebu')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify(Config.Locales.Notify['inventory_full'], "error")
	end
end)

RegisterServerEvent('rw:pickedUpTeh')
AddEventHandler('rw:pickedUpTeh', function()
	local xItem = RNRFunctions.getInventoryItem('daun_teh')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify(Config.Locales.Notify['inventory_full'], "error")
	end
end)

RNRFunctions.RegisterServerCallback('rw:canPickUp', function(source, cb, item)
	local xPlayer = RNRFunctions.GetPlayerFromId(source)
	local xItem = RNRFunctions.getInventoryItem(item)
	cb(true)
end)