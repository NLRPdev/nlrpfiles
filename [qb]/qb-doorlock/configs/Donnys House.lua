

-- Back Door created by Donatello Gotti
Config.DoorList['Donnys House-Back Door'] = {
    doors = {
        {objName = 3821668, objYaw = 310.0, objCoords = vec3(-1479.825806, -41.407204, 57.090919)},
        {objName = 3821668, objYaw = 129.99998474121, objCoords = vec3(-1481.160156, -39.816914, 57.090919)}
    },
    doorLabel = 'Back Door',
    doorRate = 1.0,
    authorizedCitizenIDs = { ['OBB98517'] = true },
    distance = 2,
    doorType = 'double',
    locked = true,
}

-- Front Door created by Donatello Gotti
Config.DoorList['Donnys House-Front Door'] = {
    fixText = false,
    objYaw = 129.99996948242,
    objCoords = vec3(-1464.869385, -35.261990, 55.534500),
    locked = true,
    doorType = 'door',
    distance = 2,
    doorLabel = 'Front Door',
    authorizedCitizenIDs = { ['OBB98517'] = true },
    doorRate = 1.0,
    objName = -834363616,
}

-- Gate 1 created by Donatello Gotti
Config.DoorList['Donnys House-Gate 1'] = {
    doors = {
        {objName = -349730013, objYaw = 251.23202514648, objCoords = vec3(-1452.903320, -29.550320, 54.867191)},
        {objName = -1918480350, objYaw = 251.23202514648, objCoords = vec3(-1454.664185, -34.730736, 54.864338)}
    },
    doorLabel = 'Gate 1',
    doorRate = 1.0,
    authorizedCitizenIDs = { ['OBB98517'] = true },
    distance = 10,
    doorType = 'double',
    locked = true,
}

-- Gate 2 created by Donatello Gotti
Config.DoorList['Donnys House-Gate 2'] = {
    doors = {
        {objName = -1918480350, objYaw = 9.7088384628296, objCoords = vec3(-1469.959961, -13.796524, 54.893871)},
        {objName = -349730013, objYaw = 9.7088384628296, objCoords = vec3(-1475.353394, -14.718674, 54.896725)}
    },
    doorLabel = 'Gate 2',
    doorRate = 1.0,
    authorizedCitizenIDs = { ['OBB98517'] = true },
    distance = 10,
    doorType = 'double',
    locked = true,
}