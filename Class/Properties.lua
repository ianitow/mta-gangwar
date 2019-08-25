local super = Class("Properties",LuaObject,function ()
    static.instances = ArrayList()
	
	static.timeReceiveLucre =600000
    
	static.data = {
		{'Golf Club House', 1458.47, 2773.43, 10.82, 125000, 12500},
		{'Marine', -2379.22, 1541.933, 2.11, 500000, 50000},
		{'Newboy Ranch', -385.1865234375, -1438.87890625, 26.3203125, 100000, 10000},
		{'Petrobas', -1038.5859375, -588.439453125, 32.012603759766, 300000, 30000},
		{'Stairway to Heaven', -1419.521, -963.478, 200.724, 250000, 25000},
		{'Four Dragons', 2022.261352, 1000.560607, 10.820312, 115000, 11500},
		{'Sex Shop', 2088.078125, 2078.019042, 11.057899, 30000, 3000},
		{'Snooker Bar', 2306.662353, -1643.453735, 14.421875, 20000, 2000},
		{'Caligulas', 2195.359619, 1681.807739, 12.367187, 130000, 13000},
		{'Lojas Zip', 1461.488281, -1137.91333, 24.068649, 25000, 2500},
		{'Lojas Binco', 2248.006591, -1663.412475, 15.469003, 20000, 2000},
		{'Tatoo Shop', 2071.049072, -1776.437011, 13.55842, 10000, 1000},
		{'Angel Pine Motel', -2194.968017, -2257.319091, 30.67765, 15000, 1500},
		{'Strip Club', 2416.866455, -1225.032592, 24.891101, 35000, 3500},
		{'Verdant Meadows Air Strip', 414, 2530, 16, 25000, 2500},
		{'Emerald Isle', 2127.593994, 2370.425537, 10.8203, 80000, 8000},
		{'The Visage', 2022.517944, 1916.684814, 12.339699, 105000, 10500},
		{'Sprunk Factory', 1343.197265, 281.531036, 19.561452, 25000, 2500},
		{'The Well Stacked Pizza', 212.153274, -204.281005, 1.578125, 20000, 2000},
		{'Lojas Victim', 457.40335, -1504.311157, 31.018157, 20000, 2000},
		{'Camels Toe', 2210.599121, 1285.864501, 10.8203, 80000, 8000},
		{'Come-a-Lot', 2181.033447, 1116.374877, 12.6484, 180000, 18000},
		{'Autobahn Imports', 2201.160888, 1391.220092, 10.8203, 40000, 4000},
		{'The Royal Casino', 2088.149902, 1449.090576, 10.8203, 80000, 8000},
		{'The Motel', 2087.002197, 2175.8208, 10.8203, 50000, 5000},
		{'Pirates in Mans Pants Hotel', 1971.73999, 1623.162963, 12.8624, 50000, 5000},
		{'Las Venturas Bandits Stadion', 1477.944702, 2248.830078, 11.0234, 115000, 11500},
		{'Xoomer Corporation', 270.562896, 1369.568725, 10.5859, 300000, 30000},
		{'Big Ear Radioteleskop', -360.792907, 1593.684448, 76.816497, 15000, 1500},
		{'The King Ring', -143.919296, 1224.510009, 19.8992, 20000, 2000},
		{'Jays Diner', -1941.351074, 2379.801025, 49.694301, 20000, 2000},
		{'Tee Pee Motel', -844.719177, 2746.094726, 46.140899, 25000, 2500},
		{'The Snakefarm', -36.079299, 2349.664306, 24.3026, 20000, 2000},
		{'Lojas Pro Laps', 503.761077, -1361.570556, 16.125158, 20000, 2000},
		{'Lojas Dider Sachs', 451.216705, -1475.865112, 30.720579, 20000, 2000},
		{'Teatro Cathay', 1022.766906, -1124.102783, 23.8708, 60000, 6000},
		{'Shopping Verona', 1129.056884, -1489.081176, 22.768999, 95000, 9500},
		{'Zero RC Shop', -2233.709716, 133.708694, 1035.42102, 25000, 2500},
		{'Jizzys Club', -2244.912597, 132.652008, 35.320312, 50000, 5000},
		{'Country Club', -2724.392089, -314.795684, 7.1861, 180000, 18000},
		{'Wang Cars', -1957.312377, 302.89239, 35.468799, 90000, 9000},
		{'Hotel', -1754.213867, 960.23468, 24.882799, 90000, 9000},
		{'Ottos Autos', -1660.478149, 1218.463623, 7.25, 90000, 9000},
		{'Pink Flamingo Hotel', 2010.50061, 1167.57373, 10.8203, 50000, 5000},
		{'The High Roller Casino', 1933.024047, 1345.544677, 9.968799, 80000, 8000},
		{'Casa de Carnes Las Venturas', 2367.984619, 1983.124267, 10.8203, 25000, 2500},
		{'Las Venturas Casino', 2318.662841, 2117.777343, 10.8281, 90000, 9000},
		{'Starfish Casino', 2205.292724, 1900.587646, 10.8203, 75000, 7500},
		{'Clowns Pocket Casino', 2221.172119, 1839.124267, 10.8203, 90000, 9000},
		{'Tikki Motel', 2483.155517, 1527.300048, 11.250399, 30000, 3000},
		{'Estacionamento Central', 2310.416015, 1389.879394, 10.8203, 50000, 5000},
		{'Supa Save Supermercado', -2442.810058, 753.777587, 35.171901, 50000, 5000},
		{'Tuff Nut Donuts', -2766.106201, 788.763916, 52.781299, 20000, 2000}
	}
	
    static.getInstance = function()
        return LuaObject.getSingleton(static)
	end
	static.database = Database("tbl_properties")
	static.database:custom([[
		CREATE TABLE IF NOT EXISTS tbl_properties(
        id INTEGER NOT NULL UNIQUE AUTO_INCREMENT, 
        name VARCHAR(50) UNIQUE,
        owner VARCHAR(50) NULL, 
        PRIMARY KEY(id))]]):execute()
   
end).getSuperclass()

