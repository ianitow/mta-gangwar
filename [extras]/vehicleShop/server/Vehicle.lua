local super = Class("VehicleShop",LuaObject,function ()
    static.instances = ArrayList()
	
	static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
end).getSuperclass()

function VehicleShop:init(owner, vehicleid, credits, newVehicle)
	super.init(self)
	
	self.owner = owner
	self.vehicle = vehicleid
	self.credits = credits
	self.newVehicle = newVehicle
	
	VehicleShop.instances:add(self);
    return self;
end

function VehicleShop.hasPlayerVehicle(player)
	for index,instance in pairs(VehicleShop.instances.table) do
		if(instance.owner == player.name) then
			return true
	    end
	end
	return false
end

function VehicleShop.getVehicleByOwner(player)
	for index,instance in pairs(VehicleShop.instances.table) do
		if(instance.owner == player.name) then
			return instance.vehicle
	    end
	end
end

function VehicleShop.getVehicleCredits(player)
	for index,instance in pairs(VehicleShop.instances.table) do
		if(instance.owner == player.name) then
			return instance.credits
	    end
	end
end

function VehicleShop.setVehicleUsed(player)
	for index,instance in pairs(VehicleShop.instances.table) do
		if(instance.owner == player.name) then
			if (instance.newVehicle == true) then
				instance.newVehicle = false
				player:outputChat("#FF6464[TRANSFENDER]#00FF00 Primeira vez por conta da casa!.", 255, 0, 0, true)
			else
				instance.credits = instance.credits - 1
				player:outputChat("#FF6464[TRANSFENDER]#00FF00 Creditos restante: "..tostring(instance.credits), 255, 0, 0, true)
				if (instance.credits == 0) then
					instance.owner = nil
					instance.vehicleid = nil
					instance.newVehicle = nil
					instance.credits = nil
					exports.Database:getDatabase():exec("DELETE FROM Vehicles WHERE owner=?", player.name)
				end
			end
	    end
	end
end

addEvent("onPlayerBuyVehicle", true)
addEventHandler("onPlayerBuyVehicle", getRootElement(), function(vehicleid, vehiclePrice)
	if (VehicleShop.hasPlayerVehicle(client)) then
		client:outputChat("#FF6464[TRANSFENDER]#00FF00 Você já possui um veiculo. Use /veiculo", 255, 255, 255, true)
		return
	end
	
	if (client:getMoney() < vehiclePrice) then
		client:outputChat("#FF6464[TRANSFENDER]#00FF00 Dinheiro insuficiente para comprar o veiculo "..getVehicleNameFromModel(vehicleid), 255, 255, 255, true)
		return
	end
	
	client:takeMoney(vehiclePrice)
	client:outputChat("#FF6464[TRANSFENDER]#00FF00 Você comprou o veiculo "..getVehicleNameFromModel(vehicleid).." por "..tostring(vehiclePrice).."$. Use /veiculo", 255, 255, 255, true)
	VehicleShop(client.name, vehicleid, 10, true)
	--exports.Database:getDatabase():exec("INSERT INTO Vehicles (owner,vehicleid) VALUES (?,?)", client.name, vehicleid)
	triggerClientEvent(client, "onPlayerClientBuyVehcile", client)
end)

