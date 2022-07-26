

-- MRPD created by JJG GAMING
Config.DoorList['MRPD-MRPD'] = {
    distance = 3,
    fixText = false,
    objYaw = 0.0,
    doorType = 'door',
    objName = -1406685646,
    objCoords = vec3(440.520081, -977.601074, 30.823193),
    locked = true,
    doorRate = 1.0,
    doorLabel = 'Front left door',
    authorizedJobs = { ['police'] = 0 },
}

-- MRPD Rightdoor created by JJG GAMING
Config.DoorList['MRPD-MRPD Rightdoor'] = {
    distance = 2,
    fixText = false,
    objYaw = 180.00001525879,
    doorType = 'door',
    objName = -96679321,
    objCoords = vec3(440.520081, -986.233459, 30.823193),
    locked = true,
    doorRate = 1.0,
    doorLabel = 'Front right door',
    authorizedJobs = { ['police'] = 0 },
}

-- MRPD right side doors created by JJG GAMING
Config.DoorList['MRPD-MRPD right side doors'] = {
    doors = {
        {objName = -1547307588, objYaw = 180.00001525879, objCoords = vec3(443.061768, -998.746216, 30.815304)},
        {objName = -1547307588, objYaw = 0.0, objCoords = vec3(440.739197, -998.746216, 30.815304)}
    },
    doorLabel = 'right side doors',
    distance = 2,
    doorType = 'double',
    doorRate = 1.0,
    locked = true,
    authorizedJobs = { ['police'] = 0 },
}

-- MRPD left side doors created by JJG GAMING
Config.DoorList['MRPD-MRPD left side doors'] = {
    authorizedJobs = { ['police'] = 0 },
    doorRate = 1.0,
    doorType = 'double',
    locked = true,
    distance = 2,
    doorLabel = 'Left side doors ',
    doors = {
        {objName = -1547307588, objYaw = 0.0, objCoords = vec3(455.886169, -972.254272, 30.815308)},
        {objName = -1547307588, objYaw = 180.00001525879, objCoords = vec3(458.208740, -972.254272, 30.815308)}
    },
}

-- MRPD armory 1 created by JJG GAMING
Config.DoorList['MRPD-MRPD armory 1'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 89.999977111816,
    objCoords = vec3(479.750732, -999.629028, 30.789167),
    locked = true,
    doorType = 'door',
    doorLabel = 'armory1',
    distance = 2,
    doorRate = 1.0,
    objName = -692649124,
}

-- MRPD armory 2 created by JJG GAMING
Config.DoorList['MRPD-MRPD armory 2'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 181.28001403809,
    objCoords = vec3(487.437836, -1000.189270, 30.786972),
    locked = true,
    doorType = 'door',
    doorLabel = 'armory2',
    distance = 2,
    doorRate = 1.0,
    objName = -692649124,
}

-- MRPD backdoor created by JJG GAMING
Config.DoorList['MRPD-MRPD backdoor'] = {
    doors = {
        {objName = -692649124, objYaw = 180.00001525879, objCoords = vec3(469.774261, -1014.406006, 26.483816)},
        {objName = -692649124, objYaw = 0.0, objCoords = vec3(467.368622, -1014.406006, 26.483816)}
    },
    authorizedJobs = { ['police'] = 0 },
    doorRate = 1.0,
    doorLabel = 'backdoor',
    distance = 2,
    doorType = 'double',
    locked = true,
}

-- MRPD backgate created by JJG GAMING
Config.DoorList['MRPD-MRPD backgate'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 90.0,
    objCoords = vec3(488.894806, -1017.211975, 27.149349),
    locked = true,
    doorType = 'sliding',
    doorLabel = 'backgate',
    distance = 5,
    doorRate = 1.0,
    objName = -1603817716,
}

-- MRPD holding cell doors created by JJG GAMING
Config.DoorList['MRPD-MRPD holding cell doors'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 270.13998413086,
    objCoords = vec3(476.615692, -1008.875427, 26.480055),
    locked = true,
    doorType = 'door',
    doorLabel = 'cells main gate 1',
    distance = 2,
    doorRate = 1.0,
    objName = -53345114,
}

-- MRPD Holding cells gate 2 created by JJG GAMING
Config.DoorList['MRPD-MRPD Holding cells gate 2'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 180.00001525879,
    objCoords = vec3(481.008362, -1004.117981, 26.480055),
    locked = true,
    doorType = 'door',
    doorLabel = 'Holding cells gate 2',
    distance = 2,
    doorRate = 1.0,
    objName = -53345114,
}

-- MRPD Dugeon created by Donatello Gotti
Config.DoorList['MRPD-MRPD Dugeon'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 180.00001525879,
    objCoords = vec3(484.176422, -1007.734375, 26.480055),
    locked = true,
    doorType = 'door',
    doorLabel = 'Cell 5',
    distance = 2,
    doorRate = 1.0,
    objName = -53345114,
}

