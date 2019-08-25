local super = Class("Area", LuaObject, function ()
	static.instances = {};
	static.database = Database("tbl_gang_areas")
    static.database:custom([[
		CREATE TABLE IF NOT EXISTS tbl_gang_areas(
        id INTEGER NOT NULL UNIQUE AUTO_INCREMENT, 
        name VARCHAR(50) UNIQUE,
        owner VARCHAR(50) NULL, 
        type VARCHAR(20),
        PRIMARY KEY(id))]]):execute()
	static.gangzonaID = {
		["Baseball"] = 1,
		["Airport LV"] = 2,
		["Bank"] = 3,
		["Come-A-Lot"] = 4,
		["Dime Motel"] = 5,
		["Docks"] = 6,
		["Rock Hotel"] = 7,
		["KACC"] = 8
	}

	static.DATA = 
	{
		{'Las Colinas' , 2505.16015625, -1439.33984375, 10.875, 423.1484375, 386.03125, 1000, 'territorio' }, 
		{'East Beach' , 2413.248046875, -1724.25, 10.914066314697, 532.2060546875, 277.7451171875, 1000, 'territorio' }, 
		{'East Beach1' , 2744.1328125, -2238.9375, 10.9453125, 139.8759765625, 511.0556640625, 1000, 'territorio' }, 
		{'Los Santos' , 2349.2646484375, -2652.5732421875, 0, 501.3671875, 324.916015625, 1000, 'territorio' }, 
		{'East Beach2' , 2606.6181640625, -2036.7646484375, 10.8828125, 136.1376953125, 308.7158203125, 1000, 'territorio' }, 
		{'Playa del Seville' , 2413.248046875, -2248.171875, 13.22829914093, 322.4267578125, 208.5, 1000, 'territorio' }, 
		{'Los Santos International' , 1319.5, -2698.5390625, 13.546875, 809.1767578125, 229.7890625, 1000, 'territorio' }, 
		{'Ocean Docks' , 1487.560546875, -2458.5458984375, 13.546875, 794.5849609375, 194.3154296875, 1000, 'territorio' }, 
		{'Las Colinas1' , 2303.30859375, -1301.470703125, 23.828481674194, 193.1220703125, 214.6162109375, 1000, 'territorio' }, 
		{'East Los Santos' , 2091.6328125, -1659.705078125, 24.772527694702, 321.251953125, 324.193359375, 1000, 'territorio' }, 
		{'Las Colinas2' , 2105.5927734375, -1318.23828125, 23.811748504639, 191.5322265625, 285.369140625, 1000, 'territorio' }, 
		{'Ganton' , 2195.0625, -2153.7138671875, 13.546875, 212.7822265625, 485.55078125, 1000, 'territorio' }, 
		{'Ganton1' , 2414.2451171875, -2037.2568359375, 3.0393323898315, 184.7138671875, 305.521484375, 1000, 'territorio' }, 
		{'Idlewood' , 1687.5, -1990.80859375, 3.984375, 490.8310546875, 308.48046875, 1000, 'territorio' }, 
		{'Willowfield' , 1675.419921875, -2253.8349609375, 13.3828125, 508.18359375, 252.68359375, 1000, 'territorio' }, 
		{'Commerce' , 1350.171875, -2269.4130859375, 13.546875, 325.73828125, 581.6806640625, 1000, 'territorio' }, 
		{'Verdant Bluffs' , 998.1376953125, -2450.3671875, 13.518402099609, 345.376953125, 534.1123046875, 1000, 'territorio' }, 
		{'Commerce1' , 862.7509765625, -1883.7041015625, 13.595377922058, 483.2255859375, 186.80859375, 1000, 'territorio' }, 
		{'Verona Beach3' , 526.478515625, -1924.02734375, 3.2356023788452, 327.48828125, 312.1201171875, 1000, 'territorio' }, 
		{'Rodeo' , 79.0439453125, -1944.8525390625, 1.4328322410583, 442.2646484375, 318.9833984375, 1000, 'territorio' }, 
		{'Las Colinas3' , 1870.341796875, -1468.0625, 24.51406288147, 216.228515625, 492.7421875, 1000, 'territorio' }, 
		{'Glen Park' , 1705.67578125, -1376.1650390625, 23.9609375, 147.103515625, 375.7353515625, 1000, 'territorio' }, 
		{'Mulholland Intersection' , 1347.6142578125, -1080.6337890625, 23.8984375, 345.404296875, 119.7705078125, 1000, 'territorio' }, 
		{'Mulholland Intersection1' , 1334.3916015625, -1317.9375, 24.113668441772, 356.947265625, 212.890625, 1000, 'territorio' }, 
		{'Glen Park1' , 1590.376953125, -1676.685546875, 3.7756652832031, 269.306640625, 283.0556640625, 1000, 'territorio' }, 
		{'Downtown Los Santos' , 1200.91565, -1570.10303, 16.484375, 379.4765625, 240.0, 1000, 'territorio' }, 
		{'Mulholland' , 954.78515625, -1136.9931640625, 25.281217575073, 354.357421875, 375.3818359375, 1000, 'territorio' }, 
		{'Vinewood' , 610.3544921875, -1309.8408203125, 23.825687408447, 329.345703125, 353.1630859375, 1000, 'territorio' }, 
		{'Richman' , 84.9287109375, -1609.8056640625, 14.62853717804, 503.0380859375, 475.2646484375, 1000, 'territorio' }, 
		{'Market' , 944.822265625, -1689.580078125, 13.038870811462, 215.404296875, 544.837890625, 1000, 'territorio' }, 
		{'Market1' , 780.728515625, -1599.5390625, 13.390609741211, 158.2705078125, 283.0693359375, 1000, 'territorio' }, 
		{'Vinewood1' , 600.07421875, -1602.9873046875, 13.546875, 169.701171875, 200.1640625, 1000, 'territorio' }, 
		{'Idlewood1' , 1867.427734375, -1675.083984375, 3.2152638435364, 216.6337890625, 199.5283203125, 1000, 'territorio' }, 
		{'San Fierro' , -2181.9853515625, 1170.9560546875, -34.457969665527, 579.2978515625, 238.6962890625, 1000, 'territorio' }, 
		{'San Fierro1' , -2751.837890625, 1180.1474609375, 7.0390625, 533.087890625, 257.3525390625, 1000, 'territorio' }, 
		{'Paradiso' , -2770.220703125, 711.3974609375, 35.023345947266, 219.87109375, 458.0380859375, 1000, 'territorio' }, 
		{'Juniper Hollow' , -2530.1328125, 716.7646484375, 35.211978912354, 212.20703125, 453.37890625, 1000, 'territorio' }, 
		{'Esplanade East' , -1832.720703125, 858.4560546875, -0.55000001192093, 359.13671875, 271.7109375, 1000, 'territorio' }, 
		{'Financial' , -1993.9580078125, 861.9404296875, 32.761756896973, 149.216796875, 300.2705078125, 1000, 'territorio' }, 
		{'Calton Heights' , -2299.94921875, 1043.0009765625, 45.4453125, 298.1572265625, 122.771484375, 1000, 'territorio' }, 
		{'Downtown' , -2086.3173828125, 573.4873046875, 7.1875, 569.1640625, 276.3408203125, 1000, 'territorio' }, 
		{'Calton Heights1' , -2312.9619140625, 853.625, 45.296875, 303.703125, 176.4482421875, 1000, 'territorio' }, 
		{'Calton Heights2' , -2296.6748046875, 504.21484375, 35.015625, 204.7529296875, 342.96484375, 1000, 'territorio' }, 
		{'Downtown1' , -2082.20703125, 322.736328125, 24.616046905518, 235.5537109375, 239.9716796875, 1000, 'territorio' }, 
		{'Easter Basin' , -1777.5732421875, -134.19140625, 3.5495557785034, 513.4091796875, 396.9716796875, 1000, 'territorio' }, 
		{'Red County' , -1722.4267578125, -658.087890625, 1.9609375, 605.046875, 503.2392578125, 1000, 'territorio' }, 
		{'Easter Basin1' , -2132.302734375, -62.28515625, 8.4139680862427, 348.5673828125, 374.3076171875, 1000, 'territorio' }, 
		{'Doherty' , -2319.8525390625, -455.8828125, 10.712282180786, 511.017578125, 382.0205078125, 1000, 'territorio' }, 
		{'Kings' , -2441.30859375, -61.3955078125, 35.171875, 278.5263671875, 516.99609375, 1000, 'territorio' }, 
		{'Garcia' , -2825.3828125, -318.3701171875, 4.1796875, 500.0107421875, 238.4384765625, 1000, 'territorio' }, 
		{'Queens' , -2818.142578125, -64.6845703125, 4.1796875, 364.0400390625, 275.0869140625, 1000, 'territorio' }, 
		{'Queens1' , -2813.0654296875, 216.509765625, 4.328125, 370.19140625, 208.228515625, 1000, 'territorio' }, 
		{'Juniper Hill' , -2807.154296875, 439.0048828125, 14.455195426941, 503.8095703125, 266.951171875, 1000, 'territorio' }, 
		{'Palisades' , -2959.017578125, 703.298828125, 5.6950674057007, 168.3828125, 502.8134765625, 1000, 'territorio' }, 
		{'Palisades1' , -2927.599609375, 417.23046875, 5.6950674057007, 106.3466796875, 275.03125, 1000, 'territorio' }, 
		{'City Hall' , -2926.46875, -319.9599609375, 4.5, 107.392578125, 718.046875, 1000, 'territorio' }, 
		{'Avispa Country Club' , -2968.783203125, -855.2265625, 3.7503094673157, 641.48828125, 529.169921875, 1000, 'territorio' }, 
		{'Foster Valley' , -2198.2763671875, -1008.935546875, 31.96875, 278.8828125, 288.771484375, 1000, 'territorio' }, 
		{'Bank' , 2163.524169, 2031.388061, 10.8203125, 148.514405, 36.29773, 5000, 'gangzona' }, 
		{'Rock Hotel' , 2561.369384, 2304.550781, 10.8203125, 114.70752, 170.457031, 5000, 'gangzona' }, 
		{'Come-A-Lot' , 2077.818115, 983.492431, 10.8203125, 259.855224, 199.989502, 5000, 'gangzona' }, 
		{'Baseball' , 1296.236572, 2099.944335, 11.015625, 101.659302, 99.525147, 5000, 'gangzona' }, 
		{'Docks' , 2229.64038, 511.183441, 1.794376373291, 162.627686, 91.421051, 5000, 'gangzona' }, 
		{'Dime Motel' , 1876.639282, 643.369567, 10.8203125, 100.614258, 120.770996, 5000, 'gangzona' }, 
		{'Airport LV' , 1258.306518, 1468.404296, 10.8203125, 109.507446, 200.120972, 5000, 'gangzona' },
		{'KACC' , 2495.55811, 2703.81763, 10.82031, 270, 180, 5000, 'gangzona' }, 
		{'Fort Carson' , -344.501495, 1006.335388, 19.59375, 369.015843, 201.004944, 10000, 'villa' }, 
		{'Palomino Creek' , 2216.439697, -104.214347, 26.336164474487, 310.290039, 251.378928, 10000, 'villa' }, 
		{'Blueberry' , 132.167495, -200.448593, 16.1875, 196.332108, 126.025887, 10000, 'villa' }, 
		{'DilliMore' , 600.664794, -614.969848, 16.1875, 241.034302, 126.765106, 10000, 'villa' }
	
}

	--STATIC VARIABLES
	static.DOMINATION_TIME = 260000
	static.ATTACK_TIME = 200000
	static.EXP_MIN_GANG_ZONA = 6000
	static.EXP_MIN_VILLAGE = 11000
	static.EXP_MIN_BUY_BASE = 12000
	static.POINTS_DEFENSER = 500

end).getSuperclass()

