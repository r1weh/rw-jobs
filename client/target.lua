Citizen.CreateThread(function()
    if Config.Target == "ox_target" then
        local ox_target = exports.ox_target
        local drawZones = Config.Debug
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
        
        ox_target:addBoxZone({
            coords = vec3(-95.0819, 6207.5879, 31.0259),
            size = vec3(2, 2, 2),
            rotation = 45,
            debug = drawZones,
            options = {
                {
                    event = "rnr_chicken:Process",
                    icon = "fa-solid fa-drumstick-bite",
                    label = "Cut Chicken"
                }
            }
        })
        
        ox_target:addBoxZone({
            coords = vec3(-99.9406, 6201.8672, 31.0685),
            size = vec3(2, 2, 2),
            rotation = 45,
            debug = drawZones,
            options = {
                {
                    event = "rnr_chicken:Process2",
                    icon = "fa-solid fa-drumstick-bite",
                    label = "Cut Chicken",
                }
            }
        })

        ox_target:addBoxZone({
            coords = vec3(-103.8782, 6208.5313, 30.9089),
            size = vec3(2, 2, 2),
            rotation = 136.2,
            debug = drawZones,
            options = {
                {
                    event = "rnr_chicken:Pack",
                    icon = "fa-solid fa-drumstick-bite",
                    label = "Pack Chicken",
                }
            }
        })
        
        for i = 1, #Config.Lokasi['PotongAyam'].zones do
            local temp = Config.Lokasi['PotongAyam'].zones[i]
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
        for i = 1, #Config.Lokasi['PackingAyam'].zones do
            local temp = Config.Lokasi['PackingAyam'].zones[i]
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
        
        exports['qb-target']:AddBoxZone("cut_chicken_1", vector3(-95.0819, 6207.5879, 31.0259), 2, 2, {
            name = "cut_chicken_1",
            heading = 45,
            debugPoly = false, -- Ubah ke true jika ingin melihat zona
            minZ = 30.0,
            maxZ = 32.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "rnr_chicken:Process",
                    icon = "fas fa-drumstick-bite",
                    label = "Cut Chicken",
                    -- item = 'WEAPON_KNIFE',
                },
            },
            distance = 2.0
        })
        
        exports['qb-target']:AddBoxZone("cut_chicken_2", vector3(-99.9406, 6201.8672, 31.0685), 2, 2, {
            name = "cut_chicken_2",
            heading = 45,
            debugPoly = false, -- Ubah ke true jika ingin melihat zona
            minZ = 30.0,
            maxZ = 32.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "rnr_chicken:Process2",
                    icon = "fas fa-drumstick-bite",
                    label = "Cut Chicken",
                    -- item = 'WEAPON_KNIFE',
                },
            },
            distance = 2.0
        })
    end
end)