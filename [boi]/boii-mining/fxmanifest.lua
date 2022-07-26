-------------------------------
---------- CASE#2506 ----------
-------------------------------

fx_version 'adamant'

game 'gta5'

description 'BOII | Development; Mining Script'

version '0.2'

author 'case#2506'

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
    'server/*.lua',
    'client/mining_c.lua',
}

dependency '/assetpacks'