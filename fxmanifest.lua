fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'RNR`Developments'
description 'All Job Non Whitelist!'
version '0.0.2'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	-- '@rnr_core/locale.lua', -- Hidupin jika kamu menggunakan ESX!
    'config.lua',
	'server/*.lua'
}

client_scripts {
	-- '@rnr_core/locale.lua', -- Hidupin jika kamu menggunakan ESX!
	'config.lua',
	'client/**.lua',
}