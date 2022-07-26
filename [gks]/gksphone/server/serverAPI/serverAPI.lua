Config.Core.Functions.CreateUseableItem('pink_phone', function(source)
  TriggerClientEvent('gks:server:use', source)
end)

Config.Core.Functions.CreateUseableItem('gold_phone', function(source)
  TriggerClientEvent('gks:server:use', source)
end)

Config.Core.Functions.CreateUseableItem('phone', function(source)
  TriggerClientEvent('gks:server:use', source)
end)

Config.Core.Functions.CreateCallback('gksphone:server:phone-check', function(source, cb)
  local xPlayer = Config.Core.Functions.GetPlayer(source)
  local cannotopenphone = false
  if not xPlayer then return end
  if xPlayer.PlayerData.metadata["isdead"] or xPlayer.PlayerData.metadata["inlaststand"] then
    cannotopenphone = true
  else
    cannotopenphone = false
  end
  if Config.UsableItem then
    for k, v in pairs(Config.ItemName) do
        local items = xPlayer.Functions.GetItemByName(v)
        if items ~= nil then
            if items.amount > 0 then
                cb(v, cannotopenphone)
                return
            end
        end
    end
    cb(nil, cannotopenphone)
  else
    cb('phone', cannotopenphone)
  end
end)

function itemphonecheck(source)

  local xPlayer = Config.Core.Functions.GetPlayer(source)
  local cannotopenphone = false
  if xPlayer then
    if xPlayer.PlayerData.metadata["isdead"] or xPlayer.PlayerData.metadata["inlaststand"] then
      cannotopenphone = true
    else
      cannotopenphone = false
    end
    if Config.UsableItem then
      for k, v in pairs(Config.ItemName) do
        local items = xPlayer.Functions.GetItemByName(v)
        if items ~= nil then
          if items.amount > 0 then
            return true, cannotopenphone
          end
        end
      end
    else
      return true, cannotopenphone
    end
  else
    return false, cannotopenphone
  end

end

-- weather --

function getRandomInt(mini, maxx)
  min = math.ceil(mini);
  max = math.floor(maxx);
  return math.floor(math.random() * (max - min)) + min;
end

local water = {
  ExtraSunny = { 90, 110 },
  Clear = { 80, 95 },
  Neutral = { 80, 95 },
  Smog = { 90, 95 },
  Foggy = { 80, 90 },
  Clouds = { 80, 90 },
  Overcast = { 80, 80 },
  Clearing = { 75, 85 },
  Raining = { 75, 90 },
  ThunderStorm = { 75, 90 },
  Blizzard = { -15, 10 },
  Snowing = { 0, 32 },
  Snowlight = { 0, 32 },
  Christmas = { -5, 15 },
  Halloween = { 50, 80 }
}

function temperatureRanges(birincihava)

  local deneyasd = getRandomInt(water[birincihava][1], water[birincihava][2])

  if not Config.Fahrenheit then
    deneyasd = (deneyasd - 32) * (5 / 9)
  end

  local temp_conv_str = string.format('%.0f', deneyasd)

  if Config.Fahrenheit then
    return temp_conv_str .. ' °F'
  else
    return temp_conv_str .. ' °C'
  end

end

RegisterNetEvent("gksphone:weathercontrol")
AddEventHandler("gksphone:weathercontrol", function(birincihava, ikincihava)
  local weatherg = {}
  local temperature = temperatureRanges(birincihava)
  local temperatureto = temperatureRanges(ikincihava)

  table.insert(weatherg, { weatersi = birincihava, waterso = ikincihava, tempsi = temperature, tempso = temperatureto })

  TriggerClientEvent('gksphone:weathers', -1, weatherg)

end)


-- weather --

-- REGISTER COMMAND --

RegisterCommand('telfix', function(source)
  TriggerEvent('gksphone:gkssc:playerLoad', source)
end)

RegisterCommand('logi', function(source)
  TriggerClientEvent('gksphone:instologout', source)
end)

RegisterCommand('logt', function(source)
  TriggerClientEvent('gksphone:twlogout', source)
end)

RegisterCommand('logti', function(source)
  TriggerClientEvent('gksphone:tnlogout', source)
end)

