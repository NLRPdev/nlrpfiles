fx_version 'adamant'
game 'gta5'
lua54 'yes'

description 'Flatbeds Script v3'
author 'Theebu'

version '0.3.9'

client_scripts {
	'config.lua',
	'client/client.lua',
	'client/utils.lua',
}

server_scripts {
	'server/server.lua'
}

escrow_ignore {
	'config.lua',
	'client/utils.lua'
}
dependency '/assetpacks'