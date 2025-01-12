GlobalState.Sapi = Config.Sapi

CreateThread(function()
    for _, v in pairs(Config.Sapi) do
        v.perah = false
        v.kulit = false
    end
end)

function SapiCooldown(loc)
    local src = source
    Config.Sapi[loc].perah = false
    Config.Sapi[loc].kulit = false
    GlobalState.Sapi = Config.Sapi
    TriggerClientEvent('rnr_jobs:client:respawnsapi', src, loc)
end

function CheckDist(source, player)
    local pcoords = GetEntityCoords(player)
    local ok
    if #(pcoords - Config.CowDist['Area']) < 100.0 then
        return ok
    else
        if Config.Debug then
            print("Player is too far from the location")
        end
    end
end

RegisterNetEvent('rnr_jobs:server:perahsapi', function(loc)
    local src = source
	local playerPed = GetPlayerPed(src)
	if CheckDist(src, playerPed) then return end
    if not Config.Sapi[loc].perah then
        Config.Sapi[loc].perah = true
        local Player = QBCore.Functions.GetPlayer(src)
        if Config.Items['TakeMilk'].Used then
            for k, v in pairs(Config.Items['TakeMilk'].Item) do
                RNRFunctions.AddItem(v.name, v.amount)
                if Config.Debug then
                    print('Peras Susu: '..v.item..' x '..v.amount..' berhasil diambil')
                end
            end
        end
    else
        if Config.Debug then
            print("Player has already spawned a sapi at this location")
        end
    end
end)

RegisterNetEvent('rnr_jobs:server:kulitisapi', function(loc)
    local src = source
	local playerPed = GetPlayerPed(src)
	if CheckDist(src, playerPed) then return end
    if not Config.Sapi[loc].kulit then
        Config.Sapi[loc].kulit = true
        GlobalState.Sapi = Config.Sapi
        TriggerClientEvent("nazz:client:removesapi", src, loc)
        SapiCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(src)
        if Config.Items['TakeSkin'].Used then
            for k, v in pairs(Config.Items['TakeSkin'].Item) do
                RNRFunctions.AddItem(v.name, v.amount)
                if Config.Debug then
                    print('Peras Susu: '..v.item..' x '..v.amount..' berhasil diambil')
                end
            end
        end
        if Config.Items['TakeMeat'].Used then
            for k, v in pairs(Config.Items['TakeMeat'].Item) do
                RNRFunctions.AddItem(v.name, v.amount)
                if Config.Debug then
                    print('Peras Susu: '..v.item..' x '..v.amount..' berhasil diambil')
                end
            end
        end
    else
        if Config.Debug then
            print("Player has already spawned a sapi at this location")
        end
    end
end)