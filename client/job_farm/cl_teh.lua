local spawnedTeh = 0
local tehPlants = {}
local isPickingUp = false
local CurrentCheckPointTeh = 0
local LastCheckPointTeh   = -1
local CheckPointsTeh = Config.CheckPoints.location_teh
local onDutyTeh = 0
local blipteh = nil
local countcabutteh = 0


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local letSleep = true
        local coords = GetEntityCoords(PlayerPedId())
        
        if onDutyTeh == 2 then
		    if GetDistanceBetweenCoords(coords, Config.CircleZones.TehField.coords, true) < 50 then
				letSleep = false
				SpawnTanamanTeh()
            end
        end

        if GetDistanceBetweenCoords(coords, -1146.27, 2664.13, 18.21, true) < 3 then
			letSleep = false
			DrawMarker(39, -1146.27, 2664.13, 18.21, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
			RNRFunctions.drawtext('E - Mengambil Traktor (Teh)')
			if IsControlJustReleased(0, 38) and onDutyTeh == 0 then 
				RNRFunctions.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
				Citizen.Wait(500)
				RNRFunctions.SpawnVehicle(Config.VehicleSpawnFarm['Teh'].Codespawn ,Config.VehicleSpawnFarm['Teh'].CoordsCabe, Config.VehicleSpawnFarm['Teh'].Heading, function(callback_vehicle)
					onDutyTeh = 1
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
				end)
			end
		else
			RNRFunctions.hidedraw()
        end
		if letSleep then 
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(tehPlants) do
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
		local nextCheckPoint = CurrentCheckPointTeh + 1

		if onDutyTeh == 1 then 
			if CheckPointsTeh[nextCheckPoint] == nil then
				if DoesBlipExist(blipteh) then
					RemoveBlip(blipteh)
				end

				vehicle = GetVehiclePedIsIn(playerPed, false)
				DeleteVehicle(vehicle)
				onDutyTeh = 2
			else
				if CurrentCheckPointTeh ~= LastCheckPointTeh then
					if DoesBlipExist(blipteh) then
						RemoveBlip(blipteh)
					end

					blipteh = AddBlipForCoord(CheckPointsTeh[nextCheckPoint].Pos.x, CheckPointsTeh[nextCheckPoint].Pos.y, CheckPointsTeh[nextCheckPoint].Pos.z)
					SetBlipRoute(blipteh, 1)

					LastCheckPointTeh = CurrentCheckPointTeh
				end

				local distance = GetDistanceBetweenCoords(coords, CheckPointsTeh[nextCheckPoint].Pos.x, CheckPointsTeh[nextCheckPoint].Pos.y, CheckPointsTeh[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(20, CheckPointsTeh[nextCheckPoint].Pos.x, CheckPointsTeh[nextCheckPoint].Pos.y, CheckPointsTeh[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3 then
					vehicle = GetVehiclePedIsIn(playerPed, false)
					if GetHashKey(Config.VehicleSpawnFarm.Teh) == GetEntityModel(vehicle) then
						CurrentCheckPointTeh = CurrentCheckPointTeh + 1
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

		for i=1, #tehPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(tehPlants[i]), false) < 1 then
				nearbyObject, nearbyID = tehPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp  then
				RNRFunctions.ShowHelpNotification("E - Mengambil")
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
                if countcabutteh >= 80 then 
                    onDutyTeh = 0
					countcabutteh = 0
				else
					isPickingUp = true
					RNRFunctions.TriggerServerCallback('rw:canPickUp', function(canPickUp)
						if canPickUp then
							if lib.progressBar({
								duration = 2500,
								label = 'Mencabut Teh',
								useWhileDead = false,
								canCancel = true,
								disable = {
									move = true,
									car = true
								},
								anim = {
									animDict = "creatures@rottweiler@tricks@",
									anim = "petting_franklin",
								},
							}) then
								DeleteObject(nearbyObject)
				
								table.remove(tehPlants, nearbyID)
								spawnedTeh = spawnedTeh - 1
								countcabutteh = countcabutteh + 1
			
								TriggerServerEvent('rw:pickedUpTeh')
							else
								RNRFunctions.ShowHelpNotification('Kamu Telah Cancel Progress!')
							end
						else
							RNRFunctions.ShowHelpNotification('Melebihi Batas', 'error')
						end
						isPickingUp = false
					end, 'teh')
				end
			end
		else
			RNRFunctions.hidedraw()
			Citizen.Wait(500)
		end
	end
end)

function SpawnTanamanTeh()
	while spawnedTeh < 10 do
		Citizen.Wait(0)
		local tehCoords = GenerateTehCoords()

		RNRFunctions.SpawnLocalObject(Config.PropFarm.Teh, tehCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(tehPlants, obj)
			spawnedTeh = spawnedTeh + 1
		end)
	end
end

function ValidateTehCoord(plantCoord)
	if spawnedTeh > 0 then
		local validate = true

		for k, v in pairs(tehPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.TehField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateTehCoords()
	while true do
		Citizen.Wait(1)

		local tehCoordX, tehCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-15, 15)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-15, 15)

		tehCoordX = Config.CircleZones.TehField.coords.x + modX
		tehCoordY = Config.CircleZones.TehField.coords.y + modY

		local coordZ = GetCoordZ(tehCoordX, tehCoordY)
		local coord = vector3(tehCoordX, tehCoordY, coordZ)

		if ValidateTehCoord(coord) then
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