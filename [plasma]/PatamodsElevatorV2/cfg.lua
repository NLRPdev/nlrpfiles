DEBUG = false
--Define Your Language
Lang = "EN"

--If you have multiple lift you can modify this to not interfere
EventHash = "LIFT45"

t = {
	["FR"] = {
	call = "Appuyez sur ~INPUT_CONTEXT~ pour appeler l'ascenseur",
	up =   "Appuyez sur ~INPUT_CONTEXT~ pour monter",
	down = "Appuyez sur ~INPUT_CONTEXT~ pour descendre",

	},
	["EN"] = {
	call = "Press ~INPUT_CONTEXT~ to call the elevator",
	up =   "Press ~INPUT_CONTEXT~ to go up",
	down = "Press ~INPUT_CONTEXT~ to go down",

	},
}

aff = print

function print(text)
	if DEBUG then
		aff(text)
	end
end

interiorID = nil

if IsDuplicityVersion() then

else 
	interiorID = GetInteriorAtCoords(-2260.2849121094,225.82176208496,169.70088195801)
	print("interiorID : "..tostring(interiorID))
end

-- Wait(150)

liftData = {
	-- ["789456"] = {
		code = "789456",
		
		controlup = {x=-2257.830078125,y=227.81008911133,z=169.7008972168}, --(Inter de control murale pour appeler la cabine)
		controldown = {x=-2257.6892089844,y=227.77281188965,z=108.37055206299}, 
		
		up = {x=-2252.746,y=226.3271,z=168.69+1.396}, --(position cabine) --  -1.396 mais je sais pas pk ca se decal ???
		down = {x=-2252.746,y=226.3271,z=107.37+1.396},
		
		offsetup = {x=-2252.746,y=226.3271,z=168.69}, --  -1.396 mais je sais pas pk ca se decal ??? spawn
		offsetdown = {x=-2252.746,y=226.3271,z=107.4},
		
		controlCabineUp = {x=-2256.5749511719,y=223.61421203613,z=169.69009399414}, --(Inter de control dans la cabine)
		controlCabineDown = {x=-2256.568359375,y=223.59599304199,z=108.39996337891},
		
		useMLOInterior = true,
		room = 549289364,
		interiorCoords = {x=-2260.2849121094,y=225.82176208496,z=169.70088195801},
		lodCoords = {x=-2260.2849121094,y=225.82176208496,z=139.70088195801},
		
		Zelevate=168.69-107.4, --Hauteur d'élévation Zmax - Zmin (flemme de calculer)
		
		isUp = true,
		
		isInUse = false,
		
		elevateProps = "patoche_plasmakart_elevator", --Cabine props
		rotation = {a=0.0,b=0.0,c=0.0},
		elevateHeading = 90.0, --Heading de l'ascenceur (World relative)
		elevateID = 0, -- ID du props spawn
		elevateNetID = 0,
		elevateNetOwner = 0,
		
		downDoorIsOpen = false,
		
		doorDown = "patoche_plasmakart_elevator_door2",
		doorDownCoords = {x=-2257.1,y=225.7272,z=107.38},
		doorDownOpenCoords = {x=-2257.1,y=225.7272,z=109.86},
		doorDownHeading = 90.0,
		doorDownID = 0, -- ID du props spawn
		doorDownNetID = 0,
		doorDownNetOwner = 0,
		
		upDoorIsOpen = true,
		
		doorUp = "patoche_plasmakart_elevator_door1",
		doorUpCoords = {x=-2257.1,y=225.7272,z=168.735},
		doorUpOpenCoords = {x=-2257.1,y=225.7271,z=171.2},
		doorUpHeading = 90.0,
		doorUpID = 0,-- ID du props spawn
		doorUpNetID = 0,
		doorUpNetOwner = 0,
		
}