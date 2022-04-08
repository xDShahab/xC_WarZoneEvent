ESX = nil 
TriggerEvent('esx:xCooreShared', function(obj) ESX = obj end)

local PermStart = 10 -- // Permmision For Start Warzone
local Permend =10 -- // Permmision For End Warzone
local WarZoneWorld = 90 -- // World WarZone Event

local Lobbey = false 
local WorldLob = 89
local AllPlayerInWz = 0

local WarZone = { 
    Start = false ,
    Health = 0 , 
    Distance = 0.0 ,
    Coords = vector3(-1266.35,-3010.98,-48.0) ,
    Time = 0,
}

RegisterCommand("swarzone",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if WarZone.Start == true then return
        TriggerClientEvent('esx:showNotification', source, "~r~A Warzone Event Has Already Started")
    end 
    if Lobbey then return 
        TriggerClientEvent('esx:showNotification', source, "~r~A Warzone Lobby Has Already Started") 
    end
    if xPlayer.permission_level >= PermStart  then 
        Lobbey = true 
        TriggerClientEvent('chat:addMessage',  xPlayer.source, {
            template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#0060ff, #0000ff);border-radius: 20px;box-shadow: 0 0 10px #0060ff;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:7px;border-radius:10px;"><i class="fa fa-bullhorn"></i></span> <b>WarZone</b></span>{0}</div>',
            args = { "WarZone Event Started Please Type ^1/joinwz ^0 For Join To The Lobby" }
        })
    else
        TriggerClientEvent('esx:showNotification', source, '~r~You Dont Have Permmision For Use This Command')   
    end
end)

RegisterCommand("joinwz",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if GetPlayerRoutingBucket(source) == WorldLob then return end 
    if Lobbey  then 
        Lobbey = true 
        TriggerClientEvent('chat:addMessage',  xPlayer.source, {
	    	template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#24b300, #349426);border-radius: 20px;box-shadow: 0 0 10px #24b300;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:7px;border-radius:10px;"><i class="fa fa-bullhorn"></i></span> <b>WarZone</b></span>{0}</div>',
            args = { "You Joined To The WarZone Event Please Wait For More Players" }
        })
        SetPlayerRoutingBucket(source,WorldLob)
        TriggerClientEvent("WarZone:JoinLobbery",source)
        TriggerClientEvent("WarZone:UpdateMembers",source,AllPlayerInWz) 
    else 
        TriggerClientEvent('chat:addMessage',  xPlayer.source, {
            template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#d81c1f, #8b2525);border-radius: 20px;box-shadow: 0 0 10px #d81c1f;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:7px;border-radius:10px;"><i class="fa fa-bullhorn"></i></span> <b>WarZone</b></span>{0}</div>',
            args = { "WarZone Lobby Closed" }
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
            args = { "WarZone Lobby Closed !" }
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
        TriggerClientEvent('esx:showNotification', source, '~r~You Dont Have Permmision For Use This Command')   
    end
end)

RegisterCommand("cwz",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Players = 0 
    if Lobbey == false then return  
        TriggerClientEvent('esx:showNotification', source, "~r~No Events Started") 
    end 
    if WarZone.Start == true  then return  
        TriggerClientEvent('esx:showNotification', source, "~r~WarZone Event Already Started") 
    end 
    if xPlayer.permission_level >= PermStart  then 
        if tonumber(args[1]) and tonumber(args[2])  and tonumber(args[3])  then   
            if  tonumber(args[2]) > 2000 then return
                TriggerClientEvent('esx:showNotification', source, "~r~The Amount Entered Is Too Large") 
            end  
            if  tonumber(args[2]) < 500 then return  
                TriggerClientEvent('esx:showNotification', source, "~r~The Amount Entered Is Too Small") 
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
            TriggerClientEvent('esx:showNotification', source, "~r~The Entered Option Is Incorrect")
        end 
    else
        TriggerClientEvent('esx:showNotification', source, '~r~You Dont Have Permmision For Use This Command')   
    end
end)

RegisterCommand("endwz",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if WarZone.Start == false then return  
        TriggerClientEvent('esx:showNotification', source, "~r~No Events Started") 
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
        TriggerClientEvent('esx:showNotification', source, '~r~You Dont Have Permmision For Use This Command')   
    end
end)

RegisterCommand("exitwz",function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if WarZone.Start == false then return
        TriggerClientEvent('esx:showNotification', source, "~r~No Events Started") 
    end 
    if GetPlayerRoutingBucket(source) == 90 then 
        TriggerClientEvent("WarZone:ExitMision",source)
        TriggerClientEvent('esx:showNotification', source, '~g~You Exited From WarZone Event')
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
                    args = { "WarZone It Was Over And ^4"..Name.."^0 Winner" }
                }) 
                end 
            end 
        end
    end 
end)