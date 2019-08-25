function playerFromID(ID)
	for k, player in pairs (getElementsByType("player")) do
		local playersId = getElementData(player, "ID")
		if (ID == playersId) then
			return player
		else
			return false
		end
	end
end

function hitman (op, cmd, pessoa, valor)
	if pessoa and valor then
		local rec = tonumber(valor)
		if rec ~= nil then
			if rec < 50000 then
				outputChatBox( "[ERRO] Valor inválido. <Mínimo $50000>", op, 255, 0, 0, true)
				return 
			end
		else
			outputChatBox( "[ERRO] Valor inválido. <Mínimo $50000>", op, 255, 0, 0, true)
			return
		end
		if getPlayerMoney(op) >= rec then
			if tonumber (pessoa) then
				local v = playerFromID(tonumber(pessoa))
				if isElement(v) then
					hp = v
				else
					outputChatBox( "[ERRO] O player não existe.", op, 255, 0, 0, true)
					return
				end
			elseif getPlayerFromName(pessoa) then
				hp = getPlayerFromName(pessoa)
			else
				outputChatBox( "[ERRO] O player não existe.", op, 255, 0, 0, true)
				return
			end
			if getElementData(hp, "HITMAN") == nil or getElementData(hp, "HITMAN") == false  then
				setElementData(hp, "HITMAN", 0)
			end
			local nRec = getElementData(hp, "HITMAN") + rec
			setElementData(hp, "HITMAN", nRec)
			takePlayerMoney(op, rec)
			outputChatBox("#DA70D6[RECOMPENSAS] " .. getPlayerName(op) .. " (id: " .. getElementData(op, "ID") ..") está dando uma recompensa de $" .. valor .. " pela cabeça de " .. getPlayerName(hp) .. " (id: " .. getElementData(hp, "ID") .. "). <Total: $" .. tostring(getElementData(hp, "HITMAN")) .. ">", root, 255, 255, 255, true)
		else
			outputChatBox( "[ERRO] Você não tem dinheiro suficiente.", op, 255, 0, 0, true)
			return
		end
	else
		outputChatBox( "[ERRO] Use /hitman <player> <quantidade>", op, 255, 0, 0, true)
	end
end

function recompensas (op, cmd)
	outputChatBox("#7FFF00[RECOMPENSAS] Recompensas atuais:", op, 255, 255, 255, true)
	for i, pr in pairs(getElementsByType("player")) do
		if getElementData(pr, "HITMAN") ~= nil and getElementData(pr, "HITMAN") ~= false then
			local hihi = getElementData(pr, "HITMAN")
			outputChatBox("#7FFF00[RECOMPENSAS] #FFFFFF" .. getPlayerName(pr) .. " (id: " .. getElementData(pr, "ID") .. "): $" .. hihi .. ".", op, 255, 255, 255, true)
		end
	end
end


function hitrec (ammo, hitman)
	if getElementData(source, "HITMAN") ~= nil and getElementData(source, "HITMAN") ~= false then
		if hitman == false or hitman == source then
			if #getElementsByType("player") == 1 then
				outputChatBox("#7CFC00[RECOMPENSAS] #FFFFFFPerdeu mais um dinheirinho.", root, 255, 255, 255, true)
				setElementData(source, "HITMAN", false)
				return
			end
			print (sorteado, "sortudo ae")
			local sort = getRandomPlayer(  )
			outputChatBox("#7CFC00[RECOMPENSAS] #FFFFFFO jogador " .. getPlayerName(source) .. " (id: " .. getElementData(source, "ID") .. ") se matou e a recompensa de #7CFC00$".. tostring(getElementData(source, "HITMAN")) .."#FFFFFF foi sorteada. Ganhador: ".. getPlayerName(sort) .." (id: " .. getElementData(sort, "ID") .. ").", root, 255, 255, 255, true)
			setPlayerMoney(sort, getPlayerMoney(sort) + getElementData(source, "HITMAN"))
			setElementData(source, "HITMAN", false)
		else
			outputChatBox("#7CFC00[RECOMPENSAS] #FFFFFFO jogador " .. getPlayerName(hitman) .. " (id: " .. getElementData(hitman, "ID") .. ") ganhou a recompensa de #7CFC00$".. tostring(getElementData(source, "HITMAN")) .."#FFFFFF pela cabeça de " .. getPlayerName(source) .. " (id: " .. getElementData(source, "ID") .. ").", root, 255, 255, 255, true)
			setPlayerMoney(hitman, getPlayerMoney(hitman) + getElementData(source, "HITMAN"))
			setElementData(source, "HITMAN", false)
		end
	end
end

function hitquit ()
	if getElementData(source, "HITMAN") ~= nil and getElementData(source, "HITMAN") ~= false then
		local sort = getRandomPlayer()
		if sort then
			outputChatBox("#7CFC00[RECOMPENSAS] #FFFFFFO jogador " .. getPlayerName(source) .. " (id: " .. getElementData(source, "ID") .. ") desconectou-se e a recompensa de #7CFC00$".. tostring(getElementData(source, "HITMAN")) .."#FFFFFF foi entregue ao player mais próximo. Ganhador: ".. getPlayerName(sort) .." (id: " .. getElementData(sort, "ID") .. ").", root, 255, 255, 255, true)
			setPlayerMoney(sort, getPlayerMoney(sort) + getElementData(source, "HITMAN"))
			setElementData(source, "HITMAN", false)
		end
	end
end


function pm(ep, cmd, id, msg, ...)
	if (msg) then
		if (id) then
			for k, v in pairs (getElementsByType("player")) do
				local playersId = getElementData(v, "ID")
				if (tonumber(id) == playersId) then
					if (getElementData(v, "BlockPm") ~= getElementData(ep, "ID") and getElementData(v, "BlockPm") ~= "tudoBlock") then
						local allParam = {...}
						local strg = table.concat(allParam, " ")
						outputChatBox("#00FFFF[PM] Mensagem recebida de "..getPlayerName(ep).."(" .. getElementData(ep, "ID") .. "): ".. msg.. " "..  strg, v, 255, 255, 255, true)
						triggerClientEvent(v, "onReceivePm", ep, v)
						outputChatBox("#1E90FF[PM] Mensagem enviada para ".. getPlayerName(v) .. "(" .. getElementData(v, "ID") .. "): ".. msg.. " ".. strg, ep, 255, 255, 255, true)
					elseif (getElementData(v, "BlockPm") == "tudoBlock") then
						outputChatBox("#1E90FF[PM] ".. getPlayerName(v) .. " bloqueou todas as mensagens privadas.", ep, 255, 255, 255, true)
					elseif (getElementData(v, "BlockPm") == getElementData(ep, "ID")) then
						outputChatBox("#1E90FF[PM] ".. getPlayerName(v) .. " bloqueou você de enviar-lhe mensagens privadas.", ep, 255, 255, 255, true)
					end
				end
			end
		else
			outputChatBox("#00FFFF[PM] Syntax /pm <id> <msg>", ep, 255, 255, 255, true)
		end
	else
		outputChatBox("#00FFFF[PM] Syntax /pm <id> <msg>", ep, 255, 255, 255, true)
	end
end

function blockPm (ep, cmd, id)
	if (id) then
		for k, v in pairs (getElementsByType("player")) do
			local playersId = getElementData(v, "ID")
			if (tonumber(id) == playersId) then
				if (getElementData(ep, "BlockPm") == tonumber(id)) then
					setElementData(ep, "BlockPm", "tudoBlock")
					outputChatBox("#1E90FF[PM] Você desbloqueou as mensagens privadas de ".. getPlayerName(v) .. ".", ep, 255, 255, 255, true)
				else
					setElementData(ep, "BlockPm", tonumber(id))
					outputChatBox("#1E90FF[PM] Você bloqueou as mensagens privadas de ".. getPlayerName(v) .. ".", ep, 255, 255, 255, true)
					return
				end
			elseif (id == "*") then
				if(getElementData(ep, "BlockPm") == "tudoBlock") then
					setElementData(ep, "BlockPm", nil)
					outputChatBox("#1E90FF[PM] Você desbloqueou todas as mensagens privadas.", ep, 255, 255, 255, true)
				return
				else
					setElementData(ep, "BlockPm", "tudoBlock")
					outputChatBox("#1E90FF[PM] Você bloqueou todas as mensagens privadas.", ep, 255, 255, 255, true)
				return
				end
			end
		end
	else
		outputChatBox("#00FFFF[PM] Syntax /blockpm <id>", ep, 255, 255, 255, true)
	end
end






local ParticipantesEvento = {}
local eventMarker = createMarker(0, 0, -30, "cylinder", 1.5, 0, 255, 255, 255)
setElementData(eventMarker, "EVENTO", false)


function playerFromID(ID)
	for k, player in pairs (getElementsByType("player")) do
		local playersId = getElementData(player, "ID")
		if (ID == playersId) then
			return player
		end
	end
end


function darVida (source,cmd, distance)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		local ax, ay, az = getElementPosition(source)
		local dimS = getElementDimension(source)
		local dis = tonumber(distance) or 25
		for i, player in pairs (getElementsByType("player")) do
			local px, py, pz = getElementPosition(player)
			local playersDist = getDistanceBetweenPoints3D(ax, ay, az, px, py, pz)
			local dimP = getElementDimension(player)
		    if  playersDist <= dis and dimP == dimS then
		    	if isPedInVehicle(player) then
		    		setElementHealth(getPedOccupiedVehicle(player), 1000)
		    	end
		      setElementHealth(player , 100)
		      outputChatBox( "#00FFFF[EVENTO] O admin " .. getPlayerName (source) .. " deu vida para você.", player, 231, 217, 176, true)
		    end
		end
	end
end



