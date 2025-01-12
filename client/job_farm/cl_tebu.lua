local spawnedTebu = 0
local tebuPlants = {}
local isPickingUp = false
local CurrentCheckPointTebu = 0
local LastCheckPointTebu   = -1
local CheckPointsTebu = Config.CheckPoints.location_tebu
local onDutyTebu = 0
local bliptebu = nil
local countcabuttebu = 0


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local letSleep = true
        local coords = GetEntityCoords(PlayerPedId())
        
        if onDutyTebu == 2 then
		    if GetDistanceBetweenCoords(coords, Config.CircleZones.TebuField.coords, true) < 50 then
				letSleep = false
				SpawnTanamanTebu()
            end
        end

        if GetDistanceBetweenCoords(coords, 437.73, 6456.33, 28.28, true) < 3 then
			letSleep = false
			DrawMarker(39, 437.73, 6456.33, 28.28, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
			RNRFunctions.ShowHelpNotification('E - Mengambil Traktor (Tebu)')
			if IsControlJustReleased(0, 38) and onDutyTebu == 0 then 
				RNRFunctions.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
				Citizen.Wait(500)
				RNRFunctions.SpawnVehicle(Config.VehicleSpawnFarm.Cabe, Config.VehicleSpawnFarm.CoordsCabe, 326.37, function(callback_vehicle)
					onDutyTebu = 1
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
		for k, v in pairs(tebuPlants) do
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
		local nextCheckPoint = CurrentCheckPointTebu + 1

		if onDutyTebu == 1 then 
			if CheckPointsTebu[nextCheckPoint] == nil then
				if DoesBlipExist(bliptebu) then
					RemoveBlip(bliptebu)
				end

				vehicle = GetVehiclePedIsIn(playerPed, false)
				DeleteVehicle(vehicle)
				onDutyTebu = 2
			else
				if CurrentCheckPointTebu ~= LastCheckPointTebu then
					if DoesBlipExist(bliptebu) then
						RemoveBlip(bliptebu)
					end

					bliptebu = AddBlipForCoord(CheckPointsTebu[nextCheckPoint].Pos.x, CheckPointsTebu[nextCheckPoint].Pos.y, CheckPointsTebu[nextCheckPoint].Pos.z)
					SetBlipRoute(bliptebu, 1)

					LastCheckPointTebu = CurrentCheckPointTebu
				end

				local distance = GetDistanceBetweenCoords(coords, CheckPointsTebu[nextCheckPoint].Pos.x, CheckPointsTebu[nextCheckPoint].Pos.y, CheckPointsTebu[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(20, CheckPointsTebu[nextCheckPoint].Pos.x, CheckPointsTebu[nextCheckPoint].Pos.y, CheckPointsTebu[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3 then
					vehicle = GetVehiclePedIsIn(playerPed, false)
					if GetHashKey(Config.VehicleSpawnFarm.Cabe) == GetEntityModel(vehicle) then
						CurrentCheckPointTebu = CurrentCheckPointTebu + 1
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

		for i=1, #tebuPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(tebuPlants[i]), false) < 1 then
				nearbyObject, nearbyID = tebuPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp  then
				RNRFunctions.ShowHelpNotification("E - Mengambil")
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
                if countcabuttebu >= 80 then 
                    onDutyTebu = 0
					countcabuttebu = 0
				else
					isPickingUp = true

					RNRFunctions.TriggerServerCallback('rw:canPickUp', function(canPickUp)
						if canPickUp then
							if lib.progressBar({
								duration = 2500,
								label = 'Mencabut Tebu',
								useWhileDead = true,
								canCancel = true,
								disable = {
									car = true,
								},
								anim = {
									dict = "creatures@rottweiler@tricks@",
									clip = "petting_franklin"
								},
							}) then
								DeleteObject(nearbyObject)
								table.remove(tebuPlants, nearbyID)
								spawnedTebu = spawnedTebu - 1
								countcabuttebu = countcabuttebu + 1
								TriggerServerEvent('rw:pickedUpTebu')
							else 
								RNRFunctions.CLNotify('Kamu Cancel', 'error')
							end
						else
							RNRFunctions.CLNotify('Melebihi Batas', 'error')
						end
						isPickingUp = false
					end, 'tebu')
				end
			end

		else
			RNRFunctions.hidedraw()
			Citizen.Wait(500)
		end

	end

end)

function SpawnTanamanTebu()
	while spawnedTebu < 10 do
		Citizen.Wait(0)
		local tebuCoords = GenerateTebuCoords()

		RNRFunctions.SpawnLocalObject(Config.PropFarm.Tebu, tebuCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			table.insert(tebuPlants, obj)
			spawnedTebu = spawnedTebu + 1
		end)
	end
end

function ValidateTebuCoord(plantCoord)
	if spawnedTebu > 0 then
		local validate = true

		for k, v in pairs(tebuPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.TebuField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateTebuCoords()
	while true do
		Citizen.Wait(1)

		local tebuCoordX, tebuCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-10, 10)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-10, 10)

		tebuCoordX = Config.CircleZones.TebuField.coords.x + modX
		tebuCoordY = Config.CircleZones.TebuField.coords.y + modY

		local coordZ = GetCoordZ(tebuCoordX, tebuCoordY)
		local coord = vector3(tebuCoordX, tebuCoordY, coordZ)

		if ValidateTebuCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0}

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end