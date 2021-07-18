ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--====================================================================================
--  OnLoad
--====================================================================================
AddEventHandler('esx:playerLoaded',function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll('SELECT commandbinds FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier,
    }, function(result)
        TriggerClientEvent("wiro_commandbinding_setupWithTable", _source, json.decode(result[1].commandbinds))
    end)
end)

RegisterServerEvent('wiro_commandbinding:save')
AddEventHandler('wiro_commandbinding:save', function(table)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.insert("UPDATE users SET commandbinds = @bindtable WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.identifier,
        ['@bindtable'] = json.encode(table)
    })
end)