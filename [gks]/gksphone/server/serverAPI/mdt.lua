
--- QBCORE MDT ----
local GeneratedPlates = {}
local function escape_sqli(teadawdaw)
	local replacements = {
		['"'] = '\\"',
		["'"] = "\\'"
	}
	return teadawdaw:gsub("['\"]", replacements)
end

local function SplitStringToArray(string)
	local retval = {}
	for i in string.gmatch(string, "%S+") do
		retval[#retval + 1] = i
	end
	return retval
end

local function GenerateOwnerName()
	local names = {
		[1] = { name = "Bailey Sykes", citizenid = "DSH091G93" },
		[2] = { name = "Aroush Goodwin", citizenid = "AVH09M193" },
		[3] = { name = "Tom Warren", citizenid = "DVH091T93" },
		[4] = { name = "Abdallah Friedman", citizenid = "GZP091G93" },
		[5] = { name = "Lavinia Powell", citizenid = "DRH09Z193" },
		[6] = { name = "Andrew Delarosa", citizenid = "KGV091J93" },
		[7] = { name = "Skye Cardenas", citizenid = "ODF09S193" },
		[8] = { name = "Amelia-Mae Walter", citizenid = "KSD0919H3" },
		[9] = { name = "Elisha Cote", citizenid = "NDX091D93" },
		[10] = { name = "Janice Rhodes", citizenid = "ZAL0919X3" },
		[11] = { name = "Justin Harris", citizenid = "ZAK09D193" },
		[12] = { name = "Montel Graves", citizenid = "POL09F193" },
		[13] = { name = "Benjamin Zavala", citizenid = "TEW0J9193" },
		[14] = { name = "Mia Willis", citizenid = "YOO09H193" },
		[15] = { name = "Jacques Schmitt", citizenid = "QBC091H93" },
		[16] = { name = "Mert Simmonds", citizenid = "YDN091H93" },
		[17] = { name = "Rickie Browne", citizenid = "PJD09D193" },
		[18] = { name = "Deacon Stanley", citizenid = "RND091D93" },
		[19] = { name = "Daisy Fraser", citizenid = "QWE091A93" },
		[20] = { name = "Kitty Walters", citizenid = "KJH0919M3" },
		[21] = { name = "Jareth Fernandez", citizenid = "ZXC09D193" },
		[22] = { name = "Meredith Calhoun", citizenid = "XYZ0919C3" },
		[23] = { name = "Teagan Mckay", citizenid = "ZYX0919F3" },
		[24] = { name = "Kurt Bain", citizenid = "IOP091O93" },
		[25] = { name = "Burt Kain", citizenid = "PIO091R93" },
		[26] = { name = "Joanna Huff", citizenid = "LEK091X93" },
		[27] = { name = "Carrie-Ann Pineda", citizenid = "ALG091Y93" },
		[28] = { name = "Gracie-Mai Mcghee", citizenid = "YUR09E193" },
		[29] = { name = "Robyn Boone", citizenid = "SOM091W93" },
		[30] = { name = "Aliya William", citizenid = "KAS009193" },
		[31] = { name = "Rohit West", citizenid = "SOK091093" },
		[32] = { name = "Skylar Archer", citizenid = "LOK091093" },
		[33] = { name = "Jake Kumar", citizenid = "AKA420609" },
	}
	return names[math.random(1, #names)]
end

Config.Core.Functions.CreateCallback('gksphone:server:FetchResult', function(source, cb, search)
	local src = source
	local search = escape_sqli(search)
	local searchData = {}
	local ApaData = {}
	local query = 'SELECT * FROM `players` WHERE `citizenid` = "' .. search .. '"'
	-- Split on " " and check each var individual
	local searchParameters = SplitStringToArray(search)
	-- Construct query dynamicly for individual parm check
	if #searchParameters > 1 then
		query = query .. ' OR `charinfo` LIKE "%' .. searchParameters[1] .. '%"'
		for i = 2, #searchParameters do
			query = query .. ' AND `charinfo` LIKE  "%' .. searchParameters[i] .. '%"'
		end
	else
		query = query .. ' OR `charinfo` LIKE "%' .. search .. '%"'
	end
	local ApartmentData = MySQL.Sync.fetchAll('SELECT * FROM apartments', {})
	for k, v in pairs(ApartmentData) do
		ApaData[v.citizenid] = ApartmentData[k]
	end
	local result = MySQL.Sync.fetchAll(query)
	if result[1] ~= nil then
		for k, v in pairs(result) do
			local wanted = MySQL.scalar.await('SELECT id FROM gksphone_wanted WHERE citizenid = ?', { v.citizenid })
			local charinfo = json.decode(v.charinfo)
			local metadata = json.decode(v.metadata)
			local appiepappie = {}
			local durumw = false
			if wanted then
				durumw = true
			end
			if ApaData[v.citizenid] ~= nil and next(ApaData[v.citizenid]) ~= nil then
				appiepappie = ApaData[v.citizenid]
			end
			searchData[#searchData + 1] = {
				citizenid = v.citizenid,
				firstname = charinfo.firstname,
				lastname = charinfo.lastname,
				birthdate = charinfo.birthdate,
				phone = charinfo.phone,
				nationality = charinfo.nationality,
				gender = charinfo.gender,
				warrant = false,
				wanted = durumw,
				driverlicense = metadata["licences"]["driver"],
				appartmentdata = appiepappie
			}
		end
		cb(searchData)
	else
		TriggerClientEvent('gksphone:notifi', src, { title = _U('wanted_title'), message = _U('wanted_noplayer'), img = '/html/static/img/icons/mdt.png' })
		cb(searchData)
	end
end)

Config.Core.Functions.CreateCallback('gksphone:server:ScanPlate', function(source, cb, plate)
	local src = source
	local vehicleData = {}
	if plate ~= nil then
		local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', { plate })
		if result[1] ~= nil then
			local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ?', { result[1].citizenid })
			local charinfo = json.decode(player[1].charinfo)
			vehicleData = {
				plate = plate,
				status = true,
				owner = charinfo.firstname .. " " .. charinfo.lastname,
				citizenid = result[1].citizenid
			}
		elseif GeneratedPlates ~= nil and GeneratedPlates[plate] ~= nil then
			vehicleData = GeneratedPlates[plate]
		else
			local ownerInfo = GenerateOwnerName()
			GeneratedPlates[plate] = {
				plate = plate,
				status = true,
				owner = ownerInfo.name,
				citizenid = ownerInfo.citizenid
			}
			vehicleData = {
				plate = plate,
				status = true,
				owner = ownerInfo.name,
				citizenid = ownerInfo.citizenid
			}
		end
		cb(vehicleData)
	else
		TriggerClientEvent('gksphone:notifi', src, { title = _U('wanted_title'), message = _U('wanted_novehicle'), img = '/html/static/img/icons/mdt.png' })
		cb(vehicleData)
	end
end)

Config.Core.Functions.CreateCallback('gksphone:server:GetVehicleSearchResults', function(source, cb, search)
	local src = source
	local search = escape_sqli(search)
	local searchData = {}
	local query = '%' .. search .. '%'
	local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE plate LIKE ? OR citizenid = ?',
		{ query, search })
	if result[1] ~= nil then
		for k, v in pairs(result) do
			local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ?', { result[k].citizenid })
			if player[1] ~= nil then
				local charinfo = json.decode(player[1].charinfo)
				local vehicleInfo = Config.Core.Shared.Vehicles[result[k].vehicle]
				if vehicleInfo ~= nil then
					searchData[#searchData + 1] = {
						plate = result[k].plate,
						status = true,
						owner = charinfo.firstname .. " " .. charinfo.lastname,
						citizenid = result[k].citizenid,
						label = vehicleInfo["name"]
					}
				else
					searchData[#searchData + 1] = {
						plate = result[k].plate,
						status = true,
						owner = charinfo.firstname .. " " .. charinfo.lastname,
						citizenid = result[k].citizenid,
						label = "Name not found.."
					}
				end
			end
		end
	else
		if GeneratedPlates[search] ~= nil then
			searchData[#searchData + 1] = {
				plate = GeneratedPlates[search].plate,
				status = GeneratedPlates[search].status,
				owner = GeneratedPlates[search].owner,
				citizenid = GeneratedPlates[search].citizenid,
				label = "Brand unknown.."
			}
		else
			local ownerInfo = GenerateOwnerName()
			GeneratedPlates[search] = {
				plate = search,
				status = true,
				owner = ownerInfo.name,
				citizenid = ownerInfo.citizenid
			}
			searchData[#searchData + 1] = {
				plate = search,
				status = true,
				owner = ownerInfo.name,
				citizenid = ownerInfo.citizenid,
				label = "Brand unknown.."
			}
		end
	end
	cb(searchData)
end)

RegisterNetEvent('gksphone:server:wantedekle', function(cid, wreason, wappear, wlastsn)
	local src = source
	local yPlayer = Config.Core.Functions.GetPlayerByCitizenId(cid)
	if yPlayer then
		local wanted = MySQL.scalar.await('SELECT id FROM gksphone_wanted WHERE citizenid = ?', { cid })
		if wanted then
			TriggerClientEvent('gksphone:notifi', src, { title = _U('wanted_title'), message = _U('wanted_error'), img = '/html/static/img/icons/mdt.png' })
		else
			local fullname = yPlayer.PlayerData.charinfo.firstname .. ' ' .. yPlayer.PlayerData.charinfo.lastname
			MySQL.Async.insert("INSERT INTO gksphone_wanted (citizenid, fullname, reason, appearance, lastseen) VALUES (@citizenid, @fullname, @reason, @appearance, @lastseen)", {
				["@citizenid"] = cid,
				["@fullname"] = fullname,
				["@reason"] = wreason,
				["@appearance"] = wappear,
				["@lastseen"] = wlastsn
			})
		end
	end
end)

Config.Core.Functions.CreateCallback('gksphone:server:wantedveri', function(source, cb)
	local src = source

	local result = MySQL.Sync.fetchAll('SELECT * FROM gksphone_wanted ORDER BY `time` DESC', {})
	cb(result)

end)

RegisterNetEvent('gksphone:server:wantedelete', function(id)
	local src = source
	MySQL.Async.execute('DELETE FROM gksphone_wanted WHERE id = @id', {
		['@id'] = id
	}, function()

		SetTimeout(200, function()
			local result = MySQL.Sync.fetchAll('SELECT * FROM gksphone_wanted ORDER BY `time` DESC', {})
			TriggerClientEvent('gksphone:client:wantedyenile', src, result)
		end)

	end)
end)