Config.Sapi = {
    { location = vector3(2259.67, 4924.93, 40.91), heading = 117.37, model = "a_c_cow"},
    { location = vector3(2260.54, 4935.67, 41.09), heading = 13.6,   model = "a_c_cow"},
    { location = vector3(2251.92, 4936.16, 41.1),  heading = 188.99, model = "a_c_cow"},
    { location = vector3(2248.79, 4929.06, 40.87), heading = 151.72, model = "a_c_cow"},
    { location = vector3(2254.63, 4922.82, 40.86), heading = 223.27, model = "a_c_cow"},
    { location = vector3(2261.94, 4924.04, 40.91), heading = 353.25, model = "a_c_cow"},
    { location = vector3(2258.62, 4937.81, 41.13), heading = 213.51, model = "a_c_cow"},
    { location = vector3(2272.51, 4935.08, 41.34), heading = 216.93, model = "a_c_cow"},
    { location = vector3(2266.22, 4917.57, 40.95), heading = 86.75,  model = "a_c_cow"},
    { location = vector3(2266.16, 4930.94, 41.01), heading = 106.27, model = "a_c_cow"}
}

Config.Items = {
    ['TakeMilk'] = {
        Used = true, -- Set to true to make items addable  
        Item = {
            name = 'milkbucket', amount = math.random(1, 10)
        }
    },
    ['TakeSkin'] = {
        Used = true, -- Set to true to make items addable  
        Item = {
            name = 'hunting_skin', amount = math.random(1, 10),
        }
    },
    ['TakeMeat'] = {
        Used = true, -- Set to true to make items addable
        Item = {
            name = 'raw_chicken', amount = math.random(1, 10),
        }
    }
}