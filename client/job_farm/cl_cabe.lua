local spawnedCabe = 0
local cabePlants = {}
local isPickingUp = false
local CurrentCheckPoint = 0
local LastCheckPoint    = -1

local CheckPoints = Config.CheckPoints.location_cabe

local onDutyCabe = 0
local blipcabe = nil
local countcabutcabe = 0


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local letSleep = true
        local coords = GetEntityCoords(PlayerPedId())
        
        if onDutyCabe == 2 then
		    if GetDistanceBetweenCoords(coords, Config.CircleZones.CabeField.coords, true) < 50 then
                if PlayerData.job.name == 'petani' then
                    letSleep = false
				    SpawnTanamanCabe()
                end
            end
        end

        if GetDistanceBetweenCoords(coords, 426.31, 6463.42, 28.78, true) < 3 then
			letSleep = false
			DrawMarker(39, 426.31, 6463.42, 28.78, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
			RNRFunctions.drawtext('E - Mengambil Traktor (Cabe)')
			if IsControlJustReleased(0, 38) and onDutyCabe == 0 then 
				RNRFunctions.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
				Citizen.Wait(500)
				RNRFunctions.hidedraw()
				RNRFunctions.SpawnVehicle(Config.VehicleSpawnFarm.Cabe,Config.VehicleSpawnFarm.CoordsCabe, 319.98, function(callback_vehicle)
					onDutyCabe = 1
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
		for k, v in pairs(cabePlants) do
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
		local nextCheckPoint = CurrentCheckPoint + 1

		if onDutyCabe == 1 then 
			if CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(blipcabe) then
					RemoveBlip(blipcabe)
				end

				vehicle = GetVehiclePedIsIn(playerPed, false)
				DeleteVehicle(vehicle)
				onDutyCabe = 2
			else
				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(blipcabe) then
						RemoveBlip(blipcabe)
					end

					blipcabe = AddBlipForCoord(CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(blipcabe, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(20, CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3 then
					vehicle = GetVehiclePedIsIn(playerPed, false)
					if GetHashKey(Config.VehicleSpawnFarm.Cabe) == GetEntityModel(vehicle) then
						CurrentCheckPoint = CurrentCheckPoint + 1
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

		for i=1, #cabePlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(cabePlants[i]), false) < 1 then
				nearbyObject, nearbyID = cabePlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp  then
				RNRFunctions.drawtext("E - Mengambil")
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
                if countcabutcabe >= 80 then 
                    onDutyCabe = 0
					countcabutcabe = 0
				else
					isPickingUp = true

					RNRFunctions.TriggerServerCallback('rw:canPickUp', function(canPickUp)

						if canPickUp then
							if lib.progressBar({
								duration = 2500,
								label = 'Memetik Cabe',
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
								table.remove(cabePlants, nearbyID)
								spawnedCabe = spawnedCabe - 1
								countcabutcabe = countcabutcabe + 1
								TriggerServerEvent('rw:pickedUpCabe')
							else 
								RNRFunctions.Notify('Kamu Cancel', 'error')
							end
						else
							RNRFunctions.Notify('Melebihi Batas', 'error')
						end
						isPickingUp = false
					end, 'cabe')
				end
			end

		else
			RNRFunctions.hidedraw()
			Citizen.Wait(500)
		end

	end

end)

function SpawnTanamanCabe()
	while spawnedCabe < 20 do
		Citizen.Wait(0)
		local cabeCoords = GenerateCabeCoords()

		RNRFunctions.SpawnLocalObject(Config.PropFarm.Cabe, cabeCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(cabePlants, obj)
			spawnedCabe = spawnedCabe + 1
		end)
	end
end

function ValidateCabeCoord(plantCoord)
	if spawnedCabe > 0 then
		local validate = true

		for k, v in pairs(cabePlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CabeField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCabeCoords()
	while true do
		Citizen.Wait(1)

		local cabeCoordX, cabeCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		cabeCoordX = Config.CircleZones.CabeField.coords.x + modX
		cabeCoordY = Config.CircleZones.CabeField.coords.y + modY

		local coordZ = GetCoordZ(cabeCoordX, cabeCoordY)
		local coord = vector3(cabeCoordX, cabeCoordY, coordZ)

		if ValidateCabeCoord(coord) then
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