function darCarro (source,cmd, veiculo, distance)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		if veiculo then
			function carroID(carro)
				if tonumber(carro) and getVehicleNameFromModel(tonumber(carro)) ~= "" then
					local idCarro = tonumber(carro)
					print(getVehicleNameFromModel(tonumber(carro)))
					return idCarro
				elseif getVehicleModelFromName(carro) then
					local idCarro = getVehicleModelFromName(carro)
					return idCarro
				else
					outputChatBox( "#00FFFF[EVENTO] Este veículo não existe.", source, 231, 217, 176, true)
					return false
				end
			end
			local carro = veiculo
			if not carroID(carro) == false then
				local ax, ay, az = getElementPosition(source)
				local dis = tonumber(distance) or 25
				for i, player in pairs (getElementsByType("player")) do
					local px, py, pz = getElementPosition(player)
					local playersDist = getDistanceBetweenPoints3D(ax, ay, az, px, py, pz)
				    if  playersDist <= dis then				    	
				      	local pcar = createVehicle(carroID(carro), px, py, pz, getElementRotation(player))
				      	warpPedIntoVehicle(player, pcar, 0)
				     	outputChatBox( "#00FFFF[EVENTO] O admin " .. getPlayerName (source) .. " deu ".. getVehicleName(pcar) ..  " para você.", player, 231, 217, 176, true)
				    end
				end
			end
		else
			outputChatBox( "[EVENTO] Erro na sintaxe. /darcarro <veiculo>.", source, 0, 255, 255, true)
		end
	end
end


function dElement(source, cmd)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		local elements = getResourceRootElement()
		destroyElement(elements)
		outputChatBox( "#00FFFF[EVENTO] Você destruiu todos os elementos do evento.", source, 231, 217, 176, true)
		eventMarker = createMarker(0, 0, -30, "cylinder", 1.5, 0, 255, 255, 255)
	end
end




function darColete (source,cmd, distance)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		local ax, ay, az = getElementPosition(source)
		local dis = tonumber(distance) or 25
		local dimS = getElementDimension(source)
		for i, player in pairs (getElementsByType("player")) do
			local px, py, pz = getElementPosition(player)
			local playersDist = getDistanceBetweenPoints3D(ax, ay, az, px, py, pz)
			local dimP = getElementDimension(player)
		    if  playersDist <= dis and dimS == dimP then
		      setPedArmor(player , 100 )
		      outputChatBox( "#00FFFF[EVENTO] O admin " .. getPlayerName (source) .. " deu colete para você.", player, 231, 217, 176, true)
		    end
		end
	end
end



function congelar (source,cmd, distance)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
	    local ax, ay, az = getElementPosition(source)
		local dis = tonumber(distance) or 25
		local dimS = getElementDimension(source)
		for i, player in pairs (getElementsByType("player")) do
			if  not hasObjectPermissionTo(player, "function.kickPlayer", false) then
				local px, py, pz = getElementPosition(player)
				local playersDist = getDistanceBetweenPoints3D(ax, ay, az, px, py, pz)
				local dimP = getElementDimension(player)
			    if  playersDist <= dis and dimS == dimP then
			      setElementFrozen(player, true)
			      toggleAllControls(player, false, true, false)
			      outputChatBox( "#00FFFF[EVENTO] O admin " .. getPlayerName (source) .. " congelou você.", player, 231, 217, 176, true)
			    end
			end
		end
		outputChatBox( "#00FFFF[EVENTO] Você congelou todos os player em um raio de ".. dis..".", source, 231, 217, 176, true)
	end
end


function descongelar (source,cmd, distance)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
	    local ax, ay, az = getElementPosition(source)
		local dis = tonumber(distance) or 25
		local dimS = getElementDimension(source)
		for i, player in pairs (getElementsByType("player")) do		
			local px, py, pz = getElementPosition(player)
			local playersDist = getDistanceBetweenPoints3D(ax, ay, az, px, py, pz)
			local dimP = getElementDimension(player)
		    if  playersDist <= dis and dimP == dimS then
		    	if not hasObjectPermissionTo(player, "function.kickPlayer", false) then
		    		outputChatBox( "#00FFFF[EVENTO] O admin " .. getPlayerName (source) .. " descongelou você.", player, 231, 217, 176, true)
		    	end
		      setElementFrozen(player, false)
		      toggleAllControls(player, true, true, false)		      
		    end
		end
		outputChatBox( "#00FFFF[EVENTO] Você descongelou todos os player em um raio de ".. dis..".", source, 231, 217, 176, true)
	end
end


function darArma (source,cmd, pessoa, arma)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
	    if pessoa and arma then
	    	function playerArma(weapon)
				if tonumber(weapon) and tonumber(weapon) > 0 and tonumber(weapon) <= 40  then
	    			local idArma = tonumber(weapon)
	    			return idArma
				elseif getWeaponIDFromName(weapon) then
					local idArma = getWeaponIDFromName(weapon)
					return idArma 
				else
					outputChatBox( "#00FFFF[EVENTO] Esta arma não existe.", source, 231, 217, 176, true)
					return false
				end
			end
	    	if tonumber(pessoa) then
	    		for k, v in pairs (getElementsByType("player")) do
					local playersId = getElementData(v, "ID")
					if (tonumber(pessoa) == playersId) then
						local pv = v
						local weapon = arma
						if not playerArma(weapon) == false then
							giveWeapon(pv, playerArma(weapon), 9999, true)
							outputChatBox( "#00FFFF[EVENTO] Você deu " .. getWeaponNameFromID(playerArma(weapon)) .. " para ".. getPlayerName(pv) .. ".", source, 231, 217, 176, true)
							outputChatBox( "#00FFFF[EVENTO] O admin " .. getPlayerName (source) .. " deu " .. getWeaponNameFromID(playerArma(weapon)) .. " para você.", pv, 231, 217, 176, true)
							break
						end
					end
				end
			elseif getPlayerFromName(pessoa) then
				local pn = getPlayerFromName(pessoa)
				local weapon = arma
				if not playerArma(weapon) == false then
					giveWeapon(pn, playerArma(weapon), 9999, true)
					outputChatBox( "#00FFFF[EVENTO] Você deu " .. getWeaponNameFromID(playerArma(weapon)) .. " para ".. getPlayerName(pn) .. ".", source, 231, 217, 176, true)
					outputChatBox( "#00FFFF[EVENTO] O admin " .. getPlayerName (source) .. " deu " .. getWeaponNameFromID(playerArma(weapon)) .. " para você.", pn, 231, 217, 176, true)
				end
			else
				outputChatBox( "#00FFFF[EVENTO] Este player não existe.", source, 231, 217, 176, true)
				return
			end
		else
			outputChatBox( "[EVENTO] Erro na sintaxe. /dararma <player> <arma>.", source, 0, 255, 255, true)
		end
	end
end




function cevent(source, cmd)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		if getElementData(eventMarker, "EVENTO") == false then
		  	local dim = getElementDimension(source)
			local mx, my, mz = getElementPosition( source)
			local interior = getElementInterior(source)
			setElementDimension(eventMarker, dim )
			setElementInterior(eventMarker, interior, mx, my, mz - 1)
			setElementPosition(eventMarker, mx, my, mz -1)
			setElementData(eventMarker, "EVENTO", true)
			outputChatBox( "#00FFFF[EVENTO] Evento criado, digite /irevento para participar.", root, 231, 217, 176, true)
		else
			outputChatBox( "[EVENTO] Já existe um evento em andamento, digite /caevent para cancelá-lo.", source, 0, 255, 255, true)
		end
	end
end


function getPedWeapons(ped)
    local weapons = {}
    for slot=1, 12 do
        local weapon = getPedWeapon(ped, slot)
        local ammo = getPedTotalAmmo(ped, slot)
        if (weapon > 0) and (ammo > 0) then
            weapons[weapon] = ammo
        end
    end
    return weapons
end

-- stats table {1participando, 2vida, 3colete, 4dimensão, 5dinheiro, 6time, 7skinID, 8interior}
function irevento(source, cmd)
	if getElementData(eventMarker, "EVENTO") == true then
		if getElementData(source, "StatsEv")[1] == false then
			if not getPedOccupiedVehicle(source) == false then
				removePedFromVehicle(source)
			end
			local stats = setElementData(source, "StatsEv", {true, getElementHealth(source), getPedArmor(source), getElementDimension(source), getPlayerMoney(source), getPlayerTeam(source), getElementModel(source), getElementInterior(source)})
			setElementData(source, "PosEv", {getElementPosition(source)})
			setElementData(source, "ArmasEv", getPedWeapons(source))
			setElementDimension(source, getElementDimension(eventMarker))
			setPlayerMoney(source, 0, true)
			local x, y, z = unpack({getElementPosition(eventMarker)})
			setElementInterior(source, getElementInterior(eventMarker), x, y, z +1)
			setElementPosition(source, x, y, z +1)
			table.insert(ParticipantesEvento, source)
		else
			outputChatBox( "[EVENTO] Você já está participando no evento.", source, 0, 255, 255, true)
		end
	else
		outputChatBox( "[EVENTO] Não há nenhum evento para ir.", source, 0, 255, 255, true)
	end
end


  


function devent(source, cmd)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		if getElementData(eventMarker, "EVENTO") == true then
			setElementPosition(eventMarker, 0, 0, -30)
			setElementData(eventMarker, "EVENTO", 0)
			outputChatBox( "[EVENTO] Evento destruído.", root, 0, 255, 255, true)
		else
			outputChatBox( "[EVENTO] Não há nenhum evento para destruir.", source, 0, 255, 255, true)
		end 
	end
end




