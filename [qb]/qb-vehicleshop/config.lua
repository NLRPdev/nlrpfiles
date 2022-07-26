Config = {}
Config.UsingTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Commission = 0.15 -- Percent that goes to sales person from a full car sale 10%
Config.FinanceCommission = 0.15 -- Percent that goes to sales person from a finance sale 5%
Config.FinanceZone = vector3(-29.53, -1103.67, 26.42)-- Where the finance menu is located
Config.PaymentWarning = 10 -- time in minutes that player has to make payment before repo
Config.PaymentInterval = 24 -- time in hours between payment being due
Config.MinimumDown = 10 -- minimum percentage allowed down
Config.MaximumPayments = 24 -- maximum payments allowed
Config.Shops = {
    ['pdm'] = {
        ['Type'] = 'free-use', -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = {--polygon that surrounds the shop
                vector2(-62.397884368896, -1100.2120361328),
                vector2(-52.756202697754, -1074.9633789063),
                vector2(-15.467049598694, -1088.1143798828),
                vector2(-24.296125411987, -1114.4490966797)
            },
            ['minZ'] = 25.0, -- min height of the shop zone
            ['maxZ'] = 28.0, -- max height of the shop zone
            ['size'] = 2.75 -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Premium Deluxe Motorsport', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 326, -- Blip sprite
        ['blipColor'] = 3, -- Blip color
        ['Categories'] = {-- Categories available to browse
            ['sportsclassics'] = 'Sports Classics',
            ['sedans'] = 'Sedans',
            ['coupes'] = 'Coupes',
            ['suvs'] = 'SUVs',
            ['offroad'] = 'Offroad',
            ['muscle'] = 'Muscle',
            ['compacts'] = 'Compacts',
            ['motorcycles'] = 'Motorcycles',
            ['vans'] = 'Vans',
            ['cycles'] = 'Bicycles',
            ['mercedes'] = 'Mercedes',
            ['bmw'] = 'BMW',
            ['ford'] = 'Ford',
            ['lambo'] = 'Lambourghini',
            ['jeep'] = 'Jeep',
            ['lexus'] = 'Lexus',
            ['audi'] = 'Audi',
            ['audi'] = 'Lexus',
            ['mclarin'] = 'Mclarin',
            ['chevy'] = 'Chevrolet',
            ['cadi'] = 'Cadillac',
            ['canam'] = 'Can-AM',
            ['gmc'] = 'GMC',
            ['dodge'] = 'Dodge',
            ['yamaha'] = 'Yamaha',
            ['bent'] = 'Bentley',
            ['bugatti'] = 'Bugatti',
            ['am'] = 'Aston Martin',
            ['vw'] = 'VW'
        },
        ['TestDriveTimeLimit'] = 3.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-45.67, -1098.34, 26.42), -- Blip Location
        ['ReturnLocation'] = vector3(-44.74, -1082.58, 26.68), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-10.34, -1084.09, 27.05, 71), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(-10.34, -1084.09, 27.05, 71), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-49.76, -1083.75, 26.88, 195.73), -- where the vehicle will spawn on display
                defaultVehicle = 'adder', -- Default display vehicle
                chosenVehicle = 'adder', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-47.90, -1091.81, 26.88, 231),
                defaultVehicle = 'schafter2',
                chosenVehicle = 'schafter2'
            },
            [3] = {
                coords = vector4(-54.58, -1096.93, 26.88, 267),
                defaultVehicle = 'comet2',
                chosenVehicle = 'comet2'
            },
            [4] = {
                coords = vector4(-36.69, -1093.20, 26.88, 98),
                defaultVehicle = 'vigero',
                chosenVehicle = 'vigero'
            },
            [5] = {
                coords = vector4(-42.06, -1101.70, 26.88, 26),
                defaultVehicle = 't20',
                chosenVehicle = 't20'
            }
        },
    },
    ['rc'] = {
        ['Type'] = 'managed', -- meaning a real player has to sell the car
        ['Zone'] = {
            ['Shape'] = {
                vector2(792.47613525391, -833.0029296875),
                vector2(792.73400878906, -802.98950195313),
                vector2(812.30548095703, -802.80035400391),
                vector2(812.63952636719, -818.55328369141),
                vector2(821.40771484375, -825.33044433594),
                vector2(821.06744384766, -832.43682861328)
            },
            ['minZ'] = 25.09,
            ['maxZ'] = 29.09,
            ['size'] = 2.75 -- size of the vehicles zones
        },
        ['Job'] = 'rc', -- Name of job or none
        ['ShopLabel'] = 'Reckless customs',
        ['showBlip'] = false, -- true or false
        ['blipSprite'] = 326, -- Blip sprite
        ['blipColor'] = 3, -- Blip color
        ['Categories'] = {
            ['rc'] = 'Reckless custom vehicles'
        },
        ['TestDriveTimeLimit'] = 3.0,
        ['Location'] = vector3(804.14, -813.29, 26.18),
        ['ReturnLocation'] = vector3(803.70, -820.60, 25.76),
        ['VehicleSpawn'] = vector4(802.44, -820.78, 25.76, 270),
        ['TestDriveSpawn'] = vector4(802.44, -820.78, 25.76, 270), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(797.01, -806.47, 25.85, 180),
                defaultVehicle = 'bnr32',
                chosenVehicle = 'bnr32'
            },
            [2] = {
                coords = vector4(797.13, -813.95, 25.76, 180),
                defaultVehicle = 'fk8',
                chosenVehicle = 'fk8'
            },
        }
    }, -- Add your next table under this comma
    ['dono'] = {
        ['Type'] = 'managed', -- meaning a real player has to sell the car
        ['Zone'] = {
            ['Shape'] = {
                vector2(-806.38470458984, -221.3757019043),
                vector2(-789.11389160156, -251.33921813965),
                vector2(-758.11865234375, -239.26568603516),
                vector2(-777.7529296875, -205.4183807373)
            },
            ['minZ'] = 35.08,
            ['maxZ'] = 40.0,
            ['size'] = 2.75 -- size of the vehicles zones
        },
        ['Job'] = 'luxadmin', -- Name of job or none
        ['ShopLabel'] = 'Luxury Autos',
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 326, -- Blip sprite
        ['blipColor'] = 2, -- Blip color
        ['Categories'] = {
            ['dono'] = 'Exclusive vics'
        },
        ['TestDriveTimeLimit'] = 3.0,
        ['Location'] = vector3(-803.68, -223.82, 37.23),
        ['ReturnLocation'] = vector3(-760.31, -232.29, 37.28),
        ['VehicleSpawn'] = vector4(-763.21, -243.77, 37.25, 113),
        ['TestDriveSpawn'] = vector4(-763.21, -243.77, 37.25, 113), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-783.90, -223.94, 36.90, 135),
                defaultVehicle = 'BENTAYGAST',
                chosenVehicle = 'BENTAYGAST'
            },
            [2] = {
                coords = vector4(-793.14, -231.98, 36.66, 261),
                defaultVehicle = 'rmodporsche918',
                chosenVehicle = 'rmodporsche918'
            },
            [3] = {
                coords = vector4(-790.34, -238.15, 36.66, 258),
                defaultVehicle = 'demonboi',
                chosenVehicle = 'demonboi'
            },
            [4] = {
                coords = vector4(-786.91, -243.09, 36.66, 256),
                defaultVehicle = '2019gt3rs',
                chosenVehicle = '2019gt3rs'
            },
        }
    },
    ['pd'] = {
        ['Type'] = 'managed', -- meaning a real player has to sell the car
        ['Zone'] = {
            ['Shape'] = {
                vector2(460.54760742188, -974.79681396484),
                vector2(459.71984863281, -973.04022216797),
                vector2(426.64447021484, -973.04022216797),
                vector2(423.15026855469, -973.03015136719),
                vector2(423.15774536133, -1000.2844848633),
                vector2(460.0051574707, -1000.2844848633),
                vector2(463.69677734375, -999.49407958984),
                vector2(463.70202636719, -973.0361328125),
                vector2(462.19647216797, -973.03540039063),
                vector2(461.63397216797, -974.79211425781)
            },
            ['minZ'] = 24.6,
            ['maxZ'] = 26.7,
            ['size'] = 2.75 -- size of the vehicles zones
        },
        ['Job'] = 'police', -- Name of job or none
        ['ShopLabel'] = 'PD',
        ['showBlip'] = false, -- true or false
        ['blipSprite'] = 326, -- Blip sprite
        ['blipColor'] = 2, -- Blip color
        ['Categories'] = {
            ['pd'] = 'PD Vehicles'
        },
        ['TestDriveTimeLimit'] = 3.0,
        ['Location'] = vector3(444.91, -985.11, 25.70),
        ['ReturnLocation'] = vector3(445.51, -981.99, 25.12),
        ['VehicleSpawn'] = vector4(426.00, -981.62, 25.12, 270),
        ['TestDriveSpawn'] = vector4(426.00, -981.62, 25.12, 270), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(459.03, -992.07, 25.11, 1),
                defaultVehicle = 'code3cvpi',
                chosenVehicle = 'code3cvpi'
            },
        }
    },
    ['boats'] = {
        ['Type'] = 'free-use', -- no player interaction is required to purchase a vehicle
        ['Zone'] = {
            ['Shape'] = {--polygon that surrounds the shop
                vector2(-729.39, -1315.84),
                vector2(-766.81, -1360.11),
                vector2(-754.21, -1371.49),
                vector2(-716.94, -1326.88)
            },
            ['minZ'] = 0.0, -- min height of the shop zone
            ['maxZ'] = 5.0, -- max height of the shop zone
            ['size'] = 6.2 -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Marina Shop', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 410, -- Blip sprite
        ['blipColor'] = 3, -- Blip color
        ['Categories'] = {-- Categories available to browse
            ['boats'] = 'Boats'
        },
        ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-738.25, -1334.38, 1.6), -- Blip Location
        ['ReturnLocation'] = vector3(-714.34, -1343.31, 0.0), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-727.87, -1353.1, -0.17, 137.09), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(-722.23, -1351.98, 0.14, 135.33), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-727.05, -1326.59, 0.00, 229.5), -- where the vehicle will spawn on display
                defaultVehicle = 'seashark', -- Default display vehicle
                chosenVehicle = 'seashark' -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-732.84, -1333.5, -0.50, 229.5),
                defaultVehicle = 'dinghy',
                chosenVehicle = 'dinghy'
            },
            [3] = {
                coords = vector4(-737.84, -1340.83, -0.50, 229.5),
                defaultVehicle = 'speeder',
                chosenVehicle = 'speeder'
            },
            [4] = {
                coords = vector4(-741.53, -1349.7, -2.00, 229.5),
                defaultVehicle = 'marquis',
                chosenVehicle = 'marquis'
            },
        },
    },
    ['air'] = {
        ['Type'] = 'free-use', -- no player interaction is required to purchase a vehicle
        ['Zone'] = {
            ['Shape'] = {--polygon that surrounds the shop
                vector2(-1607.58, -3141.7),
                vector2(-1672.54, -3103.87),
                vector2(-1703.49, -3158.02),
                vector2(-1646.03, -3190.84)
            },
            ['minZ'] = 12.99, -- min height of the shop zone
            ['maxZ'] = 16.99, -- max height of the shop zone
            ['size'] = 7.0, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Air Shop', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 251, -- Blip sprite
        ['blipColor'] = 3, -- Blip color
        ['Categories'] = {-- Categories available to browse
            ['helicopters'] = 'Helicopters',
            ['planes'] = 'Planes'
        },
        ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-1652.76, -3143.4, 13.99), -- Blip Location
        ['ReturnLocation'] = vector3(-1628.44, -3104.7, 13.94), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-1617.49, -3086.17, 13.94, 329.2), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(-1625.19, -3103.47, 13.94, 330.28), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-1651.36, -3162.66, 12.99, 346.89), -- where the vehicle will spawn on display
                defaultVehicle = 'volatus', -- Default display vehicle
                chosenVehicle = 'volatus' -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-1668.53, -3152.56, 12.99, 303.22),
                defaultVehicle = 'luxor2',
                chosenVehicle = 'luxor2'
            },
            [3] = {
                coords = vector4(-1632.02, -3144.48, 12.99, 31.08),
                defaultVehicle = 'nimbus',
                chosenVehicle = 'nimbus'
            },
            [4] = {
                coords = vector4(-1663.74, -3126.32, 12.99, 275.03),
                defaultVehicle = 'frogger',
                chosenVehicle = 'frogger'
            },
        },
    },
}
