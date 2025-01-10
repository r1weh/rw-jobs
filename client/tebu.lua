ESX = nil
local spawnedTebu = 0
local tebuPlants = {}
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

local CurrentCheckPointTebu = 0
local LastCheckPointTebu   = -1

local CheckPointsTebu = {
    {
        Pos = {x = 618.98, y = 6457.67, z = 30.07},
    },
    {
        Pos = {x = 722.73, y = 6457.19, z = 30.71},
    },
    {
        Pos = {x = 683.48, y = 6465.52, z = 30.22},
    },
    {
        Pos = {x = 715.03, y = 6475.95, z = 28.54},
    },
    {
        Pos = {x = 686.55, y = 6485.27, z = 28.98},
    },
}

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
                if PlayerData.job.name == 'petani' then
                    letSleep = false
				    SpawnTanamanTebu()
                end
            end
        end

        if GetDistanceBetweenCoords(coords, 437.73, 6456.33, 28.28, true) < 3 then

            if PlayerData.job.name == 'petani' then
                letSleep = false
                DrawMarker(39, 437.73, 6456.33, 28.28, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
                ESX.ShowHelpNotification('E - Mengambil Traktor (Tebu)')
                if IsControlJustReleased(0, 38) and onDutyTebu == 0 then 
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        if skin.sex == 0 then
                            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                        elseif skin.sex == 1 then
                            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                        end
                    end)
                    Citizen.Wait(500)
                    ESX.Game.SpawnVehicle('tractor',{ x = 437.73, y = 6456.33, z = 28.28}, 326.37, function(callback_vehicle)
						onDutyTebu = 1
						TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
					end)
                end
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
			ESX.Game.DeleteObject(v)
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
				ESX.Game.DeleteVehicle(vehicle)
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
					if GetHashKey('tractor') == GetEntityModel(vehicle) then
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
				ESX.ShowHelpNotification("E - Mengambil")
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
                if countcabuttebu >= 80 then 
                    onDutyTebu = 0
					countcabuttebu = 0
				else
					isPickingUp = true

					ESX.TriggerServerCallback('rw:canPickUp', function(canPickUp)

						if canPickUp then
							TriggerEvent("mythic_progbar:client:progress", {
								name = "stone_farm",
								duration = 2500,
								label = 'Mencabut Tebu',
								useWhileDead = true,
								canCancel = false,
								controlDisables = {
									disableMovement = true,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								},
								animation = {
									animDict = "creatures@rottweiler@tricks@",
									anim = "petting_franklin",
									flags = 49,
								},
							}, function(status)
								if not status then
									-- Do Something If Event Wasn't Cancelled
								end
							end)

							Citizen.Wait(2500)
		
							ESX.Game.DeleteObject(nearbyObject)
		
							table.remove(tebuPlants, nearbyID)
                            spawnedTebu = spawnedTebu - 1
                            countcabuttebu = countcabuttebu + 1
		
							TriggerServerEvent('rw:pickedUpTebu')
						else
							exports['mythic_notify']:SendAlert('error', 'Melebihi Batas', 10000)
						end

						isPickingUp = false

					end, 'tebu')
				end
			end

		else
			Citizen.Wait(500)
		end

	end

end)

function SpawnTanamanTebu()
	while spawnedTebu < 10 do
		Citizen.Wait(0)
		local tebuCoords = GenerateTebuCoords()

		ESX.Game.SpawnLocalObject('prop_veg_corn_01', tebuCoords, function(obj)
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