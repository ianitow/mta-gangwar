--[[
	@author: Ianito
	@since:1.0
	@website: www.maingames.com.br
	@description: Base System
]]--

local super = Class("Base", LuaObject, function()
	
	static.BASES_DATA = {
    
		['Area 51'] = {
			['x'] = 96.45930, 
			['y'] = 1799.39465,
			['width'] = 200,
			['height']= 170,
			['cost'] = 1000000,
			['markerX'] = 299.07037,
			['markerY'] = 1815.41638,
			['markerZ'] = 3.71094,
			['gateObject'] = {980, 135.40039, 1941.5996, 21, 0,0,0},
			['gateCol'] = {130.40039, 1934.5996, 18.5, 11, 14, 7},
			['gateOnEnter'] = {2800, 148.40039, 1941.5996, 21, 0,0,0},
			['gateObject2'] = {980,285.60001,1821.3,19.4, 0,0,270},
			['gateCol2'] = {280.60001,1814.3,16.8, 11, 14, 7},

		},
		['Fabrica'] = {
			['x'] = 917.29242, 
			['y'] = 2042.40979,
			['width'] = 85,
			['height']= 150,
			['cost'] = 525000,
			['markerX'] = 927.80859375,
			['markerY'] = 2070.2978515625,
			['markerZ'] = 9.82031,
			['gateObject'] = {980, 997.2939453125,2133.3556640625,12.4, 0,0,90},
			['gateCol'] = { 992.2939453125,2125.3556640625,10, 11, 14, 7},
			['gateOnEnter'] = {2800,  997.2939453125,2145.3556640625,12.4, 0,0,0}
		},
		['Departamento Militar'] = {
			['x'] = 1017.40393, 
			['y'] = 1222.84424,
			['width'] = 85,
			['height']= 140,
			['cost'] = 500000,
			['markerX'] = 1056.0244140625,
			['markerY'] = 1226.4794921875,
			['markerZ'] = 9.82031,
			['gateObject'] = {980, 1067.4, 1361.5, 12.4, 0,0,0},
			['gateCol'] = {1061.4, 1353.5, 10, 11, 14, 7},
			['gateOnEnter'] = {2800, 1080.4, 1361.5,  12.4, 0,0,0}
		
		},
		['Construção']= {
			['x'] = 2354.31299, 
			['y'] = 1782.86877,
			['width'] =140,
			['height']= 180,
			['cost'] = 475000,
			['markerX'] = 2396.197265625,
			['markerY'] = 1956.5283203125,
			['markerZ'] =5.015625,
			['gateObject'] = {980, 2464.4004, 1963.2002, 12.5, 0,0,0},
			['gateCol'] = {2456.4004, 1957.19849, 9.74966, 14, 14, 7},
			['gateOnEnter'] = {2800, 2475.4004, 1963.2002,  12.5, 0,0,0}
		},
		['Garagem'] = {
			['x'] = 2777.28394, 
			['y'] = 832.91931,
			['width'] =130,
			['height']= 190,
			['cost'] = 450000,
			['markerX'] =2841.4931640625,
			['markerY'] =893.66015625,
			['markerZ'] =9.75000,
			--OBJECT ID,X,Y,Z,RX,RY,RZ,
			['gateObject'] = {980, 2777.1001, 913.20001, 12.5, 0,0,90},
			['gateCol'] = {2771.03271, 906.19849, 9.74966, 14, 12, 7},
			['gateOnEnter'] = {2800, 2777.1001, 926.20001, 12.5, 0,0,0}
		}
	}
	
	static.database = Database("tbl_bases")
	static.database:custom([[
		CREATE TABLE IF NOT EXISTS tbl_bases ( 
            id INTEGER NOT NULL AUTO_INCREMENT,
            name VARCHAR(50) UNIQUE,
            owner VARCHAR(25),
            PRIMARY KEY (id)                          
        )]]
	):execute()
	static.instances = ArrayList();
	addCommandHandler("bases", function(player)
		outputChatBox("Bases:", player, 255, 255, 255, true)
		for index,instance in pairs(Base.instances.table) do
			outputChatBox("#00FF00"..instance.name.."#FFFFFF |#00FF00 Owner#FFFFFF: "..(instance.owner and RGBToHex(Gang.getFromName(instance.owner):getColor())..instance.owner or "Nenhum.").." |#00FF00 Price:#FFFFFF $"..instance.cost.."", player, 255,255,255, true)
		end
	end)
	static.XP_TO_BUY = 10000
	static.BASE_EXP_WHEN_PURCHASED = 10000
end).getSuperclass()	


