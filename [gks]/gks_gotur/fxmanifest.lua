fx_version 'cerulean'
games { 'gta5' }
description 'GKSHOP - GKS GOTUR JOB'
version '1.0'

files {
    -- TEST
	'img/*.jpg',
	'img/*.png'
}

-- Client Scripts
client_scripts {
	'@menuv/menuv.lua',
	'config.lua',
	'client/main.lua'
}
-- Server Scripts
server_scripts {
	"@oxmysql/lib/MySQL.lua",
	'config.lua',
	'server/main.lua',
}

dependencies {
    'menuv'
}

lua54 'yes'


escrow_ignore {
	'config.lua',
	'client/*.lua',
	'server/*.lua'
}

dependency '/assetpacks'