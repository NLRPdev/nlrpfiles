Config = {}

Config.InteractDistance         = 6.0   -- Distance to check if near a truck on foot
Config.CloseVehiclesDistance    = 20.0  -- Distance to check for nearby vehicles
Config.WinchSpeed               = 0.6   -- Winch Speed. HIGHLY suggest adjusting in 0.1 increments
Config.GetInDistance            = 2.5
Config.MaxWinchLength           = 20.0
Config.MinWindDistance          = 2.4
Config.MaxUnwindDistance        = 10.0
Config.Doublecheck              = true  -- Double locks the vehicle onto the bed to try and ensure its touching the bed

Config.DisableCabControl        = true  -- Disables Left Stick Control and Ctrl + Shift while driving.
Config.DisableSpeed             = 3.0   -- Speed at which the controls get disabled

--NOTIFICATIONS--
Config.Notifications            = true

--TRANSLATIONS More customization in utils.lua including key controls
Config.NotiUnLoadCompleteMessage    = "Unload Complete"
Config.NotiLoadCompleteMessage      = "Loading Complete"
Config.NotiBlockedMessage           = "Unloading zone blocked"
Config.NotiFBBlockedMessage         = "Flatbed blocked or occupied"

Config.Trucks = {
    [GetHashKey('ct660tow')] = {
        boneName = 'misc_a',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, 0.4, -0.1),
        carHeightOffset = 0.375,    -- Height to adjust attached car by
        winchBone = 'misc_b',
        winchDistCheck = 5.0,       -- How far from winchOffset to check for a vehicle
        winchOffset = 5.0           --How far backwards from the winch bone to check from
    },
    [GetHashKey('bc205500w')] = {
        type = 'rolling',
        boneName = 'misc_a',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, 0.8, 0.0),
        carHeightOffset = 0.2,
        winchBone = 'misc_b',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from

    },
    [GetHashKey('ramtow')] = {
        type = 'rolling',
        boneName = 'misc_f',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.5, 0.0),
        carHeightOffset = 0.1,
        winchBone = 'misc_w',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from

    },
    [GetHashKey('c3rollback')] = {
        type = 'rolling',
        boneName = 'misc_b',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, 0.5, 0.2),
        carHeightOffset = -0.05,
        winchBone = 'misc_a',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from

    },
    [GetHashKey('c3pwrollback')] = { 
        type = 'rolling',
        boneName = 'misc_b',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, 0.5, 0.2),
        carHeightOffset = -0.05,
        winchBone = 'misc_a',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from

    },
    [GetHashKey('c3f350rollback')] = {
        type = 'rolling',
        boneName = 'misc_b',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, 0.5, 0.2),
        carHeightOffset = -0.05,
        winchBone = 'misc_a',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from

    },

    [GetHashKey('c3navistar')] = {
        boneName = 'misc_b',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-5.5,-0.55),vector3(1.8,-5.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, 0.4, -0.4),
        carHeightOffset = 0.0,
        winchBone = 'misc_a',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 5.0 --How far backwards from the winch bone to check from
    },

    [GetHashKey('c3silvrollback')] = {
        type = 'rolling',
        boneName = 'misc_b',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, 0.5, -0.0),
        carHeightOffset = -0.05,
        winchBone = 'misc_a',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from

    },

    [GetHashKey('f550rb')] = {
        staticBed = false,
        boneName = 'misc_z',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.75,-0.55),vector3(1.8,-4.75,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.0, 0.0),
        carHeightOffset = 0.2,
        winchBone = 'attach_male',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from

    },

    [GetHashKey('f550rbc')] = {
        staticBed = false,
        boneName = 'misc_z',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.75,-0.55),vector3(1.8,-4.75,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.0, 0.0),
        carHeightOffset = -0.2,
        winchBone = 'attach_male',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from
    },

    [GetHashKey('20ramrbc')] = {
        staticBed = false,
        boneName = 'misc_z',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.75,-0.55),vector3(1.8,-4.75,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.0, 0.0),
        carHeightOffset = 0,
        winchBone = 'attach_male',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from

    },

    [GetHashKey('flatbedm2')] = {
        type = 'rolling',
        boneName = 'misc_a',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,2.0,-0.55)},
        carPosition = vector3(0.0, 1.2, -0.1),
        carHeightOffset = -0.15,
        winchBone = 'misc_b',
        winchDistCheck = 10.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 5.0 --How far backwards from the winch bone to check from
    },

    [GetHashKey('lgc19flatbed')] = {
        type = 'rolling',
        boneName = 'misc_a',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,2.0,-0.55)},
        carPosition = vector3(0.0, 1.2, -0.1),
        carHeightOffset = 0.4,
        winchBone = 'misc_b',
        winchDistCheck = 10.0,
        winchOffset = 3.0
    },

    [GetHashKey('112towmfd4')] = {
        type = 'rolling',
        boneName = 'misc_z',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-7.5,-0.55),vector3(1.8,-7.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.2, 0.2),
        carHeightOffset = 0.0,
        winchBone = 'attach_male',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from
    },

    [GetHashKey('108towmfd4')] = {
        type = 'rolling',
        boneName = 'misc_z',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-7.5,-0.55),vector3(1.8,-7.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.2, 0.0),
        carHeightOffset = 0.0,
        winchBone = 'attach_male',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from
    }, 

    [GetHashKey('440towmfd4')] = {
        type = 'rolling',
        boneName = 'misc_z',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-7.5,-0.55),vector3(1.8,-7.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.2, 0.0),
        carHeightOffset = 0.0,
        winchBone = 'attach_male',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from
    },

    [GetHashKey('cortowmfd4')] = {
        type = 'rolling',
        boneName = 'misc_z',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-7.5,-0.55),vector3(1.8,-7.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.2, 0.0),
        carHeightOffset = 0.0,
        winchBone = 'attach_male',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from
    },

    [GetHashKey('112towmfd3')] = {
        type = 'rolling',
        boneName = 'misc_z',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-7.0,-0.55),vector3(1.8,-7.0,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.1, 0.0),
        carHeightOffset = 0.0,
        winchBone = 'attach_male',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from

    },

    [GetHashKey('112towmfd2')] = {
        type = 'rolling',
        boneName = 'misc_z',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-5.0,-0.55),vector3(1.8,-5.0,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.1, 0.0),
        carHeightOffset = 0.0,
        winchBone = 'attach_male',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from

    },

    [GetHashKey('800towmfd4')] = {
        type = 'rolling',
        boneName = 'misc_z',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-2.5,-0.55),vector3(1.8,-7.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, -0.2, 0.0),
        carHeightOffset = 0.0,
        winchBone = 'attach_male',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 3.0 --How far backwards from the winch bone to check from
    },

    [GetHashKey('towy')] = {
        boneName = 'misc_b',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-5.5,-0.55),vector3(1.8,-5.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, 0.4, -0.1),
        carHeightOffset = -0.1,
        winchBone = 'misc_a',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 5.0 --How far backwards from the winch bone to check from
    },

    --STATIC BEDS
    [GetHashKey('flatbed')] = {
        type = 'static',
        carloadPos = vector3(0.0, -10.0, -0.55),
        loadPos = {vector3(-2.0, -5.0, -0.55)},
        unloadPos = {vector3(-2.0, 0.0, -0.55)},
        carPosition = vector3(0.0, -2.3, 0.4),
        bikePositions = {vector3(0.0, -2.3, 0.8)},
        carHeightOffset = -0.7,
    },

    --PICKUP TRUCK EXAMPLE
    [GetHashKey('sadler')] = {
        type = 'static',
        carloadPos = vector3(0.0, -5.5, -0.55),
        loadPos = {vector3(-1.5, -3.0, -0.55)},
        unloadPos = {vector3(-1.0, 0.0, -0.55)},
        carPosition = vector3(0.0, -2.2, 0.8),
        bikePositions = {vector3(0.0, -2.3, 0.8)},
        carHeightOffset = -0.6,
    },
}

