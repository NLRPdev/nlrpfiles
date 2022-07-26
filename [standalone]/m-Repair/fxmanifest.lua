fx_version 'cerulean'
author '! marcinhu.#6158'
Description 'Repairs'
game 'gta5'

shared_scripts {
    'config.lua',
}

client_scripts{
    'client/**.lua',
}

server_scripts{
    'server/**.lua',
}

escrow_ignore {
    'config.lua',
    'client/c_geral.lua',
    'server/s_geral.lua',
}

lua54 'yes'

dependency '/assetpacks'