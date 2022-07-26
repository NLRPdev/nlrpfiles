Config = Config or {}

Config.QBCoreNewversion = true

if Config.QBCoreNewversion then
    Config.CoreName = "QBCore"
    Config.Core = exports['qb-core']:GetCoreObject()
    Config.CoreNotify = "QBCore:Notify"
else
    Config.CoreName = "QBCore:GetObject"
    Config.Core = nil
    TriggerEvent(Config.CoreName, function(obj) Config.Core = obj end)
    Config.CoreNotify = "QBCore:Notify"
end


Config.Carkeys = true
Config.MinRentTime = 15 -- mins

Config.DmgPercentPay = 100 -- 100 * % body dmg + % engine dmg 

Config.AppName = "MOOV"
Config.RentSuccess = "It was rented in exchange for"
Config.RentAgain = " In return " .. Config.MinRentTime .. "'min extended"
Config.ReturnCar = "The rental was canceled. Thank you for Choosing us."
Config.NoCars = "No cars for rent at close range"
Config.VehicleNear = "You are not near the vehicle"
Config.VehiclePhoto = "Take a picture of the car"
Config.VehicleCarkey = "You have received the car key"
Config.RentaCarCoordReturn = "There is no delivery point in the vicinity."
Config.RentACarNotPlate = "It does not match the license plate of the vehicle you rented."
Config.RentaCarCoords = "Choose delivery point"

Config.AvaibleCars = {
    ["low"] = {
        [1] = { 
            ["model"] = "asea", 
            ["price"] = 50,
            ["stock"] = 1
        },
        [2] = { 
            ["model"] = "brioso", 
            ["price"] = 900,
            ["stock"] = 10
        },
        [3] = { 
            ["model"] = "sandking", 
            ["price"] = 900,
            ["stock"] = 10
        },
    },
    ["medium"] = {
        [1] = { 
            ["model"] = "sultan", 
            ["price"] = 1,
            ["stock"] = 10
        },
        [2] = { 
            ["model"] = "sultan2", 
            ["price"] = 30,
            ["stock"] = 4
        },
    },
    ["high"] = {
        [1] = { 
            ["model"] = "jugular", 
            ["price"] = 10,
            ["stock"] = 3
        },
        [2] = { 
            ["model"] = "t20", 
            ["price"] = 70,
            ["stock"] = 4
        },
        [3] = { 
            ["model"] = "adder", 
            ["price"] = 100,
            ["stock"] = 6
        }
    },    
}