function  Area.getGangZonaIDByName(name)
	if (name) then
		for index, priorityID in pairs (Area.gangzonaID) do
			if (index == name) then
				return priorityID
			end
		end
	end
	return false
end

function  Area.getGangZonaNameByID(id)
	if (id) then
		for index, priorityID in pairs (Area.gangzonaID) do
			if (priorityID == id) then
				return index
			end
		end
	end
	return false
end

function Area.getGangZonaRespawn(owner)
	if (owner) then
		local priority = {}
		for index,instance in pairs (Area.instances) do
			if (instance.type == "gangzona") then
				if (instance.owner == owner) then
					local id = Area.getGangZonaIDByName(instance.name)
					table.insert(priority, id)
					table.sort(priority, function (a, b) return a < b end)
				end
			end
		end
		if (priority[1] ~= nil) then
			return Area.getGangZonaNameByID(priority[1])
		end
		return false
	end
end

function Area.getAreaOwnerByName(name)
	for index,instance in pairs (Area.instances) do
		if (instance.name == name) then
			return instance.owner;
		end
	end
	return nil;
end

function Area.getOwnerXp(gangName)
	local xp = 0
	for index,instance in pairs (Area.instances) do
		if (instance.owner == gangName) then
			xp = xp + instance.xp
		end
	end
	return xp;
