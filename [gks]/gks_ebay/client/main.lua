--================================================================================================
--==            --    XenKnighT --        https://discord.gg/XUck63E                            ==
--================================================================================================

local meth_dealer_seller = nil
local ebaymenu = MenuV:CreateMenu(false, Config.APPName..' Menu', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv')
local ebaymenu3 = MenuV:CreateMenu(false, Config.Products, 'topright', 155, 0, 0, 'size-125', 'none', 'menuv')


local ebaymenu_button = ebaymenu:AddButton({
    icon = '📋',
    label = Config.Products,
    value = ebaymenu3,
    description = Config.Menu1Descript
})
local ebaymenu_button2 = ebaymenu:AddButton({
    icon = '📋',
    label = Config.Menu2Label,
    value = ebaymenu3,
    description = Config.Menu2Descript
})
local ebaymenu_button3 = ebaymenu:AddButton({
    icon = '📋',
    label = Config.Menu3Label,
    value = ebaymenu3,
    description = Config.Menu3Label
})

ebaymenu_button:On("select", function()
    ebaymenu3:ClearItems()
    Config.Core.Functions.TriggerCallback('gks_ebay:depoitemgoturtest', function(result)
		for i=1, #result, 1 do

			local invitem = result[i]

			  if invitem.count > 0 then
				local ebaymenu_button8 = ebaymenu3:AddButton({
					label = invitem.label .. ' | ' .. invitem.count,
					value = {name = invitem.item, count = invitem.count},
					description = Config.Menu8Descript,
					select = function(btn)
						local name = btn.Value.name
						local result = LocalInput('Count', 255, '')
						if result ~= nil then
							if tonumber(result) <= btn.Value.count then
								TriggerServerEvent('gks_ebay:depoitemdelete', name, tonumber(result))

								MenuV:CloseMenu(ebaymenu3)
							else
								Config.Core.Functions.Notify(Config.TooMuch, 'error')
							end
						end
					end
				})
			  end
		end
    end)
end)

ebaymenu_button2:On("select", function()
    ebaymenu3:ClearItems()
    Config.Core.Functions.TriggerCallback('gks_ebay:getInventory', function(result)
		for _, item in pairs(result) do
				if item.amount > 0 then
					local ebaymenu_button8 = ebaymenu3:AddButton({
						label = item.label .. ' | ' .. item.amount,
						value = {name = item.name, count = item.amount, label = item.label},
						description = Config.AddProduct,
						select = function(btn)
							local name = btn.Value.name
							local itemLabel = btn.Value.label
							local result = LocalInput('Count', 255, '')
							if result ~= nil then
								if tonumber(result) <= btn.Value.count then
									local resultd = LocalInput('Price', 255, '')
									if result ~= nil then
										local engellitem = false
										for k, v in pairs(Config.BlacklistItem) do
										  if name == v then
											engellitem = true
											Config.Core.Functions.Notify(Config.ItemBlacklist, 'error')
										  end
										end
										if engellitem == false then
											TriggerServerEvent('gks_ebay:depoitem', name, tonumber(result), resultd, itemLabel)
										end
										MenuV:CloseMenu(ebaymenu3)
									end
								else
									Config.Core.Functions.Notify(Config.TooMuch, 'error')
								end
							end
						end
					})
				end
		end
    end)
end)

ebaymenu_button3:On("select", function()
    ebaymenu3:ClearItems()
    Config.Core.Functions.TriggerCallback('gks_ebay:purchitemgotur', function(result)
		for i=1, #result, 1 do

			local invitem = result[i]

			  if invitem.count > 0 then
				local ebaymenu_button8 = ebaymenu3:AddButton({
					label = invitem.label .. ' | ' .. invitem.count,
					value = {name = invitem.item, count = invitem.count},
					description = Config.Menu8Descript,
					select = function(btn)
						local name = btn.Value.name
						local result = LocalInput('Count', 255, '')
						if result ~= nil then
							if tonumber(result) <= btn.Value.count then
								TriggerServerEvent('gks_ebay:depoitemdelete', name, tonumber(result))

								MenuV:CloseMenu(ebaymenu3)
							else
								Config.Core.Functions.Notify(Config.TooMuch, 'error')
							end
						end
					end
				})
			  end
		end
    end)
end)


function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
        return tonumber(math.abs(result))
    end
end




----- A ------



Citizen.CreateThread(function()
    if Cfg.NPCEnable == true then
		RequestModel(Cfg.NPCIdyenileehliyet)
		while not HasModelLoaded(Cfg.NPCIdyenileehliyet) do
			Wait(1)
		end

		meth_dealer_seller = CreatePed(1, Cfg.NPCIdyenileehliyet, Cfg.NPCKonummrpd.x, Cfg.NPCKonummrpd.y, Cfg.NPCKonummrpd.z - 1.0, Cfg.NPCKonummrpd.h, false, true)
		FreezeEntityPosition(meth_dealer_seller, true)
		SetEntityInvincible(meth_dealer_seller, true)
		SetBlockingOfNonTemporaryEvents(meth_dealer_seller, true)

        if Cfg.EyeTarget then
            exports['qb-target']:AddTargetEntity(meth_dealer_seller, {
                options = {
                    {
                        label = Config.APPName,
                        icon = "fas fa-shopping-basket",
                        action = function()
                            MenuV:OpenMenu(ebaymenu)
                        end
                    }
                },
                distance = 2.0
            })
        end
	end
end)



	function npckafa(deneme)
		local Tag = CreateFakeMpGamerTag(meth_dealer_seller, Config.APPName, false, false, "NOS", false)
		if deneme then
			SetMpGamerTagAlpha(Tag, 0, 255) -- Sets "MP_TAG_GAMER_NAME" bar alpha to 100% (not needed just as a fail safe)
			SetMpGamerTagColour(Tag, 0, 012) 			-- https://wiki.rage.mp/index.php?title=Fonts_and_Colors -- 000 //  129
			--SetMpGamerTagHealthBarColour(Tag, 25)  --https://wiki.rage.mp/index.php?title=Fonts_and_Colors
			SetMpGamerTagVisibility(Tag, 0, false) -- Activates the player ID Char name and FiveM name
		else
			SetMpGamerTagVisibility(Tag, 0, false)
			RemoveMpGamerTag(Tag)
		end
	end

	local letSleep = true
	local teksefer = false
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Cfg.NPCKonummrpd.x, Cfg.NPCKonummrpd.y, Cfg.NPCKonummrpd.z, true) < Cfg.DrawDistance then
				letSleep = false
				if not teksefer then
					teksefer = true
					npckafa(teksefer)
				end
				if not Cfg.EyeTarget then
					if IsControlJustReleased(0, 38) then
						MenuV:OpenMenu(ebaymenu)
					end
				end
			else
				letSleep = true
				if teksefer then
					teksefer = false
					npckafa(teksefer)
				end
			end
			if letSleep then Citizen.Wait(1000) end
		end
	end)

