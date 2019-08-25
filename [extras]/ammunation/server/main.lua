addEvent("onPlayerBuyAmmuItem",true)
addEventHandler("onPlayerBuyAmmuItem",root,
function(itemName, weaponid, price)
	if(itemName == "Armor") then
		local PlayerMoney = getPlayerMoney(client)
		if (PlayerMoney >= price) then
			playSoundFrontEnd(client, 11)
			takePlayerMoney(client, price)
			setPedArmor(client, 100)
			outputChatBox("#FF6464[AMMUNATION]#00FF00 Você comprou "..itemName, client, 0, 255, 0, true)
		else
			playSoundFrontEnd(client, 1)
			outputChatBox("#FF6464[AMMUNATION]#00FF00 Dinheiro insuficiente", client, 255, 0, 0, true)
		end
	else
		local PlayerMoney = getPlayerMoney(client)
		if (PlayerMoney >= price) then
			playSoundFrontEnd(client, 11)
			takePlayerMoney(client, price)
			giveWeapon(client , weaponid, 25)
			outputChatBox("#FF6464[AMMUNATION]#00FF00 Você comprou "..itemName, client, 0, 255, 0, true )
		else
			playSoundFrontEnd(client, 1)
			outputChatBox("#FF6464[AMMUNATION]#00FF00 Dinheiro insuficiente", client, 255, 0, 0, true)
		end
	end
end)


local blipPosition = {
	{2159.54077, 943.18250, 10.82031},
	{2539.54297, 2084.05005, 10.82031},
	{776.72345, 1871.40454, 4.90660},
	{-316.16156, 829.97339, 14.24219},
	{-1508.77307, 2610.69629, 55.83594},
	{-2625.92676, 208.23489, 4.81250},
	{-2093.64087, -2464.96045, 30.62500},
	{243.29506, -178.36353, 1.58216},
	{2333.08838, 61.54024, 26.70579},
	{1369.00000, -1279.67737, 13.54688},
	{2400.43774, -1981.99609, 13.54688}
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in pairs (blipPosition) do
		local blip = createBlip(v[1], v[2], v[3], 6)
		setBlipVisibleDistance(blip, 500)
	end
end)