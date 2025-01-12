local spawnedPadi = 0
local padiPlants = {}
local isPickingUp = false
local CurrentCheckPointPadi = 0
local LastCheckPointPadi   = -1
local CheckPointsPadi = Config.CheckPoints.location_padi
local onDutyPadi = 0
local blippadi = nil
local countcabutpadi = 0


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local letSleep = true
        local coords = GetEntityCoords(PlayerPedId())
        
        if onDutyPadi == 2 then
		    if GetDistanceBetweenCoords(coords, Config.CircleZones.PadiField.coords, true) < 50 then
				letSleep = false
				SpawnTanamanPadi()
            end
        end

        if GetDistanceBetweenCoords(coords, 428.14, 6476.53, 28.32, true) < 3 then
			letSleep = false
			DrawMarker(39, 428.14, 6476.53, 28.32, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
			RNRFunctions.drawtext('E - Mengambil Traktor (Padi)')
			if IsControlJustReleased(0, 38) and onDutyPadi == 0 then 
				RNRFunctions.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
				Citizen.Wait(500)
				RNRFunctions.SpawnVehicle(Config.VehicleSpawnFarm['Padi'].Codespawn ,Config.VehicleSpawnFarm['Padi'].CoordsCabe, Config.VehicleSpawnFarm['Padi'].Heading, function(callback_vehicle)
					onDutyPadi = 1
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
		for k, v in pairs(padiPlants) do
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
		local nextCheckPoint = CurrentCheckPointPadi + 1

		if onDutyPadi == 1 then 
			if CheckPointsPadi[nextCheckPoint] == nil then
				if DoesBlipExist(blippadi) then
					RemoveBlip(blippadi)
				end

				vehicle = GetVehiclePedIsIn(playerPed, false)
				DeleteVehicle(vehicle)
				onDutyPadi = 2
			else
				if CurrentCheckPointPadi ~= LastCheckPointPadi then
					if DoesBlipExist(blippadi) then
						RemoveBlip(blippadi)
					end

					blippadi = AddBlipForCoord(CheckPointsPadi[nextCheckPoint].Pos.x, CheckPointsPadi[nextCheckPoint].Pos.y, CheckPointsPadi[nextCheckPoint].Pos.z)
					SetBlipRoute(blippadi, 1)

					LastCheckPointPadi = CurrentCheckPointPadi
				end

				local distance = GetDistanceBetweenCoords(coords, CheckPointsPadi[nextCheckPoint].Pos.x, CheckPointsPadi[nextCheckPoint].Pos.y, CheckPointsPadi[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(20, CheckPointsPadi[nextCheckPoint].Pos.x, CheckPointsPadi[nextCheckPoint].Pos.y, CheckPointsPadi[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3 then
					vehicle = GetVehiclePedIsIn(playerPed, false)
					if GetHashKey(Config.VehicleSpawnFarm.Cabe) == GetEntityModel(vehicle) then
						CurrentCheckPointPadi = CurrentCheckPointPadi + 1
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

		for i=1, #padiPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(padiPlants[i]), false) < 1 then
				nearbyObject, nearbyID = padiPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp  then
				RNRFunctions.ShowHelpNotification("E - Mengambil")
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
                if countcabutpadi >= 80 then 
                    onDutyPadi = 0
					countcabutpadi = 0
				else
					isPickingUp = true

					RNRFunctions.TriggerServerCallback('rw:canPickUp', function(canPickUp)
							if canPickUp then
								if lib.progressBar({
									duration = 2500,
									label = 'Mencabut Padi',
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
									table.remove(padiPlants, nearbyID)
									spawnedPadi = spawnedPadi - 1
									countcabutpadi = countcabutpadi + 1
									TriggerServerEvent('rw:pickedUpPadi')
								else 
									RNRFunctions.CLNotify('Kamu Cancel', 'error')
								end
							else
								RNRFunctions.CLNotify('Melebihi Batas', 'error')
							end
						isPickingUp = false
					end, 'padi')
				end
			end

		else
			RNRFunctions.hidedraw()
			Citizen.Wait(500)
		end

	end

end)

function SpawnTanamanPadi()
	while spawnedPadi < 20 do
		Citizen.Wait(0)
		local padiCoords = GeneratePadiCoords()

		RNRFunctions.SpawnLocalObject(Config.PropFarm.Padi, padiCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(padiPlants, obj)
			spawnedPadi = spawnedPadi + 1
		end)
	end
end

function ValidatePadiCoord(plantCoord)
	if spawnedPadi > 0 then
		local validate = true

		for k, v in pairs(padiPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.PadiField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratePadiCoords()
	while true do
		Citizen.Wait(1)

		local padiCoordX, padiCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		padiCoordX = Config.CircleZones.PadiField.coords.x + modX
		padiCoordY = Config.CircleZones.PadiField.coords.y + modY

		local coordZ = GetCoordZ(padiCoordX, padiCoordY)
		local coord = vector3(padiCoordX, padiCoordY, coordZ)

		if ValidatePadiCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end