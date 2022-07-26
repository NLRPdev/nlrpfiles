local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	for k, v in pairs(Config.Machines_QBTARGET['Washing Machines']) do
		Wait(100)
		exports['qb-target']:AddBoxZone("Money Wash #"..k, v.location, v.depth, v.width, {
			name = "Money Wash #"..k,
			heading = v.heading,
			debugPoly = false,
			minZ = v.minZ,
			maxZ = v.maxZ,
		}, {
			options = {
				{
					type = "client",
					event = "rebel-moneywash:client:openMoneyWashMenu",
					icon = "fas fa-sign-in-alt",
					label = "Wash Money",
						
					-- Information --
					machine = "Money Wash #"..k 
				},
			},
			distance = 1.0
		})
	end
	
	for k, v in pairs(Config.Machines_QBTARGET['Dryers']) do
		Wait(100)
		exports['qb-target']:AddBoxZone("Dryer #"..k, v.location, v.depth, v.width, {
			name = "Dryer #"..k,
			heading = v.heading,
			debugPoly = false,
			minZ = v.minZ,
			maxZ = v.maxZ,
		}, {
			options = {
				{
					type = "client",
					event = "rebel-moneywash:client:openDryMoneyMenu",
					icon = "fas fa-sign-in-alt",
					label = "Dry Money",
						
					-- Information --
					machine = "Dryer #"..k 
				},
			},
			distance = 1.0
		})
	end
end)

RegisterNetEvent('rebel-moneywash:client:openMoneyWashMenu', function(args)
    local Player = QBCore.Functions.GetPlayerData()

	local MoneyWashExperience = Player.metadata.moneywashrep
	local highestvalue = 0
	local level = nil
	
	local cangrabmoney = nil
    local canwashmoney = nil

    local AvailableMoney = nil
	local AvailableMoneyText = nil

	local WashMoneyText = nil

    local WashMoneyLocked = true
    local GrabMoneyLocked = true

	local Currently_Washing = false

    QBCore.Functions.TriggerCallback("rebel-moneywash:server:GetAvailableMoney", function(result)
        if result ~= nil then
			if result.amount ~= nil then
				if result.time_left == 0 then
					AvailableMoneyText = "Available Cash: $"..result.amount
					AvailableMoney = result.amount
					cangrabmoney = true
					Currently_Washing = true
				else
					AvailableMoneyText = "Currently Washing $"..result.amount.."<br><br>Time left: "..result.time_left.." seconds"
					AvailableMoney = 0
					cangrabmoney = false
					Currently_Washing = true
				end
				QBCore.Functions.TriggerCallback("rebel-moneywash:server:GetWashableItems", function(result)
                    if result ~= nil then
                        canwashmoney = true
                    else
                        canwashmoney = false
                    end
                end)
			end
		else
            QBCore.Functions.TriggerCallback("rebel-moneywash:server:GetWashableItems", function(result)
                if result ~= nil then
                    canwashmoney = true
                else
                    canwashmoney = false
                end
            end)
			AvailableMoneyText = "There is no available cash in here"
			cangrabmoney = false
		end
	end, args.machine, 'Wash')

    repeat
        Wait(10)
    until (cangrabmoney ~= nil) and (canwashmoney ~= nil)

    if cangrabmoney then
        GrabMoneyLocked = false
    else
        GrabMoneyLocked = true
    end

    if canwashmoney then
		if not Currently_Washing then
			WashMoneyText = "View all washable items..."
        	WashMoneyLocked = false
		else
			WashMoneyText = "This machine is already in use..."
			WashMoneyLocked = true
		end
    else
		WashMoneyText = "You don't have any washable items..."
        WashMoneyLocked = true
    end

	for k,v in pairs(Config.MoneyDestructionRate) do
		if MoneyWashExperience >= k then
			if tonumber(k) >= highestvalue then
				highestvalue = tonumber(k)
				level = v
			end
		end
	end

    exports['qb-menu']:openMenu({
		{
			header = args.machine,
			txt = "Experience level: "..level.level,
			isMenuHeader = true, -- Set to true to make a nonclickable title
		},
		{
			header = "Wash Money",
			isMenuHeader = WashMoneyLocked, -- Set to true to make a nonclickable title
            txt = WashMoneyText,
			params = {
				event = "rebel-moneywash:client:openWashableItemsMenu",
				args = {
					machine = args.machine
				}
			}
		},
		{
			header = "Grab Wet Money",
			isMenuHeader = GrabMoneyLocked, -- Set to true to make a nonclickable title
			txt = AvailableMoneyText,
			params = {
				event = "rebel-moneywash:client:GrabWetMoney",
				args = {
					machine = args.machine,
					wetmoney = AvailableMoney
				}
			}
		},
		{
			header = "Close",
			params = {
				event = "qb-menu:closeMenu"
			}
		}
	})
end)

