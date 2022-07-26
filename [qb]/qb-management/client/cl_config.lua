-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(461.54, -986.24, 31.71),
    },
    ['ambulance'] = {
        vector3(334.80, -594.36, 43.28),
    },
    ['realestate'] = {
        vector3(-716.11, 261.21, 84.14),
    },
    ['taxi'] = {
        vector3(907.24, -150.19, 74.17),
    },
    ['cardealer'] = {
        vector3(-27.47, -1107.13, 27.27),
    },
    ['mechanic'] = {
        vector3(-339.53, -156.44, 44.59),
    },
    ['rc'] = {
        vector3(836.41, -828.95, 26.33),
    },
    ['billiards'] = {
        vector3(-1577.10, -983.95, 13.11),
    },
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(461.54, -986.24, 31.71), length = 0.35, width = 0.45, heading = 351.0, minZ = 30.58, maxZ = 30.68 } ,
    },
    ['ambulance'] = {
        { coords = vector3(334.80, -594.36, 43.28), length = 1.2, width = 1.2, heading = 341.0, minZ = 42.28, maxZ = 44.28 },
    },
    ['realestate'] = {
        { coords = vector3(-716.11, 261.21, 84.14), length = 0.6, width = 1.0, heading = 25.0, minZ = 83.943, maxZ = 84.74 },
    },
    ['taxi'] = {
        { coords = vector3(907.24, -150.19, 74.17), length = 1.0, width = 3.4, heading = 327.0, minZ = 73.17, maxZ = 74.57 },
    },
    ['cardealer'] = {
        { coords = vector3(-27.47, -1107.13, 27.27), length = 2.4, width = 1.05, heading = 340.0, minZ = 27.07, maxZ = 27.67 },
    },
    ['mechanic'] = {
        { coords = vector3(-339.53, -156.44, 44.59), length = 1.15, width = 2.6, heading = 353.0, minZ = 43.59, maxZ = 44.99 },
    },
    ['rc'] = {
        { coords = vector3(836.41, -828.95, 26.33), length = 2.0, width = 2.0, heading = 353.0, minZ = 25.33, maxZ = 27.33 },
    },
    ['billiards'] = {
        { coords = vector3(-1577.10, -983.95, 13.11), length = 2.0, width = 2.0, heading = 53, minZ = 12.11, maxZ = 14.1 },
    },
}

Config.GangMenus = {
    ['lostmc'] = {
        vector3(0, 0, 0),
    },
    ['ballas'] = {
        vector3(0,0, 0),
    },
    ['vagos'] = {
        vector3(0, 0, 0),
    },
    ['cartel'] = {
        vector3(0, 0, 0),
    },
    ['families'] = {
        vector3(0, 0, 0),
    },
}

Config.GangMenuZones = {
    --[[
    ['gangname'] = {
        { coords = vector3(0.0, 0.0, 0.0), length = 0.0, width = 0.0, heading = 0.0, minZ = 0.0, maxZ = 0.0 },
    },
    ]]
}
