-------------------------------
---------- CASE#2506 ----------
-------------------------------

### BOII MINING ###

Just a simple but rewarding mining script for your city.
Your citizens can drill for paydirt at the quarry with a chance for premium paydirt! After purchasing a permit of course!
After they can head to the foundry to process their dirt into rewards.
Highly customisable.
Enjoy.

### USAGE ###

- Speak to ped to purchase a mining permit
- Third-eye targeting on the rocks to drill for paydirt
- Rewards paydirt or premium paydirt 
- Regular paydirt rewards materials premium paydirt rewards gems
- You will have to add your own way of selling the gems unless you use our pawnshop resource

### INSTALL ###

1) Customise `config.lua` to your liking.
2) Drag and drop `boii-mining` into your server resources
3) Add item information provided into `qb-core/shared.lua` or `qb-core/shared/items.lua`
4) Add images provided into `qb-core/inventory/html/images`
5) Restart your city 

**ENSURE THAT YOU HAVE ALL OF THE REQUIREMENTS BELOW INSTALLED AND YOUR LOAD ORDER IS CORRECT (QB-TARGET AND PROGRESSBAR SHOULD BE ENSURED AFTER QB-CORE AND BEFORE OUR SCRIPTS**

### SHARED.LUA ### 

	-- Mining
    ["miningpermit"]             = {["name"] = "miningpermit",              ["label"] = "Mining Permit",            ["weight"] = 10,         ["type"] = "item",      ["image"] = "miningpermit.png",        ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "You need a mining permit to mine at the quarry!"},
    ["paydirt"]                  = {["name"] = "paydirt",                   ["label"] = "Paydirt",                  ["weight"] = 3500,       ["type"] = "item",      ["image"] = "paydirt.png",             ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "A bag of paydirt! I wonder whats inside?"},
    ["premiumpaydirt"]           = {["name"] = "premiumpaydirt",            ["label"] = "Premium Paydirt",          ["weight"] = 2500,       ["type"] = "item",      ["image"] = "premiumpaydirt.png",      ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "A bag of premium paydirt! I wonder whats inside?"},
    ["gold"]                     = {["name"] = "gold",                      ["label"] = "Gold Scraps",              ["weight"] = 200,        ["type"] = "item",      ["image"] = "gold.png",                ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "A handful of gold scraps."},
    ["diamond"]                  = {["name"] = "diamond",                   ["label"] = "Diamond",                  ["weight"] = 100,        ["type"] = "item",      ["image"] = "diamond.png",             ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "A shiny diamond."},
    ["emerald"]                  = {["name"] = "emerald",                   ["label"] = "Emerald",                  ["weight"] = 100,        ["type"] = "item",      ["image"] = "emerald.png",             ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "A shiny emerald."},
    ["ruby"]                     = {["name"] = "ruby",                      ["label"] = "Ruby",                     ["weight"] = 100,        ["type"] = "item",      ["image"] = "ruby.png",                ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "A shiny ruby."},
    ["opal"]                     = {["name"] = "opal",                      ["label"] = "Opal",                     ["weight"] = 100,        ["type"] = "item",      ["image"] = "opal.png",                ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "A shiny opal."},
    ["black_diamond"]            = {["name"] = "black_diamond",             ["label"] = "Black Diamond",            ["weight"] = 100,        ["type"] = "item",      ["image"] = "black_diamond.png",       ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "A rare black diamond!"}, 
    ["pink_diamond"]             = {["name"] = "pink_diamond",              ["label"] = "Pink Diamond",             ["weight"] = 100,        ["type"] = "item",      ["image"] = "pink_diamond.png",        ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "A rare pink diamond!"}, 
    ["sapphire"]                 = {["name"] = "sapphire",                  ["label"] = "Sapphire",                 ["weight"] = 100,        ["type"] = "item",      ["image"] = "sapphire.png",            ["unique"] = false,      ["useable"] = false,     ["shouldclose"] = true,    ["combinable"] = nil,   ["description"] = "A shiny sapphire."},
	
### REQUIREMENTS ###

qb-menu - https://github.com/qbcore-framework/qb-menu
qb-target - https://github.com/BerkieBb/qb-target
progressbar - https://github.com/qbcore-framework/progressbar


### PREVIEW ###
https://www.youtube.com/watch?v=tsBMTxHd_VA

### SUPPORT ### 
https://discord.gg/MUckUyS5Kq


