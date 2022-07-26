Loc["ro"] = {
	["common"] = { --commonly used strings
		owned = "Nu detii acest vehicul, nu il poti modifca",
		close = "❌ Inchide",
		ret = "⬅️ Intoarce",
		stock = "Stoc", -- Default, Original, whatever word you use for this
		current = "Deja montat",
		noOptions = "Nu exista optiuni",
		installing = "",
		amountoption = "Optiuni Valabile: ",
		already = " Deja montat", -- eg. "Stock Bumper already Installed"
		menuinstalled = " Optiunea a fost montata: ", --eg "[4 Options] Installed: Grille 1"
	},
	--Performance Items
	["armour"] = { --armour.lua
		cant = "Armura nu poate fi montata pe acest vehicul",
		already = "Armura a fost deja montata",
		install = "Armura se monteaza..",
		installed = "Armura a fost montata..",
		failed = "Montarea armurii a esuat!",
		removed = "Armura a fost scoasa",
		removing = "Scoatem armura..",
		remfail = "Scoaterea armurii a esuat!",
	},
	["brakes"] = { --brakes.lua
		cant = "Franele nu pot fi montate pe acest vehicul",
		already = "Franele sunt deja montate",
		install = "Se monteaza franele: ",
		installed = "Franele au fost montate..",
		failed = "Montarea franelor a esuat!",
		remove = "Franele au fost scoase",
		removing = "Scoatem franele..",
		remfail = "Scoaterea franelor a esuat!",
	},
	["engines"] = { --engines.lua
		cant = "Motorul nu poate fi montat pe acest  vehicul",
		already = "Motorul a fost deja montat",
		install = "Se monteaza motorul: ",
		installed = " Motorul a fost montat..",
		failed = "Montarea motorului a esuat!",
		remove = "Motorul a fost scos",
		removing = "Se scoate motorul..",
		remfail = "Scoaterea motorului a esuat!",
	},
	["suspension"] = { --suspension.lua
		cant = "Suspensia nu poate fi montata pe acest vehicul",
		already = "Suspensia este deja montata",
		install = "Se monteaza suspenia: ",
		installed = " Suspensie montata..",
		failed = "Montarea suspensiei a esuat!",
		removed = "Suspensia a fost scoasa",
		removing = "Scoatem suspensia..",
		remfail = "Scoaterea suspensiei a esuat!",
	},
	["transmission"] = { --transmission.lua
		cant = "Transmisia nu poate fi montata pe acest vehicul",
		already = "Transmisia a fost deja montata",
		install = "Se monteaza transmisia: ",
		installed = "Transmisia a fost montata..",
		failed = "Montarea transmisiei a esuat!",
		remove = "Transmisia a fost scoasa",
		removing = "Se scoate transmisia..",
		remfail = "Scoaterea transmisiei a esuat!",
	},
	["tires"] = { --tires.lua
		--Drift
   		already = "Cauciucurile de drift au fost deja montate",
		install = "Se monteaza cauciucurile de drift",
		installed = "Cauciucurile de drift au fost montate",
		failed = "Montarea caucicurilor de drift a esuat!",
		remove = "Cauciucurile de drift au fost scoase",
		removing = "Se scot cauciucurile de drift..",
		remfail = "Scoaterea cauciucurilor de drift a esuat!",
		swap = "Cauciucurile anti glont au fost schimbate!",
		--BProof
		already2 = "Cuciucurile antiglont sunt deja montate",
		install2 = "Se monteaza cauciucurile antiglont..",
		installed2 = "Cauciucurile antiglont au fost montate",
		failed2 = "Montarea cauciucurilor antiglont a esuat!",
		remove2 = "Cauciucurile antiglont au fost scoase",
		removing2 = "Se scot cauciucurile antiglont",
		remfail2 = "Scoaterea cauciucurilor antiglont a esuat!",
		swap2 = "Cauciucurile de drift au fost schimbate!",
	},
	["turbo"] = { --turbo.lua
		already = "Turbo suflanta e deja montata",
		install = "Se instaleaza turbosuflanta..",
		installed = "Turbo suflanta a fost montata..",
		failed = "Montarea turbo suflantei a esuat!",
		remove = "Turbo suflanta a fost scoasa",
		removing = "Se scoate Turbo..",
		remfail = "Scoaterea turbo suflantei a esuat!",
	},
	["xenons"] = { --xenons.lua
		already = "Xenoanele au fost deja montate",
		install = "Xenoanele se insteaza..",
		installed = "Xenoanele au fost montate",
		failed = "Montarea xenoanelor a esuat",
		remove = "Xenonul a fost scos",
		removing = "Se scoate xenonul..",
		remfail = "Scoaterea xenonului a esuat",
		closer = "Trebuie sa fi langa faruri",
		
		notinstall = "Xenoanele nu sunt montate",
		--Menus
		neonheader1 = "Contol faruri",
		neonheader2 = "Control Neoane",
		neonheader3 = "Culoare Neoane",
		neonheader4 = "Control xenoane",
		customheader = "Custom RBG",
		customconfrim = "Aplica",
		neontxt1 = "Control fin al neoanelor",
		toggle = "Aprinde toate luminile",
		front = "Neon fata",
		right = "Neon dreapta",
		left = "Neon stanga",
		back = "Neon spate",
		neontxt2 = "Schimba culoarea neoanelor",
		xenonheader = "Controler xenoane",
		xenontxt = "Ajusteaza culoarea farurilor",
	},

	--Cosmetic Items
	["bumpers"] = { --bumpers.lua
		stockMod = "Bara stock..",
		installed = "Bara a fost montata",
		failed = "Instalarea barii a esuat!",
		menuheader = "Cosmeticele grilajului si ale barii", --eg "Sultan RS Grille and Bumper Cosmetics"
		menugrille = "Grilaj",
		menuFBumper = "Bara fata",
		menuBBumper = "Bara spate",
	},	
	["exhaust"] = { --exhaust.lua
		stockMod = "Toba de esapament stock..",
		already = " Deja montata", -- eg. "Stock Bumper already Installed"
		installed = "Toba de esapament montata",
		failed = "Montarea tobei de esapament a esuat",
		menuheader = "Modificari ale tobei de esapament ", --eg "Sultan RS Grille and Bumper Cosmetics"
	},
	["exterior"] = { --exterior.lua
		stockMod = "Exterior stock..",
		installed = "Mod exterior instalat",
		failed = "Montarea modului exterior a esuat",
		menuheader = "Modificari exterior", --eg "Sultan RS Grille and Bumper Cosmetics"
		
		label1 = "Trim A",
		label2 = "Trim B",
		label3 = "Portbagaj",
		label4 = "Block Motor",
		label5 = "Filtru",
		label6 = "Struts",
		label7 = "Hydraulice",
		label8 = "Arch Covers",
		label9 = "Rezervor de benzina",
		label10 = "Aerials",
	},
	["hood"] = { --hood.lua
		stockMod = "Capota stock..",
		installed = "Capota montata",
		failed = "Montarea capotei a esuat",
		menuheader = "Modificari capota", --eg "Sultan RS Grille and Bumper Cosmetics"
	},	
	["horns"] = { --horns.lua
		installed = "Claxon montat",
		failed = "Montarea claxonului a esuat",
		menuheader = "Modificari claxon", --eg "Sultan RS Grille and Bumper Cosmetics"
	},
	["interior"] = { --interior.lua
		stockMod = "Mod interior stock..",
		installed = "Mod interior montat",
		failed = "Montarea modului interior a esuat",
		menuheader = "Modificari interior", --eg "Sultan RS Grille and Bumper Cosmetics"
		
		label1 = "Bare de sustinere",
		label2 = "Ornamente",
		label3 = "Panou",
		label4 = "Cadrane",
		label5 = "Boxe pe usi",
		label6 = "Volan",
		label7 = "Schimbator de viteza",
		label8 = "Placute",
		label9 = "Boxe",
	},	
	["livery"] = { --exhaust.lua
		oldMod = "Vechi",
		already = "Deja montat", -- eg. "Stock Bumper already Installed"
		installed = "Livery a fost montat",
		failed = "Montarea Lyvery a esuat",
		menuheader = "Modificari livery", --eg "Sultan RS Grille and Bumper Cosmetics"
	},		
	["nos"] = { --exhaust.lua
		notinstalled = "NOS nu este montat",
		installing = "Se monteaza NOS",
		installed = "NOS a fost montat",
		failed = "Montarea NOS a esuat",
		removing = "Scoatem butelia de NOS",
		removed = "Butelia NOS a fost scoasa",
		remfail = "Scoaterea buteliei NOS a esuat",
	},	
	["paint"] = { --paints.lua
		primary = "Culoare primara",
		secondary = "Culoare secundara",
		pearl = "Perla",
		wheel = "Roti",
		dashboard = "Cadrane",
		interior = "Interior",
		
		classic = "Classic",
		metallic = "Metalic",
		matte = "Mat",
		metals = "Metalic",
		
		installing = "Se aplica culoarea",
		installed = "Culoarea a fost aplicata",
		failed = "Aplicarea culorii a esuat",
		menuheader = "Revopsire",
	},
	["paintrgb"] = {
		select = "Selecteaza",
		finish = "Termina selectarea",
		error = "Hex Code input needs to be 6 characters",
		customheader = "Custom HEX",
		chrome = "Chrome",
		hex = "HEX Picker",
		rgb = "RGB Picker",
	},
	["plates"] = { --paints.lua
		already = "Placutele sunt deja montate",
		installing = "Se monteaza placutele..",
		installed = "Placutele au fost instalate",
		failed = "Instalarea placutelor a esuat",
		menuheader = "Modificarea placutelor",
		label1 = "Rama Placute",
		label2 = "Vanity Plates",
		label3 = "Placute custom",
		menuheader2 = " Stil placute custom",
	},
	["rims"] = {
		installing = "Montam jante..",
		installed = "Jantele au fost instalate",
		failed = "Instalarea jantelor a esuat",
		menuheader = "Modificari jante",
		
		label1 = "Sport",
		label2 = "Muscle",
		label3 = "Lowrider",
		label4 = "SUV",
		label5 = "Offroad",
		label6 = "Tuner",
		label7 = "Highend",
		label8 = "Benny's Originals",
		label9 = "Benny's Bespoke",
		label10 = "Open Wheel",
		label11 = "Street",
		label12 = "Track",
		label13 = "Front Wheel",
		label14 = "Back Wheel",
		label15 = "Motorcycle",
		
		labelcustom = "Custom Rims",
	},
	["rollcage"] = { --rollcage.lua
		installed = "Success! Roll Cage Installed",
		failed = "Roll Cage installation failed!",
		menuheader = " Roll Cage Modification",
	},
	["roof"] = { --roof.lua
		installed = "Plafon montat",
		failed = "Montarea plafonului a esuat",
		menuheader = "Modificari plafon", --eg "Sultan RS Grille and Bumper Cosmetics"
	},	
	["seat"] = { --seat.lua
		installed = "Scaune montate",
		failed = "Montarea scaunelor au esuat",
		menuheader = "Modificari sacune", --eg "Sultan RS Grille and Bumper Cosmetics"
	},
	["skirts"] = { --skirts.lua
		installed = "Praguri montate",
		failed = "Montarea pragurilor au esuat",
		menuheader = "Cosmetice praguri si fendere", --eg "Sultan RS Grille and Bumper Cosmetics"
		menuskirt = "Praguri",
		menuRF = "Fender drept",
		menuLF = "Fender stang",
	},		
	["spoilers"] = { --spoilers.lua
		installed = "Spoiler montat",
		failed = "Montarea spoilerului a esuat",
		menuheader = "Modificari spoiler", --eg "Sultan RS Grille and Bumper Cosmetics"
	},		
	["smoke"] = { --tiresmoke.lua
		already = "Culoarea e deja aplicata",
		installing = "Montam culoarea la cauciucuri..",
		installed = "Culoare aplicata",
		failed = "Aplicarea culorii a esuat",
		menuheader = "Modificari culoare cauciucuri", --eg "Sultan RS Grille and Bumper Cosmetics"
		
		remove = "Remove Smoke",
		custom = "CUSTOM RBG",
		black = "Negru",
		white = "Alb",
		blue = "Albastru",
		eblue = "Albastru electric",
		mgreen = "Verde menta",
		lgreen = "Verde lime",
		yellow = "Galben",
		gshower = "Golden Shower",
		orange = "Portocaliu",
		red = "Rosu",
		ppink = "Pony Pink",
		hpink = "Hot Pink",
		purple = "Mov",
		blacklight = "Blacklight",	
	
		submit = "Submit",
	},	
	["windows"] = { --windows.lua
		installed = "Folie geamuri aplicata",
		failed = "Aplicare folie geamuri esuata",
		menuheader = "Modificari folie geamuri", --eg "Sultan RS Grille and Bumper Cosmetics"
		
		label1 = "Scoatere folie geamuri",
		label2 = "Lime",
		label3 = "Verde",
		label4 = "Light Smoke",
		label5 = "Dark Smoke",
		label6 = "Pure Black",
	},	
	["stores"] = {
		browse = "Cauta in magazin",
		tools = "Scule mecanic",
		perform = "Upgradeuri performanta",
		cosmetic = "Upgradeuri Cosmetce",
	},
	["crafting"] = { --crafting.lua
		menuheader = "Crafting mecanici",
		toolheader = "Scule mecanici",
		performheader = "Upgradeuri performanta",
		cosmetheader = "Upgradeuri cosmetice",
		numitems = " Obiecte", --for menu. eg. "11 items"
		ingredients = "Nu ai materialele necesare",
	},
	["payments"] = { --payments.lua
		charge = "Scoate factura",
	},	
	["check"] = { --check_tunes.lua
		plate = "Placuta",
		value = "Valoare",
		unavail = "❌Nu e valoare",
		notinstall = "Nu e instalat",
		reinforced = "Ranforsare ",
		xenoninst = "Xenon Instalat",
		tireinst = "Instalat",
		
		label1 = "Motor",
		label2 = "Frane:",
		label3 = "Suspensii",
		label4 = "Transmisie:",
		label5 = "Armura:",
		label6 = "Turbo:",
		label7 = "Xenon:",
		label8 = "Cauciucuri de drift:",
		label9 = "Cauciucuri antiglont:",
		label10 = "Lista Modificari",
		label11 = "Vehicul: ",
		
		label12 = " Optiuni",
		label13 = "- Modificari externe -",
		label14 = "- Modificari interne - ",
		label15 = "Spoiler - [ ",
		label16 = "Bara fata - [ ",
		label17 = "Bara spate - [ ",
		label18 = "Praguri - [ ",
		label19 = "Toba de esapament - [ ",
		label20 = "Grilaj - [ ",
		label21 = "Capota- [ ",
		label22 = "Fender stanga- [ ",
		label23 = "Fender dreapta - [ ",
		label24 = "Plafon- [ ",
		label25 = "Rama placute - [ ",
		label26 = "Placute - [ ",
		label27 = "Trim A - [ ",
		label28 = "Trim B - [ ",
		label29 = "Portbagaj - [ ",
		label30 = "Bloc motor - [ ",
		label31 = "Filtru aer - [ ",
		label32 = "Engine Strut - [ ",
		label33 = "Faruri - [ ",
		
		label34 = "Bare de sustinere [ ",
		label35 = "Ornamente- [ ",
		label36 = "Bord - [ ",
		label37 = "Cadrane- [ ",
		label38 = "Boxe usi - [ ",
		label39 = "Scaune - [ ",
		label40 = "Volan- [ ",
		label41 = "Schimbator viteza",
		label42 = "Placute - [ ",
		label43 = "Boxe - [ ",
		label44 = "Hydraulice - [ ",
		label45 = "Aerials - [ ",
		label46 = "Rezervor de benzina - [ ",
		label47 = "✅ Da",
		label48 = "❌ Nu",
		label49 = "Vrei sa scoti franele?",
		label50 = "Vrei sa scoti motorul?",
		label51 = "Vrei sa scoti suspensia?",
		label52 = "Vrei sa scoti transmisia?",
		label53 = "Vrei sa scoti armura?",
		label54 = "vrei sa scoti Turbo?",
		label55 = "vrei sa scoti Xenoanele?",
		label56 = "Vrei sa scoti cauciucurile?",
		label57 = "vrei sa golesti NOS ?",
		label58 = "NOS:",
	},
	["repair"] = {
		browse = "Cauta in stash",
		materials = "Nu ai destule materiale",
		checkeng = "Verifica daune motor..",
		checkbody = "verifica daune caroserie..",
		
		engine = "Motor",
		body = "Caroserie",
		radiator = "Radiator",
		driveshaft = "Transmisie",
		brakes = "Frane",
		clutch = "Ambreiaj",
		tank = "Rezervor de benzina",
		
		repairing = "Repara",
		repaired = " Reparat complet",
		cancel = " Reparatie anulata",
		nomaterials = "Nu sunt destule materiale in seif",
		failinfo = "Nu ai reusit sa afli informatiile vehiculului,incearca sa folosesti sculele din nou",
		
		cost = "Pret ",
		status = "Status: ",
		doyou = "Vrei sa repari?",
		
		applyduct = "Aplica banda izoliera..",
		ductfull = "Prea multa banda izoliera ,dao dracu ca nu-i dacie",
		nocar = "Nu exista nici un vehicul in apropiere",
	},
	["police"] = {
		userepair = "Foloseste statia de reparare",
		repair = "Repara",
		extras = "Extra",
		plates = "Placute",
		livery = "Livery",
		spoiler = "Spoiler",
		cleaning = "Cleaning Vehicle...",
		engine = "Repairing Engine...",
		body = "Repairing Body...",
		complete = "Repair Complete",
	},
	["manual"] = {
		tyres = "Replacing Damaged Tyres",
		window = "Removing Damaged Windows",
		doors = "Repairing Doors",
	},
	["extras"] = {
		clean = "Spala vehicul",
		doorerr = "Eroare usa",
		locked = "Usa masinii e incuiata",
		flipping = "Intoarce vehicul",
		flipped =  "Vehicul intors",
		failed = "Intoarcerea masinii esuata",
		noseat = "Numar de locuri?",
		moveseat = "Te-ai mutat pe alt scaun ",
		fastseat = "Mergi prea repede..",
		notseat = "Acest scaun nu e disponibil..",
		harness = "Ai hamul pus..",
	},
	["functions"] = {
		distance = "Distanta: ",
		inCar = "Nu poti face asta din vehicul",
		outCar = "Nu poti face asta din afara vehiculului",
		locked = "Vehicle is Locked",
		nearby = "Nu e niciun vehicul in apropiere",
		shop = "Nu poti lucra decat in service!",
		mechanic = "Ai nevoie de un mecanic sa te ajute cu asta",
	},
	["servfunction"] = {
		checkdamage = "Verifica vehicul de daune",
		checkmods = "Verifica masina de moduri",
		flipvehicle = "Intoarce cel mai apropiat vehicul",
		togglesound = "Mareste sunet motor",
		togglesoundesc = "Seteaza sunet motor on/off",
		cleancar = "Curata vehicul",
		hood = "Inchide/deschide capota",
		trunk = "Inchide/deschide portbagaj",
		door = "Inchide/deschide portiera [0-3]",
		seat = "Schimba scaunul [-1 to 10]",
	},
	["previews"] = {
		changes = "Numar de modificari: ",
	},
	["garage"] = {
		jobgarage = "Job Garage",
		vehout = "Vehicle out of Garage",
		remveh = "Remove Vehicle",
		cantspawn = " in the way",
		marker = "Job Vehicle Marked on Map",
		markername = "Job Vehicle",
	},
	--Below are names of items/mods that can't be reteived natively
	vehiclePlateOptions = {
		{ name = "Blue on White #1", id = 0 },
		{ name = "Blue on White #2", id = 3 },
		{ name = "Blue on White #3", id = 4 },
		{ name = "Yellow on Blue", id = 2 },
		{ name = "Yellow on Black", id = 1 },
		{ name = "North Yankton", id = 5 },
	},
	vehicleNeonOptions = {
	    { name = "White", R = 255, G = 255, B = 255 },
        { name = "Blue", R = 2, G = 21, B = 255 },
        { name = "Electric Blue", R = 3, G = 83, B = 255 },
        { name = "Mint Green", R = 0, G = 255, B = 140 },
        { name = "Lime Green", R = 94, G = 255, B = 1 },
        { name = "Yellow", R = 255, G = 255, B = 0 },
        { name = "Golden Shower", R = 255, G = 150, B = 0 },
        { name = "Orange", R = 255, G = 62, B = 0 },
        { name = "Red", R = 255, G = 1, B = 1 },
        { name = "Pony Pink", R = 255, G = 50, B = 100 },
        { name = "Hot Pink", R = 255, G = 5, B = 190 },
        { name = "Purple", R = 35, G = 1, B = 255 },
        { name = "Blacklight", R = 15, G = 3, B = 255 }
	},
	vehicleXenonOptions = {
		{ name = "White", id = 0 },
		{ name = "Blue", id = 1 },
		{ name = "Electric Blue", id = 2 },
		{ name = "Mint Green", id = 3 },
		{ name = "Lime Green", id = 4 },
		{ name = "Yellow", id = 5 },
		{ name = "Golden Shower", id = 6 },
		{ name = "Orange", id = 7 },
		{ name = "Red", id = 8 },
		{ name = "Pony Pink", id = 9 },
		{ name = "Hot Pink", id = 10 },
		{ name = "Purple", id = 11 },
		{ name = "Blacklight", id = 12 }
	},
	vehicleHorns = {
		{ name = "Truck Horn", id = 0 },
		{ name = "Cop Horn", id = 1 },
		{ name = "Clown Horn", id = 2 },
		{ name = "Musical Horn 1", id = 3 },
		{ name = "Musical Horn 2", id = 4 },
		{ name = "Musical Horn 3", id = 5 },
		{ name = "Musical Horn 4", id = 6 },
		{ name = "Musical Horn 5", id = 7 },
		{ name = "Sad Trombone", id = 8 },
		{ name = "Classical Horn 1", id = 9 },
		{ name = "Classical Horn 2", id = 10 },
		{ name = "Classical Horn 3", id = 11 },
		{ name = "Classical Horn 4", id = 12 },
		{ name = "Classical Horn 5", id = 13 },
		{ name = "Classical Horn 6", id = 14 },
		{ name = "Classical Horn 7", id = 15 },
		{ name = "Scale - Do", id = 16 },
		{ name = "Scale - Re", id = 17 },
		{ name = "Scale - Mi", id = 18 },
		{ name = "Scale - Fa", id = 19 },
		{ name = "Scale - Sol", id = 20 },
		{ name = "Scale - La", id = 21 },
		{ name = "Scale - Ti", id = 22 },
		{ name = "Scale - Do", id = 23 },
		{ name = "Jazz Horn 1", id = 24 },
		{ name = "Jazz Horn 2", id = 25 },
		{ name = "Jazz Horn 3", id = 26 },
		{ name = "Jazz Horn Loop", id = 27 },
		{ name = "Star Spangled Banner 1", id = 28 },
		{ name = "Star Spangled Banner 2", id = 29 },
		{ name = "Star Spangled Banner 3", id = 30 },
		{ name = "Star Spangled Banner 4", id = 31 },
		{ name = "Classical Horn 8 Loop", id = 32 },
		{ name = "Classical Horn 9 Loop", id = 33 },
		{ name = "Classical Horn 10 Loop", id = 34 },
		{ name = "Classical Horn 8", id = 35 },
		{ name = "Classical Horn 9", id = 36 },
		{ name = "Classical Horn 10", id = 37 },
		{ name = "Funeral Loop", id = 38 },
		{ name = "Funeral", id = 39 },
		{ name = "Spooky Loop", id = 40 },
		{ name = "Spooky", id = 41 },
		{ name = "San Andreas Loop", id = 42 },
		{ name = "San Andreas", id = 43 },
		{ name = "Liberty City Loop", id = 44 },
		{ name = "Liberty City", id = 45 },
		{ name = "Festive 1 Loop", id = 46 },
		{ name = "Festive 1", id = 47 },
		{ name = "Festive 2 Loop", id = 48 },
		{ name = "Festive 2", id = 49 },
		{ name = "Festive 3 Loop", id = 50 },
		{ name = "Festive 3", id = 51 }
	},
	vehicleResprayOptionsClassic = {
		{ name = "Black", id = 0 },
		{ name = "Carbon Black", id = 147 },
		{ name = "Graphite", id = 1 },
		{ name = "Anhracite Black", id = 11 },
		{ name = "Black Steel", id = 11 },
		{ name = "Dark Steel", id = 3 },
		{ name = "Silver", id = 4 },
		{ name = "Bluish Silver", id = 5 },
		{ name = "Rolled Steel", id = 6 },
		{ name = "Shadow Silver", id = 7 },
		{ name = "Stone Silver", id = 8 },
		{ name = "Midnight Silver", id = 9 },
		{ name = "Cast Iron Silver", id = 10 },
		{ name = "Red", id = 27 },
		{ name = "Torino Red", id = 28 },
		{ name = "Formula Red", id = 29 },
		{ name = "Lava Red", id = 150 },
		{ name = "Blaze Red", id = 30 },
		{ name = "Grace Red", id = 31 },
		{ name = "Garnet Red", id = 32 },
		{ name = "Sunset Red", id = 33 },
		{ name = "Cabernet Red", id = 34 },
		{ name = "Wine Red", id = 143 },
		{ name = "Candy Red", id = 35 },
		{ name = "Hot Pink", id = 135 },
		{ name = "Pfsiter Pink", id = 137 },
		{ name = "Salmon Pink", id = 136 },
		{ name = "Sunrise Orange", id = 36 },
		{ name = "Orange", id = 38 },
		{ name = "Bright Orange", id = 138 },
		{ name = "Gold", id = 99 },
		{ name = "Bronze", id = 90 },
		{ name = "Yellow", id = 88 },
		{ name = "Race Yellow", id = 89 },
		{ name = "Dew Yellow", id = 91 },
		{ name = "Dark Green", id = 49 },
		{ name = "Racing Green", id = 50 },
		{ name = "Sea Green", id = 51 },
		{ name = "Olive Green", id = 52 },
		{ name = "Bright Green", id = 53 },
		{ name = "Gasoline Green", id = 54 },
		{ name = "Lime Green", id = 92 },
		{ name = "Midnight Blue", id = 141 },
		{ name = "Galaxy Blue", id = 61 },
		{ name = "Dark Blue", id = 62 },
		{ name = "Saxon Blue", id = 63 },
		{ name = "Blue", id = 64 },
		{ name = "Mariner Blue", id = 65 },
		{ name = "Harbor Blue", id = 66 },
		{ name = "Diamond Blue", id = 67 },
		{ name = "Surf Blue", id = 68 },
		{ name = "Nautical Blue", id = 69 },
		{ name = "Racing Blue", id = 73 },
		{ name = "Ultra Blue", id = 70 },
		{ name = "Light Blue", id = 74 },
		{ name = "Chocolate Brown", id = 96 },
		{ name = "Bison Brown", id = 101 },
		{ name = "Creeen Brown", id = 95 },
		{ name = "Feltzer Brown", id = 94 },
		{ name = "Maple Brown", id = 97 },
		{ name = "Beechwood Brown", id = 103 },
		{ name = "Sienna Brown", id = 104 },
		{ name = "Saddle Brown", id = 98 },
		{ name = "Moss Brown", id = 100 },
		{ name = "Woodbeech Brown", id = 102 },
		{ name = "Straw Brown", id = 99 },
		{ name = "Sandy Brown", id = 105 },
		{ name = "Bleached Brown", id = 106 },
		{ name = "Schafter Purple", id = 71 },
		{ name = "Spinnaker Purple", id = 72 },
		{ name = "Midnight Purple", id = 142 },
		{ name = "Bright Purple", id = 145 },
		{ name = "Cream", id = 107 },
		{ name = "Ice White", id = 111 },
		{ name = "Frost White", id = 112 },
	},
	vehicleResprayOptionsMatte = {
		{ name = "Black", id = 12 },
		{ name = "Gray", id = 13 },
		{ name = "Light Gray", id = 14 },
		{ name = "Ice White", id = 131 },
		{ name = "Blue", id = 83 },
		{ name = "Dark Blue", id = 82 },
		{ name = "Midnight Blue", id = 84 },
		{ name = "Midnight Purple", id = 149 },
		{ name = "Schafter Purple", id = 148 },
		{ name = "Red", id = 39 },
		{ name = "Dark Red", id = 40 },
		{ name = "Orange", id = 41 },
		{ name = "Yellow", id = 42 },
		{ name = "Lime Green", id = 55 },
		{ name = "Green", id = 128 },
		{ name = "Forest Green", id = 151 },
		{ name = "Foliage Green", id = 155 },
		{ name = "Olive Darb", id = 152 },
		{ name = "Dark Earth", id = 153 },
		{ name = "Desert Tan", id = 154 },
	},
	vehicleResprayOptionsMetals = {
		{ name = "Brushed Steel", id = 117 },
		{ name = "Brushed Black Steel", id = 118 },
		{ name = "Brushed Aluminium", id = 119 },
		{ name = "Pure Gold", id = 158 },
		{ name = "Brushed Gold", id = 159 },
		{ name = "Chrome", id = 120 },
	},
}