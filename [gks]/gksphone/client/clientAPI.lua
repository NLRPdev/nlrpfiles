function  GiveKeyCar (callback_vehicle, vehicle)
    exports['LegacyFuel']:SetFuel(callback_vehicle, vehicle.fuel)
    TriggerEvent("vehiclekeys:client:SetOwner", Config.Core.Functions.GetPlate(callback_vehicle))  -- You may need to write your car key function
end

function  OpenPhoneBlock () -- You can use this function if you want to prevent the phone from being turned on.
  return true
end


-- ## JOB APP ## --

RegisterNUICallback('JobMMessages', function(data, cb)
  local myPos = GetEntityCoords(PlayerPedId())
  local GPS = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  TriggerServerEvent('gksphone:gkcs:jbmessage', data.name, data.number, data.message, data.photo, GPS, data.jobm, data.anon)
end)


-- ## Weather in phone ## --


local letSleepd = true
local letSleed = true

CreateThread(function()                         -- Weather
  while true do
    Citizen.Wait(500)
    local faruk, deea, waadad = GetWeatherTypeTransition()
      if 0.98 < waadad or letSleed then
        letSleed = false
        local denmee
        local agasdwa
          
          if (faruk == -1750463879) then
            denmee = 'ExtraSunny' 
          elseif (faruk == 916995460) then
            denmee = 'Clear' 
          elseif (faruk == -1530260698) then
            denmee = 'Neutral' 
          elseif (faruk == 282916021) then
            denmee = 'Smog' 
          elseif (faruk == -1368164796) then
            denmee = 'Foggy' 
          elseif (faruk == 821931868) then
            denmee = 'Clouds' 
          elseif (faruk == -1148613331) then
            denmee = 'Overcast'
          elseif (faruk == 1840358669) then
            denmee = 'Clearing'
          elseif (faruk == 1420204096) then
            denmee = 'Raining'
          elseif (faruk == -1233681761) then
            denmee = 'ThunderStorm'
          elseif (faruk == 669657108) then
            denmee = 'Blizzard'
          elseif (faruk == -273223690) then
            denmee = 'Snowing'
          elseif (faruk == 603685163) then
            denmee = 'Snowlight'
          elseif (faruk == -1429616491) then
            denmee = 'Christmas'
          elseif (faruk == -921030142) then
            denmee = 'Halloween'
          end

          if (deea == -1750463879) then
            agasdwa = 'ExtraSunny' 
          elseif (deea == 916995460) then
            agasdwa = 'Clear' 
          elseif (deea == -1530260698) then
            agasdwa = 'Neutral' 
          elseif (deea == 282916021) then
            agasdwa = 'Smog' 
          elseif (deea == -1368164796) then
            agasdwa = 'Foggy' 
          elseif (deea == 821931868) then
            agasdwa = 'Clouds' 
          elseif (deea == -1148613331) then
            agasdwa = 'Overcast'
          elseif (deea == 1840358669) then
            agasdwa = 'Clearing'
          elseif (deea == 1420204096) then
            agasdwa = 'Raining'
          elseif (deea == -1233681761) then
            agasdwa = 'ThunderStorm'
          elseif (deea == 669657108) then
            agasdwa = 'Blizzard'
          elseif (deea == -273223690) then
            agasdwa = 'Snowing'
          elseif (deea == 603685163) then
            agasdwa = 'Snowlight'
          elseif (deea == -1429616491) then
            agasdwa = 'Christmas'
          elseif (deea == -921030142) then
            agasdwa = 'Halloween'
          end

          TriggerServerEvent('gksphone:weathercontrol', denmee, agasdwa)
  
      else
        letSleepd = true	
      end
      if letSleepd then Citizen.Wait(9000) end
  end
end)



-- ## Clock in phone ## --

local useMilitaryTime = false

RegisterNUICallback('saat', function(data)
  hour = GetClockHours()
  minute = GetClockMinutes()

  if useMilitaryTime == false then
    if hour == 0 or hour == 24 then
      hour = 12
    elseif hour >= 13 then
      hour = hour - 12
    end
  end

  if hour <= 9 then
    hour = "0" .. hour
  end
  if minute <= 9 then
    minute = "0" .. minute
  end
  timeText = hour ..':' ..minute;
  SendNUIMessage({event = 'emuncuk', timeText = timeText})
end)


-- qphone trigger --

RegisterNetEvent('qb-phone:client:RemoveBankMoney', function(amount)
  if amount > 0 then
      TriggerEvent('gksphone:notifi', {title = _U('bank_title'), message = "$"..amount.." has been removed from your balance!", img= '/html/static/img/icons/wallet.png'})
  end
end)

RegisterNetEvent('qb-phone:client:AddTransaction', function(SenderData, TransactionData, Message, Title)
  TriggerEvent('gksphone:notifi', {title = _U('qbit_title'), message = Message, img= '/html/static/img/icons/qbit.png'})
end)

if Config.HospitalAmbulanceAlert then
  RegisterNetEvent('hospital:client:ambulanceAlert', function(coords, text)
    local GPS = 'GPS: ' .. coords.x .. ', ' .. coords.y
    TriggerServerEvent('gksphone:gkcs:jbmessage', "Anonymous", "", 'Emergency aid notification ' ..text, '', GPS, '["ambulance"]', true)
  end)
end


-- REGISTER COOMAND --

RegisterCommand("testmailbutton",function(source, args, rawCommand)
	TriggerServerEvent('gksphone:NewMail', {
		sender = 'GKSHOP',
		image = '/html/static/img/icons/mail.png',
		subject = "GKSPHONE",
		message = 'TEST',
    button = {
      buttonEvent = "qb-drugs:client:setLocation",
      buttonData = "test",
      buttonname = "test"
    }
  })
end)

RegisterCommand("testmail",function(source, args, rawCommand)
	TriggerServerEvent('gksphone:NewMail', {
		sender = 'GKSHOP',
		image = '/html/static/img/icons/mail.png',
		subject = "GKSPHONE",
		message = 'TEST'
  })
end)



RegisterCommand("911p",function(source, args, rawCommand)
  local message = args[1]
  local label = ""
  for i=1, #args, 1 do
    label = label .. ' ' ..args[i]
  end
  if message then
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local myPos = GetEntityCoords(PlayerPedId())
    local GPS = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
    local Playerd = Config.Core.Functions.GetPlayerData()
    local display = Playerd.charinfo.firstname .. " " .. Playerd.charinfo.lastname
    local pnumber = Playerd.charinfo.phone
    TriggerServerEvent('gksphone:gkcs:jbmessage', display, pnumber, label, '', GPS, '["police", "sheriff"]', false)
  end
end, false)

RegisterCommand("911e",function(source, args, rawCommand)
  local message = args[1]
  local label = ""
  for i=1, #args, 1 do
    label = label .. ' ' ..args[i]
  end
  if message then
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local myPos = GetEntityCoords(PlayerPedId())
    local GPS = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
    local Playerd = Config.Core.Functions.GetPlayerData()
    local display = Playerd.charinfo.firstname .. " " .. Playerd.charinfo.lastname
    local pnumber = Playerd.charinfo.phone

    TriggerServerEvent('gksphone:gkcs:jbmessage', display, pnumber, label, '', GPS, '["ambulance"]', false)

  end
end, false)

-- REGISTER COMMAND --

