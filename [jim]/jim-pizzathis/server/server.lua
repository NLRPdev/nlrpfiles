local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	for k, v in pairs(Crafting) do for i = 1, #v do
			for l, b in pairs(v[i]) do if not QBCore.Shared.Items[l] then print("Crafting: Missing Item from QBCore.Shared.Items: '"..k.."'") end
				for j, c in pairs(b) do if not QBCore.Shared.Items[j] then print("Crafting: Missing Item from QBCore.Shared.Items: '"..j.."'") end end end end end
	for i = 1, #Config.DrinkItems.items do
		if not QBCore.Shared.Items[Config.DrinkItems.items[i].name] then print("Store: Missing Item from QBCore.Shared.Items: '"..Config.DrinkItems.items[i].name.."'") end
	end
	for i = 1, #Config.FoodItems.items do
		if not QBCore.Shared.Items[Config.FoodItems.items[i].name] then print("Store: Missing Item from QBCore.Shared.Items: '"..Config.FoodItems.items[i].name.."'") end
	end		
	for i = 1, #Config.WineItems.items do
		if not QBCore.Shared.Items[Config.WineItems.items[i].name] then print("Store: Missing Item from QBCore.Shared.Items: '"..Config.WineItems.items[i].name.."'") end
	end		
	for i = 1, #Config.FreezerItems.items do
		if not QBCore.Shared.Items[Config.FreezerItems.items[i].name] then print("Store: Missing Item from QBCore.Shared.Items: '"..Config.FreezerItems.items[i].name.."'") end
	end
	if not QBCore.Shared.Jobs["pizzathis"] then print("Error: Job role not found - 'pizzathis'") end
end)

--Consumables
CreateThread(function()
	local wines = { "amarone", "barbera", "dolceto", "housered", "housewhite", "rosso" }
    for k,v in pairs(wines) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-pizzathis:client:DrinkAlcohol', source, item.name) end) end
	
	local beers = { "ambeer", "dusche", "logger", "pisswasser", "pisswasser2", "pisswasser3" }
    for k,v in pairs(beers) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-pizzathis:client:DrinkAlcohol', source, item.name) end) end
	
	local drink = { "sprunk", "sprunklight", "ecola", "ecolalight" }
    for k,v in pairs(drink) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-pizzathis:client:Drink', source, item.name) end) end
	
	local food = { "tiramisu", "gelato", "medfruits", "capricciosa", "diavola", "marinara", "margherita", "prosciuttio", "vegetariana", "bolognese", "calamari", "meatball", "alla", "pescatore" }
    for k,v in pairs(food) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-pizzathis:client:Eat', source, item.name) end) end
	
	local boxes = { "capricciosabox", "diavolabox", "marinarabox", "margheritabox", "prosciuttiobox", "vegetarianabox" }
    for k,v in pairs(boxes) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerEvent('jim-pizzathis:OpenBox', source, item.name) end) end
end)

RegisterServerEvent('jim-pizzathis:OpenBox', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if item == "capricciosabox" then slices = "capricciosa"
	elseif item == "diavolabox" then slices = "diavola"
	elseif item == "marinarabox" then slices = "marinara"
	elseif item == "margheritabox" then slices = "margherita"
	elseif item == "prosciuttiobox" then slices = "prosciuttio"
	elseif item == "vegetarianabox" then slices = "vegetariana" end
	--This removes the box
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "remove", 1) 
	Player.Functions.RemoveItem(item, 1)
	Wait(600)
	--This gives the slices
	Player.Functions.AddItem(slices, 6)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[slices], "add", 6) 
end)

---Crafting 
RegisterServerEvent('jim-pizzathis:Crafting:GetItem', function(ItemMake, craftable)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	--This grabs the table from client and removes the item requirements
	local amount = 1
	if craftable then 
		if craftable["amount"] then amount = craftable["amount"] end
		for k,v in pairs(craftable[ItemMake]) do
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tostring(k)], "remove", v) 
			Player.Functions.RemoveItem(tostring(k), v)
			if Config.Debug then print("Removing "..tostring(k)) end
		end
	end
	--This should give the item, while the rest removes the requirements
	Player.Functions.AddItem(ItemMake, amount)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ItemMake], "add", amount)
	if Config.Debug then print("Giving Player "..tostring(ItemMake).." x"..amount) end
end)

---ITEM REQUIREMENT CHECKS
QBCore.Functions.CreateCallback('jim-pizzathis:Crafting:get', function(source, cb, item, craftable)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local hasitem = true
	local testtable = {}
	for k, v in pairs(craftable[item]) do testtable[k] = false end
	for k,v in pairs(craftable[item]) do
		if QBCore.Functions.GetPlayer(source).Functions.GetItemByName(k) and QBCore.Functions.GetPlayer(source).Functions.GetItemByName(k).amount >= v then
			testtable[k] = true if Config.Debug then print(k.." (x"..v..") found") end
		end
	end
	for k, v in pairs(testtable) do
		if not v then hasitem = false if Config.Debug then print(QBCore.Shared.Items[k].label.." NOT found") end end
	end
	cb(hasitem)
end)