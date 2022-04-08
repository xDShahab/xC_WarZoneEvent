ESX = nil 
TriggerEvent('esx:xCooreShared', function(obj) ESX = obj end)
local PermStart = 10 -- // Perm Start Wz
local Permend =10 -- // Perm End Wz
local WarZoneWorld = 90 -- // World Wz
local Lobbey = false 
local WorldLob = 89
local AllPlayerInWz = 0
local WarZone = { -- Neyazi be Edit Inja Nist Serfan Jahat Amoozesh
    Start = false , --> Start Warozne true = Yes
    Health = 0 , --> Teadad Jon Player 
    Distance = 0.0 , --> Andaze Zone Warzone
    Coords = vector3(-1266.35,-3010.98,-48.0) , --> Mokhtsat Warzone
    Time = 0, --> Zaman Baste Shodan Har Zone min
}

RegisterCommand("swarzone",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if WarZone.Start == true then return
        TriggerClientEvent('esx:showNotification', source, "~r~Dar Hale Hazer Yek Match WarZone Start Hast")
    end 
    if Lobbey then return 
        TriggerClientEvent('esx:showNotification', source, "~r~Dar Hale Hazer Yek Lobby WarZone Baz Hast") 
    end
    if xPlayer.permission_level >= PermStart  then 
        Lobbey = true 
        TriggerClientEvent('chat:addMessage',  xPlayer.source, {
            template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#0060ff, #0000ff);border-radius: 20px;box-shadow: 0 0 10px #0060ff;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:7px;border-radius:10px;"><i class="fa fa-bullhorn"></i></span> <b>WarZone</b></span>{0}</div>',
            args = { "Event WarZone Start Shod Jahat Vorud Be Event Warzon ^4/joinwz^0 Ra Bezanid " }
        })
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Shoma Dastresi Kafi Barai In Kar Nadarid')   
    end
end)

RegisterCommand("joinwz",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if GetPlayerRoutingBucket(source) == WorldLob then return end 
    if Lobbey  then 
        Lobbey = true 
        TriggerClientEvent('chat:addMessage',  xPlayer.source, {
	    	template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#24b300, #349426);border-radius: 20px;box-shadow: 0 0 10px #24b300;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:7px;border-radius:10px;"><i class="fa fa-bullhorn"></i></span> <b>WarZone</b></span>{0}</div>',
            args = { "Shoma Join Event WarZone Dadid Lotfan Ta Start Shodan Event Montazer Bemanid " }
        })
        SetPlayerRoutingBucket(source,WorldLob)
        TriggerClientEvent("WarZone:JoinLobbery",source)
        TriggerClientEvent("WarZone:UpdateMembers",source,AllPlayerInWz) 
    else 
        TriggerClientEvent('chat:addMessage',  xPlayer.source, {
            template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#d81c1f, #8b2525);border-radius: 20px;box-shadow: 0 0 10px #d81c1f;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:7px;border-radius:10px;"><i class="fa fa-bullhorn"></i></span> <b>WarZone</b></span>{0}</div>',
            args = { "Lobby WarZone Baste Shoda Va Nmitavanid Join Bedid" }
        }) 
    end
end)

RegisterCommand("clwz",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if WarZone.Start == true then return  TriggerClientEvent('esx:showNotification', source, "~r~Event WarZone Dare Bargozar Mishe") end 
    if Lobbey == false  then return  TriggerClientEvent('esx:showNotification', source, "~r~Lobbey WarZone Baz Nist") end 
    if xPlayer.permission_level >= Permend  then 
        TriggerClientEvent('chat:addMessage',  xPlayer.source, {
            template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#d81c1f, #8b2525);border-radius: 20px;box-shadow: 0 0 10px #d81c1f;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:7px;border-radius:10px;"><i class="fa fa-bullhorn"></i></span> <b>WarZone</b></span>{0}</div>',
            args = { "Lobby WarZone Baste Shoda !" }
        }) 
        local xPlayers = ESX.GetPlayers()
        for k, v in pairs (xPlayers) do 
            if GetPlayerRoutingBucket(v) == WorldLob then
                TriggerClientEvent("WarZone:ExitMision",v)
            end 
        end 
        WarZone = {
            Start = false , 
            Health = 0 , 
            Distance = 0.0 , 
            Coords = vector3(216.14, -816.73, 30.64) ,
            Time = 0 
        }
        Wait(710)
        Lobbey = false 
    else 
        TriggerClientEvent('esx:showNotification', source, '~r~Shoma Dastresi Kafi Barai In Kar Nadarid')   
    end
end)


RegisterCommand("cwz",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Players = 0 
    if Lobbey == false then return  
        TriggerClientEvent('esx:showNotification', source, "~r~  Lobbery WarZone Start Nist  ") 
    end 
    if WarZone.Start == true  then return  
        TriggerClientEvent('esx:showNotification', source, "~r~  WarZone Starte ") 
    end 
    if xPlayer.permission_level >= PermStart  then 
        if tonumber(args[1]) and tonumber(args[2])  and tonumber(args[3])  then   
            if  tonumber(args[2]) > 2000 then return
                TriggerClientEvent('esx:showNotification', source, "~r~ Andaze Zone Besyar Bozorg Ast ") 
            end  
            if  tonumber(args[2]) < 500 then return  
                TriggerClientEvent('esx:showNotification', source, "~r~ Andaze Zone Besyar Kochick Ast ") 
            end 
            Lobbey = false 
            WarZone = {
                Start = true , 
                Health = tonumber(args[1]) , 
                Distance = tonumber(args[2]) , 
                Coords = GetEntityCoords(GetPlayerPed(source)),
                Time = tonumber(args[3])
                }
                Wait(710)
                WarZone_()
                TriggerClientEvent('chat:addMessage',  xPlayer.source, {
                    template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#24b300, #349426);border-radius: 20px;box-shadow: 0 0 10px #24b300;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:7px;border-radius:10px;"><i class="fa fa-bullhorn"></i></span> <b>WarZone</b></span>{0}</div>',
                    args = { "Event WarZone Start Shod  Ba Hozor ^4"..AllPlayerInWz.."^0 Player !" }
                })
                Wait(710)
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Gozine Vared Shode Eshtebah Ast")
        end 
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Shoma Dastresi Kafi Barai In Kar Nadarid')   
    end
end)

