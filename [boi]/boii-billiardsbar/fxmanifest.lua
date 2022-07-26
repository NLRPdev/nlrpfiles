-------------------------------
---------- CASE#2506 ----------
-------------------------------

fx_version 'adamant'

game 'gta5'

author 'case#2506'

description 'BOII | Development - Billiards Bar Job Script'

version '1.1'

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
    'config.lua',
    'client/billiardsbar_c.lua',
    'server/billiardsbar_s.lua',
}
dependency '/assetpacks'