RegisterNetEvent('rebel-moneywash:client:openWashableItemsMenu', function(args)
	local Player = QBCore.Functions.GetPlayerData()

	local MoneyWashExperience = Player.metadata.moneywashrep
	local highestvalue = 0
	local level = nil

	local WashableItemsMenu = {}
	local washable_items = nil

	for k,v in pairs(Config.MoneyDestructionRate) do
		if MoneyWashExperience >= k then
			if tonumber(k) >= highestvalue then
				highestvalue = tonumber(k)
				level = v
			end
		end
	end

	QBCore.Functions.TriggerCallback("rebel-moneywash:server:GetWashableItems", function(result)
		if result ~= nil then
			washable_items = result
		else
			washable_items = false
		end
	end)

	repeat Wait(10) until washable_items ~= nil

	table.insert(WashableItemsMenu, {
		header = "Washable Items",
		txt = "Select an item that you want to wash...<br><br>About "..level.mdr.."% of the money will be destroyed in the process",
		isMenuHeader = true
	})

	local a, b = nil, nil

	function compare(a,b)
		a = a.info[Config.Washable_Items[a.name]]
		b = b.info[Config.Washable_Items[b.name]]

		repeat
			
		until (a ~= nil) and (b ~= nil)

		return a > b
	end

	table.sort(washable_items, compare)

	for k,v in ipairs(washable_items) do
		table.insert(WashableItemsMenu, {
			header = QBCore.Shared.Items[v.name]['label'],
			txt = "Amount: $"..v.info[Config.Washable_Items[v.name]],
			params = {
				event = "rebel-moneywash:client:openWashMoneyMenu",
				args = {
					oldargs = args,
					item = v
				}
			}
		})
	end

	table.insert(WashableItemsMenu, {
		header = "<-- Back",
		txt = "",
		params = {
			event = 'rebel-moneywash:client:openMoneyWashMenu',
			args = args
		}
	})

	exports['qb-menu']:openMenu(WashableItemsMenu) 
end)

RegisterNetEvent('rebel-moneywash:client:openWashMoneyMenu', function(args)
	local Player = QBCore.Functions.GetPlayerData()

	local MoneyWashExperience = Player.metadata.moneywashrep
	local highestvalue = 0
	local level = nil

	local value = args.item.info[Config.Washable_Items[args.item.name]]

	for k,v in pairs(Config.MoneyDestructionRate) do
		if MoneyWashExperience >= k then
			if tonumber(k) >= highestvalue then
				highestvalue = tonumber(k)
				level = v
			end
		end
	end

	exports['qb-menu']:openMenu({
		{
			header = "Do you wish to wash $"..value,
			isMenuHeader = true, -- Set to true to make a nonclickable title
		},
		{
			header = "Wash Money",
			txt = "<br>Estimated wash time: "..(value/100 * Config.Wash_Time).." seconds<br><br>Estimated Clean Cash: $"..(value/100)*(100 - level.mdr),
			params = {
				event = "rebel-moneywash:client:startMoneyWash",
				args = {
					item = args.item,
					item_worth = (value/100)*(100 - level.mdr),
					washtime = (value/100 * Config.Wash_Time),
					args = args
				}
			}
		},
		{
			header = "<-- Back",
			params = {
				event = "rebel-moneywash:client:openWashableItemsMenu",
				args = args.oldargs
			}
		}
	})
end)

