Framework = nil
RNRFunctions = {}

if Config.Framework == 'esx' then
	Framework = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'qb' then
	Framework = exports["qb-core"]:GetCoreObject()
end

RNRFunctions.RegisterServerCallback = function(name, cb, ...)
	if Config.Framework == 'esx' then
		Framework.RegisterServerCallback(name, cb, ...)
	elseif Config.Framework == 'qb' then
		Framework.Functions.CreateCallback(name, cb, ...)
	end
end

RNRFunctions.GetPlayerFromId = function(source)
	if Config.Framework == 'esx' then
		return Framework.GetPlayerFromId(source)
	elseif Config.Framework == 'qb' then
		return Framework.Functions.GetPlayer(source)
	end
end

RNRFunctions.Notify = function(msg, info)
	if Config.Framework == 'esx' then
        TriggerClientEvent('esx:showNotification', source, msg)
    elseif Config.Framework == 'qb' then
        TriggerClientEvent('QBCore:Notify', source, msg, info)
	end
end