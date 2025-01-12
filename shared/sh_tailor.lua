Config.Penjahit = {
    ['GrabWool'] = {
        zones = {
            {
                name = "Take Wool",
                coords = vec3(2125.8560, 4775.0527, 40.9703),
                size = vec3(1.75, 11.55, 1.0),
                rotation = 315.0,
                heading = 43.0828
            },
            {
                name = "Take Wool",
                coords = vec3(2142.6106, 4772.2769, 41.0413),
                size = vec3(1.75, 11.55, 1.0),
                rotation = 315.0,
                heading = 226.8433
            },
        }
    },
    ['GrabCloth'] = {
        zones = {
            {
                name = "Proccesing Cloth",
                coords = vec3(712.8567, -973.5587, 30.3954),
                size = vec3(1.75, 11.55, 1.0),
                rotation = 315.0,
                heading = 43.0828
            },
        }
    },

    ['MakeClothes'] = {
        zones = {
            {
                name = "Make Cloth",
                coords = vec3(713.8736, -961.8239, 30.3954),
                size = vec3(1.75, 11.55, 1.0),
                rotation = 315.0,
                heading = 43.0828
            },
            {
                name = "Make Cloth 2",
                coords = vec3(719.0349, -964.0794, 30.3954),
                size = vec3(1.75, 11.55, 1.0),
                rotation = 315.0,
                heading = 43.0828
            }
        }
    },
}

Config.PenjahitItem = {
    ['ambilwool'] = {
        dapet = {
            {item = 'wool', amount = 2}
        }
    },
    ['proseswool'] = {
        dapet = {
            {item = 'kain', amount = 1}
        },
        butuh = {
            {item = 'wool', amount = 2}
        }
    },
    ['jadipakain'] = {
        dapet = {
            {item = 'pakaian', amount = 1}
        },
        butuh = {
            {item = 'kain', amount = 2}
        }
    }
}