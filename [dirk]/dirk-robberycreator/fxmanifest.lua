fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'
mod 'dirk-robcreator'
version '1.0.0'

ui_page 'src/nui/index.html'

description 'In-Game Robbery Creator. Creator: DirkDiggler#6969'

client_script {
  'src/ShellSettings.lua',
  'userConfig/*.lua',
    
  'src/client/fw.lua',
  'src/client/utils.lua',
  'src/client/functions.lua'
}


server_script {
  'userConfig/*.lua',
  -- 'userConfig/config.lua',
 
  'src/ShellSettings.lua',
  'src/server/fw.lua',
  'src/server/utils.lua',
  'src/server/dataloading.lua',
  'src/server/doors.lua',
  'src/server/objects.lua',
  'src/server/peds.lua',
  'src/server/functions.lua'
}


escrow_ignore{
  'userConfig/*.lua',
  'userData/*.lua',
  'userData/*.json',

  'src/server/fw.lua',
  'src/server/utils.lua',

  'src/client/fw.lua',
  'src/client/utils.lua',

}
dependencies {
    'dirk-shn',
}
files{
  'src/nui/index.html',  
}

dependency '/assetpacks'