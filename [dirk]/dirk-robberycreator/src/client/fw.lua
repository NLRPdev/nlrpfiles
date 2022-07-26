FW = {
  PlayerJob = {},



  Callback = function(name,cb,...)
    if Config.UsingESX then
      ESX.TriggerServerCallback(name,cb,...)
    elseif Config.UsingQBCore then 
      QBCore.Functions.TriggerCallback(name,cb,...)
    end
  end,

  GetPlayerJob = function()
    local jt = {}
    if Config.UsingESX then 
      local data = ESX.GetPlayerData()
      jt.name  =  data.job.name
      jt.label =  data.job.label
      jt.rank  =  data.job.grade
      jt.rankL =  data.job.grade_label
      FW.PlayerJob = jt
    elseif Config.UsingQBCore then 
      local data = QBCore.Functions.GetPlayerData()
      jt.name  = data.job.name
      jt.label = data.job.label
      jt.rank  = data.job.grade
      jt.rankL = data.job.grade.name
      FW.PlayerJob = jt
    end

    if Config.PoliceJobs[jt.name] then 
      isCop = true
    else
      isCop = false
    end
  end,

  GetClosestObject = function(obj,cs,rad)
    if Config.UsingQBCore then 
      local cO, cD = QBCore.Functions.GetClosestObject(cs.xyz)
      if GetEntityModel(cO) == tonumber(obj) then 
        if cD <= rad then
          return cO
        end
      end
    elseif Config.UsingESX then 
      local cO = ESX.Game.GetClosestObject()
      local cD = GetEntityCoords(cO)
      if GetEntityModel(cO) == tonumber(obj) then 
        if #(cD - cs) <= rad then
          return cO
        end
      end
    end
    return false
  end,


  GetClosestPed = function()
    if Config.UsingESX then 

    elseif Config.UsingQBCore then 
     local peds = QBCore.Functions.GetPeds()
    local closestDistance = false
    local closestPed = false
    for i = 1, #peds, 1 do
        local pedCoords = GetEntityCoords(peds[i])
        local ply = PlayerPedId()
        local distance = #(pedCoords - GetEntityCoords(ply))
        if distance < 15.0 and ply ~= peds[i] then 
          closestPed = peds[i]
          closestDistance = peds[i]
        end

    end
    return closestPed, closestDistance
    end
    return false,false
  end,

  GetClosestVehicle = function(cs)
    if Config.UsingESX then
      local cV, cD = ESX.Game.GetClosestVehicle()
      return cV, cD
    elseif Config.UsingQBCore then 
      local cV,cD = QBCore.Functions.GetClosestVehicle()
      return cV,cD
    end
    return false,false
  end
}






if Config.UsingESX then 
  RegisterNetEvent("esx:setJob", function(job)
    FW.GetPlayerJob()
  end)
elseif Config.UsingQBCore then 
  RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    FW.GetPlayerJob()
  end)
end




