
function getServerTime ()
    local time = getRealTime()
    local year = string.gsub(tostring(time.year+1900), "20", "")
    local month = time.month+1
    if month < 10 then
    	month = "0"..month
    end
    local day = time.monthday
    if(day < 10) then
    	day = "0"..day
    end
    return year..month..day
end
function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end
function getAllPedClothes(ped)
    local clothes = { }
    for type=0, 17 do
        local texture, model = ped:getClothes(type)
        if (texture) and (model) then
            table.insert(clothes, {type, texture, model})
        end
    end
    return clothes
end
function round(val, n)
    if (n) then
       return math.floor( (val * 10^n) + 0.5) / (10^n)
    else
       return math.floor(val+0.5)
    end
 end
 
function removeAllPedClothes(thePed) 
    for i=0, 17 do 
        removePedClothes(thePed, i) 
    end 
    return true
end 

function getPedWeapons(ped)
    local weapons = {}
    for slot=1, 12 do
        local weapon = getPedWeapon(ped, slot)
        local ammo = getPedTotalAmmo(ped, slot)
        if (weapon > 0) and (ammo > 0) then
            weapons[weapon] = ammo
        end
    end
    return weapons
end
function getAllBases()
    return Base.instances.table
end

function sellBase(name)
    return Base:sellBase(name)
end

function getGangBase(name)
	return Base.getGangBase(name)
end

function onGangNameChange(previous, new)
    return Base.onGangNameChange(previous, new)
end

function saveBases()
    for index,instance in pairs(Base.instances.table) do
	    exports.Database:getDatabase():exec('UPDATE Bases SET owner=?, color=? WHERE name=?', instance.owner, toJSON({instance.base:getColor()}), instance.name)
	end
end

function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix(element)
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z
end

function syncVehicle(vehicle)
	vehicle:toggleRespawn(true)
	vehicle.idleRespawnDelay = 120000
	vehicle.respawnDelay = 10000
end

function hex2rgba(hex)
  hex = hex:gsub("#","")
  local a = tonumber("0x"..hex:sub(7,8)) or 255
  return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)), a
end

function isStringValid(text)
    return not pregFind(text, "[^a-zA-Z0-9_]");
end