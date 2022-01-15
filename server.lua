local charset = {}

for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end

function string.random(length)
  math.randomseed(os.time())

  if length > 0 then
    return string.random(length - 1) .. charset[math.random(1, #charset)]
  else
    return ""
  end
end

local eventpassword = string.random(12)
print("[gvrp_yannik]: Eventpassword: " .. eventpassword)


RegisterServerEvent('gvrp_getpw')
AddEventHandler('gvrp_getpw', function ()
	TriggerClientEvent('gvrp_clientpw', source, eventpassword)
end)

RegisterServerEvent('gvrp_alarm')
AddEventHandler('gvrp_alarm', function(pw)
	if pw == eventpassword then
	TriggerClientEvent('gvrp_prisonalarm', -1)
	else
    DropPlayer(source, "No modding allowed.")
	end
end)

RegisterServerEvent('policeNotification')
AddEventHandler('policeNotification', function(rainson)
	local _source = source
	local _raison = rainson
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('police:InfoService', xPlayers[i], _raison)
		end
	end
end)
