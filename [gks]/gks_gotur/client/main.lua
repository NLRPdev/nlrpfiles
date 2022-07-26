--================================================================================================
--==            --    XenKnighT --        https://discord.gg/XUck63E                            ==
--================================================================================================
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local blipana = {}
local Intervals = {}

SetInterval = function(id, msec, callback, onclear)
	if Intervals[id] and msec then
		Intervals[id] = msec
	else
		CreateThread(function()
			Intervals[id] = msec
			repeat
				Wait(Intervals[id])
				callback(Intervals[id])
			until Intervals[id] == -1 and (onclear and onclear() or true)
			Intervals[id] = nil
		end)
	end
end

ClearInterval = function(id)
	if Intervals[id] then Intervals[id] = -1 end
end

RegisterNetEvent(Config.CoreName..':Client:OnPlayerLoaded')
AddEventHandler(Config.CoreName..':Client:OnPlayerLoaded', function()
    Config.Core.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "gotur" then
                Config.Zones.OfficeActions.Type = 1
				SocietyMenu(PlayerJob.isboss)
				dawdadawd()
				BlipGotur()
			else
				Config.Zones.OfficeActions.Type = -1
				dawdadawd()
				blipsil()
			end
        end
    end)
end)

RegisterNetEvent(Config.CoreName..':Client:OnJobUpdate')
AddEventHandler(Config.CoreName..':Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
	if onDuty then
		if PlayerJob.name == "gotur" then
			Config.Zones.OfficeActions.Type = 1
			SocietyMenu(PlayerJob.isboss)
			dawdadawd()
			BlipGotur()
		else
			Config.Zones.OfficeActions.Type = -1
			dawdadawd()
			blipsil()
		end
	end
end)



local menu = MenuV:CreateMenu(false, Config.AppName..'Menu', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'gksgoturmain')
function SocietyMenu (boss)
	if boss then
		local menu2 = MenuV:CreateMenu(false, Config.SocietyM, 'topright', 155, 0, 0, 'size-125', 'none', 'menuv')
		local menu_button4 = menu:AddButton({
			icon = '💰',
			label = Config.SocietyM,
			value = menu2,
			description = Config.Menu4Descrpit
		})
		local menu_button5 = menu2:AddButton({
			icon = '💲',
			label = '',
			value = nil,
			description = Config.Menu5Descrpit
		})
		local menu_button6 = menu2:AddButton({
			icon = '🤑',
			label = Config.Menu6Label,
			value = menu2,
			description = Config.Menu6Descrpit
		})
		local menu_button7 = menu2:AddButton({
			icon = '🏦',
			label = Config.Menu7Label,
			value = menu2,
			description = Config.Menu7Descrpit
		})

		-- Society
		menu_button4:On('select', function()
			UpdateSociety()
		end)
		-- Withdraw
		menu_button6:On("select", function()
			local result = LocalInput('Withdrawal Amount', 255, '')
			if result ~= nil then
				TriggerServerEvent("qb-bossmenu:server:withdrawMoney", tonumber(result))
				UpdateSociety()
			end
		end)

		-- Deposit
		menu_button7:On("select", function()
			local result = LocalInput('Deposit Amount', 255, '')
			if result ~= nil then
				TriggerServerEvent("qb-bossmenu:server:depositMoney", tonumber(result))
				UpdateSociety()
			end
		end)

		function UpdateSociety()
			Config.Core.Functions.TriggerCallback('qb-bossmenu:server:GetAccount', function(cb)
				menu_button5.Label = Config.SocietyM..': $' ..comma_value(cb)
			end, PlayerJob.name)
		end

	end
end

local menu3 = MenuV:CreateMenu(false, Config.Products, 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'employees')


-- Create blips
function blipsil ()
	if blipana[1] then
		for i, blip in pairs(blipana) do
			RemoveBlip(blip)
		end
	end
end

