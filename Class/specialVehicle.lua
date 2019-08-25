local super = Class("specialVehicle", LuaObject, function()

    static.instances = ArrayList();
    static.allowTimer = {}
    static.forbidden = {}
	static.rcVehicles = {}
	static.vehicleData = {
	
	    {"Area 51", 425, 267.02517700195, 1861.5544433594, 18.719791412354, 83}, -- Hunter - Area51
		{"Fabrica", 520, 948.71069, 2120.38989, 19.69389, 270}, -- Hydra
		{"Departamento Militar", 432, 1088.14758, 1334.06299, 10.82031, 87}, -- Rhino
		{"Construção", 447, 2454.79443, 1914.87244, 10.86473, 0}, -- Seasparrow - Base Departamento Militar
		{"Garagem", 447, 2870.40112, 919.25647, 10.75000, 90} -- Seasparrow - Base garagem
	}

end).getSuperclass()	


function specialVehicle:init(base, model, x, y, z, rotation)
    super.init(self)

	self.vehicle = createVehicle (model, x, y, z, 0, 0, rotation)
    self.base = base
    self.owner = nil

    exports.Vehicles:syncVehicle(self.vehicle)

	addEventHandler("onVehicleStartEnter", self.vehicle, function(...)
		self:onVehicleStartEnter(...)
	end)
	
	addEventHandler("onVehicleEnter", self.vehicle, function(...)
		self:onVehicleEnter(...)
	end)
	
	addEventHandler("onVehicleExit", self.vehicle, function(...)
		self:onVehicleExit(...)
	end)	
	
	addEventHandler("onVehicleExplode", self.vehicle, function()
		self:onVehicleExplode()
	end)	
		
	addEventHandler("onVehicleRespawn", self.vehicle, function(...)
		self:onVehicleRespawn(source)
	end)
		
	specialVehicle.instances:add(self);
	return self
end

function specialVehicle:onVehicleStartEnter(player)
    if (player) and (player:getType() == "player")  then
    	if (player.team) and (player.team.name == self.owner) then
    		if (isTimer(specialVehicle.allowTimer[source])) then
    			cancelEvent()
				outputChatBox("[BASE] Este veiculo foi usado recentemente.", player, 255, 0, 0, true)
    		end
    	else
			outputChatBox("[BASE] Este veiculo pertence a base "..self.base, player, 255, 0, 0, true)
    		cancelEvent()
    	end
    end
end

function specialVehicle:onVehicleRespawn(vehicle)
	vehicle:setData("forbidden", true)
	if (not isTimer(specialVehicle.allowTimer[vehicle])) then
		specialVehicle.allowTimer[vehicle] = setTimer(function()
		vehicle:setData("forbidden", false)
		end, 10*60000,1)
	end
end

addEvent("onPlayerRequestForbiddenVehicles", true)
addEventHandler("onPlayerRequestForbiddenVehicles", root,
function()
	for index,instance in pairs(specialVehicle.instances.table) do
		if (isTimer(specialVehicle.allowTimer[instance.vehicle])) then
			specialVehicle.timers = {}
			specialVehicle.forbidden.elem = instance.vehicle
			specialVehicle.forbidden.time = getTimerDetails(specialVehicle.allowTimer[instance.vehicle])
			specialVehicle.timers[#specialVehicle.timers+1] = specialVehicle.forbidden
			triggerClientEvent(source, "onClientRecieveForbiddenVehicles", source, specialVehicle.timers)
		end
	end
end)

addEventHandler("onResourceStart", resourceRoot, 
    function ()
	for _,vehicle in pairs (specialVehicle.vehicleData) do
	    specialVehicle(vehicle[1], vehicle[2], vehicle[3], vehicle[4], vehicle[5], vehicle[6])
	end
end)