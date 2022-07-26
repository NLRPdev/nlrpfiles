CreateThread(function()
    QBCore = exports["qb-core"]:GetCoreObject()
    
    Functions = {
        ExecuteSQL = function(string)
            if GetResourceState("oxmysql") == "started" then
                exports.oxmysql:execute(string, {}, function(retVal) end)
            end
            if GetResourceState("ghmattimysql") == "started" then
                exports.ghmattimysql:execute(string, {}, function(retVal) end)
            end
        end,
        
        SelectSQL = function(string,cb)
            if GetResourceState("oxmysql") == "started" then
                local retVal = exports.oxmysql:executeSync(string, {})
                cb(retVal)
            end
            if GetResourceState("ghmattimysql") == "started" then
                exports.ghmattimysql:scalar(string, {}, function(retVal)
                    cb(retVal)
                end)
            end
        end
    }

    -- default commands
    QBCore.Commands.Add("givemultijob", "Give a player an job through the multi job system", {
        {
            name = "id",
            label = "Player ID"
        },
        {
            name = "job",
            label = "Job Name"
        },
        {
            name = "grade",
            label = "Grade Number"
        }
    }, true, function(source,args)
        if #args == 3 then
            local Target = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if Target ~= nil then
                local job = QBCore.Shared.Jobs[tostring(args[2])]
                if job ~= nil then
                    if job.grades[tostring(args[3])] then
                        TriggerClientEvent("QBCore:Notify", source, string.format("You added %s to %s\'s multi job list", job.label, Target.PlayerData.charinfo.firstname .. " " .. Target.PlayerData.charinfo.lastname))
                        TriggerClientEvent("QBCore:Notify", Target.PlayerData.source, string.format("%s got added to your multi job list", job.label))
                        exports[GetCurrentResourceName()]:AddJob(Target.PlayerData.citizenid, tostring(args[2]), tonumber(args[3]))
                    else
                        TriggerClientEvent('chat:addMessage', source,  {
                            template = '<strong>Zerio Multijobs:</strong> it looks like the job grade is invalid',
                            args = {}
                        })
                    end
                else
                    TriggerClientEvent('chat:addMessage', source,  {
                        template = '<strong>Zerio Multijobs:</strong> it looks like the job name is invalid',
                        args = {}
                    })
                end
            else
                TriggerClientEvent('chat:addMessage', source,  {
                    template = '<strong>Zerio Multijobs:</strong> it looks like this player doesn\'t exist',
                    args = {}
                })
            end
        else
            TriggerClientEvent('chat:addMessage', source,  {
                template = '<strong>Zerio Multijobs:</strong> it looks like you either passed too many or not enough args',
                args = {}
            })
        end
    end)

    QBCore.Commands.Add("removemultijob", "Remove a players job through the multi job system", {
        {
            name = "id",
            label = "Player ID"
        },
        {
            name = "job",
            label = "Job Name"
        }
    }, true, function(source,args)
        if #args == 2 then
            local Target = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if Target ~= nil then
                local job = QBCore.Shared.Jobs[tostring(args[2])]
                if job ~= nil then
                    TriggerClientEvent("QBCore:Notify", source, string.format("You removed %s from %s\'s multi job list", job.label, Target.PlayerData.charinfo.firstname .. " " .. Target.PlayerData.charinfo.lastname))
                    TriggerClientEvent("QBCore:Notify", Target.PlayerData.source, string.format("%s got removed from your multi job list", job.label))
                    exports[GetCurrentResourceName()]:RemoveJob(Target.PlayerData.citizenid, tostring(args[2]))
                else
                    TriggerClientEvent('chat:addMessage', source,  {
                        template = '<strong>Zerio Multijobs:</strong> it looks like the job name is invalid',
                        args = {}
                    })
                end
            else
                TriggerClientEvent('chat:addMessage', source,  {
                    template = '<strong>Zerio Multijobs:</strong> it looks like this player doesn\'t exist',
                    args = {}
                })
            end
        else
            TriggerClientEvent('chat:addMessage', source,  {
                template = '<strong>Zerio Multijobs:</strong> it looks like you either passed too many or not enough args',
                args = {}
            })
        end
    end)
end)