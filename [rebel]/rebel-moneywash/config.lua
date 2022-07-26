Config = {}

Config.DiscordWebhooks = {
    Washing_Logs = "",
    Drying_Logs = ""
}

Config.Washable_Items = {
    -- The left string is the item name. The right string is the item value.
    ['markedbills'] = "worth", -- Example Item name is markedbills, the item value is called worth
--    ^Item Name^      ^Value Name^
}

Config.Wash_Time = 15 -- 15% Example: $1000 would take 150 seconds to wash

Config.Machines_QBTARGET = {
    ['Washing Machines'] = {
        { location = vector3(1135.95, -992.19, 46.11), heading = 98.57, width = 0.8, depth = 0.2, minZ=45.8, maxZ=46.6, distance = 4.7 },
        { location = vector3(1135.75, -990.85, 46.11), heading = 98.57, width = 0.8, depth = 0.2, minZ=45.8, maxZ=46.6, distance = 4.7 },
        { location = vector3(1135.60, -989.55, 46.11), heading = 98.57, width = 0.8, depth = 0.2, minZ=45.8, maxZ=46.6, distance = 4.7 },
        { location = vector3(1135.42, -988.24, 46.11), heading = 98.57, width = 0.8, depth = 0.2, minZ=45.8, maxZ=46.6, distance = 4.7 },
    },
    ['Dryers'] = {
        { location = vector3(1138.91, -991.87, 46.11), heading = 8.0, width = 0.73, depth = 0.73, minZ=45.2, maxZ=46.4, distance = 8.0 },
        { location = vector3(1138.80, -991.18, 46.11), heading = 8.0, width = 0.72, depth = 0.72, minZ=45.2, maxZ=46.4, distance = 8.0 },
        { location = vector3(1138.72, -990.47, 46.11), heading = 8.0, width = 0.72, depth = 0.72, minZ=45.2, maxZ=46.4, distance = 8.0 },
        { location = vector3(1138.62, -989.78, 46.11), heading = 8.0, width = 0.72, depth = 0.72, minZ=45.2, maxZ=46.4, distance = 8.0 },
        { location = vector3(1139.66, -991.77, 46.11), heading = 8.0, width = 0.72, depth = 0.72, minZ=45.2, maxZ=46.4, distance = 8.0 },
        { location = vector3(1139.56, -991.08, 46.11), heading = 8.0, width = 0.72, depth = 0.72, minZ=45.2, maxZ=46.4, distance = 8.0 },
        { location = vector3(1139.47, -990.34, 46.11), heading = 8.0, width = 0.72, depth = 0.72, minZ=45.2, maxZ=46.4, distance = 8.0 },
        { location = vector3(1139.4, -989.65, 46.11), heading = 8.0, width = 0.72, depth = 0.72, minZ=45.2, maxZ=46.4, distance = 8.0 },
    }
}

-- Money Destruction Rate
Config.MoneyDestructionRate = {
    [0] = { -- How many experience points are needed
        mdr = 50, -- How much percentage of the money that will be destroyed in the process
        level = 1, -- Self explanitory
        experience_knowledge = 2 -- How many experience points should you get per successful money laundering
    },
    [5] = {
        mdr = 45,
        level = 2,
        experience_knowledge = 2
    },
    [10] = {
        mdr = 40,
        level = 3,
        experience_knowledge = 2
    },
    [15] = {
        mdr = 38,
        level = 4,
        experience_knowledge = 2
    },
    [20] = {
        mdr = 36,
        level = 5,
        experience_knowledge = 2
    },
    [25] = {
        mdr = 34,
        level = 6,
        experience_knowledge = 2
    },
    [30] = {
        mdr = 32,
        level = 7,
        experience_knowledge = 2
    },
    [35] = {
        mdr = 30,
        level = 8,
        experience_knowledge = 1
    },
    [40] = {
        mdr = 28,
        level = 9,
        experience_knowledge = 1
    },
    [45] = {
        mdr = 26,
        level = 10,
        experience_knowledge = 1
    },
    [50] = {
        mdr = 24,
        level = 11,
        experience_knowledge = 1
    },
    [55] = {
        mdr = 22,
        level = 12,
        experience_knowledge = 1
    },
    [60] = {
        mdr = 20,
        level = 13,
        experience_knowledge = 1
    },
    [65] = {
        mdr = 18,
        level = 14,
        experience_knowledge = 1
    },
    [70] = {
        mdr = 16,
        level = 15,
        experience_knowledge = 1
    },
    [75] = {
        mdr = 14,
        level = 16,
        experience_knowledge = 1
    },
    [80] = {
        mdr = 12,
        level = 17,
        experience_knowledge = 1
    },
    [85] = {
        mdr = 10,
        level = 18,
        experience_knowledge = 1
    },
    [90] = {
        mdr = 8,
        level = 19,
        experience_knowledge = 1
    },
    [95] = {
        mdr = 6,
        level = 20,
        experience_knowledge = 1
    },
    [100] = {
        mdr = 5,
        level = 21,
        experience_knowledge = 1
    },
}