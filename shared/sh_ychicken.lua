Config.ChickenField = vector3(2375.71, 5054.3, 46.44)

Config.Items = {
    ['PotongAyam'] = {
        dapet = {
            {item = 'ayampotong', amount = 2},
            {item = 'buluayam', amount = 1}
        },
        butuh = {
            {item = 'ayam', amount = 2}
        }
    },
    ['PackingAyam'] = {
        dapet = {
            {item = 'paketayam', amount = 5}
        },
        butuh = {
            {item = 'ayampotong', amount = 5}
        }
    },
    ['PengambilanAyam'] = {
        dapet = {
            {item = 'ayam', amount = 1}
        }
    }
}

Config.Lokasi = {
    ['PotongAyam'] = {
        minigame = {'easy'}, -- jika tidak ingin menggunakan minigame set value ke false
        zones = {
            {
                name = "Potong ayam 1",
                coords = vec3(-95.71, 6207.54, 31.0),
                size = vec3(1.9, 2.85, 1),
                rotation = 45.0,
            },
            {
                name = "Potong ayam 2",
                coords = vec3(-100.24, 6202.27, 31.0),
                size = vec3(1.9, 1.7, 1),
                rotation = 45.0,
            }
        }
    },
    ['PackingAyam'] = {
        minigame = {'easy'}, -- jika tidak ingin menggunakan minigame set value ke false
        zones = {
            {
                name = "Pack Ayam",
                coords = vec3(-102.99, 6208.22, 31.0),
                size = vec3(1.75, 11.55, 1.0),
                rotation = 315.0,
                heading = 43.0828
            },
            {
                name = "Packing Ayam 2",
                coords = vec3(-104.43, 6209.56, 31.0),
                size = vec3(1.75, 11.55, 1.0),
                rotation = 315.0,
                heading = 226.8433
            },
        }
    },
    ['PengambilanAyam'] = {
        zones = {
            {
                name = "Pengambilan Ayam",
                coords = vec3(2409.33, 5019.12, 46.16),
                size = vec3(2.5, 3.0, 0.95),
                rotation = 313.5,
            }
        }
    }
}

Config.Saleayam = {
    itemsale = {
        ["paketayam"] = {
            ["Price"] = 900
        },
    },
}