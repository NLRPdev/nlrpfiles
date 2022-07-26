-------------------------------
---------- CASE#1993 ----------
-------------------------------

fx_version 'cerulean'

game 'gta5'

author 'CASE#1993'

description 'BOII |  Development - Pawnshop Script'

version '2.0'

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
    'config.lua',
    'server/pawnshop_s.lua',
    'client/pawnshop_c.lua',
}
dependency '/assetpacks'