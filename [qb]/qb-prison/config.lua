Config = {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.Jobs = {
    ["electrician"] = "Electrician"
}

Config.Locations = {
    jobs = {
        ["electrician"] = {
            [1] = {
                coords = vector4(1761.46, 2540.41, 45.56, 272.249),
            },
            [2] = {
                coords = vector4(1718.54, 2527.802, 45.56, 272.249),
            },
            [3] = {
                coords = vector4(1700.199, 2474.811, 45.56, 272.249),
            },
            [4] = {
                coords = vector4(1664.827, 2501.58, 45.56, 272.249),
            },
            [5] = {
                coords = vector4(1621.622, 2509.302, 45.56, 272.249),
            },
            [6] = {
                coords = vector4(1627.936, 2538.393, 45.56, 272.249),
            },
            [7] = {
                coords = vector4(1625.1, 2575.988, 45.56, 272.249),
            }
        }
    },
    ["freedom"] = {
        coords = vector4(1790.67, 2546.56, 44.67, 40)
    },
    ["outside"] = {
        coords = vector4(1848.13, 2586.05, 44.67, 269.5)
    },
    ["yard"] = {
        coords = vector4(1765.67, 2565.91, 44.56, 1.5)
    },
    ["middle"] = {
        coords = vector4(1693.33, 2569.51, 44.55, 123.5)
    },
    ["shop"] = {
        coords = vector4(1780.46, 2560.76, 44.67, 183)
    },
    spawns = {
        [1] = {
            animation = "lean",
            coords = vector4(1766.56, 2502.40, 45.74, 208)
        },
        [2] = {
            animation = "lean",
            coords = vector4(1763.49, 2500.68, 45.74, 205)
        },
        [3] = {
            animation = "lean",
            coords = vector4(1760.30, 2498.77, 45.74, 214)
        },
        [4] = {
            animation = "lean",
            coords = vector4(1753.88, 2495.13, 45.74, 208)
        },
        [5] = {
            animation = "lean",
            coords = vector4(1750.79, 2493.35, 45.74, 211)
        },
        [6] = {
            animation = "sitchair",
            coords = vector4(1763.24, 2487.72, 45.24, 29)
        }
    }
}

Config.CanteenItems = {
    [1] = {
        name = "sandwich",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 1
    },
    [2] = {
        name = "water_bottle",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 2
    }
}