function caevent (source, cmd)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		if getElementData(eventMarker, "EVENTO") == 0 or getElementData(eventMarker, "EVENTO") == true then
			for k, player in pairs(ParticipantesEvento) do
				if (getElementData(player, "StatsEv") and  getElementData(player, "StatsEv")[1] == true) then
					setElementPosition(eventMarker, 0, 0, -30)					
					setElementHealth(player, getElementData(player, "StatsEv")[2])
					setPedArmor(player, getElementData(player, "StatsEv")[3])
					setElementDimension(player, getElementData(player, "StatsEv")[4])
					setPlayerMoney(player, getElementData(player, "StatsEv")[5], true)
					setElementInterior(player, getElementData(player, "StatsEv")[8], unpack(getElementData(player, "PosEv")))
					setElementPosition(player, unpack(getElementData(player, "PosEv")))
					for id, balas in pairs (getElementData(player, "ArmasEv")) do
						giveWeapon(player, id, balas)
					end
					for k, part in pairs (ParticipantesEvento) do
						if part == source then
							table.remove(ParticipantesEvento, k)
						end
					end
					setElementData(player, "ArmasEv", nil)
					setElementData(player, "StatsEv", {false})
					setElementData(player, "PosEv", nil)
				end
			end
			setElementData(eventMarker, "EVENTO", false)
			outputChatBox( "[EVENTO] Evento cancelado.", root, 0, 255, 255, true)
		else
			outputChatBox( "[EVENTO] Não há nenhum evento para cancelar.", source, 0, 255, 255, true)
		end
	end
end


function fevent (source, cmd, winner, premio)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		if getElementData(eventMarker, "EVENTO") == 0 or getElementData(eventMarker, "EVENTO") == true then
			if winner and premio then
				if winner and tonumber(winner) then
					for k, v in pairs (getElementsByType("player")) do
						local playersId = getElementData(v, "ID")
						if (tonumber(winner) == playersId) then
							pv = v
							break
						end
					end
				elseif winner and getPlayerFromName(winner) then
					pn = getPlayerFromName(winner)
				end
				local tPlayer = pv or pn
				for k, player in pairs(getElementsByType("player")) do
					if (getElementData(player, "StatsEv") and  getElementData(player, "StatsEv")[1] == true and player == tPlayer) then
						setElementPosition(eventMarker, 0, 0, -30)					
						setElementHealth(player, getElementData(player, "StatsEv")[2])
						setPedArmor(player, getElementData(player, "StatsEv")[3])
						setElementDimension(player, getElementData(player, "StatsEv")[4])
						local atualMoney = getPlayerMoney(player)
						setPlayerMoney(player, getElementData(player, "StatsEv")[5] + atualMoney + tonumber(premio), true)
						setElementInterior(player, getElementData(player, "StatsEv")[8], unpack(getElementData(player, "PosEv")))
						setElementPosition(player, unpack(getElementData(player, "PosEv")))
						for id, balas in pairs (getElementData(player, "ArmasEv")) do
							giveWeapon(player, id, balas)
						end
						for k, part in pairs (ParticipantesEvento) do
							if part == source then
								table.remove(ParticipantesEvento, k)
							end
						end
						setElementData(player, "ArmasEv", nil)
						setElementData(player, "StatsEv", {false})
						setElementData(player, "PosEv", nil)
						setElementData(eventMarker, "EVENTO", false)
						outputChatBox( "[EVENTO] Evento finalizado. O ganhador ".. getPlayerName(player).. " recebeu $".. premio .. ",00.", root, 0, 255, 255, true)
					end
				end
			else
				outputChatBox( "[EVENTO] Erro na sintaxe. /fevent <ganhador> <premio>.", source, 0, 255, 255, true)
			end
		else
			outputChatBox( "[EVENTO] Não há como ter um vencedor se não há evento.", source, 0, 255, 255, true)
		end
	end
end







function tarmas (source, cmd, distance)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		local ax, ay, az = getElementPosition(source)
		local dis = tonumber(distance) or 25
		for i, player in pairs (getElementsByType("player")) do
			if not hasObjectPermissionTo(player, "function.kickPlayer", false) then
				local px, py, pz = getElementPosition(player)
				local playersDist = getDistanceBetweenPoints3D(ax, ay, az, px, py, pz)
			    if  playersDist <= dis then
			    	for arm, bal in pairs (getPedWeapons(player)) do
			      		takeWeapon(player, arm)
			      	end
			    	outputChatBox( "#00FFFF[EVENTO] O admin " .. getPlayerName (source) .. " retirou suas armas.", player, 231, 217, 176, true)
			    end
			end
		end
		outputChatBox( "#00FFFF[EVENTO] Você tirou armas de todos os player em um raio de ".. dis..".", source, 231, 217, 176, true)
	end
end
  



addEventHandler( "onPlayerJoin", getRootElement(), function ()
	for k, v in pairs (getElementsByType("player")) do
		setElementData(v, "StatsEv", {false})
	end
end)



addEventHandler( "onResourceStart", getRootElement(), function ()
	for k, v in pairs (getElementsByType("player")) do
		setElementData(v, "StatsEv", {false})
	end
end)


 addEventHandler( "onPlayerWasted", getRootElement(), function()
	if getElementData(source, "StatsEv")[1] == true then
		setTimer(function (source)
			local x, y, z = unpack(getElementData(source, "PosEv"))
			local skin, interior, dimension = getElementData(source, "StatsEv")[7], getElementData(source, "StatsEv")[8], getElementData(source, "StatsEv")[4]--7skinID, 8interior, 4dimensão
			spawnPlayer(source, x, y, z + 1, 0, skin, interior, dimension)
			setElementHealth(source, getElementData(source, "StatsEv")[2])
			setPedArmor(source, getElementData(source, "StatsEv")[3])
			setElementDimension(source, getElementData(source, "StatsEv")[4])
			setPlayerMoney(source, getElementData(source, "StatsEv")[5], true)		
			for id, balas in pairs (getElementData(source, "ArmasEv")) do
				giveWeapon(source, id, balas)
			end
			for k, part in pairs (ParticipantesEvento) do
				if part == source then
					table.remove(ParticipantesEvento, k)
				end
			end
			outputChatBox( "[EVENTO] Você foi eliminado!", source, 0, 255, 255, true)
			setElementData(source, "ArmasEv", nil)
			setElementData(source, "StatsEv", {false})
			setElementData(source, "PosEv", nil)
		end, 1500, 1, source)
	else
	end
end)




function getPositionInfrontOfElement(element, meters)
    if (not element or not isElement(element)) then return false end
    local meters = (type(meters) == "number" and meters) or 3
    local posX, posY, posZ = getElementPosition(element)
    local _, _, rotation = getElementRotation(element)
    posX = posX - math.sin(math.rad(rotation)) * meters
    posY = posY + math.cos(math.rad(rotation)) * meters
    rot = rotation + math.cos(math.rad(rotation))
    return posX, posY, posZ--,rot
end


function alinhar (source, cmd)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		for m, participante in pairs (ParticipantesEvento) do
			local int = getElementInterior(source)
			if int then
			setElementInterior(participante, int)
			end
			setElementPosition(participante, getPositionInfrontOfElement(source, m + 2))
			setElementDimension(participante, getElementDimension(source))			
		end
	end
end



function freeSeat (tPlayer)
	local veh = getPedOccupiedVehicle(tPlayer)
	local vOcc = getVehicleOccupants(veh)
	local vMax = getVehicleMaxPassengers(veh)
	local vRMax = vMax + 1
	local vROcc = #vOcc + 1
	if vRMax > vROcc then
		for s=0, vRMax do
			if getVehicleOccupant(veh, s) == false then
				return s
			end
		end
	else
		return false
	end
end

function goto (oP, cmd, id)
	if hasObjectPermissionTo(oP, "function.kickPlayer", false) then
		if id then
			local ID = tonumber(id)
			local gPlayer = playerFromID(ID)
			if gPlayer then
				if (isPedInVehicle(oP)) then
					removePedFromVehicle(oP)
					setCameraTarget(oP)
				end
				local ox, oy, oz = getElementPosition(gPlayer)
				local interior = getElementInterior(gPlayer)
				local dim = getElementDimension(gPlayer)
				setElementDimension(oP, dim)
				if interior then
					setElementInterior(oP, interior)
				end
				if (isPedInVehicle(gPlayer)) then
					local sea = freeSeat(gPlayer)
					if sea ~= false then
						warpPedIntoVehicle(oP, getPedOccupiedVehicle(gPlayer), sea)
						setCameraTarget(oP)
					else
						setElementPosition(oP, ox, oy, oz + 3)
					end
				else
					setElementPosition(oP, ox, oy, oz + 3)
				end
			end
		end
	end
end

function get (oP, cmd, id)
	if hasObjectPermissionTo(oP, "function.kickPlayer", false) then
		if id then
			local ID = tonumber(id)
			local gPlayer = playerFromID(ID)
			if gPlayer then
				if (isPedInVehicle(gPlayer)) then
					removePedFromVehicle(gPlayer)
					setCameraTarget(gPlayer)
				end
				local ox, oy, oz = getElementPosition(oP)
				local interior = getElementInterior(oP)
				local dim = getElementDimension(oP)
				setElementDimension(gPlayer, dim)
				if interior then
					setElementInterior(gPlayer, interior)
				end
				if (isPedInVehicle(oP)) then
					local sea = freeSeat(oP)
					if sea ~= false then
						warpPedIntoVehicle(gPlayer, getPedOccupiedVehicle(oP), sea)
						setCameraTarget(gPlayer)
					else
						setElementPosition(gPlayer, ox, oy, oz + 3)
					end
				else
					setElementPosition(gPlayer, ox, oy, oz + 3)
				end
			end
		end
	end
end




function spec (oP, cmd, id)
	if hasObjectPermissionTo(oP, "function.kickPlayer", false) then
		if (id) then
			for k, v in pairs (getElementsByType("player")) do
				local playersId = getElementData(v, "ID")
				if (tonumber(id) == playersId) then
					if getElementDimension(oP) == getElementDimension(v) and getElementInterior(oP) == getElementInterior(v) then
						setCameraTarget(oP, v)
					else
						outputChatBox("#FF0000[SPEC] Dimensão/Interior não combinam.", oP, 255, 255, 255, true)
					end
				end
			end
		elseif (getCameraTarget(oP) ~= oP) then
			setCameraTarget(oP)
		else
			outputChatBox("#FF0000[SPEC] Syntax /spec <id>", oP, 255, 255, 255, true)
		end
	end
