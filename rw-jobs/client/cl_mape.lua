ESX = nil

local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
	end
	
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local blips = {
	{title="Petani",colour=2, id=140,x = 428.76,  y = 6468.14, z = 28.78},
	{title="Petani",colour=2, id=140,x = -1146.27,  y = 2664.13, z = 18.21},
    {title="Pengolahan",colour=2, id=514,x = 433.55,  y = 6501.39, z = 28.81},
    {title="Area Tambang Batu", colour=5, id=318, x = 2935.9653320313, y = 2796.3686523438, z = 40.767963409424},
    {title="Pabrik Kayu", colour=4, id=237, x = -499.86, y = 5459.9,  z = 80.13},
}

Citizen.CreateThread(function()
	Citizen.Wait(0)
	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite (info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale  (info.blip, 0.7)
		SetBlipColour (info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)