u = {
  Thread = function(r)
    Citizen.CreateThread(r)
  end,

  IsPlayerReady = function()
    if Config.UsingESX then 
      while not ESX.IsPlayerLoaded() do Wait(500); end
      return true
    elseif Config.UsingQBCore then 
      while not QBCore.Functions.GetPlayerData().job do Wait(500); end
      return true
    end
  end,

  RNE = function(name,route)
    RegisterNetEvent(name,route)
  end,

  SHN = function(msg)
    AddTextEntry(GetCurrentResourceName(), msg)

    if thisFrame then
      DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
    else
      if beep == nil then beep = true end
      BeginTextCommandDisplayHelp(GetCurrentResourceName())
      EndTextCommandDisplayHelp(0, false, false, duration or -1)
    end
  end,

  NOTIFY = function(msg)
    if Config.UsingESX then 
      ESX.ShowNotification(msg)
    elseif Config.UsingQBCore then 
      QBCore.Functions.Notify(msg)
    end
  end,

  HasModelLoaded = function(m)
    while not HasModelLoaded(m) do RequestModel(m) Wait(0); end
    return true
  end,

  GetCloseObject = function(model, pos, rad, mis)
    local obj = false
    local dis = false
    local obj = GetClosestObjectOfType(pos.x,pos.y,pos.z,rad,GetHashKey(model), mis)
    if obj then 
      local obj_pos = GetEntityCoords(obj)
      dis = #(pos - obj_pos)
    end
    return obj, dis
  end,

  ScreenToWorld = function(iter)
    local entityType,entitySubType
    local camRot = GetGameplayCamRot(0)
    local camPos = GetGameplayCamCoord()
    local posX = 0.5
    local posY = 0.5
    local cursor = vector2(posX, posY)
    local cam3DPos, forwardDir = u.ScreenRelToWorld(camPos, camRot, cursor)
    local direction = camPos + forwardDir * 50.0
    local rayHandle = StartShapeTestRay(cam3DPos.x,cam3DPos.y,cam3DPos.z, direction.x,direction.y,direction.z, (iter and -1 or 30), 0, 0)
    local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    if entityHit <= 0 and not iter then
      return u.ScreenToWorld(true)
    end
    return hit, endCoords, entityHit
  end,
   
  ScreenRelToWorld = function(camPos, camRot, cursor)
    local camForward = u.RotationToDirection(camRot)
    local rotUp = vector3(camRot.x + 1.0, camRot.y, camRot.z)
    local rotDown = vector3(camRot.x - 1.0, camRot.y, camRot.z)
    local rotLeft = vector3(camRot.x, camRot.y, camRot.z - 1.0)
    local rotRight = vector3(camRot.x, camRot.y, camRot.z + 1.0)
    local camRight = u.RotationToDirection(rotRight) - u.RotationToDirection(rotLeft)
    local camUp = u.RotationToDirection(rotUp) - u.RotationToDirection(rotDown)
    local rollRad = -(camRot.y * math.pi / 180.0)
    local camRightRoll = camRight * math.cos(rollRad) - camUp * math.sin(rollRad)
    local camUpRoll = camRight * math.sin(rollRad) + camUp * math.cos(rollRad)
    local point3DZero = camPos + camForward * 1.0
    local point3D = point3DZero + camRightRoll + camUpRoll
    local point2D = u.World3DToScreen2D(point3D)
    local point2DZero = u.World3DToScreen2D(point3DZero)
    local scaleX = (cursor.x - point2DZero.x) / (point2D.x - point2DZero.x)
    local scaleY = (cursor.y - point2DZero.y) / (point2D.y - point2DZero.y)
    local point3Dret = point3DZero + camRightRoll * scaleX + camUpRoll * scaleY
    local forwardDir = camForward + camRightRoll * scaleX + camUpRoll * scaleY
    return point3Dret, forwardDir
  end,
   
  RotationToDirection = function(rotation)
    local x = rotation.x * math.pi / 180.0
    local z = rotation.z * math.pi / 180.0
    local num = math.abs(math.cos(x))
    return vector3((-math.sin(z) * num), (math.cos(z) * num), math.sin(x))
  end,
   
  World3DToScreen2D = function(pos)
    local _, sX, sY = GetScreenCoordFromWorldCoord(pos.x, pos.y, pos.z)
    return vector2(sX, sY)
  end,
  


  VehClasses = {
    [0] = "Compacts",  
    [1] = "Sedans",  
    [2] = "SUVs",  
    [3] = "Coupes",  
    [4] = "Muscle",  
    [5] = "Sports Classics",  
    [6] = "Sports",  
    [7] = "Super",  
    [8] = "Motorcycles",  
    [9] = "Off-road",  
    [10] = "Industrial",  
    [11] = "Utility",  
    [12] = "Vans",  
    [13] = "Cycles",  
    [14] = "Boats",  
    [15] = "Helicopters",  
    [16] = "Planes",  
    [17] = "Service",  
    [18] = "Emergency",  
    [19] =  "Military",  
    [20] = "Commercial",  
    [21] = "Trains",  
  },

  GetVehicleClass = function(e)
    local nclass = GetVehicleClass(e)
    return nclass, u.VehClasses[nclass]
  end,

}





RegisterNetEvent(string.format("%s:Notify", GetCurrentResourceName()), function(msg)
  u.NOTIFY(msg)
end)
