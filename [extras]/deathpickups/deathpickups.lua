local timers = {} -- timers for existing pickups

local function onDeathPickupHit ( player, matchingDimension )
	if matchingDimension then
		killTimer ( timers[source] )
		timers[source] = nil
		removeEventHandler ( "onPickupHit", source, onDeathPickupHit )
		local weapid = getPickupWeapon ( source )
		local weapammo = getPickupAmmo ( source )
		destroyElement ( source )
		giveWeapon ( player, weapid, weapammo, false )
	end
end

local function destroyDeathPickup ( pickup )
	timers[pickup] = nil
	removeEventHandler ( "onPickupHit", pickup, onDeathPickupHit )
	destroyElement ( pickup )
end

addEventHandler ( "onPlayerWasted", getRootElement (),
	function ( source_ammo, killer, killer_weapon, bodypart )
		local pX, pY, pZ = getElementPosition ( source )
		local timeout = get("timeout")
		
		if get("only_current") then
			local source_weapon = getPedWeapon ( source )
			if ( source_weapon and source_weapon ~= 0 and source_ammo ) then
				local pickup = createPickup ( pX, pY, pZ, 2, source_weapon, timeout, source_ammo )
				addEventHandler ( "onPickupHit", pickup, onDeathPickupHit )
				timers[pickup] = setTimer ( destroyDeathPickup, timeout, 1, pickup )
			end
		else
			local droppedWeapons = {}
			for slot=0, 12 do
				local ammo = getPedTotalAmmo(source, slot) 
				if (getPedWeapon(source, slot) ~= 0) then
					local weapon = getPedWeapon(source, slot)
					local ammo = getPedTotalAmmo(source, slot)
					table.insert(droppedWeapons, {weapon, ammo})					
				end
			end
			DropAllWeapons(droppedWeapons)
		end
	end
)

function DropAllWeapons ( droppedWeapons )
	local radius = get("radius")
	local numberDropped = #droppedWeapons
	for i, t in ipairs(droppedWeapons) do
		local pX, pY, pZ = getElementPosition ( source )
		local x = pX + radius * math.cos((i-1) * 2 * math.pi / numberDropped)
		local y = pY + radius * math.sin((i-1) * 2 * math.pi / numberDropped)
		local timeout = get("timeout")
		local pickup = createPickup(x, y, pZ, 2, t[1], timeout, t[2])
		addEventHandler ( "onPickupHit", pickup, onDeathPickupHit )
		timers[pickup] = setTimer ( destroyDeathPickup, timeout, 1, pickup )
	end	
end

-- PICKUPS MONEY --

local function destroyDeathPickupMoney(pickup)
	timers[pickup] = nil
	destroyElement(pickup)
	print("destroido")
end

function createMoney(player)
   local x, y, z = getElementPosition(player);
   local x1, y1, x2, y2;
   x1 = (x-2)+(math.random()*4);
   y1 = (y-2)+(math.random()*4);
   x2 = (x-2)+(math.random()*4);
   y2 = (y-2)+(math.random()*4);
   local moneyAmmount = getPlayerMoney(player);
   moneyAmmount = math.floor(moneyAmmount/1);
 
   takePlayerMoney(player, moneyAmmount);
 
   -- We are going to create 3 pickups, zo we are just cut the ammount in half
   moneyAmmount = math.floor(moneyAmmount/3);
 
   -- Create the pickups
   local money1 = createPickup(x1, y1, z, 3, 1212)
   local money2 = createPickup(x2, y2, z, 3, 1212)
   local money3 = createPickup(x2, y2, z, 3, 1212)
   setElementData(money1, "ammount", moneyAmmount);
   setElementData(money2, "ammount", moneyAmmount);
   setElementData(money3, "ammount", moneyAmmount);
   
   timers[money1] = setTimer(destroyDeathPickupMoney, 60000*1, 1, money1)
   timers[money2] = setTimer(destroyDeathPickupMoney, 60000*1, 1, money2)
   timers[money3] = setTimer(destroyDeathPickupMoney, 60000*1, 1, money3)
end

function moneyPickupHit(player)
	local money = getElementData(source, "ammount");
	if (money) then
		givePlayerMoney(player, money);
		destroyElement(source);
	end
end
addEventHandler("onPickupUse", getRootElement(), moneyPickupHit);

function playerJustGotDied(ammo, attacker, weapon, bodypart)
   createMoney(source);
end
addEventHandler("onPlayerWasted", getRootElement(), playerJustGotDied);
