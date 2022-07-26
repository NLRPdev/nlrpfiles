FW = {
  Callback = function(name,route)
    if Config.UsingESX then 
      ESX.RegisterServerCallback(name,route)
    elseif Config.UsingQBCore then 
      QBCore.Functions.CreateCallback(name,route) 
    end
  end,

  AddCommand = function(name,desc,func)
    if Config.UsingESX then 
      ESX.RegisterCommand(name, Config.CommandPerms, function(xPlayer, args, showError)
        func(xPlayer.playerId)
      end, false, {help = desc})
    elseif Config.UsingQBCore then 
      QBCore.Commands.Add(name, desc, {}, false, function(source)
        func(source)
      end, Config.CommandPerms)
    end
  end,

  Player = function(s)
    if Config.UsingESX then 
      return ESX.GetPlayerFromId(s)
    elseif Config.UsingQBCore then 
      return QBCore.Functions.GetPlayer(s)
    end
  end,

  GetPlayerId = function(p)
    if Config.UsingESX then 
      return ESX.GetPlayerFromId(source).identifier
    elseif Config.UsingQBCore then 
      return QBCore.Functions.GetPlayer(p).PlayerData.citizenid
    end
  end,

  Notify = function(p,msg)
    if Config.UsingESX then 
      TriggerClientEvent("esx:showNotification", p, msg)
    elseif Config.UsingQBCore then 
      TriggerClientEvent("QBCore:Notify", p, msg)
    end
  end,


  AddItem = function(p,i,a)
    local ply = FW.Player(p)
    if Config.UsingESX then 
      ply.addInventoryItem(i,a)
    elseif Config.UsingQBCore then 
      ply.Functions.AddItem(i,a)
      TriggerClientEvent('inventory:client:ItemBox', p, QBCore.Shared.Items[i], "add")
    end
  end,

  HasItem = function(p, i,a)
    local ply = FW.Player(p)
    if Config.UsingESX then 
      local item = ply.getInventoryItem(i)
      if item and item.count >= a then 
        return true
      end
    elseif Config.UsingQBCore then 
      local item = ply.Functions.GetItemByName(i)
      if item and item.amount >= a then 
        return true
      end
    end
    return false
  end,

  AddMoney = function(p,acc,a)
    if Config.UsingESX then 
      local ply = ESX.GetPlayerFromId(p)
      local accs = ply.getAccounts()
      local exists = false
      for k,v in pairs(accs) do
        if v.name == acc then
          exists = true
          break
        end
      end
      ply.addAccountMoney(acc,a)
    elseif Config.UsingQBCore then 
      local ply = QBCore.Functions.GetPlayer(p)
      ply.Functions.AddMoney(acc,a)
    end
  end,

  GetPlayerJob = function(p)
    local ply = FW.Player(p)
    if not ply then return {}; end
    local jt = {}

    if Config.UsingQBCore then 
      jt.grade = ply.PlayerData.job.grade.level
      jt.name  = ply.PlayerData.job.name
      return jt
    elseif Config.UsingESX then 
      jt.grade = ply.job.grade
      jt.name  = ply.job.name
      return jt
    end
    return {}
  end,
}

FW.AddCommand(Config.ObjectsSetupCommand, 'Edit Objects Interactions and Add New Objects', function(src)
  TriggerClientEvent("HR:OpenObjectsSetup", src)
end)

FW.AddCommand(Config.ManageRobberiesCommand, 'Manage and Create Robberies', function(src)
  TriggerClientEvent("HR:OpenManage", src)
end)
