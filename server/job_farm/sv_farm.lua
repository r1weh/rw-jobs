RegisterServerEvent('rw:pickedUpCannabis')
AddEventHandler('rw:pickedUpCannabis', function()
	local xPlayer = Framework.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('wood')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify("Tas Kamu Penuh Maszeh", "error")
	end
end)

RegisterServerEvent('rw:pickedUpBatu')
AddEventHandler('rw:pickedUpBatu', function()
	local xPlayer = RNRFunctions.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('stone')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify("Tas Kamu Penuh Maszeh", "error")
	end
end)

RegisterServerEvent('rw:pickedUpCabe')
AddEventHandler('rw:pickedUpCabe', function()
	local xPlayer = RNRFunctions.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cabe')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify("Tas Kamu Penuh Maszeh", "error")
	end
end)

RegisterServerEvent('rw:pickedUpCoklat')
AddEventHandler('rw:pickedUpCoklat', function()
	local xPlayer = RNRFunctions.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('bubuk_coklat')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify("Tas Kamu Penuh Maszeh", "error")
	end
end)

RegisterServerEvent('rw:pickedUpGaram')
AddEventHandler('rw:pickedUpGaram', function()
	local xPlayer = RNRFunctions.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('garam')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify("Tas Kamu Penuh Maszeh", "error")
	end
end)

RegisterServerEvent('rw:pickedUpKopi')
AddEventHandler('rw:pickedUpKopi', function()
	local xPlayer = RNRFunctions.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('biji_kopi')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify("Tas Kamu Penuh Maszeh", "error")
	end
end)

RegisterServerEvent('rw:pickedUpPadi')
AddEventHandler('rw:pickedUpPadi', function()
	local xPlayer = RNRFunctions.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('padi')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify("Tas Kamu Penuh Maszeh", "error")
	end
end)

RegisterServerEvent('rw:pickedUpTebu')
AddEventHandler('rw:pickedUpTebu', function()
	local xPlayer = RNRFunctions.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('tebu')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify("Tas Kamu Penuh Maszeh", "error")
	end
end)

RegisterServerEvent('rw:pickedUpTeh')
AddEventHandler('rw:pickedUpTeh', function()
	local xPlayer = RNRFunctions.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('daun_teh')

	if RNRFunctions.CanCarryItem(source, xItem, 1) then
		RNRFunctions.AddItem(source, xItem, 1)
	else
		RNRFunctions.Notify("Tas Kamu Penuh Maszeh", "error")
	end
end)

RNRFunctions.RegisterServerCallback('rw:canPickUp', function(source, cb, item)
	local xPlayer = RNRFunctions.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
	cb(true)
end)