addCommandHandler("veiculo",
function (player, command, ...) 
    local parameters = {...}
    local act = parameters[1]

    if not (act) or (act == "") then
		if not (VehicleShop.hasPlayerVehicle(player)) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você não possui um veiculo! Compre um indo até a loja TRANSFENDER", 255, 0, 0, true)
			return
		end
		
        player:outputChat("#FF6464[TRANSFENDER]#00FF00 Use /veiculo trazer - para trazer o seu veiculo até você.", 255, 0, 0, true)
		player:outputChat("#FF6464[TRANSFENDER]#00FF00 Use /veiculo trancar - para apenas você usar o seu veiculo.", 255, 0, 0, true)
		player:outputChat("#FF6464[TRANSFENDER]#00FF00 Use /veiculo destrancar - para destrancar o seu veiculo.", 255, 0, 0, true)
		player:outputChat("#FF6464[TRANSFENDER]#00FF00 Use /veiculo info - para ver informações do seu veiculo.", 255, 0, 0, true)
        return
    end
    
    if(act == "trazer") then
		
		if not (VehicleShop.hasPlayerVehicle(player)) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você não possui um veiculo! Compre um indo até a loja TRANSFENDER", 255, 0, 0, true)
			return
		end
		if isPedInVehicle(player) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00Saia do veículo para poder pedir um novo.", 255, 0, 0, true)
			
			return
		end
		if (VehicleShop.getVehicleCredits(player) >= 1) then
			for _, vehicles in pairs (getElementsByType("vehicle")) do
				if (vehicles:getData("owner")) then
					if (vehicles:getData("owner") == player.name) then
						vehicles:destroy()
					end
				end
			end
			local vehicleModel = VehicleShop.getVehicleByOwner(player)
			local x, y, z = getElementPosition(player)
			local rotx, roty, rotz = getElementRotation(player)
			local vehicle = createVehicle(vehicleModel, x, y, z, rotx, roty, rotz)
			local handler = createObject(1337,x,y,z+10)
			attachElements(vehicle,handler)
			
			setElementAlpha(handler,0)
			setObjectScale(handler,0.01)
			moveObject(handler,5000,x,y,z,0,0,0,"InOutQuad")
			setTimer(function ()
				detachElements(vehicle)
				destroyElement(handler)
			end,5000,1)
			vehicle:setData("owner", player.name)
			VehicleShop.setVehicleUsed(player)
		end
		
	elseif(act == "trancar") then
		if not (VehicleShop.hasPlayerVehicle(player)) then
		
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você não possui um veiculo! Compre um indo até a loja TRANSFENDER", 255, 0, 0, true)
			return
		end
		
		local vehicle = getPedOccupiedVehicle(player)
		if not (vehicle) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você precisar estar dentro do seu veiculo para tranca - lo.", 255, 0, 0, true)
			return
		end
		
		if (not vehicle:getData("owner")) or (vehicle:getData("owner") ~= player.name) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você pode trancar apenas o seu proprio veiculo.", 255, 0, 0, true)
			return
		end
		
		if (vehicle:getData("Locked")) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 seu veiculo já está trancado.", 255, 0, 0, true)
			return
		end
		
		vehicle:setData("Locked", true)
		player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você trancou o seu veiculo. Para destrancar use /veiculo destrancar.", 255, 0, 0, true)
		
	elseif(act == "destrancar") then
	
		if not (VehicleShop.hasPlayerVehicle(player)) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você não possui um veiculo! Compre um na loja TRANSFENDER", 255, 0, 0, true)
			return
		end
		
		local vehicle = getPedOccupiedVehicle(player)
		if not (vehicle) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você precisar estar dentro do seu veiculo para destranca - lo.", 255, 0, 0, true)
			return
		end
		
		if (not vehicle:getData("owner")) or (vehicle:getData("owner") ~= player.name) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você não pode destrancar os veiculos de outros jogadores.", 255, 0, 0, true)
			return
		end
		
		if not(vehicle:getData("Locked")) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 seu veiculo já está destrancado.", 255, 0, 0, true)
			return
		end
		
		vehicle:setData("Locked", false)
		player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você destrancou o seu veiculo. Para trancar use /veiculo trancar.", 255, 0, 0, true)
		
	elseif(act == "info") then
	
		if not (VehicleShop.hasPlayerVehicle(player)) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você não possui um veiculo! Compre um indo até a loja TRANSFENDER", 255, 0, 0, true)
			return
		end
		
		local vehicleid = VehicleShop.getVehicleByOwner(player)
		local credits = VehicleShop.getVehicleCredits(player)
		player:outputChat("#FF6464[TRANSFENDER]#00FF00 Você possui o veiculo: "..getVehicleNameFromModel(vehicleid)..", Modelo: "..tostring(vehicleid)..", Creditos Restante: "..tostring(credits), 255, 0, 0, true)
	end
end)

function onEnterVehicleBought(player, seat, jacked)
	if (source:getData("owner")) then
		if (source:getData("Locked")) then
			player:outputChat("#FF6464[TRANSFENDER]#00FF00 Este veiculo está trancado", 255, 255, 255, true)
			cancelEvent()
		end
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), onEnterVehicleBought)

function onExplodeVehicleBought()
	if (source:getData("owner")) then
		Timer(destroyElement, 3000, 1, source)
	end
end
addEventHandler("onVehicleExplode", getRootElement(), onExplodeVehicleBought)

function VehicleShop.onResourceStop()	
    for index,instance in pairs(VehicleShop.instances.table) do
        exports.Database:getDatabase():exec("UPDATE Vehicles SET credits=?, newVehicle=? WHERE owner=?", instance.credits, instance.newVehicle, instance.owner)
    end
end 
addEventHandler("onResourceStop", resourceRoot, VehicleShop.onResourceStop)

addEventHandler("onResourceStart", resourceRoot,
function ()
	
end)

local markerVehicle = createMarker(2379.8168945313, 1039.5690917969, 9.8203125, "cylinder", 2.0, 0, 255, 0, 200)
local blip = createBlip( 2379.8168945313, 1039.5690917969, 9.8203125,55)
setBlipVisibleDistance( blip,200 )
setGarageOpen(33, true)

function markerShopHit(hitElement, matchingDimension)
	if (matchingDimension) then
		if (getElementType(hitElement) == "player" and not isPedInVehicle(hitElement)) then
			triggerClientEvent(hitElement, "onHitVehicleShop", hitElement)
		end
	end
end
addEventHandler( "onMarkerHit", markerVehicle, markerShopHit)