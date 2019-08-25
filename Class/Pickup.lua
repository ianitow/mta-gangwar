local super = Class("Pickup", LuaObject, function()
    static.instances = {}

    static.data = {
	['Dime Motel'] = {
		{1921.23046875,702.908203125,11.1328125,358,34,5,30,"gun"},
		{1917.6953125,702.908203125,11.1328125,342,16,1,5,"gun"},
		{1913.76171875,702.908203125,11.1328125,352,28,30,120,"gun"}
	},
	['Docks'] = {
		{2317.255859375,596.9375,7.7802124023438,358,34,5,30,"gun"},
		{2313.2626953125,596.9375,7.7802124023438,344,18,1,5,"gun"},
		{2309.9150390625,596.9375,7.78125,356,31,30,180,"gun"}
	},
	['Come-A-Lot'] = {
		{2189.4921875,1128.37890625,23.3359375,361,37,30,120,"gun"},
		{2186.431640625,1122.8095703125,23.3359375,342,16,1,5,"gun"},
		{2183.6787109375,1118.4765625,23.3359375,353,29,30,120,"gun"}

	},
	['Bank'] = {
		{2184.271484375,2065.9580078125,16.322036743164,356,31,30,180,"gun"},
		{2187.806640625,2065.9580078125,16.322036743164,349,25,30,100,"gun"},
		{2191.4140625,2065.9580078125,16.322036743164,339,8,1,1,"gun"}
	},
	['Rock Hotel'] = {
		{2634.3154296875,2417.671875,14.860635757446,351,27,30,120,"gun"},
		{2638.0703125,2417.671875,14.860635757446,343,17,1,5,"gun"},
		{2643.0146484375,2417.671875,14.8671875,358,34,5,30,"gun"},
	},
	['Baseball'] = {
		{1393.951171875,2151.970703125,11.0234375,342,16,5,5,"gun"},
		{1393.951171875,2147.5703125,11.0234375,343,17,1,5,"gun"},
		{1393.951171875,2143.033203125,11.0234375,358,34,5,30,"gun"},
	},
	['Airport LV'] = {
		{1307.841796875,1605.8984375,10.8203125,355,30,30,180,"gun"},
		{1308.0224609375,1610.193359375,10.82031250,353,29,30,120,"gun"},
		{1308.029296875,1614.4248046875,10.8203125,349,25,30,100,"gun"},
	},
	['KACC'] = {
		{2575.8583984375,2847.265625,10.8203125,355,30,30,180,"gun"},
		{2579.7685546875,2847.265625,10.8203125,344,18,1,5,"gun"},
		{2584.619140625,2847.265625,10.8203125,358,34,5,30,"gun"},
	},
	['Departamento Militar'] = {
		{1023,1276.3974609375,10.855365753174,1240,nil,nil,nil,"health"},
		{1025.2,1276.3974609375,10.855365753174,1242,nil,nil,nil,"armour"},
		{1027.4,1276.3974609375,10.855365753174,372, 32, 30,450,"gun"},
		{1029.6,1276.3974609375,10.855365753174,355, 32, 30,450,"gun"},
		{1031.8,1276.3974609375,10.855365753174,343, 17, 1, 5,"gun"},
	},
	['Area 51']= {
			{ 288.75558, 1814.46094, 4.70313, 356, 31, 30, 400,"gun"}, -- m4
			{ 292.12494, 1814.36462, 4.70313, 350, 26, 5, 80,"gun"}, -- sawn-off
			{ 277.63937, 1814.38879, 4.70313, 363, 39, 1, 5,"gun"}, -- c4
			{ 282.08347, 1814.38574, 4.70313, 1240,nil,nil,nil,"health"}, -- health
			{ 285.06076, 1814.41150, 4.70313, 1242,nil,nil,nil,"armour"}, -- armor
	},
	['Fabrica']= {
		{ 928.46484375,2152.19140625,10.8203125, 1240,nil,nil,nil,"health" }, -- health		
		{ 930.46484375,2152.19140625,10.8203125, 1242,nil,nil,nil,"armour" }, -- armor	
		{ 932.46484375,2152.19140625,10.8203125, 356 , 31, 30, 400,"gun"}, -- m4
		{ 934.46484375,2152.19140625,10.8203125, 350 , 26, 5, 80,"gun"}, -- sawn-off
		{ 936.46484375,2152.19140625,10.8203125, 342, 16, 1, 5,"gun"}, -- granade
		
	},
	['Garagem'] = {
		{2874.12109375,916.701171875,10.755365371704,1240,nil,nil,nil,"health"},
		{2872.12109375,916.701171875,10.755365371704,1242,nil,nil,nil,"armour"},
		{2870.12109375,916.701171875,10.755365371704,355,30,30,400,"gun"},
		{2868.12109375,916.701171875,10.755365371704,351,27,25,100,"gun"},
		{2866.12109375,916.701171875,10.755365371704,342,16,1,5,"gun"},
	},
	['Construção'] = {
		{2373.8291015625,1958.3369140625,6.015625,1240,nil,nil,nil,"health"},
		{2373.8291015625,1956.3369140625,6.015625,1242,nil,nil,nil,"armour"},
		{2373.8291015625,1954.3369140625,6.015625,372,32,30,450,"gun"},
		{2373.8291015625,1952.3369140625,6.015625,356,31,30,400,"gun"},
		{2373.8291015625,1950.3369140625,6.015625,344,17,1,5,"gun"},	
	}

	





		}

		static.TIME_TO_GET_ITEM = 3000
end).getSuperclass()

