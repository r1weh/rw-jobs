Framework = nil
RNRFunctions = {}
PlayerData = {}

Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

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
        TriggerEvent('esx:showNotification',msg)
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

RNRFunctions.hidedraw = function()
    lib.hideTextUI()
end