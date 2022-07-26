QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("LegacyFuel:pagamento01")
AddEventHandler("LegacyFuel:pagamento01",function(price,galao,vehicle,fuel,fuel2,key)
	local source = source
	local output = {}
	local query = nil
	if key then
		local sql = "SELECT stock,price FROM gas_station_business WHERE gas_station_id = @gas_station_id";
		query = MySQL.Sync.fetchAll(sql, {['@gas_station_id'] = key});
		if query and query[1] then
			output = {
				['price'] = (query[1].price/100),
				['stock'] = query[1].stock,
			}
			local sql = "UPDATE `gas_station_business` SET total_visits = total_visits + 1 WHERE gas_station_id = @gas_station_id";
			MySQL.Sync.execute(sql, {['@gas_station_id'] = key});
		else
			output = {
				['price'] = Config.defaultGasPrice,
				['stock'] = Config.defaultGasStock,
			}
		end
	else
		output = {
			['price'] = Config.defaultGasPrice, 	-- Default price
			['stock'] = Config.defaultGasStock,	-- Default amount
		}
	end
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if price > 0 then
		local amount = 0
		if galao then
			amount = price
		else
			amount = math.floor(price/output.price)
			fuel = math.floor(fuel/output.price)
		end
		if galao or output.stock > amount then
			money = xPlayer.PlayerData.money.bank
			if money >= price then
				xPlayer.Functions.RemoveMoney('bank', price)
				if galao then
					xPlayer.Functions.AddItem("weapon_petrolcan", 1)
					TriggerClientEvent("gas_station:Notify",source,"sucesso","Paid <b>$"..price.." </b> for the <b>jerry can</b>.",8000)
				else
					if key and query and query[1] then
						local sql = "UPDATE `gas_station_business` SET stock = @stock, customers = customers + 1, money = money + @price, total_money_earned = total_money_earned + @price, gas_sold = gas_sold + @amount WHERE gas_station_id = @gas_station_id";
						MySQL.Sync.execute(sql, {['@gas_station_id'] = key, ['@stock'] = ((output.stock) - amount), ['@price'] = price, ['@amount'] = amount});
						
						local sql = "INSERT INTO `gas_station_balance` (gas_station_id,income,title,amount,date) VALUES (@gas_station_id,@income,@title,@amount,@date)";
						MySQL.Sync.execute(sql, {['@gas_station_id'] = key, ['@income'] = 0, ['@title'] = "Fuel sold ("..amount.." Liters)", ['@amount'] = price, ['@date'] = os.time()});
					end
					
					TriggerClientEvent('fuel:setvehiclefuel',source,vehicle,fuel)
					TriggerClientEvent("gas_station:Notify",source,"sucesso","Paid <b>$"..price.." </b> in "..amount.." liters.",8000)
				end
			else
				TriggerClientEvent("gas_station:Notify",source,"negado","Insuficient money.",8000)
			end
		else
			TriggerClientEvent("gas_station:Notify",source,"negado","Insuficient fuel stock (Max: "..output.stock.." liters).",8000)
		end
	end
end)

RegisterServerEvent('LegacyFuel:LixeiroCB01')
AddEventHandler('LegacyFuel:LixeiroCB01', function(key)
	local source = source
	if key then
		local sql = "SELECT stock,price FROM gas_station_business WHERE gas_station_id = @gas_station_id";
		local query = MySQL.Sync.fetchAll(sql, {['@gas_station_id'] = key});
		local output = {}
		if query and query[1] then
			output = {
				['price'] = (query[1].price/100),
				['stock'] = query[1].stock,
			}
			local sql = "UPDATE `gas_station_business` SET total_visits = total_visits + 1 WHERE gas_station_id = @gas_station_id";
			MySQL.Sync.execute(sql, {['@gas_station_id'] = key});
		else
			output = {
				['price'] = Config.defaultGasPrice,
				['stock'] = Config.defaultGasStock,
			}
		end

		TriggerClientEvent('LegacyFuel:LixeiroCB01', source, output)
	else
		local output = {
			['price'] = Config.defaultGasPrice,
			['stock'] = Config.defaultGasStock,
		}
		TriggerClientEvent('LegacyFuel:LixeiroCB01', source, output)
	end
end)

RegisterServerEvent('LegacyFuel:LixeiroCB02')
AddEventHandler('LegacyFuel:LixeiroCB02', function()
	local source = source
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local money = xPlayer.PlayerData.money["cash"]
	if money >= Config.RefuelWithJerryCanCost then
		xPlayer.Functions.RemoveMoney("cash", Config.RefuelWithJerryCanCost)
		TriggerClientEvent("gas_station:Notify",source,"sucesso","Paid $"..Config.RefuelWithJerryCanCost,8000)
		TriggerClientEvent('LegacyFuel:LixeiroCB02', source, true)
	else
		TriggerClientEvent("gas_station:Notify",source,"negado","Insuficient cash.",8000)
		TriggerClientEvent('LegacyFuel:LixeiroCB02', source, false)
	end
end)