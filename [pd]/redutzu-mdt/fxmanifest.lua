fx_version 'cerulean'
game 'gta5'

author 'Redutzu'
version '2.0.2'
description '✨ A good looking police MDT'
github 'https://github.com/redutzu'

lua54 'yes'

ui_page 'dist/index.html'

shared_scripts {
    'shared/utils.lua',
    'shared/sh_config.lua'
}

client_scripts {
    'shared/cl_config.lua',
    'client/animation.lua',
    'client/functions.lua',
    'client/alerts.lua',
    'client/chat.lua',
    'client/callbacks.lua',
    'client/main.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'shared/sv_config.lua',
    'server/functions.lua',
    'server/database.lua',
    'server/callbacks.lua',
    'server/alerts.lua',
    'server/chat.lua',
    'server/main.lua'
}

escrow_ignore {
    'shared/sh_config.lua',
    'shared/sv_config.lua',
    'shared/cl_config.lua'
}

files {
    'dist/index.html',
    'dist/nui.js',
    'dist/*.png',
    'dist/*.jpg',
    'dist/*.ogg'
}

dependencies {
    '/assetpacks',
    'screenshot-basic',
    'oxmysql',
    'qb-core',
    -- 'loaf_housing', -- (uncomment this only if you use loaf-housing)
    -- 'qs-housing', -- (uncomment this only if you use quasar-housing)
    'webpack',
    'yarn'
}

webpack_config 'webpack.config.js'

dependency '/assetpacks'