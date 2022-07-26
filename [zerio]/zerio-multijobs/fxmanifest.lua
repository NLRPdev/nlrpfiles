escrow_ignore {
    "locale.lua",
    "config.lua",
    "locales/*.lua",
    "client/functions.lua",
    "server/functions.lua"
}

fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_scripts {
    "locale.lua",
    "locales/*.lua",
    "config.lua"
}

client_scripts {
    "client/functions.lua",
    "client/main.lua"
}

server_scripts {
    "server/functions.lua",
    "server/main.lua"
}

files {
   "html/index.html",
   "html/script.js",
   "html/style.css",
   "html/libs/*.js",
   "html/libs/*.css"
}

ui_page "html/index.html"
dependency '/assetpacks'