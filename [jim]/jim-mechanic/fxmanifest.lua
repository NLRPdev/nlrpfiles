name "Jim-Mechanic"
author "Jimathy"
version "v2.6"
description "Mechanic Script By Jimathy"
fx_version "cerulean"
game "gta5"

dependencies {
	'qb-menu',
	'qb-input',
}

shared_scripts {
	'config.lua',
	'locales/*.lua',
	'client/functions.lua',
	'recipes.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/*.lua',
	'html/drawtext.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

ui_page 'html/index.html'

files {
	'html/*.html',
	'html/*.css',
	'html/*.js'
}

lua54 'yes'

escrow_ignore {
	'*.lua*',
	'client/*.lua*',
	'server/*.lua*',
	'locales/*.lua*',
	'html/*.lua*',
	'html/*.css*',
	'html/*.html*',
	'html/*.js*',
}
dependency '/assetpacks'