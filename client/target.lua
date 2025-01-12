Citizen.CreateThread(function()
    if Config.Target == "ox_target" then
        local chicken = {
            'a_c_hen',
        }
        local drawZones = Config.Debug
        exports.ox_target:addModel(chicken, {
            {
                name = 'ayam',
                event = "rnr_chicken:catch",
                icon = "far fas fa-laptop-medical",
                label = "Take",
            }
        })
        
        exports.ox_target:addBoxZone({
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
        
        exports.ox_target:addBoxZone({
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

        exports.ox_target:addBoxZone({
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