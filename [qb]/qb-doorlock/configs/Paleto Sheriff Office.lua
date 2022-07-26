

-- sheriff front door created by Donatello Gotti
Config.DoorList['Paleto Sheriff Office-sheriff front door'] = {
    doors = {
        {objName = 965382714, objYaw = 314.99981689453, objCoords = vec3(-438.586548, 6014.361816, 32.288513)},
        {objName = 733214349, objYaw = 134.99996948242, objCoords = vec3(-437.171692, 6012.947266, 32.288513)}
    },
    authorizedJobs = { ['police'] = 0 },
    doorType = 'double',
    doorRate = 1.0,
    doorLabel = 'sheriff front door',
    distance = 2,
    locked = true,
}

-- sheriff back door created by Donatello Gotti
Config.DoorList['Paleto Sheriff Office-sheriff back door'] = {
    doors = {
        {objName = 965382714, objYaw = 134.99992370605, objCoords = vec3(-453.486755, 5996.637207, 32.288513)},
        {objName = 733214349, objYaw = 314.99981689453, objCoords = vec3(-454.901672, 5998.051758, 32.288513)}
    },
    authorizedJobs = { ['police'] = 0 },
    doorType = 'double',
    doorRate = 1.0,
    doorLabel = 'sheriff back door',
    distance = 2,
    locked = true,
}