Config.Core.Commands.Add(Config.TwitterVerifyCommand, 'Blue Tick Approval', {{name = "AccountName", help = "Twitter Account Name"}}, true, function(source, args)
  local src = source
  if args[1] then
    local label = ""
    local first = true
    for i = 1, #args, 1 do
      if first then
        first = false
        label = label .. '' .. args[i]
      else
        label = label .. ' ' .. args[i]
      end
    end
    MySQL.Async.execute("UPDATE `gksphone_twitter_accounts` SET `averify`= 1 WHERE gksphone_twitter_accounts.username = @username", {
      ['@username'] = tostring(args[1])
    }, function (result)
      if (result == 1) then
        TriggerClientEvent(Config.CoreNotify, src, 'The user has been given a blue tick.')
      else
        TriggerClientEvent(Config.CoreNotify, src, 'You did not write the required information', 'error')
      end
    end)
  else
    TriggerClientEvent(Config.CoreNotify, src, 'You did not write the required information', 'error')
  end
end, 'god')

-- REGISTER COMMAND --

--- WEBHOOKS ---
RegisterServerEvent('gksphone:jobnotif')
AddEventHandler('gksphone:jobnotif', function(name, number, message, photo, jobm, identifier, new, name2)

  local discord_webhook = Cfg.JobNotif
  if discord_webhook == 'Discord Webhook' then
    return
  end

  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = 'Job Notif',
    ["avatar_url"] = 'https://media.discordapp.net/attachments/722981093455822958/882974778334523392/stock-market.png?width=480&height=480',
    ["embeds"] = { {
      ["color"] = 15258703
    } }
  }
  local isHttp = string.sub(photo, 0, 7) == 'http://' or string.sub(photo, 0, 8) == 'https://'
  local ext = string.sub(photo, -4)
  local isImg = ext == '.png' or ext == '.jpg' or ext == '.gif' or string.sub(photo, -5) == '.jpeg'

  if new == 1 then
    data['embeds'][1]['title']       = '[' .. name .. ']  Occupation Notification : ' .. jobm
    data['embeds'][1]['image']       = { ['url'] = photo }
    data['embeds'][1]['description'] = 'Message : ' .. message
    data['embeds'][1]['footer']      = { ['text'] = ' [Number : ' .. number .. ', identifier : ' .. identifier .. ']' }
  end
  if new == 0 then
    data['embeds'][1]['title']       = '[' .. name2 .. '] Incoming Problem Solved : ' .. jobm
    data['embeds'][1]['image']       = { ['url'] = photo }
    data['embeds'][1]['description'] = 'Message : ' .. message
    data['embeds'][1]['footer']      = { ['text'] = '[Name : ' .. name .. ' ,Number : ' .. number .. ']' }
  end
  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)

RegisterServerEvent('gksphone:cryptobuysellwebhook')
AddEventHandler('gksphone:cryptobuysellwebhook', function(test, test2, identifier, adet, coin, color, name, transferto, name2)
  local discord_webhook = Cfg.Crypto
  if discord_webhook == 'Discord Webhook' then
    return
  end

  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = 'Stock Market',
    ["avatar_url"] = 'https://seeklogo.com/images/C/cryptocurrency-blockchain-logo-249415523F-seeklogo.com.png',
    ["embeds"] = { {
      ["color"] = color
    } }
  }

  if test == 'purchased' or test == 'sold' then
    data['embeds'][1]['title'] = '[' .. name .. '] has ' .. test .. ' x' .. tonumber(adet) .. ' of ' .. coin .. '! Worth: $' .. test2 .. '!'
    data['embeds'][1]['description'] = '[' .. name .. '] [' .. identifier .. ']'
  end
  if test == 'transfer' then
    data['embeds'][1]['title'] = '[' .. name .. '] transferred  x' .. test2 .. ' ' .. coin .. ' to ' .. name2 .. ' [' .. transferto .. ']'
    data['embeds'][1]['description'] = '[' .. name .. '] [' .. identifier .. ']'
  end


  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)

RegisterServerEvent('gksphone:cryptotranwebhook')
AddEventHandler('gksphone:cryptotranwebhook', function(name, test2, coin, name2, transferto, identifier)
  local discord_webhook = Cfg.Crypto
  if discord_webhook == 'Discord Webhook' then
    return
  end

  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = 'Stock Market',
    ["avatar_url"] = 'https://seeklogo.com/images/C/cryptocurrency-blockchain-logo-249415523F-seeklogo.com.png',
    ["embeds"] = { {
      ["color"] = color
    } }
  }



  data['embeds'][1]['title'] = '[' .. name .. '] transferred  x' .. tonumber(test2) .. ' ' .. coin .. ' to ' .. name2 .. ' [' .. transferto .. ']'
  data['embeds'][1]['description'] = '[' .. name .. '] [' .. identifier .. ']'



  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)

