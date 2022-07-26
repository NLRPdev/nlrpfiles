-------------------------------
---------- CASE#2506 ----------
-------------------------------


--<!>-- DO NOT CHANGE ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local TargetName = Config.CoreSettings.TargetName
local MenuName = Config.CoreSettings.MenuName
local ItemCheckEvent = Config.CoreSettings.ItemCheckEvent
local RemoveItemEvent = Config.CoreSettings.RemoveItemEvent
local AddItemEvent = Config.CoreSettings.AddItemEvent
local RemoveStress = Config.CoreSettings.RemoveStressEvent


--<!>-- USE SEEDS CODE START --<!>--
-- Plant seeds
Core.Functions.CreateUseableItem("weed_skunk_seed", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('weed_pot') ~= nil then
    item = Player.Functions.GetItemByName('weed_pot').amount
    TriggerClientEvent('boii-outdoorweed:client:SeedPlanted', source, 'skunk')
    Player.Functions.RemoveItem('weed_skunk_seed', 1)
	Player.Functions.RemoveItem('weed_pot', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_skunk_seed'], "remove")
	TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_pot'], "remove")
	else
		TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['nopot'], 'error')
	end
end)
Core.Functions.CreateUseableItem("weed_og-kush_seed", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('weed_pot') ~= nil then
    item = Player.Functions.GetItemByName('weed_pot').amount
    TriggerClientEvent('boii-outdoorweed:client:SeedPlanted', source, 'og-kush')
    Player.Functions.RemoveItem('weed_og-kush_seed', 1)
	Player.Functions.RemoveItem('weed_pot', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_og-kush_seed'], "remove")
	TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_pot'], "remove")
	else
		TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['nopot'], 'error')
	end
end)
Core.Functions.CreateUseableItem("weed_white-widow_seed", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('weed_pot') ~= nil then
    item = Player.Functions.GetItemByName('weed_pot').amount
    TriggerClientEvent('boii-outdoorweed:client:SeedPlanted', source, 'white-widow')
    Player.Functions.RemoveItem('weed_white-widow_seed', 1)
	Player.Functions.RemoveItem('weed_pot', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_white-widow_seed'], "remove")
	TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_pot'], "remove")
	else
    TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['nopot'], 'error')
	end
end)
Core.Functions.CreateUseableItem("weed_ak47_seed", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('weed_pot') ~= nil then
    item = Player.Functions.GetItemByName('weed_pot').amount
    TriggerClientEvent('boii-outdoorweed:client:SeedPlanted', source, 'ak47')
    Player.Functions.RemoveItem('weed_ak47_seed', 1)
	Player.Functions.RemoveItem('weed_pot', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_ak47_seed'], "remove")
	TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_pot'], "remove")
	else
    TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['nopot'], 'error')
	end
end)
Core.Functions.CreateUseableItem("weed_amnesia_seed", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('weed_pot') ~= nil then
    item = Player.Functions.GetItemByName('weed_pot').amount
    TriggerClientEvent('boii-outdoorweed:client:SeedPlanted', source, 'amnesia')
    Player.Functions.RemoveItem('weed_amnesia_seed', 1)
	Player.Functions.RemoveItem('weed_pot', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_amnesia_seed'], "remove")
	TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_pot'], "remove")
	else
    TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['nopot'], 'error')
	end
end)
Core.Functions.CreateUseableItem("weed_purple-haze_seed", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('weed_pot') ~= nil then
    item = Player.Functions.GetItemByName('weed_pot').amount
    TriggerClientEvent('boii-outdoorweed:client:SeedPlanted', source, 'purple-haze')
    Player.Functions.RemoveItem('weed_purple-haze_seed', 1)
	Player.Functions.RemoveItem('weed_pot', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_purple-haze_seed'], "remove")
	TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_pot'], "remove")
	else
    TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['nopot'], 'error')
	end
end)
--<!>-- USE SEEDS CODE END --<!>--

--<!>-- USE JOINTS CODE START --<!>--
-- Use joints
Core.Functions.CreateUseableItem("weed_skunk_joint", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("boii-outdoorweed:client:UseSkunkJoint", source)
    end
end)
Core.Functions.CreateUseableItem("weed_og-kush_joint", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("boii-outdoorweed:client:UseKushJoint", source)
    end
end)
Core.Functions.CreateUseableItem("weed_white-widow_joint", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("boii-outdoorweed:client:UseWidowJoint", source)
    end
end)
Core.Functions.CreateUseableItem("weed_ak47_joint", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("boii-outdoorweed:client:UseAK47Joint", source)
    end
end)
Core.Functions.CreateUseableItem("weed_amnesia_joint", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("boii-outdoorweed:client:UseAmnesiaJoint", source)
    end
end)
Core.Functions.CreateUseableItem("weed_purple-haze_joint", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("boii-outdoorweed:client:UsePurpleJoint", source)
    end
end)
--<!>-- USE JOINTS CODE START --<!>--

