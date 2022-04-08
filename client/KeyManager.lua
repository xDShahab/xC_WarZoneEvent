local registeredKeys = {}
local keysHolding = {}
local KeysWhiteList = {["g"] = true, ["t"] = true}
local currentKeysHolding = {}
local isControlsDisabled = false

RegisterNetEvent("onKeyDown")
RegisterNetEvent("onKeyUP")
RegisterNetEvent("onMultiplePress")


function registerKey(key, type)
	local command = key .. "donttouch"

	if not registeredKeys[key] then
		registeredKeys[key] = true
		RegisterKeyMapping('+' .. command, "Lotfan Value Key Ra Edit Nakonid", type, key)
	end
	RegisterCommand('+' .. command, function()
		if not IsPauseMenuActive() and not isControlsDisabled then
			if shouldSendTheKey(key) then
				TriggerEvent("onKeyDown", key)
			end
			
			table.insert(keysHolding, key)
			currentKeysHolding[key] = true

			if #keysHolding > 1 then
				TriggerEvent("onMultiplePress", currentKeysHolding)
			end

		end
	end)	
	RegisterCommand('-' .. command, function()
		if not IsPauseMenuActive() then
			TriggerEvent("onKeyUP", key)
		end

		if currentKeysHolding[key] then
			removeKey(key)
			currentKeysHolding[key] = nil
		end
	end)
end

function removeKey(key)
	for index, currentKey in ipairs(keysHolding) do
		if currentKey == key then
			table.remove(keysHolding, index)
		end
	end
end

function shouldSendTheKey(key)
	if KeysWhiteList[key] then
		return true
	else
		local data = ESX.GetPlayerData()
		if data.HandCuffed ~= 1 then
			return true
		else
			return false
		end
	end
end

local haveToRegister = {
	["e"] = "keyboard",
	["k"] = "keyboard",
	["numpad4"] = "keyboard",
	["numpad5"] = "keyboard",
	["numpad6"] = "keyboard",
	["numpad7"] = "keyboard",
	["numpad8"] = "keyboard",
	["numpad9"] = "keyboard",
	["u"] = "keyboard",
	["x"] = "keyboard",
	["l"] = "keyboard",
	["i"] = "keyboard",
	["f"] = "keyboard",
	["r"] = "keyboard",
	["lmenu"] = "keyboard",
	["f1"] = "keyboard",
	["f2"] = "keyboard",
	["f3"] = "keyboard",
	["f4"] = "keyboard",
	["f5"] = "keyboard",
	["f6"] = "keyboard",
	["f7"] = "keyboard",
	["f10"] = "keyboard",
	["f11"] = "keyboard",
	["escape"] = "keyboard",
	["t"] = "keyboard",
	["y"] = "keyboard",
	["g"] = "keyboard",
	["q"] = "keyboard",
	["comma"] = "keyboard",
	["period"] = "keyboard",
	["minus"] = "keyboard",
	["plus"] = "keyboard",
	["9"] = "keyboard",
	["b"] = "keyboard",
	['oem_3'] = "keyboard",
	["lcontrol"] = "keyboard",
	["lshift"] = "keyboard",
	["1"] = "keyboard",
	["2"] = "keyboard",
	["3"] = "keyboard",
	["4"] = "keyboard",
	["return"] = "keyboard",
	["back"] = "keyboard",
	["up" ] = "keyboard",
	["right"] = "keyboard",
	["left" ] = "keyboard",
	["down"] = "keyboard",
	["m"] = "keyboard",
	["mouse_left"] = "mouse_button",
	["mouse_right"] = "mouse_button",
	["iom_wheel_down"] = "mouse_wheel",
	["up"] = "keyboard",
	["down"] = "keyboard",
	["return"] = "keyboard",
}

for key, type in pairs(haveToRegister) do
	registerKey(key, type)
end

exports("disableControl", function(status)
	isControlsDisabled = status
end)