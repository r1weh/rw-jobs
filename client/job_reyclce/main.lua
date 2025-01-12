local carryPackage = nil
local packagePos = nil
local onDuty = false
local oxTargetaddGetBox = nil
local oxTargetremoveGetBox = nil

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function GetRandomPackage()
    local randSeed = math.random(1, #Config["delivery"].lokasiPengambilan)
    packagePos = {}
    packagePos.x = Config["delivery"].lokasiPengambilan[randSeed].x
    packagePos.y = Config["delivery"].lokasiPengambilan[randSeed].y
    packagePos.z = Config["delivery"].lokasiPengambilan[randSeed].z
end

local function PickupPackage()
    local pos = GetEntityCoords(PlayerPedId(), true)
    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        Wait(7)
    end
    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    local model = `prop_cs_cardbox_01`
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    local object = CreateObject(model, pos.x, pos.y, pos.z, true, true, true)
    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
    carryPackage = object
end

local function DropPackage()
    ClearPedTasks(PlayerPedId())
    DetachEntity(carryPackage, true, true)
    DeleteObject(carryPackage)
    carryPackage = nil
end
-- Threads

CreateThread(function()
    local RecycleBlip = AddBlipForCoord(Config['delivery'].lokasiLuar.x, Config['delivery'].lokasiLuar.y, Config['delivery'].lokasiLuar.z)
    SetBlipSprite(RecycleBlip, 365)
    SetBlipColour(RecycleBlip, 2)
    SetBlipScale(RecycleBlip, 1.0)
    SetBlipAsShortRange(RecycleBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Recycle Center")
    EndTextCommandSetBlipName(RecycleBlip)

    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId(), true)

        if #(pos - vector3(Config['delivery'].lokasiLuar.x, Config['delivery'].lokasiLuar.y, Config['delivery'].lokasiLuar.z)) < 20.0 then
            DrawText3D(Config['delivery'].lokasiLuar.x, Config['delivery'].lokasiLuar.y, Config['delivery'].lokasiLuar.z + 1, "~g~E~w~ - Masuk")
            if IsControlJustReleased(0, 38) then
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                SetEntityCoords(PlayerPedId(), Config['delivery'].lokasiDalam.x, Config['delivery'].lokasiDalam.y, Config['delivery'].lokasiDalam.z)
                DoScreenFadeIn(500)
            end
        end

		if #(pos - vector3(Config['delivery'].lokasiDalam.x, Config['delivery'].lokasiDalam.y, Config['delivery'].lokasiDalam.z)) < 1.3 then
			DrawText3D(Config['delivery'].lokasiDalam.x, Config['delivery'].lokasiDalam.y, Config['delivery'].lokasiDalam.z + 1, "~g~E~w~ - Keluar")
			if IsControlJustReleased(0, 38) then
				DoScreenFadeOut(500)
				while not IsScreenFadedOut() do
					Wait(10)
				end
				SetEntityCoords(PlayerPedId(), Config['delivery'].lokasiLuar.x, Config['delivery'].lokasiLuar.y, Config['delivery'].lokasiLuar.z + 1)
				DoScreenFadeIn(500)
			end
		end

        if #(pos - Config.lokasiOnduty) < 3.5 and not IsPedInAnyVehicle(PlayerPedId(), false) and carryPackage == nil then
            if #(pos - Config.lokasiOnduty) < 3.5 then
                if onDuty then
                    DrawText3D(Config.lokasiOnduty.x, Config.lokasiOnduty.y, Config.lokasiOnduty.z, "Berhenti Bekerja")
                else
                    DrawText3D(Config.lokasiOnduty.x, Config.lokasiOnduty.y, Config.lokasiOnduty.z, "Mulai Bekerja")
                end
            end
        end
    end
end)

CreateThread(function()
    for k, pickuploc in pairs(Config['delivery'].lokasiPengambilan) do
        local model = GetHashKey(Config['delivery'].warehouseObjects[math.random(1, #Config['delivery'].warehouseObjects)])
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(0) end
        local obj = CreateObject(model, pickuploc.x, pickuploc.y, pickuploc.z, false, true, true)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
    end

    while true do
        Wait(5)
        if onDuty then
            if packagePos ~= nil then
                local pos = GetEntityCoords(PlayerPedId(), true)
                if carryPackage == nil then
                    if #(pos - vector3(packagePos.x, packagePos.y, packagePos.z)) then
                        DrawText3D(packagePos.x,packagePos.y,packagePos.z+ -0.4, "Mengambil Paket")
                    else
                        DrawText3D(packagePos.x, packagePos.y, packagePos.z + 1, "Paket - Paket")
                    end
                else
                    if #(pos - vector3(Config['delivery'].lokasiMembuka.x, Config['delivery'].lokasiMembuka.y, Config['delivery'].lokasiMembuka.z)) < 2.0 then
                        DrawText3D(Config['delivery'].lokasiMembuka.x, Config['delivery'].lokasiMembuka.y, Config['delivery'].lokasiMembuka.z, "Membuka Paket")
                    else
                        DrawText3D(Config['delivery'].lokasiMembuka.x, Config['delivery'].lokasiMembuka.y, Config['delivery'].lokasiMembuka.z, "Membuka")
                    end
                end
            else
                GetRandomPackage()
            end
        end
    end
end)


CreateThread(function()
    exports.ox_target:addBoxZone({
        coords = Config.lokasiOnduty,
        options = {
            {
                label = 'Buka Job Recycle',
                name = 'recycleOn',
                icon = 'fa-solid fa-boxes-packing',
                onSelect = openMenuDuty()
            }
        }
    })
end)

function openMenuDuty()
    local listduty = {}
    if onDuty then
        table.insert(listduty, {
            title = 'Berhenti Bekerja',
            icon = 'fa-solid fa-arrow-right-from-bracket',
            onSelect = function()
                onDuty = not onDuty
                Citizen.Wait(150)
                if oxTargetaddGetBox then
                    removeOXTARGET(oxTargetaddGetBox)
                end
                if oxTargetremoveGetBox then
                    removeOXTARGET(oxTargetremoveGetBox)
                end
            end,
        })
    else
        table.insert(listduty, {
            title = 'Mulai Bekerja',
            icon = 'fa-solid fa-arrow-right-to-bracket',
            onSelect = function()
                onDuty = not onDuty
                Citizen.Wait(150)
                addGetBox()
            end,
        })
    end

    lib.registerContext({
        id = 'recycle_menu',
        title = 'Job Recycle',
        options = listduty
      })
    lib.showContext('recycle_menu')
end

function addDropBox()
    if Config.Target == 'ox_target' then
        oxTargetremoveGetBox = exports.ox_target:addBoxZone({
            coords = vec3(Config['delivery'].lokasiMembuka.x, Config['delivery'].lokasiMembuka.y, Config['delivery'].lokasiMembuka.z),
            options = {
                {
                    label = 'Membuka BOX',
                    name = 'membukaBOX',
                    icon = 'fa-solid fa-boxes-packing',
                    onSelect = function (data)
                        if lib.progressCircle({
                            duration = 2000,
                            position = 'bottom',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                                move = true,
                            },
                            anim = {
                                dict = 'mp_car_bomb',
                                clip = 'car_bomb_mechanic'
                            },
                        }) then
                            DropPackage()
                            StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                            lib.callback.await('rnr_jobs:server:getItem', false)
                            GetRandomPackage()
                            Citizen.Wait(150)
                            addGetBox()
                            removeOXTARGET(oxTargetremoveGetBox)
                        end
                    end
                }
            }
        })
    elseif Config.Target == 'qb-target' then
        exports['qb-target']:AddBoxZone("membukaBOX", vec3(Config['delivery'].lokasiMembuka.x, Config['delivery'].lokasiMembuka.y, Config['delivery'].lokasiMembuka.z), 1.0, 1.0, {
            name = "membukaBOX",
            heading = 0,
            debugPoly = false,
            minZ = Config['delivery'].lokasiMembuka.z - 1.0,
            maxZ = Config['delivery'].lokasiMembuka.z + 1.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "membukaBOX:process",
                    icon = "fas fa-boxes-packing",
                    label = "Membuka BOX",
                },
            },
            distance = 2.5,
        })
    end
end

function addGetBox()
    if Config.Target == 'ox_target' then
        oxTargetaddGetBox = exports.ox_target:addBoxZone({
            coords = vec3(packagePos.x,packagePos.y,packagePos.z),
            options = {
                {
                    label = 'Mengambil BOX',
                    name = 'mengambilBox',
                    icon = 'fa-solid fa-boxes-packing',
                    onSelect = function (data)
                        if lib.progressCircle({
                            duration = 2000,
                            position = 'bottom',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                                move = true,
                            },
                            anim = {
                                dict = 'mini@repair',
                                clip = 'fixing_a_player'
                            },
                        }) then
                            ClearPedTasks(PlayerPedId())
                            PickupPackage()
                            Citizen.Wait(150)
                            removeOXTARGET(oxTargetaddGetBox)
                            addDropBox()
                        end
                    end
                }
            }
        })
    elseif Config.Target == 'qb-target' then
        exports['qb-target']:AddBoxZone("mengambilBox", vec3(packagePos.x, packagePos.y, packagePos.z), 1.0, 1.0, {
            name = "mengambilBox",
            heading = 0,
            debugPoly = false,
            minZ = packagePos.z - 1.0,
            maxZ = packagePos.z + 1.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "mengambilBox:process",
                    icon = "fas fa-boxes-packing",
                    label = "Mengambil BOX",
                },
            },
            distance = 2.5,
        })
    end
end

function removeOXTARGET(data)
    Citizen.CreateThread(function()
        if Config.Target == 'ox_target' then
            exports.ox_target:removeZone(data)
        elseif Config.Target == 'qb-target' then
            exports['qb-target']:RemoveZone(data)
        end
    end)
end

local function removeGetBox()
    exports['qb-target']:RemoveZone("mengambilBox")
    exports['qb-target']:RemoveZone("membukaBOX")
end

RegisterNetEvent("mengambilBox:process", function()
    if lib.progressCircle({
        duration = 2000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_player',
        },
    }) then
        ClearPedTasks(PlayerPedId())
        PickupPackage()
        Citizen.Wait(150)
        removeGetBox()
        addDropBox()
    end
end)

RegisterNetEvent("mengambilBox:process", function()
    if lib.progressCircle({
        duration = 2000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_player',
        },
    }) then
        ClearPedTasks(PlayerPedId())
        PickupPackage()
        Citizen.Wait(150)
        removeGetBox()
        addDropBox()
    end
end)

