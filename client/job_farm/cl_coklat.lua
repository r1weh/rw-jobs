local spawnedCoklat = 0
local coklatPlants = {}
local isPickingUp = false
local CurrentCheckPointCoklat = 0
local LastCheckPointCoklat    = -1
local CheckPointsCoklat = Config.CheckPoints.location_coklat
local onDutyCoklat = 0
local blipcoklat = nil
local countcabutcoklat = 0


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local letSleep = true
        local coords = GetEntityCoords(PlayerPedId())
        
        if onDutyCoklat == 2 then
		    if GetDistanceBetweenCoords(coords, Config.CircleZones.CoklatField.coords, true) < 50 then
                if PlayerData.job.name == 'petani' then
                    letSleep = false
				    SpawnTanamanCoklat()
                end
            end
        end

        if GetDistanceBetweenCoords(coords, -1149.95, 2673.13, 18.22, true) < 3 then

            if PlayerData.job.name == 'petani' then
                letSleep = false
                DrawMarker(39, -1149.95, 2673.13, 18.22, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
                RNRFunctions.drawtext('E - Mengambil Traktor (Coklat)')
                if IsControlJustReleased(0, 38) and onDutyCoklat == 0 then 
                    RNRFunctions.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        if skin.sex == 0 then
                            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                        elseif skin.sex == 1 then
                            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                        end
                    end)
                    Citizen.Wait(500)
                    RNRFunctions.SpawnVehicle(Config.VehicleSpawnFarm['Coklat'].Codespawn ,Config.VehicleSpawnFarm['Coklat'].CoordsCabe, Config.VehicleSpawnFarm['Coklat'].Heading, function(callback_vehicle)
						onDutyCoklat = 1
						TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
					end)
                end
			else
				RNRFunctions.hidedraw()
            end
        end
		if letSleep then 
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(coklatPlants) do
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
		local nextCheckPoint = CurrentCheckPointCoklat + 1

		if onDutyCoklat == 1 then 
			if CheckPointsCoklat[nextCheckPoint] == nil then
				if DoesBlipExist(blipcoklat) then
					RemoveBlip(blipcoklat)
				end

				vehicle = GetVehiclePedIsIn(playerPed, false)
				DeleteVehicle(vehicle)
				onDutyCoklat = 2
			else
				if CurrentCheckPointCoklat ~= LastCheckPointCoklat then
					if DoesBlipExist(blipcoklat) then
						RemoveBlip(blipcoklat)
					end

					blipcoklat = AddBlipForCoord(CheckPointsCoklat[nextCheckPoint].Pos.x, CheckPointsCoklat[nextCheckPoint].Pos.y, CheckPointsCoklat[nextCheckPoint].Pos.z)
					SetBlipRoute(blipcoklat, 1)

					LastCheckPointCoklat = CurrentCheckPointCoklat
				end

				local distance = GetDistanceBetweenCoords(coords, CheckPointsCoklat[nextCheckPoint].Pos.x, CheckPointsCoklat[nextCheckPoint].Pos.y, CheckPointsCoklat[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(20, CheckPointsCoklat[nextCheckPoint].Pos.x, CheckPointsCoklat[nextCheckPoint].Pos.y, CheckPointsCoklat[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3 then
					vehicle = GetVehiclePedIsIn(playerPed, false)
					if GetHashKey(Config.VehicleSpawnFarm.Coklat) == GetEntityModel(vehicle) then
						CurrentCheckPointCoklat = CurrentCheckPointCoklat + 1
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

		for i=1, #coklatPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(coklatPlants[i]), false) < 1 then
				nearbyObject, nearbyID = coklatPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp  then
				RNRFunctions.drawtext("E - Mengambil")
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
                if countcabutcoklat >= 80 then 
                    onDutyCoklat = 0
					countcabutcoklat = 0
				else
					isPickingUp = true

					RNRFunctions.TriggerServerCallback('rw:canPickUp', function(canPickUp)

						if canPickUp then
							if lib.progressBar({
								duration = 2500,
								label = 'Memetik Coklat',
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
								table.remove(coklatPlants, nearbyID)
								spawnedCoklat = spawnedCoklat - 1
								countcabutcoklat = countcabutcoklat + 1
								TriggerServerEvent('rw:pickedUpCoklat')
							else 
								RNRFunctions.Notify('Kamu Cancel', 'error')
							end
						else
							RNRFunctions.Notify('Melebihi Batas', 'error')
						end

						isPickingUp = false

					end, 'coklat')
				end
			end

		else
			RNRFunctions.hidedraw()
			Citizen.Wait(500)
		end

	end

end)

function SpawnTanamanCoklat()
	while spawnedCoklat < 30 do
		Citizen.Wait(0)
		local coklatCoords = GenerateCoklatCoords()

		RNRFunctions.SpawnLocalObject(Config.PropFarm.Coklat, coklatCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			table.insert(coklatPlants, obj)
			spawnedCoklat = spawnedCoklat + 1
		end)
	end
end

function ValidateCoklatCoord(plantCoord)
	if spawnedCoklat > 0 then
		local validate = true

		for k, v in pairs(coklatPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CoklatField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCoklatCoords()
	while true do
		Citizen.Wait(1)

		local coklatCoordX, coklatCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-15, 15)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-15, 15)

		coklatCoordX = Config.CircleZones.CoklatField.coords.x + modX
		coklatCoordY = Config.CircleZones.CoklatField.coords.y + modY

		local coordZ = GetCoordZ(coklatCoordX, coklatCoordY)
		local coord = vector3(coklatCoordX, coklatCoordY, coordZ)

		if ValidateCoklatCoord(coord) then
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