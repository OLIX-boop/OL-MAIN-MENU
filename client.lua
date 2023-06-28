---- CONFIG ----

function DisableHud(toggle) -- here you can add the trigger to hide you hud
    TriggerEvent('codem-blackhudv2:SetForceHide', toggle)
end

-- Here you can edit the command name, key and description
local command_name = "menu"
local command_desc = "Menu principale"
local command_key = "ESCAPE"

local bigMap = true -- true = big map like in the video | false = normal gta main menu

-- NOW GO IN html/style.css and edit .img {}
-- AND GO INTO server/server.lua and edit the DropPlayer message

---- END CONFIG ----

local display = false

RegisterCommand(command_name, function(source, args)
    if not IsPauseMenuActive() then
        SetDisplay(not display)
    end
end)

RegisterKeyMapping(command_name, command_desc, 'keyboard', command_key)

RegisterNUICallback("exit", function()
    SetDisplay(false)
end)

RegisterNUICallback("map", function()
    SetDisplay(false)
    if bigMap then
        -- opens directly the big map (like in the video)
        Citizen.CreateThread(function()
            ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 0, -1)
            Wait(100)
            PauseMenuceptionGoDeeper(149) 
            while true do
                Citizen.Wait(10)
                if IsControlJustPressed(0, 200) then
                    SetFrontendActive(0)
                    break
                end
            end
        end)
    else
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_SP_PAUSE'), 0, -1) -- opens the normal main menu
    end
end)
RegisterNUICallback("quit", function()
    SetDisplay(false)
    TriggerServerEvent("main-menu:quit")
end)
RegisterNUICallback("settings", function()
    SetDisplay(false)
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_KEYMAPPING_MENU'), true, -1)
end)

function SetDisplay(bool)
    DisableHud(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end

    while true do 
        Citizen.Wait(3)
        SetPauseMenuActive(false)
    end
end)