RegisterServerEvent('gksphone:carsellernew')
AddEventHandler('gksphone:carsellernew', function(a, name2, bidentifier, name, b, c)

  local discord_webhook = Cfg.Carseller
  if discord_webhook == 'Discord Webhook' then
    return
  end

  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = 'Car Seller',
    ["avatar_url"] = 'https://media.discordapp.net/attachments/722981093455822958/882974778334523392/stock-market.png?width=480&height=480',
    ["embeds"] = { {
      ["color"] = 15258703
    } }
  }


  data['embeds'][1]['title']       = '[' .. name .. ']' .. bidentifier .. ' Sold Vehicle'
  data['embeds'][1]['description'] = 'Car license plate : ' .. b .. ' Sale price : ' .. c
  data['embeds'][1]['footer']      = { ['text'] = 'The person who bought the vehicle : [' .. name2 .. ', identifier : ' .. a .. ']' }


  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)

AddEventHandler('gksphone:newcarseller', function(identifier, phonenumber, plate, model, price, image)

  local discord_webhook = Cfg.NewCarSeller
  if discord_webhook == 'Discord Webhook' then
    return
  end
  local headers = {
    ['Content-Type'] = 'application/json'
  }

  local data = {
    ["username"] = "New Car Post",
    ["avatar_url"] = "https://media.discordapp.net/attachments/722981093455822958/882974778334523392/stock-market.png?width=480&height=480",
    ["embeds"] = { {
      ["color"] = 1942002
    } }
  }

  data['embeds'][1]['title'] = identifier .. "[" ..phonenumber.." ] " .." Published a new vehicle ad"
  data['embeds'][1]['image'] = { ['url'] = image }
  data['embeds'][1]['description'] = "Model : "..model .. "\nPlate :" ..plate.. "\nPrice :" ..price

  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)

RegisterServerEvent('gksphone:insto_newinstas')
AddEventHandler('gksphone:insto_newinstas', function(inap)
  local discord_webhook = Cfg.InstagramWeb
  if discord_webhook == 'Discord Webhook' then
    return
  end
  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = inap.username,
    ["avatar_url"] = inap.authorIcon,
    ["embeds"] = { {
      ["color"] = 1942002
    } }
  }
  local isHttp = string.sub(inap.message, 0, 7) == 'http://' or string.sub(inap.message, 0, 8) == 'https://'
  local ext = string.sub(inap.message, -4)
  local isImg = ext == '.png' or ext == '.jpg' or ext == '.gif' or string.sub(inap.message, -5) == '.jpeg'

  data['embeds'][1]['title'] = inap.forename .. " The user posted a new post!"
  data['embeds'][1]['image'] = { ['url'] = inap.image }
  data['embeds'][1]['description'] = inap.message

  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)

RegisterServerEvent('gksphone:twitter_newTweets')
AddEventHandler('gksphone:twitter_newTweets', function(tweet)

  local discord_webhook = Cfg.TwitterWeb
  if discord_webhook == 'Discord Webhook' then
    return
  end
  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = tweet.author,
    ["avatar_url"] = tweet.authorIcon,
    ["embeds"] = { {
      ["color"] = 1942002
    } }
  }
  local isHttp = string.sub(tweet.message, 0, 7) == 'http://' or string.sub(tweet.message, 0, 8) == 'https://'
  local ext = string.sub(tweet.message, -4)
  local isImg = ext == '.png' or ext == '.jpg' or ext == '.gif' or string.sub(tweet.message, -5) == '.jpeg'

  data['embeds'][1]['title'] = tweet.author .. " The user posted a new post!"
  data['embeds'][1]['image'] = { ['url'] = tweet.image }
  data['embeds'][1]['description'] = tweet.message

  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)

