RegisterNetEvent('rebel-moneywash:server:sendWebhook', function(type, color, name, message, footer)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }
    
    if type == 1 then
        PerformHttpRequest(Config.DiscordWebhooks.Washing_Logs, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    else
        PerformHttpRequest(Config.DiscordWebhooks.Drying_Logs, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
end)
