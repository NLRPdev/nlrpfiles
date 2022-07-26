fx_version 'cerulean'
game 'gta5'

author 'Blue_Rebel | Blue Rebel#1337'
description 'Advanced Moneywash Script'
version '1.0'

shared_scripts {
	'config.lua',
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

escrow_ignore {
  'server/*.lua',
  'client/*.lua',
  'config.lua'
}

lua54 'yes'

dependency '/assetpacks'