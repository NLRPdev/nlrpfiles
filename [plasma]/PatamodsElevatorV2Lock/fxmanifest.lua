fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'PatamodsElevatorV2'
author 'Sarish#0609'
description 'Elevator made by Patamods (Patatichette) (https://discord.gg/zmQgVe7) for Patoche'
version '1.0.1'



client_scripts {
    'client.lua',
}


shared_scripts {
	'cfg.lua'
}

files {
	'img/elevatordown.png',
	'img/elevatorlobby.png',
	'img/elevatorrace.png',
	'img/elevatorup.png'
}

escrow_ignore {
  'cfg.lua'
 }
dependency '/assetpacks'