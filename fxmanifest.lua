fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'RNR`Developments'
description 'All Job Non Whitelist!'
version '0.0.2'

shared_scripts {
	'@ox_lib/init.lua',
	'shared/sh_*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/**.lua'
}

client_scripts {
	'client/**.lua',
}