RegisterCommand("endwz",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if WarZone.Start == false then return  
        TriggerClientEvent('esx:showNotification', source, "~r~  WarZone Start Nist ") 
    end 
    if xPlayer.permission_level >= Permend then 
        WarZone = {
            Start = false , 
            Health = 0 , 
            Distance = 0.0 , 
            Coords = vector3(216.14, -816.73, 30.64) ,
            Time = 0 
        }
        AllPlayerInWz = 0 
        TriggerClientEvent("WarZone:UpdateMembers",source,0)
         
        local xPlayers = ESX.GetPlayers()
        for k, v in pairs (xPlayers) do 
            if GetPlayerRoutingBucket(v) == WarZoneWorld then
                TriggerClientEvent("WarZone:ExitMision",v)
            end 
        end 
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Shoma Dastresi Kafi Barai In Kar Nadarid')   
    end
end)

RegisterCommand("exitwz",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if WarZone.Start == false then return
        TriggerClientEvent('esx:showNotification', source, "~r~Hich Event WarZonei Start Nist ") 
    end 
    if GetPlayerRoutingBucket(source) == 90 then 
        TriggerClientEvent("WarZone:ExitMision",source)
        TriggerClientEvent('esx:showNotification', source, '~g~Shoma Az Event WarZone Kharej Shodid')
    end 
end)

function WarZone_()
    if WarZone.Start ~= true then 
        return   
    end 
    local xPlayers = ESX.GetPlayers()
    for k, v in pairs (xPlayers) do 
        if GetPlayerRoutingBucket(v) == WorldLob then
            TriggerClientEvent("WarZone:StartMision",v,WarZone.Start,WarZone.Health,WarZone.Distance,WarZone.Coords ,WarZone.Time)
        end 
    end    
end 

AddEventHandler('playerDropped', function ()
    if WarZone.Start ~= true  and GetPlayerRoutingBucket(source) == WarZoneWorld  then 
        TriggerClientEvent("WarZone:DC",source)
    end     
end)

RegisterServerEvent("esx:onPlayerDeath")
AddEventHandler("esx:onPlayerDeath", function(KillData)
    if WarZone.Start ~= true then return   end 
    if GetPlayerRoutingBucket(source) ~= WarZoneWorld  then return end 
     TriggerClientEvent("WarZone:respwan",source,false)
    local xPlayers = ESX.GetPlayers()
    for k, v in pairs (xPlayers) do 
        if GetPlayerRoutingBucket(v) == WarZoneWorld then
            if  tonumber(KillData.killer)  then 
                TriggerClientEvent("WarZone:respwan",KillData.killer,true)
                TriggerClientEvent("xC_KillFeed",v, GetPlayerName(KillData.killer), GetPlayerName(source), string.upper(string.lower(ESX.Math.Trim(string.gsub("WEAPON_"..KillData.deathCause, " ", "")))), true, "pvp")
                ESX.GetPlayerFromId(KillData.killer).addMoney(1000)
                return 
      else 
        TriggerClientEvent("xC_KillFeed",v,'LOL', GetPlayerName(source), 'nil', true, "pvp")
      end
        end
    end
end)

RegisterServerEvent("Warzone:SetW")
AddEventHandler("Warzone:SetW", function(Wz)
    if WarZone.Start == true and  Lobbey == false  or  WarZone.Start == false   and   Lobbey == true  then  
        SetPlayerRoutingBucket(source,Wz)
    end 
end)

RegisterNetEvent("WarZone:OnPlayerChange")
AddEventHandler("WarZone:OnPlayerChange",function(exit)
    if exit then 
    AllPlayerInWz = AllPlayerInWz -1 
    else 
        AllPlayerInWz = AllPlayerInWz + 1 
    end 
        TriggerClientEvent("WarZone:UpdateMembers",-1,AllPlayerInWz) 
        if  WarZone.Start == true and  Lobbey == false  then 
            if   AllPlayerInWz == 1  then 
            local xPlayers = ESX.GetPlayers()
            for k, v in pairs (xPlayers) do 
                if GetPlayerRoutingBucket(v) == WarZoneWorld then
                    local Name = GetPlayerName(v)
                    TriggerClientEvent('chat:addMessage',  xPlayer.source, {
                    template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#0060ff, #0000ff);border-radius: 20px;box-shadow: 0 0 10px #0060ff;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:7px;border-radius:10px;"><i class="fa fa-bullhorn"></i></span> <b>WarZone</b></span>{0}</div>',
                    args = { "WarZone Tamam Shod Va ^4"..Name.."^0 Barande Shod" }
                }) 
                end 
            end 
        end
    end 
end)