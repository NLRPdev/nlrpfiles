fx_version 'bodacious'
game 'gta5'

author 'InZidiuZ'
description 'Legacy Fuel'
version '1.3'

ui_page 'html/ui.html'

lua54 'yes'

escrow_ignore {
	'**',
}

-- What to run
client_scripts {
	'config.lua',
	'functions/functions_client.lua',
	'source/fuel_client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'source/fuel_server.lua'
}

exports {
	'GetFuel',
	'SetFuel'
}

files {
	'html/ui.html',
	'html/ui.css', 
	'html/ui.js'
}
dependency '/assetpacks'