function Pickup:init(base)
    super.init(self)
	self.pickups = {}
	self.base = base
	self.timer = {}
	self.owner = nil
	self.col = nil;
	
	


	
	table.insert(Pickup.instances,self)
	return self;
end

function Pickup:add(posX, posY, posZ,model,weaponID,ammo,maxAmmo,type)
	local pickup =  createPickup(posX, posY, posZ, 3, model, 10000)
	table.insert(self.pickups,pickup)
	local colShape = ColShape.Sphere(posX, posY, posZ, 1)

	addEventHandler("onPickupUse", pickup, function ()
		cancelEvent()
	end)
	addEventHandler( "onColShapeHit",colShape,function(player)
		if not player.type == "player" then return end
		if(self.timer[player]) then
			if(self.timer[player]:isValid()) then
				self.timer[player]:destroy()
			end
			self.timer[player] = nil
		end
		
			self.timer[player] = Timer(function (playerIntern,typeIntern,weaponIntern,ammoIntern,maxIntern)
			self:slotProcess(playerIntern,typeIntern,weaponIntern,ammoIntern,maxIntern)		
				end,Pickup.TIME_TO_GET_ITEM,0,player,type,weaponID,ammo,maxAmmo)
	
		
	end)
	addEventHandler ( "onColShapeLeave", colShape, function (player)
		if self.timer[player] then
			if(self.timer[player]:isValid()) then
				self.timer[player]:destroy()
			end
		end	
	
	end)
end


function Pickup:slotProcess(player,type,weaponID,ammo,maxAmmo)

	if(player) then
		if(player:getTeam() or self.owner ~= nil) then
			local team = player:getTeam()
			if(team.name == self.owner) then
				if(type == "gun") then
					local slot = getSlotFromWeapon(weaponID)
					local curAmmo = player:getTotalAmmo(slot)
					local curWeapon = player:getWeapon(slot)
					if(curWeapon ~= weaponID) then
						player:takeWeapon(curWeapon)
						player:giveWeapon(weaponID, ammo, true)
					else
						if((tonumber(curAmmo) + tonumber(ammo)) >= maxAmmo) then
							takeWeapon( player,weaponID)
							player:giveWeapon(weaponID, maxAmmo, true)
						else
							player:giveWeapon(weaponID, ammo, true)
						end
					end
				elseif(type == "health") then
					local maxhealth = math.ceil(100*(getPedStat(player,24)/500))
					local slot_health = maxhealth / 100 * 10
					local health = player:getHealth()		
					if(health + slot_health <= maxhealth) then
						player:setHealth(health + slot_health)
					else
						player:setHealth(maxhealth)
					end
				elseif(type=="armour") then
					local maxarmor = 100
					local slot_armor = maxarmor / 100 * 10
					local armor = player:getArmor()			
					if(armor + slot_armor <= maxarmor) then
						player:setArmor(armor + slot_armor)
					else
						player:setArmor(maxarmor)
					end
				end
					triggerClientEvent(player,"addSparks", player)
			else
				player:outputChat("#FF6464[GANGZONA]#00FF00 Sua gang não domina esta base.", 255, 255, 0, true)
			end
		else
			player:outputChat("#FF6464[GANGZONA]#00FF00 Sua gang não domina esta base.", 255, 255, 0, true)
		end
	end
	
end

function Pickup:setOwner(ownerName)
	if(ownerName) then
		self.owner = ownerName
	else
		self.owner = nil

	end
	return true
end

function Pickup:getOwner()
	return self.owner
end

function Pickup.getFromBaseName(name)
	if not name then return nil end
	for i,k in pairs(Pickup.instances) do
		if(k.base == name) then
			return k
		end
	end
	return false
end

		
addEventHandler("onResourceStart", resourceRoot,
function()
    for index,pickupT in pairs(Pickup.data) do
	  local l = Pickup(index)
	  for internIndex,internPickup in pairs(pickupT) do
		l:add(unpack(internPickup))
		end
	end	
end)