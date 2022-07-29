local xSound = exports.xsound
local streamer = false
local musicdata = {}

RegisterNetEvent('gksphone:server:music', function(type, sid, url, coords, volume)
    if type == "play" and not streamer then
        if musicdata[sid] then
            xSound:Destroy(sid)
        end
        musicdata[sid] = true
        xSound:PlayUrlPos(sid, url, 1, coords)
        xSound:Distance(sid, 10)
        xSound:setVolumeMax(sid, 0.1)
        xSound:onPlayStart(sid, function(event) -- event argument returns getInfo(id)
            CreateThread(function()
                while true do
                    Wait(200)
                    local test = false
                    if xSound:soundExists(sid) then
                        if xSound:isPlaying(sid) then
                            local player = GetPlayerFromServerId(sid)
                            if player ~= -1 then
                                local ped = GetPlayerPed(player)
                                local kordinat = GetEntityCoords(ped)
                                xSound:Position(sid, kordinat)
                                if test then
                                    xSound:setVolumeMax(sid, event.volume)
                                    test = false
                                end
                            else
                                test = true
                                xSound:setVolumeMax(sid, 0.0)
                            end
                        end
                    else
                        xSound:Destroy(sid)
                        musicdata[sid] = nil
                        break
                    end
                end
            end)
        end)
    end
    if type == "destroy" then
        if musicdata[sid] then
            xSound:Destroy(sid)
        end
    end
    if type == "pause" then
        if musicdata[sid] then
            if xSound:soundExists(sid) then
                if xSound:isPlaying(sid) then
                    xSound:Pause(sid)
                end
            end
        end
    end
    if type == "resume" then
        if musicdata[sid] then
            if xSound:soundExists(sid) then
                if not xSound:isPlaying(sid) then
                    xSound:Resume(sid)
                end
            end
        end
    end
    if type == "volume" then
        if musicdata[sid] then
            if xSound:soundExists(sid) then
                if xSound:isPlaying(sid) then
                    xSound:setVolumeMax(sid, volume.volume)
                end
            end
        end
    end
end)



RegisterNUICallback('youtplayTEST', function(data)
    TriggerServerEvent('gksphone:server:musicAll', "play", data.link)
end)

RegisterNUICallback('youtstopAWA', function()
    TriggerServerEvent("gksphone:server:musicAll", "destroy")
end)

RegisterNUICallback('musicDevametGKS', function()
    TriggerServerEvent("gksphone:server:musicAll", "resume")
end)

RegisterNUICallback('musicDuraklatATA', function()
    TriggerServerEvent("gksphone:server:musicAll", "pause")
end)

RegisterNUICallback('BNEstreamerMod', function(data)
    streamer = data
end)

RegisterNUICallback('musicappvolume', function(volume)
    TriggerServerEvent('gksphone:server:musicAll', "volume", nil, volume)
end)
