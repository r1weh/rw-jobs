local spawnedBatu = 0
local batuPlants = {}
local isPickingUp = false
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
			RNRFunctions.drawtext("E - Mengebor")
			if not isPickingUp then
				RNRFunctions.hidedraw()
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				if PlayerData.job.name == 'miner' then
					isPickingUp = true
					RNRFunctions.TriggerServerCallback('rw:canPickUp', function(canPickUp)
						if canPickUp then
							if lib.progressBar({
								duration = 10000,
								label = 'Mengebor Batu',
								useWhileDead = false,
								canCancel = true,
								disable = {
									move = true,
									car = true
								},
								anim = {
									clip = "WORLD_HUMAN_CONST_DRILL"
								},
							}) then
								DeleteObject(nearbyObject)
								table.remove(batuPlants, nearbyID)
								spawnedBatu = spawnedBatu - 1
								TriggerServerEvent('rw:pickedUpBatu')
							else
								RNRFunctions.ShowHelpNotification('Kamu Telah Cancel Progress!')
							end
						else
							RNRFunctions.ShowHelpNotification('Melebihi Batas', 'error')
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
			DeleteObject(v)
		end
	end
end)

function SpawnBatuPlants()
	while spawnedBatu < 10 do
		Citizen.Wait(0)
		local batuCoords = GenerateBatuCoords()

		RNRFunctions.SpawnLocalObject('prop_rock_5_c', batuCoords, function(obj)
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