function Properties.onPickupHit()
	cancelEvent()
end

function Properties:init(name, posx, posy, posz, price, lucre, owner)
    super.init(self)                            

	self.name = name
	self.price = price
	self.lucre = lucre
	self.owner = owner
	
	self.pickup = createPickup(posx, posy, posz, 3, 1273, 0)
	self.pickup:setData("isPropertie", true)
	self.pickup:setData("owner", owner)
	self.pickup:setData("name", name)
	self.pickup:setData("price",price)
	self.pickup:setData("lucre",lucre)
	
	self.culboid = ColShape.Sphere(posx, posy, posz, 1.5)
	self.culboid:setData("propertie", self.pickup)
	
	self.blip = Blip(posx, posy, posz, 31)
	self.blip:setVisibleDistance(250)
	
	if (owner ~= nil) then
		self.blip:setIcon(32)
	end
	
	self.onPlayerTryBuy = function(player)
		if (player and isElement(player) and getElementType(player) == "player") then
			if (player:isWithinColShape(self.culboid)) then
				local propertie = self.culboid:getData("propertie")
				local owner = propertie:getData("owner")
				local price = propertie:getData("price")
				local name = propertie:getData("name")
				if (owner ~= nil) then
					if (owner ~= player.name) then
						if (player:getMoney() >= price) then
							if (Player(owner)) then
								Player(owner):giveMoney(price)
								Player(owner):outputChat("#FF6464[PROPRIEDADES]#00FF00 Sua propriedade "..name.." foi comprada pelo jogador "..player.name, 255, 255, 0, true)
							end
							player:takeMoney(price)
							self:setOwner(player.name)
							player:outputChat("#FF6464[PROPRIEDADES]#00FF00 Você comprou a propriedade "..name.." do jogador "..owner, 255, 255, 0, true)
						else
							player:outputChat("#FF6464[PROPRIEDADES]#00FF00 Dinheiro insuficiente para comprar a propriedade "..name..". Preço: "..tostring(price).."$", 255, 255, 0, true)
						end
					end
				else
					if (player:getMoney() >= price) then
						player:takeMoney(price)
						player:outputChat("#FF6464[PROPRIEDADES]#00FF00 Você comprou a propriedade "..name, 255, 255, 0, true)
						self:setOwner(player.name)
					else
						player:outputChat("#FF6464[PROPRIEDADES]#00FF00 Dinheiro insuficiente para comprar a propriedade "..name..". Preço: "..tostring(price).."$", 255, 255, 0, true)
					end
				end
			end
		end
	end
	
	self.onPlayerTrySell = function(player)
		if (player and isElement(player) and getElementType(player) == "player") then
			if (player:isWithinColShape(self.culboid)) then
				local propertie = self.culboid:getData("propertie")
				local owner = propertie:getData("owner")
				local price = propertie:getData("price")
				local name = propertie:getData("name")
				if (owner ~= nil) then
					if (owner ~= player.name) then
						player:outputChat("#FF6464[PROPRIEDADES]#00FF00 Você não é dono da propriedade "..name, 255, 255, 0, true)
					else
						player:giveMoney(price)
						player:outputChat("#FF6464[PROPRIEDADES]#00FF00 Você vendeu a propriedade "..name, 0, 255, 0, true)
						self:setOwner(nil)
					end
				else
					player:outputChat("#FF6464[PROPRIEDADES]#00FF00 Você não é dono da propriedade "..name, 255, 255, 0, true)
				end
			end
		end
	end
	
	self.onPlayerEnterPropertie = function(player, matchingDimension) 
		if(player:getType() == "player") then
			addCommandHandler("comprar", self.onPlayerTryBuy)
			addCommandHandler("vender", self.onPlayerTrySell)
			local propertie = source:getData("propertie")
			local owner = propertie:getData("owner")
			local name = propertie:getData("name")
			local price = propertie:getData("price")
			if (owner == nil) or (owner ~= player.name) then
				player:outputChat("#FF6464[PROPRIEDADES]#00FF00 Para comprar a propriedade "..name.." por "..tostring(price).."$. Digite /comprar!", 255, 255, 0, true)
			else
				player:outputChat("#FF6464[PROPRIEDADES]#00FF00 Para vender a propriedade "..name.." por "..tostring(price).."$. Digite /vender", 255, 255, 0, true)
			end
		end
	end
	addEventHandler("onColShapeHit", self.culboid, self.onPlayerEnterPropertie)
	
	self.onPlayerExitPropertie = function (player)
		if(player.type == "player") then
			removeCommandHandler("comprar")
			removeCommandHandler("vender")
		end
	end
	addEventHandler("onColShapeLeave", self.culboid, self.onPlayerExitPropertie)
	
	addEventHandler("onPickupHit", self.pickup, Properties.onPickupHit)
    
    Properties.instances:add(self);
    return self;
