local drawZones = Config.Debug

Citizen.CreateThread(function()
    if Config.Target == "ox_target" then
        local ox_target = exports.ox_target
        local chicken = {
            'a_c_hen',
        }
        ox_target:addModel(chicken, {
            {
                name = 'ayam',
                event = "rnr_chicken:catch",
                icon = "far fas fa-laptop-medical",
                label = "Take",
            }
        })
        
        for i = 1, #Config.Lokasi['CutChicken'].zones do
            local temp = Config.Lokasi['CutChicken'].zones[i]
            ox_target:addBoxZone({
                name = temp.name,
                coords = temp.coords,
                size = temp.size,
                rotation = temp.rotation,
                debug = drawZones,
                onExit = function ()
                    RNRFunctions.hidedraw()
                end,
                onEnter = function ()
                    RNRFunctions.drawtext('Potong Ayam', "fa-solid fa-drumstick-bite")
                end,
                options = {
                    {
                        label = 'Potong Ayam',
                        icon = "fa-solid fa-drumstick-bite",
                        evemt = 'rnr_chicken:Process',
                        distance = 3.5
                    }
                }
            })
        end
        -- Packing Ayam
        for i = 1, #Config.Lokasi['ChickenPacking'].zones do
            local temp = Config.Lokasi['ChickenPacking'].zones[i]
            ox_target:addBoxZone({
                name = temp.name,
                coords = temp.coords,
                size = temp.size,
                rotation = temp.rotation,
                debug = drawZones,
                onExit = function ()
                    RNRFunctions.hidedraw()
                end,
                onEnter = function ()
                    RNRFunctions.drawtext('Kemas Ayam', "fa-solid fa-box-open")
                end,
                options = {
                    {
                        label = 'Kemas Ayam',
                        icon = "fa-solid fa-box-open",
                        onSelect = function ()
                            TriggerEvent('rnr_chicken:Pack', temp.heading)
                        end,
                        distance = 3.5
                    }
                }
            })
        end
    elseif Config.Target == "qb-target" then
        local chicken = {
            'a_c_hen',
        }
        
        exports['qb-target']:AddTargetModel(chicken, {
            options = {
                {
                    type = "client",
                    event = "rnr_chicken:catch",
                    icon = "fas fa-laptop-medical",
                    label = "Take",
                },
            },
            distance = 2.0
        })
        
        for i = 1, #Config.Lokasi['CutChicken'].zones do
            local temp = Config.Lokasi['CutChicken'].zones[i]
            exports['qb-target']:AddBoxZone("cut_chicken_1", temp.coords, 2, 2, {
                name = "cut_chicken_1",
                heading = temp.rotation,
                debugPoly = drawZones, -- Ubah ke true jika ingin melihat zona
                minZ = 30.0,
                maxZ = 32.0,
            }, {
                options = {
                    {
                        type = "client",
                        event = "rnr_chicken:Process",
                        icon = "fas fa-drumstick-bite",
                        label = temp.name,
                    },
                },
                distance = 2.0
            })
        end

        for i = 1, #Config.Lokasi['CutChicken'].zones do
            local temp = Config.Lokasi['CutChicken'].zones[i]
            exports['qb-target']:AddBoxZone("cut_chicken_2", temp.coords, 2, 2, {
                name = "cut_chicken_2",
                heading = temp.rotation,
                debugPoly = drawZones, -- Ubah ke true jika ingin melihat zona
                minZ = 30.0,
                maxZ = 32.0,
            }, {
                options = {
                    {
                        type = "client",
                        event = "rnr_chicken:Process",
                        icon = "fas fa-drumstick-bite",
                        label = temp.name,
                    },
                },
                distance = 2.0
            })
        end
    end
end)