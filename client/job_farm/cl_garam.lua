local spawnedGaram = 0
local garamPlants = {}
local isPickingUp = false
local CurrentCheckPointGaram = 0
local LastCheckPointGaram   = -1
local CheckPointsGaram = Config.CheckPoints.location_garam
local onDutyGaram = 0
local blipgaram = nil
local countcabutgaram = 0


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local letSleep = true
        local coords = GetEntityCoords(PlayerPedId())
        
        if onDutyGaram == 2 then
		    if GetDistanceBetweenCoords(coords, Config.CircleZones.GaramField.coords, true) < 50 then
				letSleep = false
				SpawnTanamanGaram()
            end
        end

        if GetDistanceBetweenCoords(coords, 421.65, 6468.73, 28.35, true) < 3 then
			letSleep = false
			DrawMarker(39, 421.65, 6468.73, 28.35, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
			RNRFunctions.drawtext('E - Mengambil Traktor (Garam)')
			if IsControlJustReleased(0, 38) and onDutyGaram == 0 then 
				RNRFunctions.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
				Citizen.Wait(500)
				RNRFunctions.SpawnVehicle(Config.VehicleSpawnFarm.Garam,Config.VehicleSpawnFarm.CoordsGaram, 319.73, function(callback_vehicle)
					onDutyGaram = 1
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
				end)
			end
        end
		if letSleep then 
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(garamPlants) do
			DeleteObject(v)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        local letSleep = true
		local playerPed      = PlayerPedId()
		local coords         = GetEntityCoords(playerPed)
		local nextCheckPoint = CurrentCheckPointGaram + 1

		if onDutyGaram == 1 then 
			if CheckPointsGaram[nextCheckPoint] == nil then
				if DoesBlipExist(blipgaram) then
					RemoveBlip(blipgaram)
				end

				vehicle = GetVehiclePedIsIn(playerPed, false)
				DeleteVehicle(vehicle)
				onDutyGaram = 2
			else
				if CurrentCheckPointGaram ~= LastCheckPointGaram then
					if DoesBlipExist(blipgaram) then
						RemoveBlip(blipgaram)
					end

					blipgaram = AddBlipForCoord(CheckPointsGaram[nextCheckPoint].Pos.x, CheckPointsGaram[nextCheckPoint].Pos.y, CheckPointsGaram[nextCheckPoint].Pos.z)
					SetBlipRoute(blipgaram, 1)

					LastCheckPointGaram = CurrentCheckPointGaram
				end

				local distance = GetDistanceBetweenCoords(coords, CheckPointsGaram[nextCheckPoint].Pos.x, CheckPointsGaram[nextCheckPoint].Pos.y, CheckPointsGaram[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(20, CheckPointsGaram[nextCheckPoint].Pos.x, CheckPointsGaram[nextCheckPoint].Pos.y, CheckPointsGaram[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3 then
					vehicle = GetVehiclePedIsIn(playerPed, false)
					if GetHashKey(Config.VehicleSpawnFarm.Garam) == GetEntityModel(vehicle) then
						CurrentCheckPointGaram = CurrentCheckPointGaram + 1
					end
				end
			end
			
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

		for i=1, #garamPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(garamPlants[i]), false) < 1 then
				nearbyObject, nearbyID = garamPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp  then
				RNRFunctions.drawtext("E - Mengambil")
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
                if countcabutgaram >= 80 then 
                    onDutyGaram = 0
					countcabutgaram = 0
				else
					isPickingUp = true

					RNRFunctions.TriggerServerCallback('rw:canPickUp', function(canPickUp)
							if canPickUp then
								if lib.progressBar({
									duration = 2500,
									label = 'Mengambil Garam',
									useWhileDead = true,
									canCancel = true,
									disable = {
										car = true,
									},
									anim = {
										dict = "random@domestic",
										clip = "pickup_low"
									},
								}) then
									DeleteObject(nearbyObject)
									table.remove(garamPlants, nearbyID)
									spawnedGaram = spawnedGaram - 1
									countcabutgaram = countcabutgaram + 1
									TriggerServerEvent('rw:pickedUpGaram')
								else 
									RNRFunctions.CLNotify('Kamu Cancel', 'error')
								end
							else
								RNRFunctions.CLNotify('Melebihi Batas', 'error')
							end
						isPickingUp = false
					end, 'garam')
				end
			end

		else
			RNRFunctions.hidedraw()
			Citizen.Wait(500)
		end

	end

end)

function SpawnTanamanGaram()
	while spawnedGaram < 30 do
		Citizen.Wait(0)
		local garamCoords = GenerateGaramCoords()

		RNRFunctions.SpawnLocalObject(Config.PropFarm.Garam, garamCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(garamPlants, obj)
			spawnedGaram = spawnedGaram + 1
		end)
	end
end

function ValidateGaramCoord(plantCoord)
	if spawnedGaram > 0 then
		local validate = true

		for k, v in pairs(garamPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.GaramField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateGaramCoords()
	while true do
		Citizen.Wait(1)

		local garamCoordX, garamCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-15, 15)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-15, 15)

		garamCoordX = Config.CircleZones.GaramField.coords.x + modX
		garamCoordY = Config.CircleZones.GaramField.coords.y + modY

		local coordZ = GetCoordZ(garamCoordX, garamCoordY)
		local coord = vector3(garamCoordX, garamCoordY, coordZ)

		if ValidateGaramCoord(coord) then
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