RegisterNetEvent('rebel-moneywash:client:startMoneyWash', function(args)
	Has_Item = false

	QBCore.Functions.TriggerCallback("rebel-moneywash:server:GetWashableItems", function(result)
		if result ~= nil then
			for k,v in pairs(result) do
				if (v.name == args.item.name) and (v.slot == args.item.slot) and (v.info[Config.Washable_Items[v.name]] == args.item.info[Config.Washable_Items[args.item.name]]) then
					TriggerServerEvent("rebel-moneywash:server:WashMoney", args)
					Has_Item = true
				end
			end
		end
	end)

	Wait(100)
	if not Has_Item then
		QBCore.Functions.Notify('Looks like the item you tried to wash is missing...', 'error', 3000)
	end
end)

RegisterNetEvent('rebel-moneywash:client:GrabWetMoney', function(args)
	TriggerServerEvent("rebel-moneywash:server:GrabWetMoney", args)
end)

-- Dry money
RegisterNetEvent('rebel-moneywash:client:openDryMoneyMenu', function(args)
    local Player = QBCore.Functions.GetPlayerData()

	local MoneyWashExperience = Player.metadata.moneywashrep
	local highestvalue = 0
	local level = nil
	
	local cangrabmoney = nil
    local candrymoney = nil

    local AvailableMoney = nil
	local AvailableMoneyText = nil

	local DryMoneyText = nil

    local DryMoneyLocked = true
    local GrabMoneyLocked = true

	local Currently_Drying = false

    QBCore.Functions.TriggerCallback("rebel-moneywash:server:GetAvailableMoney", function(result)
        if result ~= nil then
			if result.amount ~= nil then
				if result.time_left == 0 then
					AvailableMoneyText = "Available Cash: $"..result.amount
					AvailableMoney = result.amount
					cangrabmoney = true
					Currently_Drying = true
				else
					AvailableMoneyText = "Currently Washing $"..result.amount.."<br><br>Time left: "..result.time_left.." seconds"
					AvailableMoney = 0
					cangrabmoney = false
					Currently_Drying = true
				end
				QBCore.Functions.TriggerCallback("rebel-moneywash:server:GetDryableItems", function(result)
                    if result ~= nil then
                        candrymoney = true
                    else
                        candrymoney = false
                    end
                end)
			end
		else
            QBCore.Functions.TriggerCallback("rebel-moneywash:server:GetDryableItems", function(result)
                if result ~= nil then
                    candrymoney = true
                else
                    candrymoney = false
                end
            end)
			AvailableMoneyText = "There is no available cash in here"
			cangrabmoney = false
		end
	end, args.machine, 'Dry')

    repeat
        Wait(10)
    until (cangrabmoney ~= nil) and (candrymoney ~= nil)

    if cangrabmoney then
        GrabMoneyLocked = false
    else
        GrabMoneyLocked = true
    end

    if candrymoney then
		if not Currently_Drying then
			DryMoneyText = "View all dryable items..."
        	DryMoneyLocked = false
		else
			DryMoneyText = "This machine is already in use..."
			DryMoneyLocked = true
		end
    else
		DryMoneyText = "You don't have any dryable items..."
        DryMoneyLocked = true
    end

	for k,v in pairs(Config.MoneyDestructionRate) do
		if MoneyWashExperience >= k then
			if tonumber(k) >= highestvalue then
				highestvalue = tonumber(k)
				level = v
			end
		end
	end

    exports['qb-menu']:openMenu({
		{
			header = args.machine,
			txt = "Experience level: "..level.level,
			isMenuHeader = true, -- Set to true to make a nonclickable title
		},
		{
			header = "Dry Money",
			isMenuHeader = DryMoneyLocked, -- Set to true to make a nonclickable title
            txt = DryMoneyText,
			params = {
				event = "rebel-moneywash:client:openDryableItemsMenu",
				args = {
					machine = args.machine
				}
			}
		},
		{
			header = "Grab Dry Money",
			isMenuHeader = GrabMoneyLocked, -- Set to true to make a nonclickable title
			txt = AvailableMoneyText,
			params = {
				event = "rebel-moneywash:client:GrabDryMoney",
				args = {
					machine = args.machine,
					drymoney = AvailableMoney
				}
			}
		},
		{
			header = "Close",
			params = {
				event = "qb-menu:closeMenu"
			}
		}
	})
end)

