-------------------------------
---------- CASE#1993 ----------
-------------------------------

fx_version 'cerulean'

game 'gta5'

author 'CASE#1993'

description 'BOII | Development - Cocaine & Crack Drug Script'

version '1.2'

lua54 'yes'

shared_scripts {
    'config.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}
escrow_ignore {
    'client/cocaine_c.lua',
    'server/cocaine_s.lua',
    'config.lua',
}
dependency '/assetpacks'