Config.RentalZones = {
    ["Job Center"] = {
        ["blip"] = vector3(-287.64, -907.55, 31.08),
        ["coords"] = {
            vector4(-278.92, -904.65, 30.67, 68.71),
            vector4(-280.37, -907.91, 30.67, 68.73),
            vector4(-281.49, -911.07, 30.67, 69.95),
            vector4(-282.06, -914.77, 30.67, 68.82),
            vector4(-283.83, -918.36, 30.67, 70.11),
            vector4(-285.49, -921.45, 30.67, 67.61),
        },
    },
    ["Bus Station"] = {
        ["blip"] = vector3(408.61, -638.65, 28.09),
        ["coords"] = {
            vector4(408.61, -638.65, 28.09, 268.0),
            vector4(416.08, -638.69, 28.09, 269.42),
            vector4(416.58, -641.34, 28.09, 269.0),
            vector4(409.0, -641.36, 28.09, 268.82),
            vector4(408.67, -644.1, 28.09, 268.25),
            vector4(415.55, -644.11, 28.09, 269.61),
        },
    },
    ["Airport"] = {
        ["blip"] = vector3(-989.28, -2706.4, 13.42),
        ["coords"] = {
            vector4(-989.28, -2706.4, 13.42, 150.88),
            vector4(-985.97, -2707.75, 13.42, 155.48),
            vector4(-983.18, -2709.3, 13.42, 162.51),
            vector4(-979.99, -2710.01, 13.43, 166.53),
            vector4(-976.86, -2710.33, 13.44, 171.65),
            vector4(-973.31, -2711.07, 13.44, 176.96),
        },
    },
    ["Life Invader"] = {
        ["blip"] = vector3(-942.32, -180.32, 41.46),
        ["coords"] = {
            vector4(-942.29, -180.39, 41.46, 203.68),
            vector4(-938.87, -178.78, 41.46, 206.45),
            vector4(-935.36, -176.57, 41.46, 205.5),
            vector4(-931.79, -174.28, 41.46, 207.42),
            vector4(-928.12, -173.34, 41.46, 206.26),
        },
    },
    ["Del Perro"] = {
        ["blip"] = vector3(-1590.64, -895.36, 9.17),
        ["coords"] = {
            vector4(-1590.64, -895.36, 9.17, 319.08),
            vector4(-1588.84, -897.61, 9.2, 319.18),
            vector4(-1585.97, -899.56, 9.22, 319.61),
            vector4(-1584.34, -901.89, 9.2, 319.34),
            vector4(-1581.82, -903.69, 9.21, 318.17),
        },
    },
    ["Richman"] = {
        ["blip"] = vector3(-1687.03, 31.91, 63.94),
        ["coords"] = {
            vector4(-1687.03, 31.91, 63.94, 291.76),
            vector4(-1689.11, 34.84, 64.05, 289.84),
            vector4(-1691.55, 37.37, 64.21, 290.49),
            vector4(-1693.83, 39.9, 64.38, 289.71),
            vector4(-1696.39, 42.47, 64.59, 289.72),
            vector4(-1698.89, 44.86, 64.79, 289.68),
        },
    },
    ["Motel"] = {
        ["blip"] = vector3(296.03, -343.38, 44.51),
        ["coords"] = {
            vector4(296.03, -343.38, 44.51, 69.52),
            vector4(294.06, -346.5, 44.51, 67.56),
            vector4(296.72, -339.81, 44.51, 69.62),
            vector4(297.46, -336.69, 44.51, 69.54),
            vector4(299.14, -333.81, 44.51, 70.6),
            vector4(299.85, -330.4, 44.51, 68.57),
            vector4(289.95, -326.52, 44.51, 68.58),
            vector4(288.13, -329.07, 44.51, 69.39),
            vector4(287.04, -332.55, 44.51, 70.09),
            vector4(285.9, -335.76, 44.51, 69.12),
            vector4(284.35, -338.6, 44.51, 69.58),
            vector4(283.72, -342.34, 44.51, 69.88),
        },
    },
    ["Chumash"] = {
        ["blip"] = vector3(-3249.61, 987.42, 11.92),
        ["coords"] = {
            vector4(-3249.61, 987.42, 11.92, 181.88),
            vector4(-3245.74, 987.67, 11.93, 182.57),
            vector4(-3242.09, 987.87, 11.92, 1.26),
            vector4(-3249.51, 987.86, 11.93, 182.09),
            vector4(-3253.14, 987.45, 11.9, 179.53),
        },
    },
    ["Paleto Bay"] = {
        ["blip"] = vector3(-396.83, 6059.29, 30.94),
        ["coords"] = {
            vector4(-396.83, 6059.29, 30.94, 17.62),
            vector4(-394.13, 6062.67, 30.94, 18.83),
            vector4(-390.83, 6066.1, 30.94, 17.94),
            vector4(-379.48, 6068.84, 30.94, 136.27),
            vector4(-383.78, 6072.3, 30.94, 126.97),
            vector4(-385.65, 6058.21, 30.94, 135.9),
        },
    },
    ["Sandy Shores"] = {
        ["blip"] = vector3(1369.31, 3603.48, 34.34),
        ["coords"] = {
            vector4(1369.31, 3603.48, 34.34, 17.62),
            vector4(1365.99, 3603.17, 34.29, 18.65),
            vector4(1372.17, 3604.49, 34.33, 17.91),
            vector4(1375.32, 3606.09, 34.31, 13.1),
            vector4(1379.31, 3607.16, 34.31, 16.93),

        },
    },
    ["Docs"] = {
        ["blip"] = vector3(781.61, -2961.83, 5.24),
        ["coords"] = {
            vector4(781.61, -2961.83, 5.24, 245.46),
            vector4(782.07, -2965.63, 5.24, 249.27),
            vector4(782.46, -2969.09, 5.24, 250.17),
            vector4(782.3, -2973.29, 5.24, 247.2),
            vector4(782.12, -2977.36, 5.24, 241.85),
            vector4(782.21, -2981.23, 5.24, 244.59),
            vector4(782.23, -2984.92, 5.24, 244.64),
        },
    },
}

Config.ReturnZones = {
    vector4(-285.23, -886.99, 30.52, 344.19), -- Job center
    vector4(416.79, -654.81, 28.5, 85.2), -- Bus station
    vector4(-973.18, -2692.69, 13.42, 147.06), --- Airport
    vector4(-960.48, -175.63, 41.47, 292.44), -- Life invader
    vector4(-1579.53, -889.85, 9.56, 49.05), -- Del Perro
    vector4(-1677.32, 42.3, 63.05, 160.88), -- Richman
    vector4(287.45, -347.81, 44.54, 158.12), -- Motel
    vector4(-3244.82, 992.22, 11.91, 268.48), -- Chumash
    vector4(-395.61, 6052.51, 30.94, 132.62), -- Paleto Bay
    vector4(1375.73, 3593.13, 34.31, 108.4), -- Sandy Shores
    vector4(769.44, -2966.85, 5.24, 359.66), -- Docs
}