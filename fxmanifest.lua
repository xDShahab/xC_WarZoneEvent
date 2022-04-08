fx_version 'adamant'
game 'gta5'

author 'xCoore Community - `Shahab#0128 - Discord.gg/xCoore'
description 'WarZone Event For Fivem - ESX'


-- server_script '@oxmysql/lib/MySQL.lua'
server_script '@mysql-async/lib/MySQL.lua'

server_scripts {
    'Server/*.lua', 
}

client_scripts {
    'Client/*.lua',
}