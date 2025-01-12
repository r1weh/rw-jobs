Config.DistanceSpawn = 50.0
Config.PedList = {
    -- { -- EXEMPLE!
    --     Model = 'a_m_y_hipster_01',
    --     Coords = vector4(100.0, 100.0, 30.0, 0.0),
    --     Gender = 'male',
    --     AnimDict = nil, -- Pasang Ini jika menggunakan AnimDict!
    --     AnimName = nil, -- Pasang Ini jika menggunakan AnimName!
    --     Scenario = nil, -- Pasang Ini jika menggunakan Scenario!
    --     Event = 'my_script:pedAction',
    --     Icon = 'fas fa-user',
    --     Label = 'Talk to Hipster'
    -- },

	-- Penjual Pakaian
	{
		Model = `a_m_m_hasjew_01`, -- Model name as a hash.
		Coords = vector4(452.1025, -783.4636, 27.3578, 270.2872), -- Hawick Ave (X, Y, Z, Heading)
		Gender = 'male', -- The gender of the ped, used for the CreatePed native.
        Scenario = 'WORLD_HUMAN_AA_COFFEE',
        Event = 'my_script:pedAction',
        Icon = 'fas fa-user',
        Label = 'Talk to Hipster'
	},

    -- Penjualan Farmer
    {
		Model = `a_m_m_farmer_01`, -- Model name as a hash.
		Coords = vector4(463.2415, -778.8357, 27.3590, 92.0393), -- Hawick Ave (X, Y, Z, Heading)
		Gender = 'male', -- The gender of the ped, used for the CreatePed native.
        Scenario = 'WORLD_HUMAN_CLIPBOARD',
        Event = 'my_script:pedAction',
        Icon = 'fas fa-user',
        Label = 'Talk to Hipster'
	},

    -- Lumberjack Proccess
    {
		Model = `a_m_y_soucent_03`, -- Model name as a hash.
		Coords = vector4(1205.0223, -1335.2930, 35.2269, 82.7173), -- Hawick Ave (X, Y, Z, Heading)
		Gender = 'male', -- The gender of the ped, used for the CreatePed native.
        Scenario = 'WORLD_HUMAN_AA_SMOKE',
        Event = 'my_script:pedAction',
        Icon = 'fas fa-user',
        Label = 'Talk to Hipster'
	},

    -- Lumberjack Seller
    {
		Model = `a_m_m_og_boss_01`, -- Model name as a hash.
		Coords = vector4(452.0460, -774.1253, 27.3578, 268.4489), -- Hawick Ave (X, Y, Z, Heading)
		Gender = 'male', -- The gender of the ped, used for the CreatePed native.
        Scenario = 'WORLD_HUMAN_AA_SMOKE',
        Event = 'my_script:pedAction',
        Icon = 'fas fa-user',
        Label = 'Talk to Hipster'
	},

	-- Slaughter Seller
    {
		Model = `g_m_m_chemwork_01`, -- Model name as a hash.
		Coords = vector4(451.9515, -767.9386, 27.3578, 265.5547), -- Hawick Ave (X, Y, Z, Heading)
		Gender = 'male', -- The gender of the ped, used for the CreatePed native.
        Scenario = 'WORLD_HUMAN_CLIPBOARD',
        Event = 'my_script:pedAction',
        Icon = 'fas fa-user',
        Label = 'Talk to Hipster'
	},
}

Config.SaleItem = {
    itemsale = {
        ["paketayam"] = {
            ["Price"] = 900
        }
    },
}