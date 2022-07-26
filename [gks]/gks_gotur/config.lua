Config              = {}

Config.QBCoreNewversion = true

if Config.QBCoreNewversion then
    Config.CoreName = "QBCore"
    Config.Core = exports['qb-core']:GetCoreObject()
    Config.CoreNotify = "QBCore:Notify"
else
    Config.CoreName = "QBCore:GetObject"
    Config.Core = nil
    TriggerEvent(Config.CoreName, function(obj) Config.Core = obj end)
    Config.CoreNotify = "QBCore:Notify"
end

--Blip

Config.EnableBlips = true
Config.BlipSprite   = 512
Config.ZDiff        = 2.0
Config.GOTURLocations = {
	{ ['x'] = 288.36,  ['y'] = -1267.04,  ['z'] = 29.44}
}

--warehouse location
Config.DrawDistance = 10
Config.MarkerColor  = { r = 120, g = 120, b = 240 }
Config.Zones = {

	OfficeActions = {
		Pos   = { x = 288.36, y = -1267.04, z = 29.44 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	}
}

Config.BlacklistItem = {
    "weapon_pistol",
    "weapon_appistol",
    "weapon_assaultrifle"
}

Config.deliverytime = 3 -- delivery time setting place


-- LANG

Config.AppName = "Gotur"
Config.SocietyM = "Society money"
Config.Menu4Descrpit = "View/Manage Society Money"
Config.Menu5Descrpit = "Current Society Amount"
Config.Menu6Descrpit = "Withdraw Money From Society"
Config.Menu7Descrpit = "Deposit Money Into Society"
Config.Menu6Label = "Withdraw"
Config.Menu7Label = "Deposit"
Config.Products = "Products"
Config.Menu3Descript = "Products in the store"
Config.Menu2Label = "Put product in warehouse"
Config.Menu2Descript = "Adding products to the store"
Config.Menu8Descript = "Products in the warehouse"
Config.TooMuch = "You entered too much"
Config.AddProduct = "Add product"
Config.TimeLeft = "Time Left: Order forecast time "
Config.AddMap = "The order location has been added to the map and you must deliver the order within"
Config.Minutes = "minutes"
Config.ShopColsed = "The shop is closed, try again later"
Config.NoMoney = "You dont have enough money"
Config.Order = "Order arrived"
Config.PersonCancel = "The persons order has been canceled because it did not arrive."
Config.OrderTime = "Your money has been refunded because your order did not arrive on time."
Config.OrderWay = "Order is on its way"
Config.Delivered = "Your order has been delivered"
Config.SameItem = "We already have this item in our shop"
Config.RemoveItem = "Remove the item and put a new price or put the same price"
Config.OutYouOwn = "You can\' t take out more than you own"
Config.ItemBlacklist = "The item you want to add is a black list."