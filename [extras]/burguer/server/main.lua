addEvent("onBuyEatHealth",true)
addEventHandler("onBuyEatHealth",root,
function(itemName, health, price, itemType)
local PlayerMoney = getPlayerMoney(client)
	if (PlayerMoney >= price) then
		playSoundFrontEnd(client, 11)
		takePlayerMoney(client, price)
		setElementHealth(client, getElementHealth(client) + health)
		outputChatBox("#FF6464["..itemType.."]#00FF00 Você comprou "..itemName, client, 0, 255, 0, true )
	else
		playSoundFrontEnd(client, 1)
		outputChatBox("#FF6464["..itemType.."]#00FF00 Dinheiro insuficiente", client, 255, 0, 0, true)
	end
end)

-- burguer --
createBlip(811.982,-1616.02,12.618, 10, 2, 255, 0, 0, 255, 0, 500)
createBlip(1199.13,-918.071,42.3243, 10, 2, 255, 0, 0, 255, 0, 500)
createBlip(-1912.27,828.025,34.5615, 10, 2, 255, 0, 0, 255, 0, 500)
createBlip(-2336.95,-166.646,34.3573, 10, 2, 255, 0, 0, 255, 0, 500)
createBlip(-2356.48,1008.01,49.9036, 10, 2, 255, 0, 0, 255, 0, 500)
createBlip(2366.74,2071.02,9.8218, 10, 2, 255, 0, 0, 255, 0, 500)
createBlip(2472.68,2033.88,9.822, 10, 2, 255, 0, 0, 255, 0, 500)
createBlip(2169.86,2795.79,9.89528, 10, 2, 255, 0, 0, 255, 0, 500)
createBlip(1872.24,2072.07,9.82222, 10, 2, 255, 0, 0, 255, 0, 500)
createBlip(1158.43,2072.02,9.82222, 10, 2, 255, 0, 0, 255, 0, 500)
--pizza
createBlip(1367.27,248.388,18.6229, 29, 2, 255, 0, 0, 255, 0, 500)
createBlip(2333.43,75.0488,25.7342, 29, 2, 255, 0, 0, 255, 0, 500)
createBlip(203.334,-202.532,0.600709, 29, 2, 255, 0, 0, 255, 0, 500)
createBlip(2105.32,-1806.49,12.6941, 29, 2, 255, 0, 0, 255, 0, 500)
createBlip(-1721.13,1359.01,6.19634, 29, 2, 255, 0, 0, 255, 0, 500)
createBlip(2638.58,1849.97,10.0231, 29, 2, 255, 0, 0, 255, 0, 500)
createBlip(2756.01,2477.05,10.061, 29, 2, 255, 0, 0, 255, 0, 500)
createBlip(2351.89,2532.19,9.82217, 29, 2, 255, 0, 0, 255, 0, 500)
createBlip(2083.49,2224.2,10.0579, 29, 2, 255, 0, 0, 255, 0, 500)
-- Chicken --
createBlip(172.727,1176.68,13.773, 14, 2, 255, 0, 0, 255, 0, 500)
createBlip(-1213.71,1830.46,40.9335, 14, 2, 255, 0, 0, 255, 0, 500)
createBlip(-2155.03,-2460.28,29.8484, 14, 2, 255, 0, 0, 255, 0, 500)
createBlip(2419.95,-1509.8,23.1568, 14, 2, 255, 0, 0, 255, 0, 500)
createBlip(2397.83,-1898.65,12.7131, 14, 2, 255, 0, 0, 255, 0, 500)
createBlip(928.525,-1352.77,12.4344, 14, 2, 255, 0, 0, 255, 0, 500)
createBlip(-1815.84,618.678,34.2989, 14, 2, 255, 0, 0, 255, 0, 500)
createBlip(-2671.53,258.344,3.64932, 14, 2, 255, 0, 0, 255, 0, 500)
createBlip(2638.58,1671.18,10.0231, 14, 2, 255, 0, 0, 255, 0, 500)
createBlip(2393.18,2041.66,9.8472, 14, 2, 255, 0, 0, 255, 0, 500)

