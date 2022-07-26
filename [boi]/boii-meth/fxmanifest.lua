-------------------------------
---------- CASE#1993 ----------
-------------------------------

fx_version 'cerulean'

game 'gta5'

author 'CASE#1993'

description 'BOII | Development - Meth Drug Script'

version '1.2'

lua54 'yes'

shared_scripts {
    'config.lua',
}

client_scripts{
    'client/*.lua',
}

server_scripts{
    'server/*.lua',
}
escrow_ignore{
    'server/meth_s.lua',
    'client/meth_c.lua',
    'config.lua'
}
dependency '/assetpacks'