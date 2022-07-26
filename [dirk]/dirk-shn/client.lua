UI = {
  Current   = "name",
  Last_Call = 1000, 
  Objects   = {},

  ShowHelpNotification = function(name, items)
    local now = GetGameTimer()
    local pause = IsPauseMenuActive()
    if (UI.Current ~= name or ((now - UI.Last_Call) >= 2.5)) and pause ~= 1 then  

      UI.Current = name
      UI.Objects = items
      SetNuiFocusKeepInput(true)
      SendNuiMessage(json.encode({
        type    = "show",
        message = items,
      }))
    end
    UI.Last_Call = GetGameTimer()
  end,

  Hide = function()
    UI.Current     = false
    SendNuiMessage(json.encode({
      type = "hide"
    })) 
    SetNuiFocusKeepInput(false)
  end

}



Update = function()
  while true do 
    if UI.Current then 
      local pause = IsPauseMenuActive()
      if ((GetGameTimer() - UI.Last_Call) >= 300) or pause == 1 then 
        UI.Hide()
      end
    else
      Wait(5)
    end
    Wait(0)
  end
end

Citizen.CreateThread(Update)

getObject = function()
  return UI
end


--[[
local UI = exports['dirk-shn']:GetObject()


while true do 
  UI.ShowHelpNotification("stealing", {
    {
      label = "Search this object",
      key   = "f"
    }
  })
  Wait(0)
end



]]