-- MRPD Interrogationroom area created by JJG GAMING
Config.DoorList['MRPD-MRPD Interrogationroom area'] = {
    doors = {
        {objName = 149284793, objYaw = 89.999977111816, objCoords = vec3(479.062408, -987.437561, 26.405483)},
        {objName = 149284793, objYaw = 270.00003051758, objCoords = vec3(479.062408, -985.032349, 26.405483)}
    },
    authorizedJobs = { ['police'] = 0 },
    doorRate = 1.0,
    doorLabel = 'Interrogationroom area',
    distance = 2,
    doorType = 'double',
    locked = true,
}

-- MRPD Dugeon 4 created by Donatello Gotti
Config.DoorList['MRPD-MRPD Dugeon 4'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 0.0,
    objCoords = vec3(486.913116, -1012.188660, 26.480055),
    locked = true,
    doorType = 'door',
    doorLabel = 'Cell 4',
    distance = 2,
    doorRate = 1.0,
    objName = -53345114,
}

-- MRPD Dugeon 3 created by Donatello Gotti
Config.DoorList['MRPD-MRPD Dugeon 3'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 0.0,
    objCoords = vec3(483.912720, -1012.188660, 26.480055),
    locked = true,
    doorType = 'door',
    doorLabel = 'Cell 3',
    distance = 2,
    doorRate = 1.0,
    objName = -53345114,
}

-- MRPD Interrogationroom 1 created by JJG GAMING
Config.DoorList['MRPD-MRPD Interrogationroom 1'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 270.00003051758,
    objCoords = vec3(482.670135, -987.579163, 26.405483),
    locked = true,
    doorType = 'door',
    doorLabel = 'Interrogationroom area',
    distance = 2,
    doorRate = 1.0,
    objName = -1406685646,
}

-- MRPD Dugeon 2 created by Donatello Gotti
Config.DoorList['MRPD-MRPD Dugeon 2'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 0.0,
    objCoords = vec3(480.912811, -1012.188660, 26.480055),
    locked = true,
    doorType = 'door',
    doorLabel = 'Cell 2',
    distance = 2,
    doorRate = 1.0,
    objName = -53345114,
}

-- MRPD Interrogationroom 2 created by JJG GAMING
Config.DoorList['MRPD-MRPD Interrogationroom 2'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 270.00003051758,
    objCoords = vec3(482.670258, -995.728516, 26.405483),
    locked = true,
    doorType = 'door',
    doorLabel = 'Interrogationroom 2',
    distance = 2,
    doorRate = 1.0,
    objName = -1406685646,
}

-- MRPD Dugeon 1 created by Donatello Gotti
Config.DoorList['MRPD-MRPD Dugeon 1'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 0.0,
    objCoords = vec3(477.912598, -1012.188660, 26.480055),
    locked = true,
    doorType = 'door',
    doorLabel = 'Cell 1',
    distance = 2,
    doorRate = 1.0,
    objName = -53345114,
}

-- MRPD Evidenceroom created by JJG GAMING
Config.DoorList['MRPD-MRPD Evidenceroom'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 134.97177124023,
    objCoords = vec3(475.832336, -990.483948, 26.405483),
    locked = true,
    doorType = 'door',
    doorLabel = 'Evidence room ',
    distance = 2,
    doorRate = 1.0,
    objName = -692649124,
}

-- MRPD interior parking  created by JJG GAMING
Config.DoorList['MRPD-MRPD interior parking '] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 89.870010375977,
    objCoords = vec3(464.156555, -997.509277, 26.370705),
    locked = true,
    doorType = 'door',
    doorLabel = 'parking door 1',
    distance = 2,
    doorRate = 1.0,
    objName = 1830360419,
}

-- MRPD interior parking  2 created by JJG GAMING
Config.DoorList['MRPD-MRPD interior parking  2'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 269.79000854492,
    objCoords = vec3(464.159058, -974.665588, 26.370705),
    locked = true,
    doorType = 'door',
    doorLabel = 'parking door 2',
    distance = 2,
    doorRate = 1.0,
    objName = 1830360419,
}

-- MRPD garage door 2 created by Donatello Gotti
Config.DoorList['MRPD-MRPD garage door 2'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 0.0,
    objCoords = vec3(452.300507, -1000.771667, 26.696609),
    locked = true,
    doorType = 'garage',
    doorLabel = 'Garage Door 2',
    distance = 5,
    doorRate = 1.0,
    objName = 2130672747,
}

-- MRPD garage door 1 created by Donatello Gotti
Config.DoorList['MRPD-MRPD garage door 1'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 0.0,
    objCoords = vec3(431.411926, -1000.771667, 26.696609),
    locked = true,
    doorType = 'garage',
    doorLabel = 'Garage Door 1',
    distance = 5,
    doorRate = 1.0,
    objName = 2130672747,
}

-- MRPD Rooftop created by JJG GAMING
Config.DoorList['MRPD-MRPD Rooftop'] = {
    fixText = false,
    authorizedJobs = { ['police'] = 0 },
    objYaw = 89.999977111816,
    objCoords = vec3(464.308563, -984.528442, 43.771240),
    locked = true,
    doorType = 'door',
    doorLabel = 'Rooftop door',
    distance = 2,
    doorRate = 1.0,
    objName = -692649124,
}