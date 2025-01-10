Config = {}

-- # Framework --
Config.Framework = 'qb' -- ESX | QB > Opsi Framework ur Use!
-- # Framework --

Config.CircleZones = {
	BatuField = {coords = vector3(2946.7392578125,2795.0068359375,40.665550231934), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	WeedField = {coords = vector3(-499.86, 5459.9, 80.13), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	CabeField = {coords = vector3(256.28, 6459.28, 31.42), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	CoklatField = {coords = vector3(-1604.13, 2205.93, 81.35), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	GaramField = {coords = vector3(446.52, 6728.89, 5.3), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	KopiField = {coords = vector3(-1604.13, 2205.93, 81.35), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	PadiField = {coords = vector3(643.03, 6474.95, 74.86), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	TebuField = {coords = vector3(694.12, 6468.17, 30.53), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	TehField = {coords = vector3(-1604.13, 2205.93, 81.35), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
}

Config.CheckPoints = {
	location_cabe = {
		{
			Pos = {x = 281.47, y = 6480.55, z = 29.50},
		},
		{
			Pos = {x = 215.21, y = 6474.93, z = 31.30},
		},
		{
			Pos = {x = 280.63, y = 6472.02, z = 31.30},
		},
		{
			Pos = {x = 236.72, y = 6458.71, z = 31.30},
		},
		{
			Pos = {x = 287.61, y = 6448.83, z = 31.30},
		},
	},
	location_coklat = {
		{
			Pos = {x = -1670.65, y = 2306.04, z = 58.62},
		},
		{
			Pos = {x = -1592.19, y = 2182.33, z = 76.14},
		},
		{
			Pos = {x = -1628.52, y = 2256.31, z = 77.94},
		},
	},
	location_garam = {
		{
			Pos = {x = 457.81, y = 6700.09, z = 7.42},
		},
		{
			Pos = {x = 428.66, y = 6717.38, z = 6.15},
		},
		{
			Pos = {x = 460.85, y = 6707.88, z = 6.43},
		},
		{
			Pos = {x = 442.20, y = 6734.12, z = 4.55},
		},
		{
			Pos = {x = 463.51, y = 6730.31, z = 3.2},
		},
	},
	location_kopi = {
		{
			Pos = {x = -1670.65, y = 2306.04, z = 58.62},
		},
		{
			Pos = {x = -1592.19, y = 2182.33, z = 76.14},
		},
		{
			Pos = {x = -1628.52, y = 2256.31, z = 77.94},
		},
	},
	location_padi = {
		{
			Pos = {x = 615.79, y = 6458.89, z = 29.53},
		},
		{
			Pos = {x = 663.53, y = 6458.77, z = 31.05},
		},
		{
			Pos = {x = 620.14, y = 6468.25, z = 29.49},
		},
		{
			Pos = {x = 663.89, y = 6480.31, z = 29.85},
		},
		{
			Pos = {x = 613.65, y = 6494.16, z = 29.18},
		},
	},
	location_tebu = {
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
	},
	location_teh = {
		{
			Pos = {x = -1670.65, y = 2306.04, z = 58.62},
		},
		{
			Pos = {x = -1592.19, y = 2182.33, z = 76.14},
		},
		{
			Pos = {x = -1628.52, y = 2256.31, z = 77.94},
		},
	}
}

Config.Blips = {
	{title="Petani",colour=2, id=140,x = 428.76,  y = 6468.14, z = 28.78},
	{title="Petani",colour=2, id=140,x = -1146.27,  y = 2664.13, z = 18.21},
    {title="Pengolahan",colour=2, id=514,x = 433.55,  y = 6501.39, z = 28.81},
    {title="Area Tambang Batu", colour=5, id=318, x = 2935.9653320313, y = 2796.3686523438, z = 40.767963409424},
    {title="Pabrik Kayu", colour=4, id=237, x = -499.86, y = 5459.9,  z = 80.13},
}

lib.locale()