RegisterServerEvent('gksphone:yellow_newPagess')
AddEventHandler('gksphone:yellow_newPagess', function(pages)

  local discord_webhook = Cfg.YellowWeb
  if discord_webhook == 'Discord Webhook' then
    return
  end
  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = pages.firstname,
    ["embeds"] = { {
      ["color"] = 1942002
    } }
  }
  local isHttp = string.sub(pages.message, 0, 7) == 'http://' or string.sub(pages.message, 0, 8) == 'https://'
  local ext = string.sub(pages.message, -4)
  local isImg = ext == '.png' or ext == '.jpg' or ext == '.gif' or string.sub(pages.message, -5) == '.jpeg'

  data['embeds'][1]['title'] = pages.firstname .. " The user posted a new post!"
  data['embeds'][1]['image'] = { ['url'] = pages.image }
  data['embeds'][1]['description'] = pages.message

  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)

function MessagesWebhook(transmitter, receiver, message)

  local license, steam, xbl, discord, live, fivem = '', '', '', '', '', ''
  local name = GetPlayerName(source)

  for k, v in pairs(GetPlayerIdentifiers(source)) do
    if string.sub(v, 1, string.len('license:')) == 'license:' then
      license = v
    elseif string.sub(v, 1, string.len('steam:')) == 'steam:' then
      steam = v
    elseif string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
      xbl = v
    elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
      discord = v
    elseif string.sub(v, 1, string.len('live:')) == 'live:' then
      live = v
    elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
      fivem = v
    end
  end


  local discord_webhook = Cfg.MessageWeb
  if discord_webhook == 'Discord Webhook' then
    return
  end

  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = 'Message APP',
    ["embeds"] = { {
      ["color"] = 15258703
    } }
  }

  decst = "**Message Sender** :" .. transmitter .. " **Message Recipient** :" .. receiver .. "\n **Message** :" .. message

  data['embeds'][1]['title'] = 'Messages APP'
  if discord ~= nil then
    data['embeds'][1]['description'] = '**Name:** : ' .. name .. '\n  **Hex ID:** : ' .. license .. '\n  **Steam:**' .. steam .. '\n**Discord:** <@' .. string.sub(discord, 9) .. '>' .. '\n **Game ID:** ' .. source .. '\n **Detail:** ' .. decst
  else
    data['embeds'][1]['description'] = '**Name:** : ' .. name .. '\n  **Hex ID:** : ' .. license .. '\n  **Steam:**' .. steam .. '\n **Game ID:** ' .. source .. '\n **Detail:** ' .. decst
  end

  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)

end

function CallWebhook(transmitter, receiver, source)

  local license, steam, xbl, discord, live, fivem = '', '', '', '', '', ''
  local name = GetPlayerName(source)

  for k, v in pairs(GetPlayerIdentifiers(source)) do
    if string.sub(v, 1, string.len('license:')) == 'license:' then
      license = v
    elseif string.sub(v, 1, string.len('steam:')) == 'steam:' then
      steam = v
    elseif string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
      xbl = v
    elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
      discord = v
    elseif string.sub(v, 1, string.len('live:')) == 'live:' then
      live = v
    elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
      fivem = v
    end
  end


  local discord_webhook = Cfg.CallWebhook
  if discord_webhook == 'Discord Webhook' then
    return
  end

  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = 'Calling',
    ["embeds"] = { {
      ["color"] = 15258703
    } }
  }

  decst = "**Caller** :" .. transmitter .. " **Receiver** :" .. receiver .. "\n "

  data['embeds'][1]['title'] = 'Calling'
  if discord ~= nil then
    data['embeds'][1]['description'] = '**Name:** : ' .. name .. '\n  **Hex ID:** : ' .. license .. '\n  **Steam:**' .. steam .. '\n**Discord:** <@' .. string.sub(discord, 9) .. '>' .. '\n **Game ID:** ' .. source .. '\n **Detail:** ' .. decst
  else
    data['embeds'][1]['description'] = '**Name:** : ' .. name .. '\n  **Hex ID:** : ' .. license .. '\n  **Steam:**' .. steam .. '\n **Game ID:** ' .. source .. '\n **Detail:** ' .. decst
  end

  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)

end

function BankTrasnfer(name, identifier1, amount, name2, identifier2)
  local discord_webhook = Cfg.BankTransfer
  if discord_webhook == 'Discord Webhook' then
    return
  end

  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = 'Bank Transfer',
    ["avatar_url"] = 'https://www.futurebrand.com/uploads/case-studies/_heroImage/3-NatWest-New-Logo.jpg',
    ["embeds"] = { {
      ["color"] = color
    } }
  }

  data['embeds'][1]['title'] = "[**" .. name .. "**] has transferred [**£" .. amount .. "**] to [**" .. name2 .. "**]."
  data['embeds'][1]['description'] = "[**" .. name .. "**]" .. "**[" .. identifier1 .. "**]" .. "\n" .. "[**" .. name2 .. "**]" .. "[**" .. identifier2 .. "**]"

  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

