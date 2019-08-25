local colshape = ColShape.Cuboid(1994.98413, 1516.56812, 12.04839, 11, 53, 12)
local pirateBlip = Blip(2000.65259, 1544.24548, 13.5, 19)
pirateBlip:setVisibleDistance(250)

setTimer(function()
	for k, v in pairs (getElementsByType("player")) do
		if isElementWithinColShape(v, colshape) then
			givePlayerMoney(v, math.random(15,75))
		end
	end
end,1000, 0)