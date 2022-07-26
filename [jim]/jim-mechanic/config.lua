print("Jim-Mechanic v2.6 - Mechanic Script by Jimathy")

Loc = {}
Config = {
	Lan = "en", -- Pick your language here
	Debug = false, -- Set to true to show green debug boxes to help track
	img = "qb-inventory/html/images/", -- Set this to the directory for your inventory image files
	distkph = false, -- Set to false to read distance travelled in Miles.
	
-- Main variables
	isVehicleOwned = true, -- Keep this true if you only want changes to be made to owned vehicles
	RequiresJob = true,  -- Do the specfic items require the mechanic job?
	LocationRequired = false, -- Are the mecahnics locked to specific locations? -- IF FALSE, DISABLES JobRequiredForLocation --
	LocationBlips = true, -- Enable to grab the blip locations from locations.lua
	CosmeticsJob = true, -- Do vehicle cosmetics require a mechanic job role?
	FreeRepair = false,  -- Are repairs free? True means yes
	StashRepair = true, -- Enable for repair materials to be removed from a job stash (disabled if RequiresJob = false)
	Stores = true, -- Set true to turn on shop storage features
	Crafting = true, -- Set true to turn on crafting features
	StashCraft = true,  -- Set true to grab materials from mechaincs stash for crafting
	PreviewPhone = true, -- Enable this is preview menu generates an email, False if you want to give an item
	PreviewJob = false, -- Enable this if you want the preview menu to require a Job Role or Location Checks
	JimShops = false, -- If using my free script jim-shops, enable this to use it with the mechanic stores.
	JimMenu = true, -- If using my free edit of qb-menu enable this.
	
	PhoneMail = "gks", -- If PreviewPhone is true, change this to choose the correct phone system
					  -- "qb" = use qb-phone for emails
					  -- "gks" = use gks-phone for emails
					
	CosmeticRemoval = false, -- If "true" items will be removed on successful application of a mod
							-- If "false" items will not be removed on use.
							
	ShowOdo = true, -- Wether the distance is showed in car by default
	OdoLocation  = "bottom-right", -- Where the Odometer will show, 
								 	-- "left", "right", "top", "top-left", "top-right", "bottom", "bottom-left", "bottom-right"
-- Player vehicle repair config
	ManualRepairCost = 5000, -- Set this to a high amount to get people to talk to mechanics rather than use automated systems
	
	ManualRepairBased = false, -- Set this to true if you want to set the repair cost to be based on QBCore.Shared.Vehicle costs(overrides the cost setting above)
	ManualRepairPercent = 5, -- Set this to the percent of the vehicle price (Only works if ManualRepairBased is true)
							 -- Default is 5% because $200,000 would be $10,000 max to repair by this system
							 -- 5% of a $10,000 car would be $500
							 
	repairEngine = true, -- Set this to true if automated repairs also repair engine (not just body)
	repairExtras = false, -- Set this to true for automated repairs to also repair extra damages (if mechanicjob is available and repairEngine is true)

	requireDutyCheck = true, -- if set to true, the repair bench will only be usable if there are no mechanics in the server ON DUTY
	dutyMessage = "There is a Mechanic on duty!", -- This is the notification that pops up when a person tries to repair when a mechanic is on duty, choose what you want for it.
	
	repairAnimate = true, -- Better than staring at a progress bar, "damaged" parts will be removed and replaced. Making it look more authentic
	repairSpeed = 1500, -- The time between each task while using repairAnimate. 1500 Seems to be a reasonable time for it
	
--Extra Vehicle Repair Costs
	RepairEngine = "iron",  ---Engine repair item and its MAX cost
	RepairEngineCost = 8,

	RepairBody = "plastic",  ---Body Repair item and its cost
	RepairBodyCost = 8,

	RepairRadiator = "plastic",  ---Radiator Repair item and its cost
	RepairRadiatorCost = 8,

	RepairAxle = "steel",  ---DriveShaft Repair item and its cost
	RepairAxleCost = 8,

	RepairBrakes = "iron",  ---Brakes Repair item and its cost
	RepairBrakesCost = 8,

	RepairClutch = "aluminum",  ---Clutch Repair item and its cost
	RepairClutchCost = 8,

	RepairFuel = "plastic",  ---Fuel Repair item and its cost
	RepairFuelCost = 8,

--DuctTape Controllers
	DuctSimpleMode = true, -- This will repair the engine to the max (set below)
	MaxDuctEngine = 300.0, -- 450.0 is 45% health, this will be the max amount that it can be repaired to
	DuctAmountEngine = 100.0, -- Repairs the engine by 10% each use

	DuctTapeBody = true,  --Enable if you want duct tape to repair body at the same time as engine
	MaxDuctBody = 300.0,
	DuctAmountBody = 100.0, -- Repairs the engine by 10% each use

	RemoveDuctTape = true, --If Enabled it will remove 1 duct after use. If false it will be constantly reusable

	JobRoles = { "mechanic", "rc", }, -- These are the job roles who can use items if RequiresJob is enabled. 
								-- Add your extra job roles here or just leave as "mechanic"
	--Example--
	--Config.JobRoles = { "mechanic", "tuner" }
}