--<!>-- TRIM WEED CODE START --<!>--
RegisterServerEvent('boii-outdoorweed:server:TrimWeed', function(args) 
	local source = source
    local Player = Core.Functions.GetPlayer(source)
	local args = tonumber(args)
    local weedAmount = 3
	local baggieAmount = math.random(10,14)
    if args == 1 then 
        local weedbag = Player.Functions.GetItemByName("weed_skunk_crop") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("empty_weed_bag") 
                if papers ~= nil then
                    if papers.amount >= baggieAmount then
						Player.Functions.RemoveItem("weed_skunk_crop", weedAmount)
						Player.Functions.RemoveItem("empty_weed_bag", baggieAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_skunk_crop'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['empty_weed_bag'], "remove", baggieAmount)
						TriggerClientEvent('boii-outdoorweed:client:TrimSkunk', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughbaggies'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anybaggies'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughskunkcrop'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anyskunkcrop'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
		end
	elseif args == 2 then 
        local weedbag = Player.Functions.GetItemByName("weed_og-kush_crop") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("empty_weed_bag") 
                if papers ~= nil then
                    if papers.amount >= baggieAmount then
						Player.Functions.RemoveItem("weed_og-kush_crop", weedAmount)
						Player.Functions.RemoveItem("empty_weed_bag", baggieAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_og-kush_crop'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['empty_weed_bag'], "remove", baggieAmount)
						TriggerClientEvent('boii-outdoorweed:client:TrimKush', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughbaggies'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anybaggies'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughkushcrop'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anykushcrop'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
		end
	elseif args == 3 then 
        local weedbag = Player.Functions.GetItemByName("weed_white-widow_crop") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("empty_weed_bag") 
                if papers ~= nil then
                    if papers.amount >= baggieAmount then
						Player.Functions.RemoveItem("weed_white-widow_crop", weedAmount)
						Player.Functions.RemoveItem("empty_weed_bag", baggieAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_white-widow_crop'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['empty_weed_bag'], "remove", baggieAmount)
						TriggerClientEvent('boii-outdoorweed:client:TrimWidow', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughbaggies'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anybaggies'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughwidowcrop'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anywidowcrop'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
		end
    elseif args == 4 then 
        local weedbag = Player.Functions.GetItemByName("weed_ak47_crop") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("empty_weed_bag") 
                if papers ~= nil then
                    if papers.amount >= baggieAmount then
						Player.Functions.RemoveItem("weed_ak47_crop", weedAmount)
						Player.Functions.RemoveItem("empty_weed_bag", baggieAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_ak47_crop'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['empty_weed_bag'], "remove", baggieAmount)
						TriggerClientEvent('boii-outdoorweed:client:TrimAK47', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughbaggies'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anybaggies'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughak47crop'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anyak47crop'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
		end
    elseif args == 5 then 
        local weedbag = Player.Functions.GetItemByName("weed_amnesia_crop") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("empty_weed_bag") 
                if papers ~= nil then
                    if papers.amount >= baggieAmount then
						Player.Functions.RemoveItem("weed_amnesia_crop", weedAmount)
						Player.Functions.RemoveItem("empty_weed_bag", baggieAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_amnesia_crop'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['empty_weed_bag'], "remove", baggieAmount)
						TriggerClientEvent('boii-outdoorweed:client:TrimAmnesia', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughbaggies'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anybaggies'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughamnesiacrop'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anyamnesiacrop'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
		end
    elseif args == 6 then 
        local weedbag = Player.Functions.GetItemByName("weed_purple-haze_crop") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("empty_weed_bag") 
                if papers ~= nil then
                    if papers.amount >= baggieAmount then
						Player.Functions.RemoveItem("weed_purple-haze_crop", weedAmount)
						Player.Functions.RemoveItem("empty_weed_bag", baggieAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_purple-haze_crop'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['empty_weed_bag'], "remove", baggieAmount)
						TriggerClientEvent('boii-outdoorweed:client:TrimPurple', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughbaggies'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anybaggies'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anypurplecrop'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anypurplecrop'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
		end				
	end
end)
--<!>-- TRIM WEED CODE END --<!>--

--<!>-- ROLL JOINTS CODE START --<!>--
RegisterServerEvent('boii-outdoorweed:server:RollJoints', function(args) 
	local source = source
    local Player = Core.Functions.GetPlayer(source)
	local args = tonumber(args)
    local weedAmount = 1
	local papersAmount = 2
    if args == 1 then 
        local weedbag = Player.Functions.GetItemByName("weed_skunk") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("rolling_paper") 
                if papers ~= nil then
                    if papers.amount >= papersAmount then
						Player.Functions.RemoveItem("weed_skunk", weedAmount)
						Player.Functions.RemoveItem("rolling_paper", papersAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_skunk'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['rolling_paper'], "remove", papersAmount)
						TriggerClientEvent('boii-outdoorweed:client:RollSkunk', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughpapers'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:RollJointsMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anypapers'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:RollJointsMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughskunk'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:RollJointsMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anyskunk'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:RollJointsMenu', source)
		end
	elseif args == 2 then 
        local weedbag = Player.Functions.GetItemByName("weed_og-kush") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("rolling_paper") 
                if papers ~= nil then
                    if papers.amount >= papersAmount then
						Player.Functions.RemoveItem("weed_og-kush", weedAmount)
						Player.Functions.RemoveItem("rolling_paper", papersAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_og-kush'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['rolling_paper'], "remove", papersAmount)
						TriggerClientEvent('boii-outdoorweed:client:RollKush', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughpapers'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anypapers'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughkush'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anykush'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
		end
	elseif args == 3 then 
        local weedbag = Player.Functions.GetItemByName("weed_white-widow") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("rolling_paper") 
                if papers ~= nil then
                    if papers.amount >= papersAmount then
						Player.Functions.RemoveItem("weed_white-widow", weedAmount)
						Player.Functions.RemoveItem("rolling_paper", papersAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_white-widow'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['rolling_paper'], "remove", papersAmount)
						TriggerClientEvent('boii-outdoorweed:client:RollWidow', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughpapers'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anypapers'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughwidow'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anywidow'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
		end
    elseif args == 4 then 
        local weedbag = Player.Functions.GetItemByName("weed_ak47") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("rolling_paper") 
                if papers ~= nil then
                    if papers.amount >= papersAmount then
						Player.Functions.RemoveItem("weed_ak47", weedAmount)
						Player.Functions.RemoveItem("rolling_paper", papersAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_ak47'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['rolling_paper'], "remove", papersAmount)
						TriggerClientEvent('boii-outdoorweed:client:RollAK47', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughpapers'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anypapers'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughak47'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anyak47'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
		end
    elseif args == 5 then 
        local weedbag = Player.Functions.GetItemByName("weed_amnesia") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("rolling_paper") 
                if papers ~= nil then
                    if papers.amount >= papersAmount then
						Player.Functions.RemoveItem("weed_amnesia", weedAmount)
						Player.Functions.RemoveItem("rolling_paper", papersAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_amnesia'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['rolling_paper'], "remove", papersAmount)
						TriggerClientEvent('boii-outdoorweed:client:RollAmnesia', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughpapers'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anypapers'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughamnesia'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anyamnesia'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
		end
    elseif args == 6 then 
        local weedbag = Player.Functions.GetItemByName("weed_purple-haze") 
        if weedbag ~= nil then
            if weedbag.amount >= weedAmount then
                local papers = Player.Functions.GetItemByName("rolling_paper") 
                if papers ~= nil then
                    if papers.amount >= papersAmount then
						Player.Functions.RemoveItem("weed_purple-haze", weedAmount)
						Player.Functions.RemoveItem("rolling_paper", papersAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_purple-haze'], "remove", weedAmount)
						TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['rolling_paper'], "remove", papersAmount)
						TriggerClientEvent('boii-outdoorweed:client:RollPurple', source)
					else
						TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughpapers'], 'error')
						TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
					end
				else
					TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anypapers'], 'error')
					TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
				end
			else
				TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['enoughpurple'], 'error')
				TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
			end
		else
			TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anypurple'], 'error')
			TriggerClientEvent('boii-outdoorweed:client:JointsMenu', source)
		end				
	end
end)
--<!>-- ROLL JOINTS CODE END --<!>--

--<!>-- SELL BAGS TO STORE CODE START --<!>--
-- Sell bags to store
RegisterServerEvent('boii-outdoorweed:server:SellBags', function(args) 
	local source = source
    local Player = Core.Functions.GetPlayer(source)
	local args = tonumber(args)
	if args == 1 then 
		if Player.Functions.GetItemByName('weed_skunk') ~= nil then
            item = Player.Functions.GetItemByName('weed_skunk').amount
            pay = (item * Config.WeedShopPrice['weed_skunk'])
            Player.Functions.RemoveItem("weed_skunk", item)
            Player.Functions.AddMoney('cash', pay)			
			TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items["weed_skunk"], 'remove', item)
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		else
		    TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anyskunk'], 'error')
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		end
	elseif args == 2 then 
		if Player.Functions.GetItemByName('weed_og-kush') ~= nil then
            item = Player.Functions.GetItemByName('weed_og-kush').amount
            pay = (item * Config.WeedShopPrice['weed_og-kush'])
            Player.Functions.RemoveItem("weed_og-kush", item)
            Player.Functions.AddMoney('cash', pay)
			TriggerClientEvent('Core:Notify', source, "You sold some OG Kush for $"..pay, "success")
			TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_og-kush'], "remove", 1)
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		else
		    TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anykush'], 'error')
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		end	
	elseif args == 3 then
		if Player.Functions.GetItemByName('weed_white-widow') ~= nil then
            item = Player.Functions.GetItemByName('weed_white-widow').amount
            pay = (item * Config.WeedShopPrice['weed_white-widow'])
            Player.Functions.RemoveItem("weed_white-widow", item)
            Player.Functions.AddMoney('cash', pay)
			TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_white-widow'], "remove", 1)
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		else
		    TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anywidow'], 'error')
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		end
	elseif args == 4 then
		if Player.Functions.GetItemByName('weed_ak47') ~= nil then
            item = Player.Functions.GetItemByName('weed_ak47').amount
            pay = (item * Config.WeedShopPrice['weed_ak47'])
            Player.Functions.RemoveItem("weed_ak47", item)
            Player.Functions.AddMoney('cash', pay)
			TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_ak47'], "remove", 1)
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		else
		    TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anyak47'], 'error')
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		end
	elseif args == 5 then
		if Player.Functions.GetItemByName('weed_amnesia') ~= nil then
            item = Player.Functions.GetItemByName('weed_amnesia').amount
            pay = (item * Config.WeedShopPrice['weed_amnesia'])
            Player.Functions.RemoveItem("weed_amnesia", item)
            Player.Functions.AddMoney('cash', pay)
			TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_amnesia'], "remove", 1)
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		else
		    TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anyamnesia'], 'error')
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		end
	elseif args == 6 then
		if Player.Functions.GetItemByName('weed_purple-haze') ~= nil then
            item = Player.Functions.GetItemByName('weed_purple-haze').amount
            pay = (item * Config.WeedShopPrice['weed_purple-haze'])
            Player.Functions.RemoveItem("weed_purple-haze", item)
            Player.Functions.AddMoney('cash', pay)
			TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['weed_purple-haze'], "remove", 1)
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		else
			
		    TriggerClientEvent('boii-outdoorweed:notifications', source, Config.Lang['anypurple'], 'error')
            TriggerClientEvent('boii-outdoorweed:client:SellingMenu', source)
		end
	end
end)
--<!>-- SELL BAGS TO STORE CODE END --<!>--

--<!>-- TRIMMING SHEARS CODE START --<!>--
-- Trimming shears
Core.Functions.CreateUseableItem("drug_shears", function(source, item)
    local Player = Core.Functions.GetPlayer(source)
    local scaleCheck = Player.Functions.GetItemByName('drug_scales')
    if scaleCheck ~= nil then
        TriggerClientEvent('boii-outdoorweed:client:TrimmingMenu', source)
    else
		TriggerClientEvent('boii-outdoorweed:notifications', source, "You dont have a scale", 'error')
    end
end)
--<!>-- TRIMMING SHEARS CODE START --<!>--


-- Harvest plants
RegisterServerEvent('boii-outdoorweed:server:PlantHarvested')
AddEventHandler('boii-outdoorweed:server:PlantHarvested', function(plantId)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            v.beingHarvested = true
        end
    end
    TriggerEvent('boii-outdoorweed:server:UpdatePlants')
end)

--<!>-- GRINDER CODE START --<!>--
Core.Functions.CreateUseableItem("drug_grinder", function(source, item)
    local source = source
    local Player = Core.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("boii-outdoorweed:client:RollJointsMenu", source)
    end
end)
--<!>-- GRINDER CODE END --<!>--