--SEND A TABLE WITH VALUES
function Base:init (name,table)
	super.init(self)								
	self.allowedLevels = {["Lider"] = true, ["Comandante"] = true}
	 
	self.name = name
	self.radar = RadarArea(table.x,table.y,table.width,table.height,160,160,160,190)
    self.owner = nil
	self.cost = table.cost
	if(table.gateObject) then
	self.gate = createObject(unpack(table.gateObject))
	self.gateCol = ColShape.Cuboid(unpack(table.gateCol))
	end


	self.marker = createMarker(table.markerX,table.markerY,table.markerZ,"cylinder",2,0,0,255,255)
	self.colshape = ColShape.Rectangle(table.x,table.y,table.width,table.height)	
	local blip = createBlipAttachedTo(self.marker, 62, 2, 255, 0, 0, 255, 0)
	blip:setVisibleDistance(250)
	Base.instances:add(self)

	self.onPlayerEnterColGate = function (player,matchingDimensions)
		if (player:getType() == "player") and (matchingDimensions) and not (player:isDead()) then
	
			if(player.vehicle) then
				player = player.vehicle:getController()
			end
			if(player:getData("gang") == self.owner) then
				self.gate:move(unpack(table.gateOnEnter))
			end
		end
	end
	addEventHandler("onColShapeHit", self.gateCol,self.onPlayerEnterColGate)
	

	self.onPlayerExitColGate = function (player,matchingDimensions)
		if (player:getType() == "player") and (matchingDimensions) and not (player:isDead()) then
	
			if(player.vehicle) then
				player = player.vehicle:getController()
			end
			local _,x,y,z,rx,ry,rz = unpack(table.gateObject)
			local players = source:getElementsWithin("player")
				if (#players == 0) then
					if(player:getData("gang") == self.owner) then
						self.gate:move(2800,x,y,z)
					end
				end
		end
	
	end
	addEventHandler("onColShapeLeave", self.gateCol,self.onPlayerExitColGate)

	self.onPlayerEnterMarker = function (player, matchingDimensions)
		if (player:getType() == "player") and (matchingDimensions) and not (player:isDead()) then
			if (player:isWithinMarker(source)) then
				if (player:getTeam() and (player.team:getName() == self.owner)) then
					player:outputChat("#FF6464[BASE]#00FF00 Para vender esta base por "..self.cost.."$. Digite /vender.", 0, 0, 0, true)
					addCommandHandler("vender",
						function (player)
							self:onPlayerSendSell(player)
					end)
				else
					player:outputChat("#FF6464[BASE]#00FF00 Para comprar esta base por "..self.cost.."$. Digite /comprar.", 0, 0, 0, true)
					addCommandHandler("comprar",
						function (player)
							self:onPlayerSendBuy(player)
					end)
				end
			end
		end
	end

	addEventHandler("onMarkerHit", self.marker, self.onPlayerEnterMarker)
	addEventHandler("onMarkerLeave",self.marker, function (player, matchingDimensions)
		if (player:getType() == "player" and (matchingDimensions) ) then
			removeCommandHandler( "comprar")
			removeCommandHandler( "vender")
		end
	end)
	if(table.gateObject2) then
		self.gate2 = createObject(unpack(table.gateObject2))
		self.gateCol2 = ColShape.Cuboid(unpack(table.gateCol2))
		addEventHandler("onColShapeHit", self.gateCol2,function(player,matchingDimensions)
			if (player:getType() == "player") and (matchingDimensions) and not (player:isDead()) then
	
				if(player.vehicle) then
					player = player.vehicle:getController()
				end
				outputChatBox("desabilitado, tem 2 portões, use o outro.",player)	
			end
		
		end)
		

	end
	
	

	return self;
end


--[[
	function Base:hasPermission(player)
	return:true or false
	description:Check if player has permission in base.
]]--

function Base:hasPermission(player)
	local level = player:getData('Level')	
	if not (level) then
		return false
	end
	
	if (self.allowedLevels[level]) then
	    return true
	end
	return false
 end
 
--[[
	function Base:setOwner(GangName)
	return:self.owner
	description:Set a owner to base
]]--
function Base:setOwner(owner)
	if not owner then
		self.owner = nil
		self.radar:setColor(160,160,160,190)
		local vehicleInstance = Vehicle.getFromBaseName(self.name)
		local pickupInstance = Pickup.getFromBaseName(self.name)
	if(vehicleInstance) then
		vehicleInstance:updateColor(160,160,160)
		vehicleInstance:setOwner(nil)
	end
	if(pickupInstance) then
		pickupInstance:setOwner(nil)
	end
		return true
	end
	self.owner = owner
	local r,g,b = Gang.getFromName(self.owner):getColor()	
	self.radar:setColor(Gang.getFromName(self.owner):getColor())
	local vehicleInstance = Vehicle.getFromBaseName(self.name)
	local pickupInstance = Pickup.getFromBaseName(self.name)
	if(vehicleInstance) then
		vehicleInstance:updateColor(r,g,b)
		vehicleInstance:setOwner(self.owner)
	end
	if(pickupInstance) then
		pickupInstance:setOwner(self.owner)
	end
	return self.owner
end
--[[
	function Base:onPlayerSendBuy(player)
	return:void
	description:When player try to buy the current base.
]]--
function Base:onPlayerSendBuy(player)
	 if (player:isWithinMarker(self.marker)) then
		if player.team then 
			local team = player.team
			if not (self.owner == team.name) then
				if not Base.getByOwner(team.name) then
				if (player:getMoney() >= self.cost) then
					if(self:hasPermission(player)) then
						if(Gang.getFromMember(player):getXP() >= Base.XP_TO_BUY) then
						
						if(self.owner and self.owner ~= team.name) then
							local oldOwner = getTeamFromName(ownerName)
							if (oldOwner) then
								if(oldOwner.playerCount >= 1) then
									local gPlayers = {}
									for k, v in ipairs(getPlayersInTeam(oldOwner)) do
										outputChatBox("#FF6464[BASE]#00FF00 Sua base foi comprada pela gang "..owner:getName(), v, 255, 255, 0, true)
										table.insert(gPlayers, v)
									end
									table.sort(gPlayers, function(a,b)
										return Gang.getLevelFromName(getElementData(a,"Level")) > Gang.getLevelFromName(getElementData(b,"Level"))
									end)
									if(#gPlayers>0) then
										gPlayers[1]:giveMoney(self.cost)
										for i,k in pairs(getPlayersInTeam(oldOwner)) do
											outputChatBox("#FF6464[BASE]#00FF00 O dinheiro da base foi para:#FF6464 "..gPlayers[1], k, 255, 255, 0, true)
										end
									end
								end
							end
						end
						self:setOwner(team.name)
						takePlayerMoney( player,self.cost)
						local teamInstance = Gang.getFromName(team.name) 
						if teamInstance then
							teamInstance:incrementXP(Base.BASE_EXP_WHEN_PURCHASED)
						end
						for _,member in pairs (team:getPlayers()) do
						
							outputChatBox("#FF6464[BASE]#00FF00 Sua gang comprou a base "..self.name, member, 255, 255, 0, true)

						end
						else
							 outputChatBox("#FF6464[BASE]#00FF00 Sua gang não tem xp suficiente para comprar esta base. Necessario 12000 xp", player, 255, 255, 0, true)
						end
					else
						outputChatBox("#FF6464[BASE]#00FF00 Você não tem permissão para comprar uma base.", player, 255, 255, 0, true)
					end
				else
					outputChatBox("#FF6464[BASE]#00FF00 Dinheiro insuficente para comprar esta base. Preço: "..self.cost.."$", player, 255, 255, 0, true)
				end
				else
					outputChatBox("#FF6464[BASE]#00FF00 Sua gang já possui uma base.", player, 255, 255, 0, true)	
				end
			else
				outputChatBox("#FF6464[BASE]#00FF00 Está base ja pertence a sua gang.", player, 255, 255, 0, true)
			end
		else
			outputChatBox("#FF6464[BASE]#00FF00 Você não possui uma gang.", player, 255, 255, 0, true)
		end
	end
end

function Base:onPlayerSendSell(player)
	 if (player:isWithinMarker(self.marker)) then
		if player.team then 
			local team = player.team
			if(self.owner == team.name) then
				if(self:hasPermission(player)) then
					self:setOwner(nil)
					local teamInstance = Gang.getFromName(team.name)
					if(teamInstance) then
						teamInstance:decrementXP(Base.BASE_EXP_WHEN_PURCHASED)
					end
					givePlayerMoney( player, self.cost )
					for _,member in pairs (player.team:getPlayers()) do
						outputChatBox("#FF6464[BASE]#00FF00 Jogador "..player:getName().." vendeu a base "..self.name, member, 255, 255, 0, true)
					end
				else
					outputChatBox("#FF6464[BASE]#00FF00 Você não possui permissão para vender a base.", player, 255, 255, 0, true)
				end
			else
				outputChatBox("#FF6464[BASE]#00FF00 Está base não pertence a sua gang.", player, 255, 255, 0, true)
				
			end
		else
			outputChatBox("#FF6464[BASE]#00FF00 Você não possui uma gang.", player, 255, 255, 0, true)
		end
	end
end

function Base.onResourceStart()
	for index, value in pairs (Base.BASES_DATA) do
		local instance = Base(index,value)		
		local result = Base.database:select("owner"):where("name",index):getSingle()
		if(result and type(result) == "table") then
			if(result.owner) then
				if not  Gang.getFromName(result.owner) then
					outputDebugString( "[BASE] CANT LOAD GANG: ["..result.owner.."] UPDATING BASE TO NULL",1)
					instance:setOwner(nil)
				else
					instance:setOwner(result.owner)
					Gang.getFromName(result.owner):incrementXP(Base.BASE_EXP_WHEN_PURCHASED)
				end
			end
		end
	end
end

function Base.onResourceStop()
	outputDebugString( "-------[BASE] SAVING IN DATABASE ---------", 3,0,0,255)
	for index,value in pairs(Base.instances.table) do
		local result = Base.database:select("name"):where("name",value.name):getSingle();
		
		--Check if exists
		if not result then
			Base.database:insert({
				['name'] = value.name,
				['owner'] = value.owner,
			}):execute()
		elseif(type(result) == "table") then
			Base.database:update(
			{
				['name']= value.name,
				['owner'] = (value.owner and value.owner or "NULL"),
			}):where("name",value.name):execute()
		end
	end
		outputDebugString( "-------[BASE] SAVE COMPLETED! ---------", 3,0,0,255)
end
function Base.getGangBase(name)
	for index,instance in pairs(Base.instances.table) do
		if(instance.owner == name) then
			return instance
	    end
	end
	return false
end

function Base:getName()
	return self.name
end
function Base.getByOwner(name)
	for index,instance in pairs(Base.instances.table) do
		if(instance.owner == name) then
			return true
	    end
	end
	return false
end	
addEventHandler("onResourceStart", resourceRoot,
function ()
	Base.onResourceStart()
end)


addEventHandler("onResourceStop", resourceRoot,
function ()
  Base.onResourceStop()
end)