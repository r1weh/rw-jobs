local spawnedWeeds = 0
local weedPlants = {}
local isPickingUp = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local letSleep = true
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.coords, true) < 50 then
			letSleep = false
			SpawnWeedPlants()
		end
		if letSleep then 
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants) do
			DeleteObject(v)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local letSleep = true
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #weedPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 2 then
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp and PlayerData.job.name == 'lumberjack' then
				RNRFunctions.drawtext("E - Memotong")
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				if PlayerData.job.name == 'lumberjack' then
					isPickingUp = true

					RNRFunctions.TriggerServerCallback('rw:canPickUp', function(canPickUp)

						if canPickUp then
							pickaxe = CreateObject(GetHashKey('prop_w_me_hatchet'), 0, 0, 0, true, true, true) 
							AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.1, -0.02, -0.02, -50.0, 0.00, 0.0, true, true, false, true, 1, true)
							if lib.progressBar({
								duration = 10000,
								label = 'Memotong Kayu',
								useWhileDead = false,
								canCancel = true,
								disable = {
									car = true,
								},
								anim = {
									dict = "melee@large_wpn@streamed_core",
									clip = "ground_attack_90"
								},
								prop = {
									model = `prop_ld_flow_bottle`,
									pos = vec3(0.03, 0.03, 0.02),
									rot = vec3(0.0, 0.0, -1.5)
								},
							}) then 
								DeleteObject(nearbyObject)
								DeleteObject(pickaxe)
								table.remove(weedPlants, nearbyID)
								spawnedWeeds = spawnedWeeds - 1
								TriggerServerEvent('rw:pickedUpCannabis')
							 else 
								RNRFunctions.ShowHelpNotification(Config.Locales.Notify['cancel_proggress'], 'error')
							end
						else
							RNRFunctions.ShowHelpNotification(Config.Locales.Notify['inventory_full'], "error")
						end
						isPickingUp = false
					end, 'wood')
				end
			end
		else
			RNRFunctions.hidedraw()
			Citizen.Wait(500)
		end
	end
end)

function SpawnWeedPlants()
	while spawnedWeeds < 10 do
		Citizen.Wait(0)
		local weedCoords = GenerateWeedCoords()

		RNRFunctions.SpawnLocalObject('prop_log_01', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(weedPlants, obj)
			spawnedWeeds = spawnedWeeds + 1
		end)
	end
end

function ValidateWeedCoord(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WeedField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-25, 25)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-25, 25)

		weedCoordX = Config.CircleZones.WeedField.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField.coords.y + modY

		local coordZ = GetCoordZ(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		Citizen.Wait(750)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 75.0, 76.0, 77.0, 78.0, 79.0, 80.0, 81.0, 82.0, 83.0, 84.0, 85.0}

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 76.00
end