end










function imute (oP, cmd, id, time, reason, ...)
	if hasObjectPermissionTo(oP, "function.kickPlayer", false) then
		if (id) then
			if (tonumber(time) <= 20 and tonumber(time) > 0 and tonumber(time)) then
				if (reason) then
					for k, v in pairs (getElementsByType("player")) do
						local playersId = getElementData(v, "ID")
						if (...) then
							local allParam = {...}
							local strg = table.concat(allParam, " ")
							reasonM = reason .. " " .. strg
						else
							reasonM = reason
						end
						if (tonumber(id) == playersId) then
							setPlayerMuted(v, true)
							outputChatBox( "[SERVER] O jogador ".. getPlayerName(v) .. "(" .. getElementData(v, "ID") .. ")" .. " foi mutado por ".. getPlayerName(oP).. "(" .. getElementData(oP, "ID").. ")" .. " por " .. math.ceil(time) .. " minuto(s) (motivo: " .. reasonM ..").", root, 0, 220, 255, true)
							setTimer(function()
								if (isPlayerMuted(v)) then
									setPlayerMuted(v, false)
									outputChatBox( "[SERVER] O jogador ".. getPlayerName(v) .. "(" .. getElementData(v, "ID") .. ")" .. " foi demutado pelo servidor.", root, 0, 220, 255, true)
								end
							end, (math.ceil(time) * 60000), 1)
						end
					end
				else
					outputChatBox( "[ERRO] Use /imute <id> <tempo em minutos> <motivo>", oP, 255, 0, 0, true)
				end
			else
				outputChatBox( "[ERRO] Mute máximo de 20 minutos.", oP, 255, 0, 0, true)
			end
		end
	end
end


function bannedNickFunc (serial, time, adh)
	local bans = (getBans())
	for k, v in pairs (bans) do
		if getBanSerial(v) == serial then
			local responsable = getBanAdmin(v)			
			local bannedNick = getBanNick(v)
			if adh then
				if adh == "a" then
					setElementData(root, "tempoBanido", "ano(s)")
				elseif adh == "d" then
					setElementData(root, "tempoBanido", "dia(s)")
				elseif adh == "h" then
					setElementData(root, "tempoBanido", "hora(s)")
				end
			end
			outputChatBox("[SERVER] O jogador ".. bannedNick .. " foi banido por " .. responsable .." por " .. time .. " " .. getElementData(root, "tempoBanido") .. ".", root, 0, 0, 255, false)
			print("[SERVER] O jogador ".. bannedNick .. " foi banido por " .. responsable ..".")
			setElementData(root, "tempoBanido", nil)
		end		
	end
end

function sban (oP, cmd, serial, time, adh, reason, ...)
	if hasObjectPermissionTo(oP, "function.kickPlayer", false) then
		if (serial) and (time) and (adh == "a" or adh == "d" or adh == "h") and (reason) then
			if (...) then
				local allParam = {...}
				local strg = table.concat(allParam, " ")
				reasonL = reason .. " " .. strg
			else
				reasonL = reason
			end						
			function timeInS(time, adh)
				if adh == "a" then
					return time * 31536000
				elseif adh == "d" then
					return time * 86400
				elseif adh == "h" then
					return time * 3600
				end							
			end
			if getPlayerFromName(serial) then
				username = getPlayerFromName(serial)
				serial = getPlayerSerial(username)
			end
			addBan(nil, nil, serial, oP, reasonL, timeInS(time, adh))
			bannedNickFunc(serial, time, adh)					
		else
			outputChatBox( "[ERRO] Use /sban <serial> <tempo> <a/d/h (anos, dias ou horas)> <motivo>", oP, 255, 0, 0, true)
			outputChatBox( "[INFO] Use o comando /whowas <nickPlayer> para descobrir o serial.", oP, 255, 0, 0, true)
		end
	end
end




function skick (oP, cmd, id, reason, ...)
	if hasObjectPermissionTo(oP, "function.kickPlayer", false) then
		if (id) and (reason) then
			local res = oP
			if (...) then
				local allParam = {...}
				local strg = table.concat(allParam, " ")
				reasonL = reason .. " " .. strg
			else
				reasonL = reason
			end		
			function kickarPlayer(player, res, rea)
					if isElement(player) and res and rea then
						outputChatBox("#FF8C00[SERVER] O jogador ".. getPlayerName(player) .. "#FF8C00 foi kickado por " .. getPlayerName(res) .. "#FF8C00, (" .. rea .. ").", root, 255, 255, 255, true)
						kickPlayer(player, res, rea)						
					end
				end				
			if id and tonumber(id) then
					for k, v in pairs (getElementsByType("player")) do
						local playersId = getElementData(v, "ID")
						if (tonumber(id) == playersId) then
							local player = v
							kickarPlayer(player, oP, reasonL)
							break
						end
					end
			elseif id and getPlayerFromName(id) then
				local player = getPlayerFromName(id)
				kickarPlayer(player, op, reasonL)
			else
				outputChatBox( "[ERRO] Este player não existe.", source, 255, 0, 0, true)
			end
		else
			outputChatBox( "[ERRO] Use /skick <player> <motivo>", oP, 255, 0, 0, true)
		end
	end
end


function getSerial (oP, cmd, id)
	if hasObjectPermissionTo(oP, "function.kickPlayer", false) then
		if (id) and tonumber(id) then
			for k, v in pairs (getElementsByType("player")) do
				local playersId = getElementData(v, "ID")
				if (tonumber(id) == playersId) then
					local player = v
					local serial = getPlayerSerial(player)
					outputChatBox("#FA8072[INFO] #FFD700" .. getPlayerName(player) .. "(" .. getElementData(player, "ID") .. ") serial: #00FF00" .. serial, oP, 255, 255, 255, true)
					break
				end
			end
		elseif id and getPlayerFromName(id) then
			local player = getPlayerFromName(id)
			local serial = getPlayerSerial(player)
			outputChatBox("#FA8072[INFO] #FFD700" .. getPlayerName(player) .. "(" .. getElementData(player, "ID") .. ") serial: #00FF00" .. serial, oP, 255, 255, 255, true)
		else
			outputChatBox( "[ERRO] Use /getserial <player>", oP, 255, 0, 0, true)
		end
	end
end

function kill (oP, cmd)
	local x1, y1, z1 = getElementPosition(oP)
	outputChatBox( "#FFFF00[SERVER] Fique parado durante 10 segundos.", oP, 255, 255, 255, true)
	setTimer(function()
		local x2, y2, z2 = getElementPosition(oP)
		if getDistanceBetweenPoints2D(x1, y1, x2, y2) <= 1 then
			killPed(oP, oP)
		else
			outputChatBox( "#FFFF00[SERVER] Você se moveu.", oP, 255, 255, 255, true)
		end
	end, 10000, 1)
end

local BlipNSF = createBlip(-2281.1, 2288.4, 4, 9, 1)

setBlipVisibleDistance(BlipNSF, 0)

local spawns = 
{
-2131, 2182, -2123, 2178, -2107, 2172, -2092, 2167, -2079, 2163, -2066, 2158, -2053, 2153,-2040, 2148, -2027, 2143, -2014, 2134, -2008, 2126, 
-2004, 2117, -2001, 2107, -2000, 2094, -2000, 2083, -2003, 2070, -2006, 2056, -2010, 2046, -2016, 2033, -2023, 2021, -2029, 2012, -2037, 2003, -2046, 1993,
-2057, 1985, -2067, 1978, -2079, 1972, -2091, 1966, -2104, 1960, -2117, 1955, -2130, 1950, -2141, 1947, -2155, 1943, -2166, 1940, -2180, 1938,-2191, 1936, -2205, 1933,
-2219, 1931, -2231, 1930, -2245, 1929, -2256, 1929, -2270, 1929, -2284, 1931, -2298, 1934, -2309, 1937,-2324, 1942, -2335, 1945, -2349, 1947, -2362, 1947, -2375, 1945,
-2389, 1941, -2402, 1937, -2413, 1934, -2428, 1929, -2440, 1927,-2453, 1926, -2467, 1927, -2481, 1929, -2492, 1932, -2504, 1937, -2511, 1943, -2514, 1949, -2514, 1959,
-2511, 1969, -2505, 1980, -2497, 1990, -2490, 1998, -2480, 2007, -2471, 2014, -2460, 2022, -2448, 2030, -2436, 2038,-2424, 2045, -2414, 2051, -2403, 2059, -2391, 2066,
-2389, 2068, -2379, 2074, -2370, 2081, -2358, 2089, -2347, 2098, -2335, 2106, -2325, 2112, -2284, 2478, -2263, 2489,-2237, 2504, -2212, 2512, -2195, 2514, -2181, 2510,
-2170, 2502, -2162, 2493, -2158, 2481, -2158, 2467, -2159, 2455, -2155, 2441, -2149, 2429, -2140, 2417, -2131, 2407, -2120, 2398, -2109, 2390, -2096, 2378, -2090, 2368,
-2101, 2353, -2110, 2352, -2122, 2352, -2134, 2354, -2147, 2355, -2159, 2353, -2174, 2333, -2174, 2324, -2172, 2316, -2167, 2308, -2159, 2299, -2151, 2293, -2141, 2288,
-2130, 2281, -2122, 2274, -2119, 2267, -2120, 2258, -2123, 2253, -2129, 2248, -2135, 2241, -2139, 2235, -2144, 2225, -2151, 2218, -2159, 2214, -2171, 2213, -2180, 2216,
-2188, 2221, -2197, 2226, -2209, 2231, -2220, 2232, -2230, 2230, -2238, 2226, -2249, 2220, -2258, 2214, -2268, 2205, -2276, 2197, -2285, 2189, -2293, 2181, -2303, 2172,
-2312, 2168, -2321, 2167, -2333, 2169, -2344, 2172,-2356, 2177, -2366, 2181, -2377, 2184, -2389, 2183, -2397, 2181, -2406, 2176, -2416, 2169, -2424, 2161, -2434, 2151,
-2441, 2142, -2449, 2131, -2458, 2120, -2464, 2115, -2475, 2110, -2485, 2108, -2495, 2108, -2505, 2110, -2519, 2111, -2530, 2110, -2540, 2108, -2550, 2103, -2560, 2095,
-2570, 2086, -2578, 2078, -2588, 2068, -2594, 2059, -2598, 2049,-2599, 2039, -2595, 2032, -2588, 2025, -2580, 2022, -2570, 2019, -2557, 2018, -2546, 2017, -2533, 2018,
-2522, 2019, -2508, 2021, -2494, 2023, -2483, 2026, -2469, 2028, -2455, 2031, -2441, 2034, -2430, 2035, -2416, 2037, -2404, 2038, -2390, 2040, -2377, 2042, -2365, 2045,
-2351, 2047, -2340, 2049, -2326, 2052, -2312, 2055, -2299, 2058, -2287, 2061,-2276, 2063, -2262, 2066, -2251, 2069, -2238, 2074, -2224, 2078, -2213, 2082, -2202, 2086,
-2191, 2093, -2178, 2102, -2169, 2110, -2158, 2119, -2147, 2127, -2136, 2136, -2125, 2145, -2114, 2154, -2105, 2161, -2095, 2171, -2086, 2181, -2080, 2189
}

