addEvent("onPlayerWithdraw",true)
addEventHandler("onPlayerWithdraw",root,function (quantity)
    local quantity = tonumber(quantity)
    if(quantity) then
        local bankBalance = client:getData("bank_balance") or 0
        if(bankBalance >= quantity) then
            givePlayerMoney( client, quantity)
            client:setData("bank_balance",tonumber(bankBalance - quantity))
            playSoundFrontEnd(client,6)
            triggerClientEvent(client,"updatePlayerInfoBank",client)
            outputChatBox( "#1712e6[BANCO]:#FFFFFFDinheiro sacado com sucesso:#1712e6$"..quantity,client,255,255,255,true)
        else
            outputChatBox( "#1712e6[BANCO]:#FFFFFFDinheiro insuficiente para sacar.",client,255,255,255,true)
    
        end
    else
        outputChatBox( "#1712e6[BANCO]:#FFFFFFInforme uma quantidade valida.",client,255,255,255,true)
    end
end)

addEvent("onPlayerDeposit",true)
addEventHandler("onPlayerDeposit",root,function (quantity)
    local quantity = tonumber(quantity)
    if(quantity) then
        local bankBalance = client:getData("bank_balance") or 0
        if(quantity > 0 and quantity <= client:getMoney()) then
            takePlayerMoney( client, quantity)
            playSoundFrontEnd(client,6)
            client:setData("bank_balance",tonumber(bankBalance + quantity))
            triggerClientEvent(client,"updatePlayerInfoBank",client)
            outputChatBox( "#1712e6[BANCO]:#FFFFFFDinheiro depositado com sucesso:#1712e6$"..quantity,client,255,255,255,true)
        else
            outputChatBox( "#1712e6[BANCO]:#FFFFFFDinheiro insuficiente para depositar.",client,255,255,255,true)
    
        end
    else
        outputChatBox( "#1712e6[BANCO]:#FFFFFFInforme uma quantidade válida.",client,255,255,255,true)
    end
end)


addEvent("onPlayerTransfer",true)
addEventHandler("onPlayerTransfer",root,function (toPlayer,quantity)
    if not toPlayer then
        outputChatBox( "#1712e6[BANCO]:#FFFFFFInforme um player válido.",client,255,255,255,true)
        return
    end
    local playerElement = getPlayerFromName( toPlayer )
    local quantity = tonumber(quantity)
    if not playerElement then
        outputChatBox( "#1712e6[BANCO]:#FFFFFFPlayer não existente (Online).",client,255,255,255,true)
        return
    end
    if not playerElement:getData("account") then
        outputChatBox( "#1712e6[BANCO]:#FFFFFFPlayer não existente (Online).",client,255,255,255,true)
        return
    end
    if playerElement == client then
         outputChatBox( "#1712e6[BANCO]:#FFFFFFNão é permitido transferir para você mesmo.",client,255,255,255,true)
         return
    end
    if(quantity) then
        local clientBalance = client:getData("bank_balance") or 0
        local playerBalance = playerElement:getData("bank_balance") or 0
        if(clientBalance >= quantity) then
            client:setData("bank_balance",tonumber(clientBalance-quantity))
            playerElement:setData("bank_balance",tonumber(playerBalance + quantity))
            playSoundFrontEnd(client,6)
            triggerClientEvent(client,"updatePlayerInfoBank",client)
            triggerClientEvent(playerElement,"updatePlayerInfoBank",playerElement)
            outputChatBox( "#1712e6[BANCO]:#FFFFFFDinheiro transferido para conta: ."..playerElement.name.."#FFFFFF valor: #1712e6$"..quantity,client,255,255,255,true)
        else
            outputChatBox( "#1712e6[BANCO]:#FFFFFFDinheiro insuficiente para transferir.",client,255,255,255,true)
        end
    else
        outputChatBox( "#1712e6[BANCO]:#FFFFFFInforme uma quantidade válida.",client,255,255,255,true)
    end
end)

local blipPosition = {
	{2412.50269, 1123.83569, 10.82031},
	{2194.31372, 1991.04236, 12.29688},
	{2452.42603, 2064.77344, 10.82031},
	{2546.70996, 1972.28003, 10.82031},
	{2884.83008, 2453.28003, 11.06896},
	{2247.65991, 2396.26001, 10.82031},
	{1937.25000, 2307.16992, 10.82031},
	{-181.00400, 1034.82996, 19.74219},
	{1315.48999, -897.84302, 39.57813},
	{1352.31006, -1758.30005, 13.50781},
	{1833.54004, -1843.38000, 13.57813},
	{-1492.70459, 920.17383, 7.18750},
	{-1562.63000, -2732.97998, 48.74346},
	{-1562.63000, -2732.97998, 48.74346}
}
local markerPosition = {
	{362.85846, 173.74937, 1008.38281, 0, 3},
	{-23.38661, -54.87703, 1003.54688, 5, 6},
	{-23.20298, -54.87074, 1003.54688, 4, 6},
	{-28.02946, -89.18012, 1003.54688, 2, 18},
	{-28.02946, -89.18012, 1003.54688, 3, 18},
	{-23.20596, -54.94585, 1003.54688, 3, 6},
	{-23.20596, -54.94585, 1003.54688, 7, 6},
	{-23.20596, -54.94585, 1003.54688, 0, 6},
	{-27.90755, -89.19249, 1003.54688, 1, 18},
	{-23.48763, -55.05698, 1003.54688, 2, 6},
	{-28.15056, -89.30244, 1003.54688, 0, 18},
	{-27.88890, -89.26351, 1003.54688, 37, 18},
	{-23.06417, -54.83274, 1003.54688, 1, 6},
	{-23.06417, -54.83274, 1003.54688, 1, 6}
}


addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in pairs (blipPosition) do
		local blip = createBlip(v[1], v[2], v[3], 52)
		setBlipVisibleDistance(blip, 500)
    end
    for i, v in pairs (markerPosition) do
		local marker = createMarker(v[1], v[2], v[3] - 1, "cylinder", 2.0, 0, 255, 0, 200)
		marker:setDimension(v[4])
		marker:setInterior(v[5])
		function bankHit(hitElement, matchingDimension)
			if (hitElement:getType() == "player") then
				if (matchingDimension) then
					triggerClientEvent(hitElement, "onPlayerBankHit", hitElement)
				end
			end
        end
        function bankLeave(hitElement,matchingDimension)
            if (hitElement:getType() == "player") then
				if (matchingDimension) then
					triggerClientEvent(hitElement, "onPlayerBankLeave", hitElement)
				end
			end
        end
        addEventHandler("onMarkerHit", marker, bankHit) 
        
		addEventHandler("onMarkerLeave", marker, bankLeave) 
	end
end)


