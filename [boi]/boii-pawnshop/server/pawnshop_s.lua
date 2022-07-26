-------------------------------
---------- CASE#1993 ----------
-------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.Core
local CoreFolder = Config.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local TargetName = Config.TargetName
local MenuName = Config.MenuName
local MoneyType = Config.MoneyType
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- SELL ITEMS START --<!>--
RegisterServerEvent('boii-pawnshop:server:SellItems', function(args) 
	local source = source
    local Player = Core.Functions.GetPlayer(source)
	local args = tonumber(args)
    saleitem = ''
    menuevent = ''
    -- Materials (pawnshop)
    if args == 1 then
        saleitem =  'metalscrap'
        menuevent = 'boii-pawnshop:client:SellMaterialsMenu'
	elseif args == 2 then
        saleitem =  'iron'
        menuevent = 'boii-pawnshop:client:SellMaterialsMenu'
	elseif args == 3 then
        saleitem =  'steel'
        menuevent = 'boii-pawnshop:client:SellMaterialsMenu'
    elseif args == 4 then
        saleitem =  'aluminum'
        menuevent = 'boii-pawnshop:client:SellMaterialsMenu'
    elseif args == 5 then
        saleitem =  'copper'
        menuevent = 'boii-pawnshop:client:SellMaterialsMenu'
    elseif args == 6 then
        saleitem =  'plastic'
        menuevent = 'boii-pawnshop:client:SellMaterialsMenu'
    elseif args == 7 then
        saleitem =  'rubber'
        menuevent = 'boii-pawnshop:client:SellMaterialsMenu'
    -- Gems (pawnshop)
    elseif args == 8 then
        saleitem =  'diamond'
        menuevent = 'boii-pawnshop:client:SellGemsMenu'
    -- Jewellery (pawnshop)
    elseif args == 9 then
        saleitem =  'goldchain'
        menuevent = 'boii-pawnshop:client:SellJewelleryMenu'
    elseif args == 10 then
        saleitem =  'rolex'
        menuevent = 'boii-pawnshop:client:SellJewelleryMenu'
    elseif args == 11 then
        saleitem =  '10kgoldchain'
        menuevent = 'boii-pawnshop:client:SellJewelleryMenu'
    elseif args == 12 then
        saleitem =  'diamond_ring'
        menuevent = 'boii-pawnshop:client:SellJewelleryMenu'
    -- Electronics (digital den)
    elseif args == 13 then
        saleitem =  'tablet'
        menuevent = 'boii-pawnshop:client:DigitalSellMenu'
    elseif args == 14 then
        saleitem =  'iphone'
        menuevent = 'boii-pawnshop:client:DigitalSellMenu'
    elseif args == 15 then
        saleitem =  'samsungphone'
        menuevent = 'boii-pawnshop:client:DigitalSellMenu'
    elseif args == 16 then
        saleitem =  'laptop'
        menuevent = 'boii-pawnshop:client:DigitalSellMenu'
    -- Illegal goods (gold buyer)
    elseif args == 17 then
        saleitem =  'goldbar'
        menuevent = 'boii-pawnshop:client:GoldSellMenu'
    elseif args == 18 then
        saleitem =  'gold'
        menuevent = 'boii-pawnshop:client:SellGemsMenu'
    elseif args == 19 then
        saleitem =  'emerald'
        menuevent = 'boii-pawnshop:client:SellGemsMenu'
    elseif args == 20 then
        saleitem =  'ruby'
        menuevent = 'boii-pawnshop:client:SellGemsMenu'
    elseif args == 21 then
        saleitem =  'opal'
        menuevent = 'boii-pawnshop:client:SellGemsMenu'
    elseif args == 22 then
        saleitem =  'black_diamond'
        menuevent = 'boii-pawnshop:client:SellGemsMenu'
    elseif args == 23 then
        saleitem =  'pink_diamond'
        menuevent = 'boii-pawnshop:client:SellGemsMenu'
    elseif args == 24 then
        saleitem =  'sapphire'
        menuevent = 'boii-pawnshop:client:SellGemsMenu'
    elseif args == 24 then
        saleitem =  'sapphire'
        menuevent = 'boii-pawnshop:client:SellGemsMenu'
    elseif args == 25 then
        saleitem =  'goldbar'
        menuevent = 'boii-pawnshop:client:SellGemsMenu'
    end -- You can add more items here **ensure your args and menu triggers match client**
	if Player.Functions.GetItemByName(saleitem) ~= nil then
        item = Player.Functions.GetItemByName(saleitem).amount
        pay = (item * Config.SellItems[saleitem])
        Player.Functions.RemoveItem(saleitem, item)
        Player.Functions.AddMoney(MoneyType, pay)	
        TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[saleitem], 'remove', item)
        TriggerClientEvent(menuevent, source)
    else
        TriggerClientEvent('boii-pawnshop:notifications', source, Config.Lang['noitems'], 'error')
        TriggerClientEvent(menuevent, source)
    end
end)
--<!>-- SELL ITEMS END --<!>--

--<!>-- SMELT ITEMS START --<!>--
RegisterServerEvent('boii-pawnshop:server:SmeltItems', function(args) 
	local source = source
    local Player = Core.Functions.GetPlayer(source)
	local args = tonumber(args)
    smeltitem = ''
    smeltamount = ''
	if args == 1 then
        smeltitem = 'rolex'
        smeltamount = Config.RolexAmount
        clientarg = 1
    elseif args == 2 then
        smeltitem = 'goldchain'
        smeltamount = Config.GoldChainAmount
        clientarg = 2
    elseif args == 3 then
        smeltitem = '10kgoldchain'
        smeltamount = Config.KGoldChainAmount
        clientarg = 3
    end 
    local item = Player.Functions.GetItemByName(smeltitem) 
    if item ~= nil then
        if item.amount >= smeltamount then
            Player.Functions.RemoveItem(smeltitem, smeltamount)
            TriggerClientEvent('boii-pawnshop:client:SmeltItems', source, clientarg)
        else
            TriggerClientEvent('boii-pawnshop:notifications', source, Config.Lang['enoughsmelt'], 'error')
            TriggerClientEvent('boii-pawnshop:client:SmeltingMenu', source)
        end
    else
        TriggerClientEvent('boii-pawnshop:notifications', source, Config.Lang['nosmelt'], 'error')
        TriggerClientEvent('boii-pawnshop:client:SmeltingMenu', source)
    end
end)
--<!>-- SMELT ITEMS END --<!>--