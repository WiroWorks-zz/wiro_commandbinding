local display = false

local bindings = nil
local key1, key2, key3, key4, key5 = nil,nil,nil,nil,nil

local boz = false

RegisterCommand("wirokeybind", function()
    -- MAİN WİRO
    SetDisplay(true)
    -- MAİN WİRO
end)

-- UI

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

-- UI


RegisterNetEvent('wiro_commandbinding_setupWithTable')
AddEventHandler('wiro_commandbinding_setupWithTable', function(bindingsTable)
    boz = true
    bindings = bindingsTable
    for k, v in pairs(bindings) do
        if v.tus ~= "boş" then
            if k == "1" then
                key1 = tonumber(v.tus)
            elseif k == "2" then
                key2 = tonumber(v.tus)
            elseif k == "3" then
                key3 = tonumber(v.tus)
            elseif k == "4" then
                key4 = tonumber(v.tus)
            elseif k == "5" then
                key5 = tonumber(v.tus)
            end
        end
    end
    UISetup()
    boz = false
    dongugobr()
end)

function dongugobr()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, key1) then
                if key1 ~= 210 then
                    ExecuteCommand(bindings["1"].komut .." " ..bindings["1"].arguman)
                end
            end
            if IsControlJustPressed(0, key2) then
                if key2 ~= 314 then
                    ExecuteCommand(bindings["2"].komut .." " ..bindings["2"].arguman)
                end
            end
            if IsControlJustPressed(0, key3) then
                if key3 ~= 315 then
                    ExecuteCommand(bindings["3"].komut .." " ..bindings["3"].arguman)
                end
            end
            if IsControlJustPressed(0, key4) then
                if key4 ~= 312 then
                    ExecuteCommand(bindings["4"].komut .." " ..bindings["4"].arguman)
                end
            end
            if IsControlJustPressed(0, key5) then
                if key5 ~= 313 then
                    ExecuteCommand(bindings["5"].komut .." " ..bindings["5"].arguman)
                end
            end
            if boz then
                break
            end
        end
    end)
end

function UISetup()
    SendNUIMessage({
        type = "UISetup",
        bindings = bindings,
    })
end


--NUI Callbacks

RegisterNUICallback('exit', function()
    SetDisplay(false)
end)

RegisterNUICallback('save', function(data)
    TriggerEvent("wiro_commandbinding_setupWithTable", data.savetable)
    TriggerServerEvent("wiro_commandbinding:save", data.savetable)
end)