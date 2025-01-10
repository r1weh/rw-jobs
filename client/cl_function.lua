Framework = nil
RNRFunctions = {}
PlayerData = {}

Citizen.CreateThread(function()
    if Config.Framework == "esx" then
        while Framework == nil do
            Framework = exports["es_extended"]:getSharedObject()
            Citizen.Wait(0)
        end

        while Framework.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        PlayerData = Framework.GetPlayerData()

    elseif Config.Framework == "qb" then
        while Framework == nil do
            Framework = exports["qb-core"]:GetCoreObject()
            Citizen.Wait(0)
        end

        PlayerData = Framework.Functions.GetPlayerData()
    end
end)

if Config.Framework == "esx" then
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
    end)

elseif Config.Framework == "qb" then
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = Framework.Functions.GetPlayerData()
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
        PlayerData.job = JobInfo
    end)
end


Citizen.CreateThread(function()
	Citizen.Wait(0)
	for _, info in pairs(Config.Blips) do
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

RNRFunctions.ShowHelpNotification = function(msg, info)
	if Config.Framework == 'esx' then
		Framework.ShowHelpNotification(msg)
	elseif Config.Framework == 'qb' then
		lib.notify({
			title = 'Information',
			description = msg,
			type = info
		})
	end
end

RNRFunctions.TriggerServerCallback = function(name, cb, ...)
	if Config.Framework == 'esx' then
		Framework.TriggerServerCallback(name, cb, ...)
	elseif Config.Framework == 'qb' then
		Framework.Functions.TriggerCallback(name, cb, ...)
	end
end

RNRFunctions.progressbar = function(label, durasi, anim, prop, onFinish, onCancel)
	if lib.progressBar({
		duration = durasi,
		label = label,
		useWhileDead = false,
		canCancel = true,
		disable = {
			move = true,
			car = true
		},
		anim = anim,
		prop = prop
	}) then
		onFinish()
	else
		onCancel()
	end
end

RNRFunctions.SpawnLocalObject = function(objectName, coords, cb)
	if Config.Framework	== 'esx' then
		Framework.Game.SpawnLocalObject(objectName, coords, function(obj)
            if cb then cb(obj) end
        end)
	elseif Config.Framework == 'qb' then
		Framework.Functions.SpawnObject(objectName, function(obj)
            if cb then cb(obj) end
        end, coords, true)
	end
end

RNRFunctions.SpawnVehicle = function(model, coords, heading, cb)
    if Config.Framework == 'esx' then
        Framework.Game.SpawnVehicle(model, coords, heading, function(vehicle)
            if cb then
                cb(vehicle)
            end
        end)
    elseif Config.Framework == 'qb' then
        Framework.Functions.SpawnVehicle(model, function(vehicle)
            SetEntityCoords(vehicle, coords.x, coords.y, coords.z)
            SetEntityHeading(vehicle, heading)
            if cb then
                cb(vehicle)
            end
        end)
    end
end

RNRFunctions.drawtext = function ( pesan, icon )
    lib.showTextUI(pesan, {
        position = "left-center",
        icon = icon or '',
        style = {
            borderRadius = 3,
            backgroundColor = '#028cf5',
            color = 'white'
        }
    })
end