end

function Area.getByName(name)
	for index,instance in pairs (Area.instances.table) do
		if (instance.name == name) then
			return instance;
		end
	end
	return nil;
end

function Area.getAllAreas()
    return Area.instances;
end

function Area.getByOwner(ownerName)
	if not ownerName then return end
	local tbl = {} 
	for i,k in pairs(Area.instances) do
		if(k.owner) then
			if(k.owner == ownerName) then
				table.insert(tbl,k)
			end
		end
	end
	return tbl
end
function Area:init(name, type, xp, owner, posX, posY, posZ, width, height, r, g, b)
    super.init(self)

    self.name = name
    self.owner = owner
    self.type = type
	self.xp = xp
	
    self.radarArea = RadarArea(posX, posY, width, height, r, g, b, 190)
    self.colShape = ColShape.Cuboid(posX, posY, posZ-20, width, height, 120)
	
	
    self.colShape:setData("state", nil) 
	self.colShape:setData("isAttacking", false)
	self.colShape:setData("name", name)
	self.colShape:setData("type", type)


	self.timer = {}
	self.source = self.colShape
	   
	self.onPlayerHitArea = function(hitElement, matchingDimension)
	    if (hitElement:getType() == "player") and (matchingDimension) then
	        local team = hitElement:getTeam()
	        if (team) then
	            if not (self.owner  == team.name) then
	                if not (self:isOnAttack()) then
						if (self.type == "gangzona") then
							local xp = team:getData("xp")
							if (xp >= Area.EXP_MIN_GANG_ZONA) then
								self:startDomination(team)
							else
								hitElement:outputChat("#FF6464[GANGZONE]#00FF00 A sua gang precisa de "..Area.EXP_MIN_GANG_ZONA.." xp para dominar essa gang zona", 255, 255, 255, true)
							end
	                    elseif (self.type == "villa") then
	                        local xp = team:getData("xp")
							if (xp >= Area.EXP_MIN_VILLAGE) then
								self:startDomination(team)
	                        else
	                            hitElement:outputChat("#FF6464[VILLA]#00FF00 A sua gang precisa de "..Area.EXP_MIN_VILLAGE.." xp para dominar essa villa", 255, 255, 255, true)
	                        end
                        elseif (self.type == "territorio") then
							self:startDomination(team)
	                    end
	                end
	            end
			end
		end
	    hitElement:setData("turf_domination", self.source)
		
		local dominationTime = 2000 - (5* #self:getAllPlayersTeam(team));
	    triggerClientEvent(hitElement,"onPlayerEnterArea", hitElement, self.source, dominationTime)
	end
	addEventHandler("onColShapeHit", self.colShape, self.onPlayerHitArea)
 
	
	self.onPlayerLeaveArea = function (hitElement)
	    if (hitElement:getType() == "player") then
	        local team = hitElement:getTeam()
        	if (team) then
        	    if (self.timer[team] and #self:getAllPlayersTeam(team) == 0) then 
        	        self.timer[team]:destroy()
        	        self.timer[team] = nil
        	        team:setData("isAttacking", false)
        	        source:setData("state", nil)
        	        for _, players in pairs (self:getAllPlayersTeam(team)) do
        	            players:setData("currentTime", nil)
						triggerClientEvent(players, "onTeamStopDomination", players, team)
        	        end
        	        source:setData("maximumTime", nil)   
        	    end
        	end
        	triggerClientEvent(hitElement, "onPlayerExitArea", self.source) 
	    end
	end
	addEventHandler("onColShapeLeave", self.colShape, self.onPlayerLeaveArea)

    self.onPlayerDeathInDomination = function (totalAmmo, attacker, killerWeapon, bodypart, stealth)
		local team = source:getTeam()
		if(team) then
			if (attacker == source) or (attacker == false) then
				if(source:isWithinColShape(self.source))then
					if(self:isOnAttack()) then
						if (team.name == self.war.attacker) then
							self.war.a_deaths = self.war.a_deaths + 1
							if (self.war.d_score) then
								self.war.d_score = self.war.d_score + 300
							end
						else
							self.war.d_deaths = self.war.d_deaths + 1
							if (self.war.a_score) then
								self.war.a_score = self.war.a_score + 300
							end
						end
					end
				end
				return;
			end
			
			if(source:isWithinColShape(self.source) and attacker:isWithinColShape(self.source)) then
				if(self:isOnAttack(team)) then

					if (attacker.type == "vehicle") then
					    local controller = attacker:getController()
						if(controller) then
						    attacker = controller
						end
					end
					local teamA = attacker:getTeam().name
					if (attacker:getTeam() == team) then
						if (teamA == self.war.attacker) then
							if(self.war.a_score) then
								self.war.a_deaths = self.war.a_deaths + 1
								self.war.d_score = self.war.d_score + 300
							end
						end
						if (teamA == self.war.defenser) then
							if(self.war.d_score) then
								self.war.a_deaths = self.war.a_deaths + 1
								self.war.a_score = self.war.a_score + 300
							end
						end
					else
						if (teamA == self.war.attacker) then
							if(self.war.a_score) then
								self.war.d_deaths = self.war.d_deaths + 1
								self.war.a_score = self.war.a_score + 300
							end
						end
						if (teamA == self.war.defenser) then
						if(self.war.a_score) then
								self.war.a_deaths = self.war.a_deaths + 1
								self.war.d_score = self.war.d_score + 300
							end
						end
					end
				end
			end
		end
	end
	
	addEventHandler("onPlayerWasted", root, self.onPlayerDeathInDomination)
	
	table.insert(Area.instances,self)

	
	return self;
end


function Area:startDomination(team)
	local dominationTime = Area.DOMINATION_TIME 
	if(self.timer[team]) then return end
	self.source:setData("state", "attack")
	self.timer[team] = {} 
	self.timer[team] = Timer(function () 
	
		if(#self:getAllPlayersTeam(team) >= 0 )then
			if(dominationTime > 0) then
				dominationTime = dominationTime - (500* #self:getAllPlayersTeam(team));
					for _,players in pairs(self:getAllPlayersTeam(team)) do
						triggerClientEvent(players, "onTeamStartDomination", players, self.source, team,(Area.DOMINATION_TIME - dominationTime),Area.DOMINATION_TIME)
					end
			else
				for index, _ in pairs (self.timer) do
					triggerClientEvent(resourceRoot, "onTeamStopDomination", self.source, index)
					self.timer[index]:destroy()
					self.timer[index]= nil
				end
				triggerClientEvent(root, "onTeamFinishDomination", self.source, team)
				self.source:setData("state", nil)
				return self:startAttack(team)
			end
		else
			for index, _ in pairs (self.timer) do
				triggerClientEvent(resourceRoot, "onTeamStopDomination",self.source, index)
				self.timer[index]:destroy()
				self.timer[index]= nil
			end
			return
		end
	end,1000,0)
end

function Area:getWarTable()
	if(self.war) then
		return self.war
	end
	return false
end

function Area:startAttack(team)
	local owner = self.source:getData("owner")
	local attackTime = Area.ATTACK_TIME
	if(owner) then
		local teamOwner = Team.getFromName(owner)
		if (teamOwner) then
			for _, playerValue in pairs (teamOwner:getPlayers()) do
				playerValue:outputChat("#FF6464[DEFENDA]#00FF00 A gang "..team.name.." está atacando o seu territorio "..self.name, 255, 255, 0, true)
				triggerClientEvent(playerValue, "client:soundDefende", playerValue)
			end
		end
		
		for _, teamValue in pairs (team:getPlayers()) do
			triggerClientEvent(teamValue, "client:soundAtaque", teamValue)
		end
		
		for _,player in pairs(Element.getAllByType("player")) do
		    triggerClientEvent(player, "onTeamStartAttack", player, self.source,self.radarArea, team.name, owner, attackTime)
		end
		
		self.radarArea:setFlashing(true)
		self.source:setData("isAttacking", true)
		
		self.war = {
			defenser = owner,
			d_deaths = 0,
			d_score = Area.POINTS_DEFENSER,
			attacker = team.name,
			a_deaths = 0,
			a_score = 0,
			warTime = attackTime
		}
			
		self.timerAttack = Timer(function ()
			attackTime = attackTime - 1000
			if(attackTime >= 0) then
				local defenseGang = Gang.getFromName(self.war.defenser)
				local attackerGang = Gang.getFromName(self.war.attacker)
					--SETING POINTS
					if(attackerGang:getTeamElement()) then
						self.war.a_score = self.war.a_score + #self:getAllPlayersTeam(attackerGang:getTeamElement())	
					end
					if(defenseGang:getTeamElement()) then
						self.war.d_score = self.war.d_score + #self:getAllPlayersTeam(defenseGang:getTeamElement())
					end
					--SEND EVENT TO ALL PLAYERS IN AREA
					for _, players in pairs(self:getAllPlayers()) do
						triggerClientEvent(players, "onTeamRefreshAttack", players, self.source,self.radarArea, self.war.attacker,self.war.defenser, attackTime,self.war.a_score,self.war.a_deaths,self.war.d_score,self.war.d_deaths,#self:getAllPlayersTeam(attackerGang:getTeamElement()),#self:getAllPlayersTeam(defenseGang:getTeamElement()))
					end
				
			else
				self.source:setData("isAttacking",false)
				self.radarArea:setFlashing(false)
				
				local winner = self.war.a_score > self.war.d_score and self.war.attacker or self.war.defenser
				local loser = self.war.a_score < self.war.d_score and self.war.attacker or self.war.defenser
				local winnerGang = Gang.getFromName(winner)
				local loserGang = Gang.getFromName(loser)
				local defended = false
				if(self.war.defenser == winner) then
					defended = true;
				else
					defended = false;
				end
				triggerClientEvent(root, "onTeamFinishAttack", self.source,self.radarArea, winner, loser, defended)
				self:setOwner(winner)
				self.timerAttack:destroy()
				self.timerAttack= nil
				if(self:getAllPlayersTeam(Gang.getFromName(loser):getTeamElement())) then
					self:startDomination(Gang.getFromName(loser):getTeamElement())
				end 
				if(defended) then
					winnerGang:incrementXP(1000)
				else
					winnerGang:incrementXP(self.xp)
					loserGang:decrementXP(self.xp)
				end
				return true;
					
			end
		end,1000,0)
	else
		local gangElement = Gang.getFromName(team.name):incrementXP(self.xp)
		triggerClientEvent(root, "onTeamFinishAttack", self.source,self.radarArea, team.name)
		return self:setOwner(team.name)
	end
end

function Area.refreshAll()
	for i,k in pairs(Area.instances)do
		
	end
end

function Area:setOwner(team)
	if not team then
		self.radarArea:setColor(160,160,160,190)
		self.source:setData("owner",nil)
		self.owner = nil
		if(self.type == "gangzona") then
			local vehicleInstance = Vehicle.getFromBaseName(self.name)
			local pickupInstance = Pickup.getFromBaseName(self.name)
			if(vehicleInstance) then
				vehicleInstance:updateColor(255,255,255)
				vehicleInstance:setOwner(nil)
			end
			if(pickupInstance) then
				pickupInstance:setOwner(nil)
			end
		end
	else
		if not (Gang.getFromName(team)) then
			outputDebugString( "ERROR LOAD GANG: "..team.."UPDATE TERRITORY TO NULL", 1 )
			self.radarArea:setColor(160,160,160,190)
			self.source:setData("owner",nil)
			self.owner = nil
			return 
		end
		local r,g,b = Gang.getFromName(team):getColor()	
		self.source:setData("owner",team)
		self.owner = team
		self.radarArea:setColor(r,g,b,190)
		if(self.type == "gangzona") then
			local vehicleInstance = Vehicle.getFromBaseName(self.name)
			local pickupInstance = Pickup.getFromBaseName(self.name)
			if(vehicleInstance) then
				vehicleInstance:updateColor(r,g,b)
				vehicleInstance:setOwner(self.owner)
			end
			if(pickupInstance) then
				pickupInstance:setOwner(self.owner)
			end
		
		end
	end


	--[[if(team) and (team ~= "") then 
      
        if (Team.getFromName(team)) then
        	r,g,b = Team.getFromName(team):getColor()
        else
		    r,g,b = exports.Gang:getColorFromName(team)      
		end	

		exports.Gang:onAreaChange(self.owner, team, self.xp)

		self.source:setData("owner", team)
		self.radarArea:setColor(r,g,b,190) 
		self.owner = team

		
		if (self.type == "gangzona") then
			self:updateColor(self.name, self.owner, r, g, b)
			
		    for _,pickup in pairs (Pickup.instances.table) do
			    if (pickup.base == self.name) then
				    pickup.owner = team
			    end
		    end
		end
		
	else
		self.source:setData("owner",nil)
		self.radarArea:setColor(163,163,163,163)
		self.owner = ""
		
		self:updateColor(self.name, nil, 255, 255, 255)
		
		
	end]]
end



function Area:isOnAttack()
	return self.source:getData("isAttacking")
end

function Area:getAllPlayersTeam(team) 
	local players = {}
	for _, player in pairs(self.colShape:getElementsWithin()) do
	    if(player:getType() == "player") then
	        local pTeam = player:getTeam()
		    if(pTeam) and (pTeam == team) then
		        table.insert(players,player)
			end
		end
	end
	return players
end

function Area:getAllPlayers()
	local players = {}
	for _, player in pairs(self.colShape:getElementsWithin()) do
	    if(player:getType() == "player") then
			table.insert(players,player)
		end
	end
	return players
end

addEvent("server:soundDomina", true)
addEventHandler("server:soundDomina", root, function(team, player)
	if (team) then
		local players = getPlayersInTeam(team) 
        for playerKey, playerValue in pairs ( players ) do
			if (playerValue == player) then
				triggerClientEvent(player, "client:soundDomina", player)
			end
        end
	end
end)


addEventHandler("onResourceStop", resourceRoot,
function ()
	outputDebugString( "-------[AREA] SAVING IN DATABASE ---------", 3,0,0,255)
	for index,value in pairs(Area.instances) do
		local result = Area.database:select("name"):where("name",value.name):getSingle();
		--Check if exists
		if not result then
			Area.database:insert({
				['name'] = value.name,
				['owner'] = value.owner,
				['type'] = value.type
			}):execute()
		elseif(type(result) == "table") then
			
			Area.database:update(
			{
				['name']= value.name,
				['owner'] = (value.owner and value.owner or "NULL"),
				['type'] = value.type
			}):where("name",value.name):execute()
		end
	end
		outputDebugString( "-------[AREA] SAVE COMPLETED! ---------", 3,0,0,255)
end)


addEventHandler("onResourceStart", resourceRoot,
function ()
	
	--	{'DilliMore' , 600.664794, -614.969848, 16.1875, 241.034302, 126.765106, 10000, 'villa' }
		for index,value in pairs (Area.DATA)do
			local instance = Area(value[1],value[8],value[7],nil,value[2],value[3],value[4],value[5],value[6],160,160,160)
			local result = Area.database:select("owner"):where("name",value[1]):getSingle()
			if(type(result) == "table") then
				if(result.owner) then
					
					local gang = Gang.getFromName(result.owner)
					if not gang then
						instance:setOwner(nil)
					else
						instance:setOwner(result.owner)
					end
				end
				if(value[8] == 'villa') then
					local b = createBlip( value[2]+100,value[3]+80,value[4],23)
					b:setVisibleDistance(250)
				end
			end
		end
	

	
	
	addCommandHandler("vilas", 
	function (player)
		for index, instance in pairs (Area.instances) do
			if (instance.type == "villa") then
				local hex = "#FFFFFF"
				if(instance.owner) then
					hex = RGBToHex(Gang.getFromName(instance.owner):getColor())
				end
				player:outputChat("#00FF00Name: #FFFFFF"..instance.name.." #00FF00 Owner: "..hex..(instance.owner or "Nenhum.").."", 255, 255, 255, true)
			end
		end
	end)

	addCommandHandler("gangzonas", 
	function (player)
		for index, instance in pairs (Area.instances) do
			if (instance.type == "gangzona") then
				local hex = "#FFFFFF"
				if(instance.owner) then
					hex = RGBToHex(Gang.getFromName(instance.owner):getColor())
				end
				player:outputChat("#00FF00Name: #FFFFFF"..instance.name.." #00FF00 Owner: "..hex..(instance.owner or "Nenhum.").."", 255, 255, 255, true)
			end
		end
	end)
end)