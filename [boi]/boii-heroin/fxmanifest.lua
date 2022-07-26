----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

fx_version 'cerulean'

game 'gta5'

author 'CASE#1993'

description 'BOII | Development - Heroin & Morphine Drug Script'

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
    'server/heroin_s.lua',
    'client/heroin_c.lua',
    'config.lua'
}
dependency '/assetpacks'