end

function Properties.getOwnerLucres(player)
	local lucreTotal = 0
	for index, data in pairs(Properties.instances.table) do
		if(data.owner) then
			if (data.owner == player.name) then
				lucreTotal = lucreTotal + data.lucre
			end
		end
	end
	return lucreTotal
end

function Properties.getByOwner(player)
	if not player then return end
	local tbl = {}
	for index, instance in pairs (Properties.instances.table) do
		if(instance.owner == player.name) then
			table.insert(tbl,instance)
		end
	end
	return tbl
end

function Properties:setOwner(owner)
    if not owner then
        self.owner = nil
        self.pickup:setData("owner",nil)
        self.blip:setIcon(31)
    else
        self.owner = owner
        self.pickup:setData("owner",self.owner)
        self.blip:setIcon(32)
    end
end


function Properties.onResourceStop()	
     for index,value in pairs (Properties.instances.table) do
	   
		local result = Properties.database:select("name"):where("name",value.name):getSingle();
		--Check if exists
		if not result then
			Properties.database:insert({
				['name'] = value.name,
				['owner'] = value.owner,
			}):execute()
		elseif(type(result) == "table") then
			Properties.database:update(
			{
				['name']= value.name,
				['owner'] = (value.owner and value.owner or "NULL"),
			}):where("name",value.name):execute()
        end
    end
end 
addEventHandler("onResourceStop", resourceRoot, Properties.onResourceStop)

local timer;
function Properties.onResourceStart()
	for i, v in ipairs(Properties.data) do
		local ins = Properties(v[1], v[2],  v[3],  v[4],  v[5],  v[6], nil)
		local result = Properties.database:select("owner"):where("name",v[1]):getSingle()
		if(type(result) == "table") then
			if(result.owner) then
				ins:setOwner(result.owner)
			end
		end
	end
	timer = setTimer(function()
		local players = {}
		for i,k in pairs(Properties.instances.table) do
			if(k.owner) then
				if(#players == 0 )then
					table.insert(players,k.owner)
				else
					if not (table.contains(players,k.owner)) then
						table.insert(players,k.owner)
					end
				end
			end
		end
		for index, pl in pairs(players) do
			local playerElement = getPlayerFromName(pl)
			if(playerElement) then
				local allLucres = Properties.getOwnerLucres(playerElement)
				outputChatBox("#FF6464[PROPRIEDADES]#00FF00Você recebeu $"..tostring(allLucres).." de suas propriedades.",playerElement,255,255,255,true)
				givePlayerMoney(playerElement,allLucres)
			end			
		end
	end,Properties.timeReceiveLucre,0)
end

function table.contains(table, element)
	for _, value in pairs(table) do
	  if value == element then
		return true
	  end
	end
	return false
  end

addEventHandler("onResourceStart", resourceRoot, Properties.onResourceStart)

addCommandHandler("props",function(player,cmd)
	local t = timer:getDetails()
	outputChatBox("#FF6464[PROPRIEDADES]#00FF00As propriedades irão fazer seus pagamentos em #FF6464"..(round((t/60000))>0 and round((t/60000)).." minutos." or "menos de 1 minuto." ),player,255,255,255,true)
end)