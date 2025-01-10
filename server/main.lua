ESX = nil
local ox_inventory = exports.ox_inventory

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('rw:pickedUpCannabis')
AddEventHandler('rw:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('wood')

	if ox_inventory:CanCarryItem(source, xItem, 1) then
		ox_inventory:AddItem(source, xItem, 1)
	else
		TriggerClientEvent("rri-notify:Icon",xPlayer.source,"Tas Kamu Penuh Maszeh","top-right",2500,"blue-10","white",true,"")
	end
end)

RegisterServerEvent('rw:pickedUpBatu')
AddEventHandler('rw:pickedUpBatu', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('stone')

	if ox_inventory:CanCarryItem(source, xItem, 1) then
		ox_inventory:AddItem(source, xItem, 1)
	else
		TriggerClientEvent("rri-notify:Icon",xPlayer.source,"Tas Kamu Penuh Maszeh","top-right",2500,"blue-10","white",true,"")
	end
end)

RegisterServerEvent('rw:pickedUpCabe')
AddEventHandler('rw:pickedUpCabe', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cabe')

	if ox_inventory:CanCarryItem(source, xItem, 1) then
		ox_inventory:AddItem(source, xItem, 1)
	else
		TriggerClientEvent("rri-notify:Icon",xPlayer.source,"Tas Kamu Penuh Maszeh","top-right",2500,"blue-10","white",true,"")
	end
end)

RegisterServerEvent('rw:pickedUpCoklat')
AddEventHandler('rw:pickedUpCoklat', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('bubuk_coklat')

	if ox_inventory:CanCarryItem(source, xItem, 1) then
		ox_inventory:AddItem(source, xItem, 1)
	else
		TriggerClientEvent("rri-notify:Icon",xPlayer.source,"Tas Kamu Penuh Maszeh","top-right",2500,"blue-10","white",true,"")
	end
end)

RegisterServerEvent('rw:pickedUpGaram')
AddEventHandler('rw:pickedUpGaram', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('garam')

	if ox_inventory:CanCarryItem(source, xItem, 1) then
		ox_inventory:AddItem(source, xItem, 1)
	else
		TriggerClientEvent("rri-notify:Icon",xPlayer.source,"Tas Kamu Penuh Maszeh","top-right",2500,"blue-10","white",true,"")
	end
end)

RegisterServerEvent('rw:pickedUpKopi')
AddEventHandler('rw:pickedUpKopi', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('biji_kopi')

	if ox_inventory:CanCarryItem(source, xItem, 1) then
		ox_inventory:AddItem(source, xItem, 1)
	else
		TriggerClientEvent("rri-notify:Icon",xPlayer.source,"Tas Kamu Penuh Maszeh","top-right",2500,"blue-10","white",true,"")
	end
end)

RegisterServerEvent('rw:pickedUpPadi')
AddEventHandler('rw:pickedUpPadi', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('padi')

	if ox_inventory:CanCarryItem(source, xItem, 1) then
		ox_inventory:AddItem(source, xItem, 1)
	else
		TriggerClientEvent("rri-notify:Icon",xPlayer.source,"Tas Kamu Penuh Maszeh","top-right",2500,"blue-10","white",true,"")
	end
end)

RegisterServerEvent('rw:pickedUpTebu')
AddEventHandler('rw:pickedUpTebu', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('tebu')

	if ox_inventory:CanCarryItem(source, xItem, 1) then
		ox_inventory:AddItem(source, xItem, 1)
	else
		TriggerClientEvent("rri-notify:Icon",xPlayer.source,"Tas Kamu Penuh Maszeh","top-right",2500,"blue-10","white",true,"")
	end
end)

RegisterServerEvent('rw:pickedUpTeh')
AddEventHandler('rw:pickedUpTeh', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('daun_teh')

	if ox_inventory:CanCarryItem(source, xItem, 1) then
		ox_inventory:AddItem(source, xItem, 1)
	else
		TriggerClientEvent("rri-notify:Icon",xPlayer.source,"Tas Kamu Penuh Maszeh","top-right",2500,"blue-10","white",true,"")
	end
end)

ESX.RegisterServerCallback('rw:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	cb(true)
end)