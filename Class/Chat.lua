function playerChatGangWar(message, messageType)
	if (messageType == 0) then
        cancelEvent()
        local r, g, b = getPlayerNametagColor(source)
        local tagGeneric = source:getData("gang.tag") or ""
        if string.len(tagGeneric)> 0 then
			outputChatBox("["..tagGeneric.."]"..getPlayerName(source).."("..tostring(getElementData(source, "ID")).."): #FFFFFF"..string.lower(message), root, r, g, b, true)
            return
        end
        outputChatBox(getPlayerName(source).."("..tostring(getElementData(source, "ID")).."): #FFFFFF"..string.lower(message), root, r, g, b, true)
	elseif (messageType == 1) then
		cancelEvent()
	elseif (messageType == 2) then
		cancelEvent()
		local team = getPlayerTeam(source)
		if (team) then
			local r, g, b = getTeamColor(team)
			local players = getPlayersInTeam(team)
			for playerKey, playerValue in ipairs (players) do
				outputChatBox("(GANG) "..getPlayerName(source).."("..tostring(getElementData(source, "ID")).."): #FFDAB9"..message, playerValue, r, g, b, true)
			end
		end
	end	
end
addEventHandler("onPlayerChat", root, playerChatGangWar)