QBCore = exports['qb-core']:GetCoreObject()

function beforeBuyMarket(source,key,xPlayer)
    -- Here you can do any verification when a player is buying a gas station, like if player has the permission to that or anything else you want to check before buy the gas station. return true or false
    return true
end

function MySQL_Sync_execute(sql,params)
    MySQL.Sync.execute(sql, params)
end

function MySQL_Sync_fetchAll(sql,params)
    return MySQL.Sync.fetchAll(sql, params)
end

function getPlayerName(user_id)
	if user_id then
		local tPlayer = QBCore.Functions.GetPlayerByCitizenId(user_id)
		if tPlayer and tPlayer.PlayerData then
			return tPlayer.PlayerData.charinfo.firstname.." "..tPlayer.PlayerData.charinfo.lastname
		else
			local sql = "SELECT charinfo FROM `players` WHERE citizenid = @user_id";
			local query = MySQL.Sync.fetchAll(sql,{['@user_id'] = user_id});
			if query and query[1] and query[1].charinfo then
				return json.decode(query[1].charinfo).firstname.." "..json.decode(query[1].charinfo).lastname
			end
		end
	end
	return false
end

-- Player ID that will appear on the logs
function GetPlayerIdLog(source)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local user_id = xPlayer.PlayerData.citizenid
	return user_id
end