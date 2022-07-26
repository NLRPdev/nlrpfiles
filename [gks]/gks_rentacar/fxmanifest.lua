
fx_version 'cerulean'
games { 'gta5' }
description 'GKSHOP - Mcadence'
version '1.0'

files {
    -- TEST
	'img/*.jpg',
	'img/*.png'
}

-- Client Scripts
client_script "config.lua"
client_script "client.lua"
client_script "clientAPI.lua"
-- Server Scripts
server_script "@oxmysql/lib/MySQL.lua"
server_script "config.lua"
server_script "server.lua"


lua54 'yes'

escrow_ignore {
	'config.lua', 
	'clientAPI.lua'  
}
dependency '/assetpacks'