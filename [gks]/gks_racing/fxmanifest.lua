fx_version 'adamant'

game 'gta5'

description 'GKS RACING'

version '1.0'

lua54 'yes'

client_scripts {
	'config.lua',
	'client/functions.lua',
	'client/main.lua',
    'client/map2.lua'
}

files {
    'html/dist/index.html',
    'html/dist/css/app.css',
    'html/dist/js/app.js',
	'lang.json',
}

ui_page 'html/dist/index.html'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/functions.lua',
	'server/main.lua'
}

escrow_ignore {
	'config.lua'
}

dependency '/assetpacks'