local boats = {472, 473, 493, 595, 484, 430, 453, 452, 446, 454}


setElementData(root, "peixe", 0)

function isItABoat(ped)
	if ped then
		if isPedInVehicle(ped) then
			element = getElementModel(getPedOccupiedVehicle(ped))
		else
			element = getPedContactElement(ped)
		end
		for k, barco in pairs (boats) do
			if element == barco then
				return true
			end
		end
		return false
	end
end

function spawnPeixe()
	if getElementData(root, "peixe") == 0 then
	    local tamanhoTable = #spawns
	    local index = math.random(1, tamanhoTable/4) * 2
	    setElementData(root, "peixe", {spawns[index - 1], spawns[index]})
	end
end

function pescar (eu, cmd)
	local peixePos = getElementData(root, "peixe")
	if peixePos == 0 then
		outputChatBox("#FF6347[PESCAR] #FF8C00Não há nenhum peixe disponível.", eu, 255, 255, 255, true)
		return
	end
	if getPedContactElement(eu) == false and isItABoat(eu) == false then
		outputChatBox("#FF6347[PESCAR] #FF8C00Suba em um barco para pescar.", eu, 255, 255, 255, true)
		return
	end
	local ex, ey, ez = getElementPosition(eu)
	local dis = getDistanceBetweenPoints2D(ex, ey, unpack(peixePos))
	if dis > 141.5 then
		outputChatBox("#FF6347[PESCAR] #FF8C00Não há nada aqui (Muito frio).", eu, 255, 255, 255, true)		
	elseif dis <= 141.5 and dis > 118 then
		outputChatBox("#FF6347[PESCAR] #FF8C00Não há nada aqui (Bem frio).", eu, 255, 255, 255, true)
	elseif dis <= 118 and dis > 94.5 then
		outputChatBox("#FF6347[PESCAR] #FF8C00Não há nada aqui (Frio).", eu, 255, 255, 255, true)
	elseif dis <= 94.5 and dis > 71 then
		outputChatBox("#FF6347[PESCAR] #FF8C00Não há nada aqui (Morno).", eu, 255, 255, 255, true)
	elseif dis <= 71 and dis > 47.5 then
		outputChatBox("#FF6347[PESCAR] #FF8C00Não há nada aqui (Quente).", eu, 255, 255, 255, true)
	elseif dis <= 47.5 and dis > 24 then
		outputChatBox("#FF6347[PESCAR] #FF8C00Não há nada aqui (Bem quente).", eu, 255, 255, 255, true)
	elseif dis <= 24 and dis > 1.5 then
		outputChatBox("#FF6347[PESCAR] #FF8C00Não há nada aqui (Muito quente).", eu, 255, 255, 255, true)
	elseif dis <= 1.5 then
		outputChatBox("#7CFC00[SERVER] #FFFFFF" .. getPlayerName(eu) .. " #FFFFFFencontrou um peixe e ganhou #7CFC00$100000.", root, 255, 255, 255, true)
		setPlayerMoney(eu, getPlayerMoney(eu) + 100000)
		setElementData(root, "peixe", 0)
	end
end

setTimer(function()
	if getElementData(root, "peixe") == 0 then
		spawnPeixe()
	end
end, math.random(300000, 900000), 0)

addCommandHandler("sppeixe", spawnPeixe)
addCommandHandler("pescar", pescar)



function comandosAdm (source, cmd, info)
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then
		local pl = source
		local evento = "#FFFF00Comandos para eventos: ^ #FFFF00cevent #BEBEBE -- Cria um evento. ^ #FFFF00devent #BEBEBE-- Impossibilita players de entrar no evento. ^ #FFFF00caevent #BEBEBE-- Cancela o evento. ^ #FFFF00fevent #BEBEBE-- Finaliza um evento e escolhe um ganhador. ^ #FFFF00darvida #BEBEBE-- Dá vida aos players próximos. ^ #FFFF00darcolete #BEBEBE-- Dá colete aos players próximos. ^ #FFFF00darcarro #BEBEBE-- Dá aos players próximos o veículo escolhido. ^ #FFFF00dararma #BEBEBE-- Dá ao player a arma escolhida. ^ #FFFF00congelar #BEBEBE-- Congela todos os players próximos ^ #FFFF00descongelar #BEBEBE-- Descongela todos os players próximos ^ #FFFF00alinhar #BEBEBE-- Alinha todos os players do evento. ^ #FFFF00tarmas #BEBEBE-- Tira todas as armas dos players próximos. ^ #FFFF00delements #BEBEBE-- Destrói todos os elementos criados no evento."
		local server = "#FFFF00Comandos para servidor: ^ #FFFF00goto #BEBEBE-- Vai até o player selecionado. ^ #FFFF00get #BEBEBE-- Puxa o player selecionado. ^ #FFFF00sban #BEBEBE-- Dá ban no player selecionado. ^ #FFFF00skick #BEBEBE-- Kicka do servidor o player selecionado. ^ #FFFF00imute #BEBEBE-- Muta o player selecionado. ^ #FFFF00spec #BEBEBE-- Assiste a tela do player selecionado. ^ #FFFF00ss #BEBEBE-- Printa a tela do player selecionado."
		local evstrings = split(evento,94)
		local svstrings = split(server,94)
		function erro (comando)
			outputChatBox( "[ERRO] Use /".. comando .. " <server/evento>", pl, 255, 0, 0, true)
		end
		if info and info == "evento" then		
			for k, strings in pairs (evstrings) do
				outputChatBox(strings, pl, 255, 255, 255, true)
			end
		elseif info and info == "server" then
			for k, strings in pairs (svstrings) do
				outputChatBox(strings, pl, 255, 255, 255, true)
			end
		else
			local comando = cmd
			erro(comando)
		end
	end
end


addEventHandler("onPlayerJoin",getRootElement(), 
function () 
bindKey(source,"u","down","chatbox","Report") 
end) 
  
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()), 
function () 
	for index, player in pairs(getElementsByType("player")) do
		if not isKeyBound(player, "u", "down") then
			if hasObjectPermissionTo(player, "function.kickPlayer", false) then 
				bindKey(player,"u","down","chatbox","Admin") 
			else
				bindKey(player,"u","down","chatbox","Report")
			end
		end
  	end 
end)

addEventHandler( "onPlayerLogin", getRootElement(), 
function () 
	if hasObjectPermissionTo(source, "function.kickPlayer", false) then 
		unbindKey(source, "u", "down", "chatbox", "Report")
		bindKey(source,"u","down","chatbox","Admin") 
	else
		return
	end
end)


addEventHandler( "onPlayerLogout", getRootElement(), 
function () 
	unbindKey(source, "u", "down", "chatbox", "Admin")
	unbindKey(source, "u", "down", "chatbox", "Report")
	bindKey(source,"u","down","chatbox","Report") 
end)


function onChatAdmin(player,_,...)
	if hasObjectPermissionTo(player, "function.kickPlayer", false) then
	  	local px,py,pz=getElementPosition(player) 
	  	local msg = table.concat({...}, " ") 
	  	local nick=getPlayerName(player)
		for _,v in ipairs(getElementsByType("player")) do 
	  		if hasObjectPermissionTo(v, "function.kickPlayer", false) then  
	    		outputChatBox("#FF0000(#696969ADMIN#FF0000) #FFFFFF"..getPlayerName(player).."("..tostring(getElementData(player, "ID")).."): #FFFFFF"..msg,v,255,255,255,true)      
	    	end 
	  	end
	end
end 
addCommandHandler("Admin",onChatAdmin) 
  
function onChatReport(player,_,...) 
  	local px,py,pz=getElementPosition(player) 
  	local msg = table.concat({...}, " ") 
 	local nick=getPlayerName(player) 
	outputChatBox("#FFFF00[SERVER] Report enviado. Algum administrador deve te responder em breve!",player,255,255,255,true)	
  	for _,v in ipairs(getElementsByType("player")) do 
    	if hasObjectPermissionTo(v, "function.kickPlayer", false) then    	
      		outputChatBox("#9400D3(#FF4500REPORT#9400D3) #FFFF00"..getPlayerName(player).."("..tostring(getElementData(player, "ID")).."): #FFFF00"..msg,v, 255, 255, 255,true) 
    	end 
  	end 
end 
addCommandHandler("Report",onChatReport) 



