local Sapi = {}

local function initSapi()
    local blipSapi = AddBlipForCoord(2269.11, 4925.32, 40.97)
    SetBlipSprite(blipSapi, 293)
    SetBlipColour(blipSapi, 3)
    SetBlipDisplay(blipSapi, 6)
    SetBlipScale(blipSapi, 0.8)
    SetBlipAsShortRange(blipSapi, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Pekerjaan Sapi')
    EndTextCommandSetBlipName(blipSapi)

    for k, v in pairs(GlobalState.Sapi) do
        local hash = GetHashKey(v.model)
        lib.RequestModel(hash, 60000)
        if not v.taken then
            Sapi[k] = CreatePed(0, hash, v.location.x-math.random(1, 15), v.location.y-math.random(1, 15), v.location.z - 1, v.heading, false, false)
            SetBlockingOfNonTemporaryEvents(Sapi[k], true)
            TaskWanderInArea(Sapi[k], 2263.12, 4928.45, 40.96, 17.150000000001, 0, 0)
            exports['qb-target']:AddTargetEntity(Sapi[k], {
                options = {
                    {
                        icon = 'fa-solid fa-bucket',
                        label = 'Perah Susu Sapi',
                        action = function()
                            if Sapi[Sapi[k]] ~= true then
                                ClearPedTasks(Sapi[k])
                                if lib.progressBar({
                                    duration = 3000,
                                    label = 'Memerah susu sapi...',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = {
                                        car = true,
                                        move = true,
                                        combat = true
                                    },
                                    anim = {
                                        dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                                        clip = 'machinic_loop_mechandplayer',
                                        flag = 1
                                    },
                                }) then
                                    TriggerServerEvent('nazz:server:perahsapi', k)
                                    TaskWanderInArea(Sapi[k], 2263.12, 4928.45, 40.96, 17.150000000001, 0, 0)
                                    Sapi[Sapi[k]] = true
                                end
                            else
                                QBCore.Functions.Notify('Sapi sudah diperah!', "error", 3000)
                            end
                        end,
                        canInteract = function()
                            if IsEntityDead(Sapi[k]) then return false end
                            return true
                        end,
                    },
                    {
                        icon = 'fa-solid fa-cow',
                        label = 'Potong Sapi',
                        action = function()
                            local ped = cache.ped
                            local weaponHash = GetSelectedPedWeapon(ped)
                            if weaponHash == GetHashKey('WEAPON_MACHETE') then
                                if lib.progressBar({
                                    duration = 4000,
                                    label = 'Menguliti sapi...',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = {
                                        car = true,
                                        move = true,
                                        combat = true
                                    },
                                    anim = {
                                        dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                                        clip = 'machinic_loop_mechandplayer',
                                        flag = 1
                                    },
                                }) then
                                    TriggerServerEvent('nazz:server:kulitisapi', k)
                                    if Sapi[Sapi[k]] ~= nil then
                                    Sapi[Sapi[k]] = nil
                                    end
                                end
                            else
                                QBCore.Functions.Notify('Kamu harus memegang Machete untuk menguliti sapi!', 'warning', 3000)
                            end
                        end,
                        canInteract = function()
                            if not IsEntityDead(Sapi[k]) then return false end
                            return true
                        end,
                    }
                }
            })
        end
    end
end

RegisterNetEvent('nazz:client:respawnsapi', function(loc)
    -- Wait(5000)
    local v = GlobalState.Sapi[loc]
    local hash = GetHashKey(v.model)
    lib.RequestModel(hash, 60000)
    if not Sapi[loc] then
        Sapi[loc] = CreatePed(0, hash, v.location.x-math.random(1, 15), v.location.y-math.random(1, 15), v.location.z - 1, v.heading, false, false)
        SetBlockingOfNonTemporaryEvents(Sapi[loc], true)
        TaskWanderInArea(Sapi[loc], 2263.12, 4928.45, 40.96, 17.150000000001, 0, 0)
        exports['qb-target']:AddTargetEntity(Sapi[loc], {
            options = {
                {
                    icon = 'fa-solid fa-bucket',
                    label = 'Perah Susu Sapi',
                    action = function()
                        ClearPedTasks(Sapi[loc])
                        if lib.progressBar({
                            duration = 3000,
                            label = 'Memerah susu sapi...',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                                move = true,
                                combat = true
                            },
                            anim = {
                                dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                                clip = 'machinic_loop_mechandplayer',
                                flag = 1
                            },
                        }) then
                            if Sapi[Sapi[loc]] ~= true then
                                TriggerServerEvent('nazz:server:perahsapi', loc)
                                TaskWanderInArea(Sapi[loc], 2263.12, 4928.45, 40.96, 17.150000000001, 0, 0)
                                Sapi[Sapi[loc]] = true
                            else
                                QBCore.Functions.Notify('Sapi sudah diperah!', "error", 3000)
                            end
                        end
                    end,
                    canInteract = function()
                        if IsEntityDead(Sapi[loc]) then return false end
                        return true
                    end,
                },
                {
                    icon = 'fa-solid fa-cow',
                    label = 'Potong Sapi',
                    action = function()
                        if lib.progressBar({
                            duration = 4000,
                            label = 'Menguliti sapi...',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                                move = true,
                                combat = true
                            },
                            anim = {
                                dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                                clip = 'machinic_loop_mechandplayer',
                                flag = 1
                            },
                        }) then
                            TriggerServerEvent('nazz:server:kulitisapi', loc)
                            if Sapi[Sapi[loc]] ~= nil then
                                Sapi[Sapi[loc]] = nil
                            end
                        end
                    end,
                    canInteract = function()
                        if not IsEntityDead(Sapi[loc]) then return false end
                        return true
                    end,
                }
            }
        })
    end
end)

RegisterNetEvent('nazz:client:removesapi', function(loc)
    if DoesEntityExist(Sapi[loc]) then
        DeleteEntity(Sapi[loc])
    end
    Sapi[loc] = nil
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('a_c_cow'))
        for k, v in pairs(Sapi) do
            if DoesEntityExist(v) then
                DeleteEntity(v)
                SetEntityAsNoLongerNeeded(v)
            end
        end
    end
end)

CreateThread(function()
    initSapi()
end)