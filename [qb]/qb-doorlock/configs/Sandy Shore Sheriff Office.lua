

-- sandy sheriff back door  created by Donatello Gotti
Config.DoorList['Sandy Shore Sheriff Office-sandy sheriff back door '] = {
    locked = true,
    authorizedJobs = { ['police'] = 0 },
    doorRate = 1.0,
    objYaw = 29.999982833862,
    doorType = 'door',
    objName = -1501157055,
    fixText = false,
    doorLabel = 'sandy sheriff back door',
    objCoords = vec3(1823.863281, 3681.116943, 34.339008),
    distance = 2,
}

-- sandy sheriff gate created by Donatello Gotti
Config.DoorList['Sandy Shore Sheriff Office-sandy sheriff gate'] = {
    locked = true,
    authorizedJobs = { ['police'] = 0 },
    doorRate = 1.0,
    objYaw = 30.000001907349,
    doorType = 'door',
    objName = -1156020871,
    fixText = false,
    doorLabel = 'sandy sheriff gate',
    objCoords = vec3(1845.406982, 3677.485107, 34.611950),
    distance = 2,
}

-- sandy sheriff sliding gate created by Donatello Gotti
Config.DoorList['Sandy Shore Sheriff Office-sandy sheriff sliding gate'] = {
    locked = true,
    authorizedJobs = { ['police'] = 0 },
    doorRate = 1.0,
    objYaw = 30.000005722046,
    doorType = 'sliding',
    objName = 1286535678,
    fixText = false,
    doorLabel = 'sandy sheriff sliding gate',
    objCoords = vec3(1862.001953, 3687.521973, 33.015141),
    distance = 2,
}

-- sandy sheriff front door created by Donatello Gotti
Config.DoorList['Sandy Shore Sheriff Office-sandy sheriff front door'] = {
    locked = true,
    doorType = 'double',
    doors = {
        {objName = -1501157055, objYaw = 210.0, objCoords = vec3(1835.126709, 3673.418457, 34.339008)},
        {objName = -1501157055, objYaw = 29.999982833862, objCoords = vec3(1837.378174, 3674.718262, 34.339008)}
    },
    authorizedJobs = { ['police'] = 0 },
    doorLabel = 'sandy sheriff front door',
    doorRate = 1.0,
    distance = 2,
}