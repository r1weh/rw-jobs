resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'RUW3T'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
    'config.lua',
	'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
	'config.lua',
	'client/cl_mape.lua',
	'client/lumberjack.lua',
	'client/tambang.lua',
	'client/cabe.lua',
	'client/pembuangan.lua',
	'client/coklat.lua',
	'client/garam.lua',
	'client/kopi.lua',
	'client/padi.lua',
	'client/tebu.lua',
	'client/teh.lua'
}

dependencies {
	'es_extended'
}