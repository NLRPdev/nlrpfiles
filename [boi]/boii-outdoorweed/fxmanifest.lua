-------------------------------
---------- CASE#2506 ----------
-------------------------------

fx_version 'adamant'

game 'gta5'

description 'BOII | Development - Drugs; Outdoor Weed Script'

author 'case#1993'

version '1.1'

lua54 'yes'

shared_scripts {
    'config.lua',
}

client_scripts{
    'client/*.lua',
}

server_scripts{
	'@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

escrow_ignore {
    'config.lua',
    'server/outdoorweed_s.lua',
    'client/outdoorweed_c.lua',
}

dependency '/assetpacks'