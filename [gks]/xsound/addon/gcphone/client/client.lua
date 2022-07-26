

if config.AddonList.gksphone then
    local calanMuzikler = {}
    local musicOn = false
    local streamer = false

    -- Müzik çalma
    exports('Cal', function(link, mp3)
        local ped = PlayerPedId()
        local serverId = GetPlayerServerId(PlayerId())
        local muzikAdi = tostring(serverId)
       
        if musicOn then
            TriggerServerEvent("muzik-durdur", muzikAdi)
            musicOn = false
        end

        if #calanMuzikler <= 99 then
            if mp3 then
                TriggerServerEvent("muzik-cal", muzikAdi, link,  true)
            else
                TriggerServerEvent("muzik-cal", muzikAdi, link, false)
            end
            musicOn = true
        end
    end)

    RegisterNetEvent('client-muzik-cal')
    AddEventHandler('client-muzik-cal', function(playerNetId, pos, muzikAdi, link, mp3)


                calanMuzikler[muzikAdi] = {}
                calanMuzikler[muzikAdi]["duraklat"] = false
                calanMuzikler[muzikAdi]["serverId"] = playerNetId
                calanMuzikler[muzikAdi]["mp3"] = mp3
    
                if streamer == false then
                        local eCoords = pos
                        if soundExists(muzikAdi) then
                            Destroy(muzikAdi)
                            calanMuzikler[muzikAdi] = nil
                        end
                    if mp3 then
                        PlayUrlPos(muzikAdi, link, 0.1, eCoords, true,{
                            onPlayStart = function(event)
                                Distance(muzikAdi, 10)
                            end
                        })
                    else
                        PlayUrlPos(muzikAdi, link, 0.1, eCoords, false,{
                            onPlayStart = function(event)
                                Distance(muzikAdi, 10)
                            end
                        })
                    end
                end
   
     
    end)

    -- Müzik durdurma
    exports('Durdur', function(link)
        if musicOn then
            musicOn = false
            TriggerServerEvent("muzik-durdur", tostring(GetPlayerServerId(PlayerId())))
        end
    end)

    RegisterNetEvent('client-muzik-durdur')
    AddEventHandler('client-muzik-durdur', function(muzikAdi)
            calanMuzikler[muzikAdi] = nil
            Destroy(muzikAdi)
    end)

    exports('Streamer', function(data)
        streamer = data
    end)

    -- Müzik duraklatma
    exports('Duraklat', function(link)
        local myId = tostring(GetPlayerServerId(PlayerId()))
        TriggerServerEvent("muzik-duraklat", myId)
    end)

    RegisterNetEvent('client-muzik-duraklat')
    AddEventHandler('client-muzik-duraklat', function(muzikAdi)
        if calanMuzikler[muzikAdi] ~= nil then
            if calanMuzikler[muzikAdi]["duraklat"] == false then
                calanMuzikler[muzikAdi]["duraklat"] = true
                Pause(muzikAdi)
            end
        end
    end)

    -- Müzik duraklatma
    exports('Devamet', function(link)
        local myId = tostring(GetPlayerServerId(PlayerId()))
        
        TriggerServerEvent("muzik-devamet", myId)
    end)

    RegisterNetEvent('client-muzik-devamet')
    AddEventHandler('client-muzik-devamet', function(muzikAdi)
        if calanMuzikler[muzikAdi] ~= nil then
            if calanMuzikler[muzikAdi]["duraklat"] == true then
                calanMuzikler[muzikAdi]["duraklat"] = false
                Resume(muzikAdi)
            end
        end
    end)

   -- Müzik Konum güncelleme
    local time = 100
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(time)
            for x, y in pairs(calanMuzikler) do
                local player = GetPlayerFromServerId(calanMuzikler[x]["serverId"])
                if player ~= -1 then
                    if calanMuzikler[x]["duraklat"] == false then
                        local ped = GetPlayerPed(player)
                        local kordinat = GetEntityCoords(ped)
                        local benimKordinat = GetEntityCoords(PlayerPedId())
                        local mesafe = #(benimKordinat - kordinat)
                        if mesafe < 200 then
                            time = 100
                            Position(x, kordinat)
                            if calanMuzikler[x]["mp3"]  then
                                if IsPedInAnyVehicle(ped, true) == 1 then
                                    local vehicle = GetVehiclePedIsIn(ped, false)
                                    if GetEntitySpeed(vehicle) * 3.6 > 200.0 then
                                        Distance(x, 140)
                                    elseif GetEntitySpeed(vehicle) * 3.6 > 150.0 then
                                        Distance(x, 125)
                                    elseif GetEntitySpeed(vehicle) * 3.6 > 110.0 then
                                        Distance(x, 100)
                                    elseif GetEntitySpeed(vehicle) * 3.6 > 90.0 then
                                        Distance(x, 80)
                                    elseif GetEntitySpeed(vehicle) * 3.6 > 60.0 then
                                        Distance(x, 65)
                                    elseif GetEntitySpeed(vehicle) * 3.6 > 30.0 then
                                        Distance(x, 40)
                                    else
                                        Distance(x, 25)
                                    end
                                else
                                    Distance(x, 10)
                                end
                            else
                                if IsPedInAnyVehicle(ped, true) == 1 then
                                    local vehicle = GetVehiclePedIsIn(ped, false)
                                    if GetEntitySpeed(vehicle) * 3.6 > 200.0 then
                                        Distance(x, 100)
                                    elseif GetEntitySpeed(vehicle) * 3.6 > 150.0 then
                                        Distance(x, 90)
                                    elseif GetEntitySpeed(vehicle) * 3.6 > 110.0 then
                                        Distance(x, 70)
                                    elseif GetEntitySpeed(vehicle) * 3.6 > 90.0 then
                                        Distance(x, 70)
                                    elseif GetEntitySpeed(vehicle) * 3.6 > 60.0 then
                                        Distance(x, 50)
                                    elseif GetEntitySpeed(vehicle) * 3.6 > 30.0 then
                                        Distance(x, 40)
                                    else
                                        Distance(x, 25)
                                    end
                                else
                                    Distance(x, 15)
                                end
                            end
                        else
                            time = 2000
                            Position(x, kordinat)
                        end
                    else
                        time = 1000
                    end
                else
                    local muzikAdi = tostring(calanMuzikler[x]["serverId"])
                    calanMuzikler[muzikAdi] = nil
                    Destroy(muzikAdi)
                end
            end
        end
    end)
end