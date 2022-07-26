
Config = {
  Debug       = false,
  EditorMode  = false,

  UsingESX    = false, -- Make sure you CHANGE THESE SETTINGS
  UsingQBCore = true,


  CommandPerms               = 'god', 

  ManageRobberiesCommand     = "Robberies:Manage", -- Creating and Managing Robberies
  ObjectsSetupCommand        = "Robberies:EditObjects", -- Setting Objects for Robberies

  AlertMoveSpeed = 2.5, --## In m/s how fast do you have to move within a peds Radius to alert them?
  SneakButton    = false, --## Set to true if not using any form of crouch script etc. This will slow the player down if being held. will affect performance (maybe not much noticeable :shrug:)

  DropSprint         = true, --## Drop objects upon sprinting?
  DropJump           = true, --## Drop objects upon jumping?
  ChanceLockpickCops = 50,    --## Meh might change this chance to be per door soon so you can have sneakier entrances etc or blatant entrances. but anyway it's the chance out of 100 the cops will be called when lockpicking :meh:



  Robberies = {}, --## This will autopopulate when the script starts --### You can add robberies in manually if you wish too :shrug:

  ReSyncTime = function()
    if Config.UsingQBCore then 
      TriggerServerEvent("qb-weathersync:server:RequestStateSync")
    elseif Config.UsingESX then 
      ---# Probably fill with somesort of weather/time sync for resetting time when coming out of shell
    end
  end,

  Shells = { -- Uncomment/Add more as you need them.
    ['k4coke_shell']     = vector4(0,0,0,0), --## Add your shells here like so you will just need to put the default offset in here. Won'tmatter if you leave it as 0,0,0,0 as you set these entrances in game anyway
    ['k4meth_shell']     = vector4(0,0,0,0),
    ['k4weed_shell']     = vector4(0,0,0,0),

    -- ['shell_apartment1'] = vector4(0,0,0,0),
    -- ['shell_apartment2'] = vector4(0,0,0,0),
    -- ['shell_apartment3'] = vector4(0,0,0,0),
    -- ['shell_banham']     = vector4(0,0,0,0),
    -- ['shell_frankaunt']  = vector4(0,0,0,0),
    -- ['shell_highend']    = vector4(0,0,0,0),
    -- ['shell_highendv2']  = vector4(0,0,0,0),
    -- ['shell_lester']     = vector4(0,0,0,0),
    -- ['shell_medium2']    = vector4(0,0,0,0),
    -- ['shell_medium3']    = vector4(0,0,0,0),
    -- ['shell_michael']    = vector4(0,0,0,0),
    -- ['shell_ranch']      = vector4(0,0,0,0),
    -- ['shell_trailer']    = vector4(0,0,0,0),
    -- ['shell_trevor']     = vector4(0,0,0,0),
    -- ['shell_v16low']     = vector4(0,0,0,0),
    -- ['shell_v16mid']     = vector4(0,0,0,0),
    -- ['shell_westons']    = vector4(0,0,0,0),
    -- ['shell_westons2']   = vector4(0,0,0,0),
  },
 
  Anims = { --## Add more anims to this table with their label as the index. You can use these on NPC's you place. Leave 'NONE' alone godammit.
    ['NONE'] = {},
    ['SLEEPING'] = {
      Anim    = "idle_c",
      Dict    = "timetable@tracy@sleep@",
    },
  },

  Weapons = { --## Weapons that you can use in the creation of robbery zones
    'NONE',
    'WEAPON_PISTOL',
    'WEAPON_KNIFE',  
    'WEAPON_KNIGHTSTICK',
    'WEAPON_HAMMER',
    'WEAPON_BAT',
    'WEAPON_GOLFCLUB',
    'WEAPON_CROWBAR',
    'WEAPON_BOTTLE',
    'WEAPON_DAGGER',
    'WEAPON_HATCHET',
    'WEAPON_MACHETE',
    'WEAPON_FLASHLIGHT',
    'WEAPON_SWITCHBLADE',
    'WEAPON_REVOLVER',
    'WEAPON_PISTOL',
    'WEAPON_PISTOL_MK2',
    'WEAPON_COMBATPISTOL',
    'WEAPON_APPISTOL',
    'WEAPON_PISTOL50',
    'WEAPON_SNSPISTOL',
    'WEAPON_HEAVYPISTOL',
    'WEAPON_VINTAGEPISTOL',
    'WEAPON_MARKSMANPISTOL',
    'WEAPON_MICROSMG',
    'WEAPON_SMG',
    'WEAPON_ASSUALTSMG',
    'WEAPON_MG',
    'WEAPON_COMBATPDW',
    'WEAPON_ASSAULTRIFLE',
    'WEAPON_CARBINERIFLE',
    'WEAPON_ADVANCEDRIFLE',
    'WEAPON_BULLPUPRIFLE',
    'WEAPON_PUMPSHOTGUN',
    'WEAPON_SAWNOFFSHOTGUN',
    'WEAPON_BULLPUPSHOTGUN',
    'WEAPON_DBSHOTGUN',
  },

  Objects = { --## This list will also populate based on things you make in the objectDefiner. Car-Keys is a required item for the car functionality. You could add them here if that was yer thing...


    --## This is the template for an object. You can add as many of these as you want to Config.Objects in order to use in the in-game creator
    ['Monitor'] = { --## This is going to be a unique name to this object don't replicate it anywhere else in this list. 
      ------- REQUIRED ALWAYS -------------------------
      Model  = "ex_prop_monitor_01_ex", --## The Model name https://gtahash.ru/ has these if you need them
      Tiny   = 1.0, ---## SET TO FALSE IF OBJECT IS LARGE SET TO A SMALL NUMBER IF OBJECT IS TINY 
      ---------------------------------------------

      ------- REQUIRED IF CARRY IS ENABLED --------
      Weight = 100, --## How much will this item weigh in a vehicle in kilograms? 
      Carry  = 0.25, --## Can this item be carried? false or number between 0.0 and 1.0 -- this number determines how fast you can walk with this -- 0.1 is like you're in slow mo as guidance.
      PRot   = {X = 0.0, y = 0.0, z = 0.0},--## Rotation for Carrying keep this as is if the object looks fine when you pick it up adjust otherwise
      PPos   = {X = 0.0, y = 0.0, z = 0.0},--## Positioning for Carryingkeep this as is if the object looks fine when you pick it up adjust otherwise
      ---------------------------------------------
      
      ------- REQUIRED IF SEARCH IS ENABLED -------
      Search = false, --## Can this item be searched? true or false
      ---------------------------------------------
     
      ------- REQUIRED IF GRAB IS ENABLED ---------
      Grab     = false, --## Can this item be picked up and put straight to inventory?
      GrabItem = "car-keys", --## Set to car-keys if you want to give access to garage otherwise set to any other item or an account in your framework e.g cash or money
      GrabMin   = 1,  --## How many of this item will they get if you are giving them an account e.g cash then this will be the amount they recieve   
      GrabMax   = 1,
      ---------------------------------------------
    },

    ['Car-Keys'] = {
      Tiny   = 0.3,
      Model  = "p_car_keys_01", 
      ------- REQUIRED IF GRAB IS ENABLED ---------
      Grab     = true, --## Can this item be picked up and put straight to inventory?
      GrabItem = "car-keys", --## Set to car-keys if you want to give access to garage otherwise set to any other item,
      GrabMin   = 1,     
      GrabMax   = 1,     
      -------------------------------------------------
    },
  },

  CarClasses = { -- This is the car classes you will choose from when/if you setup garages
    ['A'] = {
      ['blista'] = { --## Car Name is the index for this table.
        Chance = 85,  --## Chance out of 100 you could get this vehicle 85 being a high chance.
        Price  = math.random(500,1000) -- Price the car will sell for at the car-sale ped. I may expose events for your own use for this as it's basic.
      },
      ['sultan'] = {
        Chance = 25, 
        Price  = math.random(500,1000)
      },
    },
    ['B'] = {
      ['blista'] = {
        Chance = 25, 
        Price  = math.random(500,1000)
      },
      ['sultan'] = {
        Chance = 25, 
        Price  = math.random(500,1000)
      },
    },
  },

  PoliceJobs = { --# Police Jobs for Police Counts + Notifications
    police = true, -- JobName followed by true if they are considered cops (allows you to toggle cops towards the count off/on fairly quick and for me to index it easier hehe.)
  },

  PoliceAlert = function(pos,msg) --## Fill with your own police alert system I will include a basic one but you may want to use a secondary one. :shrug:
    
  end,

  AddKeys = function(veh,plate) --#' This is the function called to add keys for a vehicle you own. '
    if Config.UsingQBCore then 
      TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate) --## Standard event compatible with qb-vehiclekeys
      --TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(plate)) --## If using cd_garage then uncomment this
    elseif Config.UsingESX then 
      --TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(plate)) --## If using cd_garage then uncomment this
    end
  end,


  VehicleWeights = { --## This is the weight limit for putting grabbable objects in each car class (you define weight of an object in the objectdefiner see docs)
    [0] = 1000, 
    [1] = 1000,
    [2] = 1000,
    [3] = 1000,
    [4] = 1000,
    [5] = 1000,
    [6] = 1000,
    [7] = 1000,
    [8] = 1000,
    [9] = 1000,
    [10] = 1000,
    [11] = 1000,
    [12] = 1000,
    [13] = 1000,
    [14] = 1000,
    [15] = 1000,
    [16] = 1000,
    [17] = 1000,
    [18] = 1000,
    [19] = 1000,
    [20] = 1000,
    [21] = 1000, 
  },


  --## For selling stolen vehicles

  CarSellAccount = "cash",

  CarSellSpots = {
    vector3(-70.300704956055,-1822.5357666016,26.941974639893),    
  },


  CarryPayAccount = "cash", --## When selling items from your vehicle which account to pay into.
 
  ObjectSellSpots = {
    vector3(174.76301574707,-1806.51953125,29.077741622925), 
  }

}




if Config.UsingESX then  -- I guess you could change the event/export you use to get the object for your framework here 
  TriggerEvent("esx:getSharedObject", function(obj) ESX = obj; end)
elseif Config.UsingQBCore then 
  QBCore = exports['qb-core']:GetCoreObject()
end