RegisterNetEvent('rebel-moneywash:client:openDryableItemsMenu', function(args)
	local Player = QBCore.Functions.GetPlayerData()

	local MoneyWashExperience = Player.metadata.moneywashrep
	local highestvalue = 0
	local level = nil

	local DryableItemsMenu = {}
	local dryable_items = nil

	for k,v in pairs(Config.MoneyDestructionRate) do
		if MoneyWashExperience >= k then
			if tonumber(k) >= highestvalue then
				highestvalue = tonumber(k)
				level = v
			end
		end
	end

	QBCore.Functions.TriggerCallback("rebel-moneywash:server:GetDryableItems", function(result)
		if result ~= nil then
			dryable_items = result
		else
			dryable_items = false
		end
	end)

	repeat Wait(10) until dryable_items ~= nil

	table.insert(DryableItemsMenu, {
		header = "Dryable Items",
		txt = "Select an item that you want to dry...",
		isMenuHeader = true
	})

	local a, b = nil, nil

	function compare(a,b)
		a = a.info.worth
		b = b.info.worth

		repeat
			
		until (a ~= nil) and (b ~= nil)

		return a > b
	end

	table.sort(dryable_items, compare)

	for k,v in ipairs(dryable_items) do
		table.insert(DryableItemsMenu, {
			header = QBCore.Shared.Items[v.name]['label'],
			txt = "Amount: $"..v.info.worth,
			params = {
				event = "rebel-moneywash:client:openDryMoneyMenu2",
				args = {
					oldargs = args,
					item = v
				}
			}
		})
	end

	table.insert(DryableItemsMenu, {
		header = "<-- Back",
		txt = "",
		params = {
			event = 'rebel-moneywash:client:openDryMoneyMenu',
			args = args
		}
	})

	exports['qb-menu']:openMenu(DryableItemsMenu) 
end)

RegisterNetEvent('rebel-moneywash:client:openDryMoneyMenu2', function(args)
	exports['qb-menu']:openMenu({
		{
			header = "Do you wish to dry $"..args.item.info.worth,
			isMenuHeader = true, -- Set to true to make a nonclickable title
		},
		{
			header = "Dry Money",
			txt = "<br>Estimated dry time: "..(args.item.info.worth/100 * Config.Wash_Time).."<br><br>You will receive: $"..args.item.info.worth,
			params = {
				event = "rebel-moneywash:client:startDryMoney",
				args = {
					item = args.item,
					item_worth = args.item.info.worth,
					drytime = (args.item.info.worth/100 * Config.Wash_Time),
					args = args
				}
			}
		},
		{
			header = "<-- Back",
			params = {
				event = "rebel-moneywash:client:openDryableItemsMenu",
				args = args.oldargs
			}
		}
	})
end)

RegisterNetEvent('rebel-moneywash:client:startDryMoney', function(args)
	Has_Item = false

	QBCore.Functions.TriggerCallback("rebel-moneywash:server:GetDryableItems", function(result)
		if result ~= nil then
			for k,v in pairs(result) do
				if (v.name == args.item.name) and (v.slot == args.item.slot) and (v.info.worth == args.item.info.worth) then
					TriggerServerEvent("rebel-moneywash:server:DryMoney", args)
					Has_Item = true
				end
			end
		end
	end)

	Wait(100)
	if not Has_Item then
		QBCore.Functions.Notify('Looks like the item you tried to dry is missing...', 'error', 3000)
	end
end)

RegisterNetEvent('rebel-moneywash:client:GrabDryMoney', function(args)
	TriggerServerEvent("rebel-moneywash:server:GrabDryMoney", args)
end)