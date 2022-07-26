local taskInProcess = false

function openGui(time)
    TriggerEvent("tgiann-base:closeInv")
    SetNuiFocus(true, false)
    SendNUIMessage({type = "open", time = time})
end
  
RegisterNUICallback('fail', function(data, cb)
    closeMenu("fail")
end)

RegisterNUICallback('success', function(data, cb)
    closeMenu("success")
end)

function closeMenu(type)
    SetNuiFocus(false, false)
    status = type
    taskInProcess = false
end

function taskBar(difficulty)
    if taskInProcess then return end
    taskInProcess = true
    openGui(difficulty)
    while taskInProcess do 
        local playerPed = PlayerPedId()
        if IsPedRagdoll(playerPed) or IsPedBeingStunned(playerPed) then 
            SetNuiFocus(false, false)
            SendNUIMessage({type = "close"})
            taskInProcess = false
            return false
        end
        Citizen.Wait(0) 
    end
    Citizen.Wait(200)
    if status == "success" then
        return true
    else
        return false
    end
end

local finished = exports["tgiann-skillbar"]:taskBar(30000)
if not finished then
    isActive = false
else
    local finished2 = exports["tgiann-skillbar"]:taskBar(2000)
    if not finished2 then
        isActive = false
    else
        local finished3 = exports["tgiann-skillbar"]:taskBar(1000)
        if not finished3 then
            isActive = false
        else
            local finished4 = exports["tgiann-skillbar"]:taskBar(4200)
            if not finished4 then
                isActive = false
            else
                local finished5 = exports["tgiann-skillbar"]:taskBar(1400)
                if not finished5 then
                    isActive = false
                else
                    ClearPedSecondaryTask(playerPed)
                    isActive = false
                end
            end
        end
    end
end