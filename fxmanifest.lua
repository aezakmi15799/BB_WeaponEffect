--[[

▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
██░▄▄▀█░▄▄▀██░▄▄▀██░███░██░▄▄▄░██░██░██░▄▄▄░██░▄▄░████░▄▄▄░██░▄▄▀██░▄▄▀█▄░▄██░▄▄░█▄▄░▄▄██░▄▄▄░
██░▄▄▀█░▀▀░██░▄▄▀██▄▀▀▀▄██▄▄▄▀▀██░▄▄░██░███░██░▀▀░████▄▄▄▀▀██░█████░▀▀▄██░███░▀▀░███░████▄▄▄▀▀
██░▀▀░█░██░██░▀▀░████░████░▀▀▀░██░██░██░▀▀▀░██░███████░▀▀▀░██░▀▀▄██░██░█▀░▀██░██████░████░▀▀▀░
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀

<Discord : AlertX#9397>,
<description 'This resource is created by BABYSHOP\'s Scripts'>

--]]

fx_version 'cerulean'
game 'gta5'
author '<Discord : AlertX>, <Website : Not >'
description 'This resource is created by BABYSHOP\'s Scripts'
github 'https://github.com/clementinise/kc-unicorn'
version '1.2'

shared_scripts {
	'config/general.setting.lua',
}

client_scripts {
	'config/general.setting.lua',
	'source/client/main-client.lua',
}

server_scripts {
	'config/general.setting.lua',
	'source/server/main-server.lua',
}

fivem_checker 'yes'
