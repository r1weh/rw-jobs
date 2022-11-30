ESX = nil
local spawnedBatu = 0
local batuPlants = {}
local isPickingUp = false

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


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.BatuField.coords, true) < 50 then
			if PlayerData.job.name == 'miner' then
				SpawnBatuPlants()
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #batuPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(batuPlants[i]), false) < 1 then
				nearbyObject, nearbyID = batuPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp and PlayerData.job.name == 'miner' then
				ESX.ShowHelpNotification("E - Mengebor")
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				if PlayerData.job.name == 'miner' then
					isPickingUp = true

					ESX.TriggerServerCallback('rw:canPickUp', function(canPickUp)

						if canPickUp then
							TriggerEvent("mythic_progbar:client:progress", {
								name = "stone_farm",
								duration = 10000,
								label = 'Mengebor Batu',
								useWhileDead = true,
								canCancel = false,
								controlDisables = {
									disableMovement = true,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								},
								animation = {
									task = "WORLD_HUMAN_CONST_DRILL",
								},
							}, function(status)
								if not status then
									-- Do Something If Event Wasn't Cancelled
								end
							end)

							Citizen.Wait(10000)
		
							ESX.Game.DeleteObject(nearbyObject)
		
							table.remove(batuPlants, nearbyID)
							spawnedBatu = spawnedBatu - 1
		
							TriggerServerEvent('rw:pickedUpBatu')
						else
							TriggerEvent("rri-notify:Icon","Tas Kamu Penuh Maszeh","top-right",2500,"blue-10","white",true,"")
						end

						isPickingUp = false

					end, 'stone')
				end
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(batuPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnBatuPlants()
	while spawnedBatu < 10 do
		Citizen.Wait(0)
		local batuCoords = GenerateBatuCoords()

		ESX.Game.SpawnLocalObject('prop_rock_5_c', batuCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(batuPlants, obj)
			spawnedBatu = spawnedBatu + 1
		end)
	end
end

function ValidateBatuCoord(plantCoord)
	if spawnedBatu > 0 then
		local validate = true

		for k, v in pairs(batuPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.BatuField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateBatuCoords()
	while true do
		Citizen.Wait(1)

		local batuCoordX, batuCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-25, 25)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-25, 25)

		batuCoordX = Config.CircleZones.BatuField.coords.x + modX
		batuCoordY = Config.CircleZones.BatuField.coords.y + modY

		local coordZ = GetCoordZ(batuCoordX, batuCoordY)
		local coord = vector3(batuCoordX, batuCoordY, coordZ)

		if ValidateBatuCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0}

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end