function admins(oP, cmd)
	local players = getElementsByType ( "player" )
	local admins = ""
	for k,v in ipairs(players) do
	  	local accountname = ""
	   	if (isGuestAccount(getPlayerAccount(v)) == false) then
	   		accountname = getAccountName (getPlayerAccount(v))
	   		if isObjectInACLGroup ( "user." .. accountname, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ( "user." .. accountname, aclGetGroup ( "Console" ) ) or isObjectInACLGroup ( "user." .. accountname, aclGetGroup ( "Moderator" ) ) or isObjectInACLGroup ( "user." .. accountname, aclGetGroup ( "SuperModerator" ) ) then
	      		if (admins == "") then
	            	admins = getPlayerName(v).."("..tostring(getElementData(v, "ID"))..")"
	        	else
	            	admins = admins .. ", " .. getPlayerName(v).."("..tostring(getElementData(v, "ID"))..")"
	        	end
	    	end
		end
	end
	outputChatBox( "Admins online:", oP, 255, 255, 0)
	outputChatBox( " " .. tostring ( admins ), oP, 255, 255, 0)
end

addCommandHandler("admins", admins)

addEventHandler( "onResourceStart", getResourceRootElement( getThisResource()), 
function()
	setElementData(root, "LOTOActive", false)
	setElementData(root, "LOTO", 500000)
	setTimer(
	function()		
		loteriaNumeros = {}
		local lotoWinners = {}
		outputChatBox("#32CD32[LOTO]#FFFFFF A loteria está aberta, Jackpot inicial #32CD32$" .. tostring(getElementData(root, "LOTO"))  ..",00. #FFFFFFDigite /loteria e um número de 1 a 100. (Preço: #32CD32$5000)", root,255, 255, 255, true)
		setElementData(root, "LOTOActive", true)
		local sorteadoRandom = math.random(1, 100)
		for lotoI, lotoV in pairs(loteriaNumeros) do
			table.remove(loteriaNumeros, lotoI)
		end
		local vezesRepetir = {0, 1, 2, 3, 4}
		setTimer(
		function()
			if vezesRepetir[#vezesRepetir] ~= 0 then				
				outputChatBox("#32CD32[LOTO]#FFFFFF A loteria está aberta, digite /loteria e um número de 1 a 100. Preço: #32CD32$5000. #FFFFFFTempo restante: " .. vezesRepetir[#vezesRepetir] .. " minuto(s)", root,255, 255, 255, true)
				table.remove(vezesRepetir)
			else
				if loteriaNumeros[sorteadoRandom] == nil then
					outputChatBox("#32CD32[LOTO]#FFFFFF A loteria acumulou um total de #32CD32$" .. getElementData(root, "LOTO") .."#FFFFFF, o número sorteado foi #FF00FF" .. sorteadoRandom .. "#FFFFFF e não houveram ganhadores, o total acumulado irá para a próxima loteria.", root,255, 255, 255, true)
					setElementData(root, "LOTOActive", false)
				else
					local ganhadores = loteriaNumeros[sorteadoRandom]
					if string.find(ganhadores, ",") then
						for k, v in pairs (getElementsByType("player")) do
							if string.find(ganhadores, getPlayerName(v)) or string.match(ganhadores, getPlayerName(v) .. ",")  then
								table.insert(lotoWinners, v)
							end
						end
						local quantiaParaCada = getElementData(root, "LOTO") / #lotoWinners
						for i, val in pairs (lotoWinners) do
							givePlayerMoney(val, quantiaParaCada)
						end
						outputChatBox("#32CD32[LOTO]#FFFFFF A loteria acumulou um total de #32CD32$" .. getElementData(root, "LOTO") .."#FFFFFF, o número sorteado foi #FF00FF" .. sorteadoRandom .."#FFFFFF. Ganhadores: " .. ganhadores .. ". (#32CD32$" .. quantiaParaCada .. " #FFFFFFpara cada)", root,255, 255, 255, true)
						setElementData(root, "LOTOActive", false)
						setElementData(root, "LOTO", 500000)
					else
						for k, v in pairs (getElementsByType("player")) do
							if string.match(ganhadores, getPlayerName(v)) then
								table.insert(lotoWinners, v)
							end
						end
						givePlayerMoney(lotoWinners[1], getElementData(root, "LOTO"))
						outputChatBox("#32CD32[LOTO]#FFFFFF A loteria acumulou um total de #32CD32$" .. getElementData(root, "LOTO") .."#FFFFFF, o número sorteado foi #FF00FF" .. sorteadoRandom .."#FFFFFF. Ganhador: " .. ganhadores .. ".", root,255, 255, 255, true)
						setElementData(root, "LOTOActive", false)
						setElementData(root, "LOTO", 500000)
					end
				end
			end
		end, 60000, 5)
	end, 1500000, 0)
end)

function loteria (oP, cmd, numero)
	if getElementData(root, "LOTOActive") == true then
		local num = tonumber(numero)
		if num and num > 0 and num <= 100 then
			if getPlayerMoney(oP) >= 5000 then
				if loteriaNumeros[num] == nil then
					table.insert(loteriaNumeros, num, getPlayerName(oP))
					takePlayerMoney(oP, 5000)
					setElementData(root, "LOTO", getElementData(root, "LOTO") + 5000)
					outputChatBox("#32CD32[LOTO]#FFFFFF Você apostou #32CD32$5000 #FFFFFFno número #FF00FF" .. numero .. "#FFFFFF. Lembre-se, em quanto mais números você apostar, maior sua chance de ganhar!", oP, 255, 255, 255, true)					
				elseif not string.match(loteriaNumeros[num], getPlayerName(oP)) then
					local mesmoNum = loteriaNumeros[num]
					table.remove(loteriaNumeros, num)
					table.insert(loteriaNumeros, num, mesmoNum .. ", " .. getPlayerName(oP))
					takePlayerMoney(oP, 5000)
					setElementData(root, "LOTO", getElementData(root, "LOTO") + 5000)
					outputChatBox("#32CD32[LOTO]#FFFFFF Você apostou #32CD32$5000 #FFFFFFno número #FF00FF" .. numero .. "#FFFFFF. Lembre-se, em quanto mais números você apostar, maior sua chance de ganhar!", oP, 255, 255, 255, true)
				else
					outputChatBox("#32CD32[LOTO]#FFFFFF Você já comprou este número.", oP, 255, 255, 255, true)
				end
			else
				outputChatBox("#32CD32[LOTO]#FFFFFF Você não possui dinheiro suficiente.", oP, 255, 255, 255, true)
			end
		else
			outputChatBox("#32CD32[LOTO]#FFFFFF Valor inválido.", oP, 255, 255, 255, true)
		end
	else
		outputChatBox("#32CD32[LOTO]#FFFFFF O tempo para apostar expirou!", oP, 255, 255, 255, true)
	end
end

function lotoInfo (oP, cmd)
	if getElementData(root, "LOTOActive") == true then
		outputChatBox("#32CD32[LOTO]#FFFFFF Números comprado: ", oP, 255, 255, 255, true)
		for k, v in pairs (loteriaNumeros) do
			if v ~= nil then
				outputChatBox("#32CD32[LOTO]#FFFFFF Número [#32CD32" .. k .. "#FFFFFF] comprado por: #32CD32" .. v .. "#FFFFFF.", oP, 255, 255, 255, true)
			end
		end
	else
		outputChatBox("#32CD32[LOTO]#FFFFFF Nenhuma loteria está aberta no momento.", oP, 255, 255, 255, true)
	end
end

function sortear (oP, cmd, id1, id2)
	if hasObjectPermissionTo(oP, "function.kickPlayer", false) then
		if id1 and id2 then
			local sorteado = math.random(id1, id2)
			outputChatBox("#32CD32[SORTEIO]#FFFFFF O número sorteado pelo admin " .. getPlayerName(oP) .. " #FFFFFFfoi: #32CD32" .. tostring(sorteado), root, 255, 255, 255, true)
		else
			outputChatBox("[ERRO] Use /sortear <valorMin> <valorMax>", oP, 255, 0, 0, true)
		end
	end
end

function lotoQuit()
	if loteriaNumeros then
		for k, v in pairs (loteriaNumeros) do
			if string.match(v, getPlayerName(source)) then
				if not string.match(v, ",") then
					table.remove(loteriaNumeros, k)
					table.insert(loteriaNumeros, k, nil)
				else
					local c, f = string.find(v, getPlayerName(source))
					if c == 1 then
						local newString = string.sub(v, f + 3)
						table.remove(loteriaNumeros, k)
						table.insert(loteriaNumeros, k, newString)
					else
						local newString = string.sub(v, 1, c - 3) .. string.sub(v, f+1)
						table.remove(loteriaNumeros,k)
						table.insert(loteriaNumeros,k, newString)
					end
				end
			end
		end
	end
end

function manutencao (oP, cmd, senha)
	if hasObjectPermissionTo(oP, "function.kickPlayer", false) then
		if senha == "off" then
			setServerPassword(nil)
			setGameType("Gang War")
			outputChatBox("Server aberto", root, 255, 255, 255)			
		else
			for k, v in pairs(getElementsByType("player")) do
				if not hasObjectPermissionTo(v, "function.kickPlayer", false) then
					kickPlayer(v, oP, "Manutenção")
				else
					outputChatBox("Senha setada para: " .. senha, v, 255, 255, 255)
				end
			end
			setServerPassword(senha)
			setGameType("MANUTENÇÃO")			
		end
	end
end

function godmode(oP)
	if hasObjectPermissionTo(oP, "function.kickPlayer", false) then
		local state = (not getElementData (oP, "god_mode" ))
        setElementData (oP, "god_mode", state)
	end
end






--[[function grudar (eu, cmd)
	for k, v in pairs (getElementsByType("player")) do
		if v ~= eu then
			attachElements(v, eu, 0, 0, -4)
		end
	end
end

function desgrudar (eu, cmd)
	for k, v in pairs (getElementsByType("player")) do
		if v ~= eu then
			detachElements(v, eu)
		end
	end
end]]

function kickAFKPlayer()
	if getElementData(client, "afk") then
		if hasObjectPermissionTo(client, "function.kickPlayer", false) then
			return
		else
			outputChatBox(getPlayerName(client) .. " foi kickado por inatividade durante 5 minutos." , root, 255, 255, 0)
			kickPlayer(client, "AFK durante 5 minutos")
		end
	end
end

addEvent("timeToKick", true)
addEventHandler("timeToKick", resourceRoot, kickAFKPlayer)




for k, players in pairs (getElementsByType("player")) do 
	setElementData(players, "duelo", nil)
	setElementData(players, "duelo_stats", nil)
end


function duelo (oP, cmd, DAR, idname, duelType, aposta)
	local dueloTable = {[1] = {22, 26, 32}, [2] = {24, 27, 29, 31, 34}, [3] = {24, 26, 32}, [4] = {24, 25}}

	if not DAR then
	 	outputChatBox("#FA8072[DUELO] #FFA500Use /duelo <desafiar/aceitar/recusar>", oP, 255, 255, 255, true)
	 	return
	end
	if DAR == "aceitar" then
		if getElementData(oP, "duelo") == "participando" then
			outputChatBox("#FA8072[DUELO] #FFA500Você já está em um duelo.", oP, 255, 255, 255, true)
			return
		end
	 	if getElementData(oP, "duelo") == "desafiado" then
	 		local apostaAceitar = getElementData(oP, "duelo_stats")[1]
	 		if apostaAceitar then
	 			if getPlayerMoney(oP) >= apostaAceitar then
 					takePlayerMoney(oP, apostaAceitar)
 				elseif getElementData(oP, "bank_balance") >= apostaAceitar then
 					setElementData(oP, "bank_balance", getElementData(oP, "bank_balance") - apostaAceitar)
 					outputChatBox("#7FFF00[BANCO] $#FFFFFF" .. apostaAceitar.. " foi retirado da sua conta bancária!", oP, 255, 255, 255, true)
 				else
 					outputChatBox("#FA8072[DUELO] #FFA500Você não possui dinheiro suficiente.", oP, 255, 255, 255, true)
 					outputChatBox("#FA8072[DUELO] #FFA500Seu oponente não possui dinheiro suficiente.", getElementData(oP, "duelo_stats")[9], 255, 255, 255, true)
 					return
 				end
 			end
 			setElementData(oP, "duelo", "participando")
 			setElementData(getElementData(oP, "duelo_stats")[9], "duelo", "participando")
 			outputChatBox("#FA8072[DUELO] #00FF00Você aceitou o duelo. Começando em 5 segundos.", oP, 255, 255, 255, true)
 			outputChatBox("#FA8072[DUELO] #FFFFFF" .. getPlayerName(oP) ..  " #00FF00aceitou o duelo. Começando em 5 segundos.", getElementData(oP, "duelo_stats")[9], 255, 255, 255, true)
 			local pos= {getElementPosition(oP)}
	 		local money, interior, dim, health, armor, armas = getPlayerMoney(oP), getElementInterior(oP), getElementDimension(oP), getElementHealth(oP), getPedArmor(oP), getPedWeapons(oP)
	 		--table [1] aposta, [2] pos, [3] money, [4] interior, [5] dimensão, [6] vida, [7] colete, [8] armas, [9] quem me desafiou, [10] 
	 		local tableStats = {}
	 		if apostaAceitar then
	 			table.insert(tableStats, 1, apostaAceitar)
	 		else
	 			table.insert(tableStats, 1, 0)
	 		end
	 		table.insert(tableStats, 2, pos)
	 		table.insert(tableStats, 3, money)
	 		table.insert(tableStats, 4, interior)
	 		table.insert(tableStats, 5, dim)
	 		table.insert(tableStats, 6, health)
	 		table.insert(tableStats, 7, armor)
	 		table.insert(tableStats, 8, armas)
	 		local desafiador = getElementData(oP, "duelo_stats")[9]
	 		local armamentor = getElementData(oP, "duelo_stats")[10]
	 		setElementData(oP, "duelo_stats", tableStats)
 			setTimer(
			function()
				dueloCol = createColPolygon(1988.5, 1957, 2010.74023, 1980.21802, 1981.19189, 1928.60315, 1980.88074, 1927.88196, 1967.34424, 1935.89453, 1997.40234, 1988.05713)
				setElementDimension(dueloCol, getElementData(desafiador, "ID"))
				setGlitchEnabled ( "highcloserangedamage", false )
				outputChatBox("#FA8072[DUELO] #FFA500Ultrapassar as barreiras do prédio resultará em uma morte instantânea!", oP, 255, 255, 255, true)
				outputChatBox("#FA8072[DUELO] #FFA500Ultrapassar as barreiras do prédio resultará em uma morte instantânea!", desafiador, 255, 255, 255, true)
				setElementPosition(desafiador, 2003.03625, 1981.83740, 122.01563)
				setElementDimension(desafiador, getElementData(desafiador, "ID"))
				setElementRotation(desafiador, 0, 0, 148.5)
				setElementHealth(desafiador, 100)
				setPedArmor(desafiador, 100)
				for oldarma, _ in pairs (getPedWeapons(desafiador)) do
					takeWeapon(desafiador, oldarma)
				end
				local novasArmasTable = dueloTable[armamentor]
				for _, arma in pairs (novasArmasTable) do
					giveWeapon(desafiador, arma, 9999, false)
				end
				setElementPosition(oP, 1974.96436, 1933.27319, 122.01563)
				setElementDimension(oP, getElementData(desafiador, "ID"))
				setElementRotation(oP, 0, 0, 328.5)
				setElementHealth(oP, 100)
				setPedArmor(oP, 100)
				for oldarma, _ in pairs (getPedWeapons(oP)) do
					takeWeapon(oP, oldarma)
				end
				local novasArmasTable = dueloTable[armamentor]
				for _, arma in pairs (novasArmasTable) do
					giveWeapon(oP, arma, 9999, false)
				end
				function saiuColShape(thePlayer, matchdim)
					if matchdim == true then
						if getElementData(thePlayer, "duelo") == "participando" then
							local ganhador = getElementData(thePlayer, "duelo_stats")[9]
							killPed(thePlayer, ganhador, 0)
						end
					end
				end
				addEventHandler( "onColShapeLeave", dueloCol, saiuColShape)
				
	 			addEventHandler("onPlayerWasted", oP, 
				function(ammo, killer)
					if getElementData(source, "duelo") == "participando" then
						outputChatBox("#FA8072[DUELO] #00FF00Você perdeu o duelo.", source, 255, 255, 255, true)
						local recompensa = getElementData(source, "duelo_stats")[1]
						if recompensa > 0 then
							givePlayerMoney(killer, recompensa*2)
							outputChatBox("#FA8072[DUELO] #00FF00Você recebeu $" .. recompensa*2 .. " por ganhar o duelo.", killer, 255, 255, 255, true)
						else
							outputChatBox("#FA8072[DUELO] #00FF00Você ganhou o duelo.", killer, 255, 255, 255, true)
						end
						setElementData(source, "duelo", nil)
		 				setElementData(killer, "duelo", nil)
						destroyElement(dueloCol)
						setElementPosition(killer, unpack(getElementData(killer,"duelo_stats")[2]))
						setElementInterior(killer, getElementData(killer,"duelo_stats")[4])
						setElementDimension(killer, getElementData(killer,"duelo_stats")[5])
						setElementHealth(killer, getElementData(killer,"duelo_stats")[6])
						setPedArmor(killer, getElementData(killer,"duelo_stats")[7])
						for oldarma, _ in pairs (getPedWeapons(source)) do
							takeWeapon(killer, oldarma)
						end
						for id, balas in pairs (getElementData(killer, "duelo_stats")[8]) do
							giveWeapon(killer, id, balas)
						end						
		 				setElementData(source, "duelo_stats", nil)
		 				setElementData(killer, "duelo_stats", nil)
		 				return
					end
				end)
	 			addEventHandler("onPlayerWasted", desafiador, 
				function(ammo, killer)
					if getElementData(source, "duelo") == "participando" then
						outputChatBox("#FA8072[DUELO] #00FF00Você perdeu o duelo.", source, 255, 255, 255, true)
						local recompensa = getElementData(source, "duelo_stats")[1]
						if recompensa > 0 then
							givePlayerMoney(killer, recompensa*2)
							outputChatBox("#FA8072[DUELO] #00FF00Você recebeu $" .. recompensa*2 .. " por ganhar o duelo.", killer, 255, 255, 255, true)
						else
							outputChatBox("#FA8072[DUELO] #00FF00Você ganhou o duelo.", killer, 255, 255, 255, true)
						end
						setElementData(source, "duelo", nil)
		 				setElementData(killer, "duelo", nil)
						destroyElement(dueloCol)
						setElementPosition(killer, unpack(getElementData(killer,"duelo_stats")[2]))
						setElementInterior(killer, getElementData(killer,"duelo_stats")[4])
						setElementDimension(killer, getElementData(killer,"duelo_stats")[5])
						setElementHealth(killer, getElementData(killer,"duelo_stats")[6])
						setPedArmor(killer, getElementData(killer,"duelo_stats")[7])
						for oldarma, _ in pairs (getPedWeapons(source)) do
							takeWeapon(killer, oldarma)
						end
						for id, balas in pairs (getElementData(killer, "duelo_stats")[8]) do
							giveWeapon(killer, id, balas)
						end						
		 				setElementData(source, "duelo_stats", nil)
		 				setElementData(killer, "duelo_stats", nil)
		 				return
					end
				end)

			end, 5000, 1)


	 	else
	 		outputChatBox("#FA8072[DUELO] #FFA500Você não foi desafiado.", oP, 255, 255, 255, true)
	 		return
	 	end
	elseif DAR == "recusar" then
	 	if getElementData(oP, "duelo") == "desafiado" then
	 		local quemMeDesafiou = getElementData(oP, "duelo_stats")[9]
	 		setElementData(oP, "duelo", nil)
			setElementData(quemMeDesafiou, "duelo_stats", nil)
			setElementData(quemMeDesafiou, "duelo", nil)
			setElementData(oP, "duelo_stats", nil)
			outputChatBox("#FA8072[DUELO] #FFA500Duelo recusado.", oP, 255, 255, 255, true)
			outputChatBox("#FA8072[DUELO] #FFA500Duelo recusado.", quemMeDesafiou, 255, 255, 255, true)
			if isTimer(timerExpirar) then
				killTimer( timerExpirar )
			end
			return
	 	else
	 		outputChatBox("#FA8072[DUELO] #FFA500Você não foi desafiado.", oP, 255, 255, 255, true)
 			return
 		end
 	elseif DAR == "desafiar" then
 		if getElementData(oP, "duelo") == "participando" or getElementData(oP, "duelo") == "desafiado"  then
 			outputChatBox("#FA8072[DUELO] #FFA500Você já está em um duelo.", oP, 255, 255, 255, true)
 			return
 		elseif tonumber(idname) then
 			desafiado = playerFromID(tonumber(idname))
 			if not desafiado then
 				outputChatBox("#FA8072[DUELO] #FFA500O jogador não existe.", oP, 255, 255, 255, true)
 				return
 			end
 			if desafiado == oP then 
 				outputChatBox("#FA8072[DUELO] #FFA500Você não pode duelar consigo mesmo.", oP, 255, 255, 255, true)
 				return end
		local desafiadoStatus = getElementData(desafiado, "duelo")
 		elseif desafiadoStatus == "participando" or "desafiadoStatus" == "desafiado" then
 				outputChatBox("#FA8072[DUELO] #FFA500Este player já está em um duelo.", oP, 255, 255, 255, true)
 			return
 		elseif type(idname) == "string" then
 			desafiado = getPlayerFromName(idname)
 			if not desafiado then
 				outputChatBox("#FA8072[DUELO] #FFA500O jogador não existe.", oP, 255, 255, 255, true)
 				return
 			end
 			if desafiado == oP then
 				outputChatBox("#FA8072[DUELO] #FFA500Você não pode duelar consigo mesmo.", oP, 255, 255, 255, true) 
			return end
 		local desafiadoStatus = getElementData(desafiado, "duelo")
 		elseif desafiadoStatus == "participando" or "desafiadoStatus" == "desafiado" then
 			outputChatBox("#FA8072[DUELO] #FFA500Este player já está em um duelo.", oP, 255, 255, 255, true)
 			return
 		end

	 	local dueloArmamento = tonumber(duelType)
	 	if dueloArmamento == false or dueloArmamento == nil or dueloArmamento < 1 or dueloArmamento > 4 then
 			outputChatBox("#FA8072[DUELO] #FFA500Use /duelo <desafiar> <id/nick> <1/2/3/4> [valor aposta].", oP, 255, 255, 255, true)
 			outputChatBox("#FA8072[DUELO] #FFFFFF1- Armamento Leve; 2- Armamento Pesado; 3- Armamento Mixed; 4- Deagle + Pump.", oP, 255, 255, 255, true)
 			return
 		end
 		if dueloArmamento == 1 then
 			dueloArmamentoSTRING = "Armamento Leve"
		elseif dueloArmamento == 2 then
			dueloArmamentoSTRING = "Armamento Pesado"
		elseif dueloArmamento == 3 then
			dueloArmamentoSTRING = "Armamento Mixed"
		elseif dueloArmamento == 4 then
			dueloArmamentoSTRING = "Deagle + Pump"
		end
 		local valorApostado = tonumber(aposta)
 		if valorApostado then
 			if valorApostado > 0 then
 				if getPlayerMoney(oP) >= valorApostado then
 					takePlayerMoney(oP, valorApostado)
 					setElementData(desafiado, "duelo_stats", {})
 					table.insert(getElementData(desafiado, "duelo_stats"), 1, valorApostado)
 				elseif getElementData(oP, "bank_balance") >= valorApostado then
 					setElementData(oP, "bank_balance", getElementData(oP, "bank_balance") - valorApostado)
 					outputChatBox("#7FFF00[BANCO] $#FFFFFF" .. valorApostado.. " foi retirado da sua conta bancária!", oP, 255, 255, 255, true)
 					setElementData(desafiado, "duelo_stats", {})
 					table.insert(getElementData(desafiado, "duelo_stats"), 1, valorApostado)
 				else
 					outputChatBox("#FA8072[DUELO] #FFA500Você não possui dinheiro suficiente.", oP, 255, 255, 255, true)
 					return
 				end
 			else
 				outputChatBox("#FA8072[DUELO] #FFA500Valor inválido.", oP, 255, 255, 255, true)
 				return
 			end
 		end
 		outputChatBox("#FA8072[DUELO] #00FF00Desafio enviado.", oP, 255, 255, 255, true)
 		local pos= {getElementPosition(oP)}
 		local money, interior, dim, health, armor, armas = getPlayerMoney(oP), getElementInterior(oP), getElementDimension(oP), getElementHealth(oP), getPedArmor(oP), getPedWeapons(oP)
 		--table [1] aposta, [2] pos, [3] money, [4] interior, [5] dimensão, [6] vida, [7] colete, [8] armas, [9] desafiado, [10] armamento
 		local tableStats = {}
 		if valorApostado then
 			table.insert(tableStats, 1, valorApostado)
 		else
 			table.insert(tableStats, 1, 0)
 		end
 		table.insert(tableStats, 2, pos)
 		table.insert(tableStats, 3, money)
 		table.insert(tableStats, 4, interior)
 		table.insert(tableStats, 5, dim)
 		table.insert(tableStats, 6, health)
 		table.insert(tableStats, 7, armor)
 		table.insert(tableStats, 8, armas)
 		table.insert(tableStats, 9, desafiado)
 		table.insert(tableStats, 10, dueloArmamento)
 		setElementData(oP, "duelo_stats", tableStats)
 		setElementData(desafiado, "duelo_stats", {[1] = valorApostado, [9] = oP, [10] = dueloArmamento})
 		setElementData(oP, "duelo", "desafiado")
 		setElementData(desafiado, "duelo", "desafiado")
 		triggerClientEvent(getElementsByType("player"), "onDuelInvite", oP, desafiado)
 		if valorApostado then
 			outputChatBox("#FA8072[DUELO] #FFFFFF".. getPlayerName(oP) ..  " #00FF00te convidou para um duelo #FFFFFF(" .. dueloArmamentoSTRING .. ") #FFFF00valendo $".. valorApostado ..", #00FF00digite /duelo aceitar ou /duelo recusar. #FFA500(Ao aceitar você apostará o mesmo valor)", desafiado, 255, 255, 255, true)
 		else
 			outputChatBox("#FA8072[DUELO] #FFFFFF".. getPlayerName(oP) ..  " #00FF00te convidou para um duelo #FFFFFF(" .. dueloArmamentoSTRING .. ") #00FF00amistoso, digite /duelo aceitar ou /duelo recusar.", desafiado, 255, 255, 255, true)
 		end
 		timerExpirar = setTimer(
 		function()
 			if getElementData(desafiado, "duelo") ~= "participando" then
 				outputChatBox("#FA8072[DUELO] #FFA500Desafio expirou.", oP, 255, 255, 255, true)
 				outputChatBox("#FA8072[DUELO] #FFA500Desafio expirou.", desafiado, 255, 255, 255, true)
 				if valorApostado then
 					givePlayerMoney(oP, valorApostado)
 				end
 				setElementData(oP, "duelo", nil)
 				setElementData(desafiado, "duelo", nil)
 				setElementData(oP, "duelo_stats", nil)
 				setElementData(desafiado, "duelo_stats", nil)
 				return
 			end
 		end, 10000, 1)
 	end
end







--addCommandHandler("desgrudar", desgrudar)
--addCommandHandler("grudar", grudar)
addCommandHandler("duelo", duelo)
addCommandHandler("godmode", godmode)
addCommandHandler("manutencao", manutencao)
addCommandHandler("manu", manutencao)
addEventHandler("onPlayerQuit", getRootElement(), lotoQuit)
addCommandHandler("pm", pm)
addCommandHandler("blockpm", blockPm)
addCommandHandler("hitman", hitman)
addCommandHandler("recompensas", recompensas)
addEventHandler("onPlayerWasted", getRootElement(), hitrec)
addCommandHandler("comandosadm", comandosAdm)
addCommandHandler("cmdadm", comandosAdm)
addCommandHandler( "getserial", getSerial)
addCommandHandler( "skick", skick)
addCommandHandler( "sban", sban)
addCommandHandler("imute", imute)
addCommandHandler("spec", spec)
addCommandHandler("goto", goto)
addCommandHandler("get", get)
addCommandHandler("alinhar", alinhar)
addCommandHandler("tarmas", tarmas)
addCommandHandler("caevent", caevent)
addCommandHandler("fevent", fevent)
addCommandHandler ("cevent", cevent)
addCommandHandler( "darvida", darVida )
addCommandHandler( "darcarro", darCarro)
addCommandHandler( "delement", dElement)
addCommandHandler ("dararma", darArma)
addCommandHandler("devent", devent)
addCommandHandler( "darcolete", darColete )
addCommandHandler("irevento", irevento)
addCommandHandler ("descongelar", descongelar)
addCommandHandler ("congelar", congelar)
addCommandHandler("kill", kill)
addCommandHandler("loteria", loteria)
addCommandHandler("loto", loteria)
addCommandHandler("lotoinfo", lotoInfo)
addCommandHandler("sortear", sortear)