function BlipGotur()
	if not Config.EnableBlips then return end
	if PlayerJob.name == "gotur" then
		for _, GOTURLocations in pairs(Config.GOTURLocations) do
			GOTURLocations.blip = AddBlipForCoord(GOTURLocations.x, GOTURLocations.y, GOTURLocations.z - Config.ZDiff)
			table.insert(blipana, GOTURLocations.blip)
			SetBlipSprite(GOTURLocations.blip, Config.BlipSprite)
			SetBlipDisplay(GOTURLocations.blip, 4)
			SetBlipScale(GOTURLocations.blip, 0.9)
			SetBlipColour(GOTURLocations.blip, 2)
			SetBlipAsShortRange(GOTURLocations.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('GOTUR')
			EndTextCommandSetBlipName(GOTURLocations.blip)
		end
	end
end



function test ()
		if (Config.Zones.OfficeActions.Type == 1) then
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Zones.OfficeActions.Pos.x, Config.Zones.OfficeActions.Pos.y, Config.Zones.OfficeActions.Pos.z, true) < Config.DrawDistance then
				DrawMarker(Config.Zones.OfficeActions.Type, Config.Zones.OfficeActions.Pos.x, Config.Zones.OfficeActions.Pos.y, Config.Zones.OfficeActions.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Zones.OfficeActions.Size.x, Config.Zones.OfficeActions.Size.y, Config.Zones.OfficeActions.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				if IsControlJustReleased(0, Keys['E']) then
					MenuV:OpenMenu(menu)
				end
			end
		end
end



function dawdadawd ()

	Citizen.CreateThread(function()
		if (Config.Zones.OfficeActions.Type == 1) then
			while true do
				test()
				Citizen.Wait(0)
			end
		end
	end)

end



local menu_button = menu:AddButton({
    icon = '📋',
    label = Config.Products,
    value = menu3,
    description = Config.Menu3Descript
})
local menu_button2 = menu:AddButton({
    icon = '📋',
    label = Config.Menu2Label,
    value = menu3,
    description = Config.Menu2Descript
})



menu_button:On("select", function()
    menu3:ClearItems()
    Config.Core.Functions.TriggerCallback('gks_gotur:depoitemgotur', function(result)
		for i=1, #result, 1 do

			local invitem = result[i]

			  if invitem.count > 0 then
				local menu_button8 = menu3:AddButton({
					label = invitem.label .. ' | ' .. invitem.count,
					value = {name = invitem.item, count = invitem.count},
					description = Config.Menu8Descript,
					select = function(btn)
						local name = btn.Value.name
						local result = LocalInput('Count', 255, '')
						if result ~= nil then
							if tonumber(result) <= btn.Value.count then
								TriggerServerEvent('gks_gotur:depoitemdelete', name, tonumber(result))

								MenuV:CloseMenu(menu3)
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

menu_button2:On("select", function()
    menu3:ClearItems()
    Config.Core.Functions.TriggerCallback('gks_gotur:getInventory', function(result)

		for _, item in pairs(result) do
				if item.amount > 0 then
					local menu_button8 = menu3:AddButton({
						label = item.label .. ' | ' .. item.amount,
						value = {name = item.name, count = item.amount},
						description = Config.AddProduct,
						select = function(btn)
							local name = btn.Value.name
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
											TriggerServerEvent('gks_gotur:depoitem', name, tonumber(result), resultd)
										end

										MenuV:CloseMenu(menu3)
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

function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end



deliverytime = Config.deliverytime
maxdeliverytime = Config.deliverytime
deliverystarted = false
total = 0
bilgi = nil
TrackerRunning = false
StoreBlip = {}

RegisterNetEvent('gks_gotur:gerisaybitir')
AddEventHandler('gks_gotur:gerisaybitir', function(ida)
  deliverystarted = false
  deliverytime = Config.deliverytime
  total = 0
  bilgi = nil
end)

RegisterNetEvent('gks_gotur:gerisayim')
AddEventHandler('gks_gotur:gerisayim', function(gelens, gotur)
  deliverystarted = true
  total = gelens
  bilgi = gotur
  TriggerEvent('gksphone:notifi', {title = Config.AppName, message = Config.TimeLeft ..' ' .. deliverytime, img= '/html/static/img/icons/gotur.png' })

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		if deliverystarted then
			deliverytime = deliverytime - 1

			if deliverytime <= (maxdeliverytime / 3) then
				TriggerEvent('gksphone:notifi', {title = Config.AppName, message = Config.TimeLeft.. ' ' .. deliverytime, img= '/html/static/img/icons/gotur.png' })
			elseif deliverytime <= (maxdeliverytime / 3) * 2 then
				TriggerEvent('gksphone:notifi', {title = Config.AppName, message = Config.TimeLeft.. ' ' .. deliverytime , img= '/html/static/img/icons/gotur.png' })
			elseif deliverytime <= (maxdeliverytime / 3) * 3 then
				TriggerEvent('gksphone:notifi', {title = Config.AppName, message = Config.TimeLeft.. ' ' .. deliverytime, img= '/html/static/img/icons/gotur.png' })
			end
			if deliverytime <= 0 then
				failed()
			end
		end
	end
end)

RegisterNetEvent('gks_gotur:blipp')
AddEventHandler('gks_gotur:blipp', function(bilgi, deneme, number)
	SetInterval(deneme, 5000, function()
		Config.Core.Functions.TriggerCallback('tonygetcoords', function(coords)
			local playerCoords = coords
			startTracking(playerCoords, bilgi, number)
		end, deneme)
	end)
end)

function startTracking(coords, name, number)
	if StoreBlip[number] ~= nil then
		RemoveBlip(StoreBlip[number])
		StoreBlip[number] = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(StoreBlip[number], 480)
		SetBlipScale(StoreBlip[number], 1.0)
		SetBlipDisplay(StoreBlip[number], 4)
		SetBlipAsShortRange(StoreBlip[number], true)


		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(' ' ..name)
		EndTextCommandSetBlipName(StoreBlip[number])
	else
		StoreBlip[number] = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(StoreBlip[number], 480)
        SetBlipScale(StoreBlip[number], 1.0)
        SetBlipDisplay(StoreBlip[number], 4)
        SetBlipAsShortRange(StoreBlip[number], true)


        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(' ' ..name)
        EndTextCommandSetBlipName(StoreBlip[number])
	end
end

RegisterNetEvent('gks_gotur:stopblipp')
AddEventHandler('gks_gotur:stopblipp', function(number, ida)
    Wait(7000)
    TrackerRunning = false
	ClearInterval(ida)
	Wait(7000)
	RemoveBlip(StoreBlip[number])
end)



function failed()
	deliverystarted = false
	deliverytime = Config.deliverytime
	TriggerServerEvent('gks_gotur:failed', total, bilgi)
end

AddEventHandler('onClientResourceStart', function(resName)
	deliverytime = Config.deliverytime
	maxdeliverytime = Config.deliverytime
	deliverystarted = false
	total = 0
	bilgi = nil
	TrackerRunning = false
	StoreBlip = {}

end)