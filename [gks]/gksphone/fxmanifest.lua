fx_version 'cerulean'
games { 'gta5' }

description 'GKSPHONE'
version '1.5.1'

ui_page 'html/index.html'

data_file 'DLC_ITYP_REQUEST' 'stream/patoche_props_phone.ytyp'

shared_scripts {
    '@qb-apartments/config.lua',
    '@qb-garages/config.lua',
}

files {
	'html/index.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/static/fonts/*.otf',
	'html/static/fonts/*.ttf',
	'html/static/config/config.json',
	'html/static/config/lang/*.json',

    -- TEST
	'html/static/img/**/*.jpg',
	'html/static/img/**/*.png',
	'html/static/img/**/*.svg',
	'html/static/sound/*.ogg',
	'html/static/sound/*.mp3',
}

client_script {
	'locales.lua',
	"locales/*.lua",
	"config.lua",
	"client/prop.lua",
	"client/client.lua",
	"client/photo.lua",
	"client/bank.lua",
	"client/twitter.lua",
	"client/yellow.lua",
	"client/instagram.lua",
	"client/valet.lua",
	"client/client2.lua",
	"client/clientAPI.lua",
	"client/race.lua"
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'locales.lua',
	"locales/*.lua",
	"config.lua",
	"configAPI.lua",
	"server/server.lua",
	"server/serverAPI/*.lua",
	"server/twitter.lua",
	"server/yellow.lua",
	"server/instagram.lua",
	"server/server2.lua",
	"server/versioncheck.lua",
}

-- Client Exports --
exports {
    'CheckFlightMode',
	'PhoneNumber',
	'CheckOpenPhone',
	'ClosePhone',
	'BlockOpenPhone'
}

server_exports {
	'cryptoadd',
	'cryptoremove',
	'GetSourceByPhone'
}

lua54 'yes'

escrow_ignore {
	'locales.lua',
	'locales/en.lua',
	'config.lua',
	'configAPI.lua',
	"server/serverAPI/*.lua",
	'client/prop.lua',
	'client/valet.lua',
	'client/photo.lua',
	'client/clientAPI.lua'
}

dependency '/assetpacks'