RegisterServerEvent('gksphone:server:racecreateweb')
AddEventHandler('gksphone:server:racecreateweb', function(races, source)

  if races[1] then
    local license, steam, discord = '', '', ''
    local name = GetPlayerName(source)

    for k, v in pairs(GetPlayerIdentifiers(source)) do
      if string.sub(v, 1, string.len('license:')) == 'license:' then
        license = v
      elseif string.sub(v, 1, string.len('steam:')) == 'steam:' then
        steam = v
      elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
        discord = v
      end
    end

    local discord_webhook = Cfg.RaceCreate
    if discord_webhook == 'Discord Webhook' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "Race Create",
      ["embeds"] = { {
        ["color"] = 1942002
      } }
    }



    data['embeds'][1]['title'] = "Race Create | Race ID: " .. races[1].RaceId .. " | Race Amount : " .. races[1].raceamount
    if discord ~= nil then
      data['embeds'][1]['description'] = '**Name:** : ' .. name .. '\n  **Hex ID:** : ' .. license .. '\n  **Steam:**' .. steam .. '\n**Discord:** <@' .. string.sub(discord, 9) .. '>' .. '\n **Game ID:** ' .. source .. '\n '
    else
      data['embeds'][1]['description'] = '**Name:** : ' .. name .. '\n  **Hex ID:** : ' .. license .. '\n  **Steam:**' .. steam .. '\n **Game ID:** ' .. source .. '\n '
    end

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  end

end)

RegisterServerEvent('gksphone:server:racekazancwebhook')
AddEventHandler('gksphone:server:racekazancwebhook', function(races)

  local discord_webhook = Cfg.RaceWinning
  if races[1] then
    local label = " **Race fee** : " .. races[1].raceamount .. " **Race Checkpoint** : " .. races[1].checkpoint .. " **Race Lap** : " .. races[1].lap .. '\n '
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "Race winnings",
      ["embeds"] = { {
        ["color"] = 1942002
      } }
    }

    for k, l in pairs(races) do
      label = label .. '**Source** :' .. l.identifier .. ', **Identifier** :' .. l.steamidentifier .. ', **Race Name** :' .. l.player_name .. ', **Winnings** : ' .. l.kazanc .. '\n '
    end

    data['embeds'][1]['title'] = "Race winnings Race ID:" .. races[1].raceid
    data['embeds'][1]['description'] = label

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  end
end)

RegisterNetEvent('gksphone:exploitwebhook', function(source, app, decst)
  local license, steam, xbl, discord, live, fivem = '', '', '', '', '', ''
  local name = GetPlayerName(source)

  for k, v in pairs(GetPlayerIdentifiers(source)) do
    if string.sub(v, 1, string.len('license:')) == 'license:' then
      license = v
    elseif string.sub(v, 1, string.len('steam:')) == 'steam:' then
      steam = v
    elseif string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
      xbl = v
    elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
      discord = v
    elseif string.sub(v, 1, string.len('live:')) == 'live:' then
      live = v
    elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
      fivem = v
    end
  end


  local discord_webhook = Cfg.ExploitWebhook
  if discord_webhook == 'Discord Webhook' then
    return
  end

  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = 'Car Seller',
    ["avatar_url"] = 'https://media.discordapp.net/attachments/722981093455822958/882974778334523392/stock-market.png?width=480&height=480',
    ["embeds"] = { {
      ["color"] = 15258703
    } }
  }


  data['embeds'][1]['title'] = '[' .. app .. ']' .. ' Tried to exploit'
  if discord ~= nil then
    data['embeds'][1]['description'] = '**Name:** : ' .. name .. '\n  **Hex ID:** : ' .. license .. '\n  **Steam:**' .. steam .. '\n**Discord:** <@' .. string.sub(discord, 9) .. '>' .. '\n **Game ID:** ' .. source .. '\n **Detail:** ' .. decst
  else
    data['embeds'][1]['description'] = '**Name:** : ' .. name .. '\n  **Hex ID:** : ' .. license .. '\n  **Steam:**' .. steam .. '\n **Game ID:** ' .. source .. '\n **Detail:** ' .. decst
  end

  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)

--- WEBHOOKS ---
