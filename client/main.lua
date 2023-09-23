local QBCore = exports[Config.core]:GetCoreObject()

RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports[Config.core]:GetCoreObject() end)

local headerShown = false
local sendData = nil

-- Functions
local function openMenu(data)
    if not data or not next(data) then return end
	for _, v in pairs(data) do		
		if v["icon"] then	
			if Config.inventorySystem == "ox" then				
				local item = exports.ox_inventory:Items(tostring(v["icon"]))
				if item then					
					if item.metadata and item.metadata.image then						
						v["icon"] = Config.imgPath .. item.metadata.image
					else
						v["icon"] = Config.imgPath .. v["icon"] .. ".png"
					end
				end
			elseif Config.inventorySystem == "qb" then
				if QBCore.Shared.Items[v["icon"]] then
					v["icon"] = Config.imgPath .. QBCore.Shared.Items[v["icon"]].image
				end
			end
		end		
	end
    SetNuiFocus(true, true)
    headerShown = false
    sendData = data
    SendNUIMessage({ action = 'OPEN_MENU', data = table.clone(data) })
end

local function closeMenu()
    sendData = nil
    headerShown = false
    SetNuiFocus(false)
    SendNUIMessage({ action = 'CLOSE_MENU' })
end

local function showHeader(data)
    if not data or not next(data) then return end
    headerShown = true
    sendData = data
    SendNUIMessage({ action = 'SHOW_HEADER', data = table.clone(data) })
end

-- Events

RegisterNetEvent('qbx-menu:client:openMenu', function(data) openMenu(data) end)

RegisterNetEvent('qbx-menu:client:closeMenu', function() closeMenu() end)

-- NUI Callbacks

RegisterNUICallback('clickedButton', function(option)
    if headerShown then headerShown = false end
    --PlaySoundFrontend(-1, 'Highlight_Cancel', 'DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
    SetNuiFocus(false)
    if sendData then
        local data = sendData[tonumber(option)]
        sendData = nil
        if data then
            if data.params.event then
                if data.params.isServer then
                    TriggerServerEvent(data.params.event, data.params.args)
                elseif data.params.isCommand then
                    ExecuteCommand(data.params.event)
                elseif data.params.isQBCommand then
                    TriggerServerEvent('QBCore:CallCommand', data.params.event, data.params.args)
                elseif data.params.isAction then
                    data.params.event(data.params.args)
                else
                    TriggerEvent(data.params.event, data.params.args)
                end
            end
        end
    end
end)

RegisterNUICallback('closeMenu', function()
    headerShown = false
    sendData = nil
    SetNuiFocus(false)
end)

-- Command and Keymapping
RegisterCommand('playerfocus', function() if headerShown then SetNuiFocus(true, true) end end)
RegisterKeyMapping('playerFocus', 'Give Menu Focus', 'keyboard', 'LMENU')

-- Exports
exports('openMenu', openMenu)
exports('closeMenu', closeMenu)
exports('showHeader', showHeader)