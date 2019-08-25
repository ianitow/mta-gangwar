local super = Class("Interiors",LuaObject,function ()
    static.instances = ArrayList()
    
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
   
end).getSuperclass()

local blockPlayer

function Interiors.getEntryDataById(id)
    for index, data in pairs(Interiors.instances.table) do
        if (data.type == "entry") then
            if (data.id == id) then
                return data.posx, data.posy, data.posz, data.rotation, data.interior, data.dimension
            end
        end
    end
end

function Interiors.getReturnDataById(id)
    for index, data in pairs(Interiors.instances.table) do
        if (data.type == "return") then
            if (data.id == id) then
                return data.posx, data.posy, data.posz, data.rotation, data.interior, data.dimension
            end
        end
    end
end

function Interiors:init(id, posx, posy, posz, rotation, interior, dimension, interiorType)
    super.init(self)                                
    
    self.type = interiorType
    self.id = id
    self.posx = posx
    self.posy = posy
    self.posz = posz
    self.rotation = rotation
    self.interior = interior
    self.dimension = dimension
    
    self.marker = createMarker(posx, posy, posz + 2.2, "arrow", 2, 255, 255, 0, 200)
    self.marker:setInterior(self.interior)
    self.marker:setDimension(self.dimension)
    self.col = createColSphere (posx, posy, posz , 1.5 )
    self.col:setInterior(self.interior)
    self.col:setDimension(self.dimension)
    
    Interiors.instances:add(self);
    return self;
end

function colshapeHit(player, matchingDimension)
    if not isElement(player) or getElementType (player) ~= "player" then return end
    if player ~= getLocalPlayer() then return end
    if (not matchingDimension) or (isPedInVehicle(player)) or 
    (doesPedHaveJetPack(player)) or (not isPedOnGround(player)) or 
    (getPedControlState(player, "aim_weapon")) or (blockPlayer) 
    then return end
    
    for index, interiors in pairs(Interiors.instances.table) do
        if (interiors.col == source) then
            if (interiors.type == "entry") then
                local x, y, z, rot, int, dim = Interiors.getReturnDataById(interiors.id)
                fadeCamera(false, 1.0)
                setTimer(function(player, int,dim,rot,x,y,z)
					triggerServerEvent("setPlayerInsideInterior", player, int,dim,rot,x,y,z)
				end, 1000, 1, player, int,dim,rot,x,y,z)
                blockPlayer = true
                setTimer(function() blockPlayer = nil end, 3500, 1)
            elseif (interiors.type == "return") then
                local x, y, z, rot, int, dim =Interiors.getEntryDataById(interiors.id)
                fadeCamera(false, 1.0)
                setTimer(function(player, int,dim,rot,x,y,z)
					triggerServerEvent("setPlayerInsideInterior", player, int,dim,rot,x,y,z)
				end, 1000, 1, player, int,dim,rot,x,y,z)
                blockPlayer = true
                setTimer(function() blockPlayer = nil end, 3500, 1)
            end
        end
    end
end
addEventHandler("onClientColShapeHit", getRootElement(), colshapeHit)

function Interiors.onResourceStart()
    ---Carrega os interiors exterioes --
    local entryInteriors = getElementsByType("interiorEntry", getResourceRootElement(resource))
    for key, interiors in pairs (entryInteriors) do
        local id = getElementData(interiors, "id")
        local posx, posy, posz = tonumber(getElementData(interiors, "posX")), tonumber(getElementData(interiors, "posY")), tonumber(getElementData(interiors, "posZ"))
        local rotation, interior, dimension = tonumber(getElementData(interiors, "rotation")), tonumber(getElementData(interiors, "interior")), tonumber(getElementData(interiors, "dimension"))
        if not id then outputDebugString ( "Interiors: Error, Id não especificado em entryInterior", 2 )
        end
        
        Interiors(id, posx, posy, posz, rotation, interior, dimension, "entry")
    end
    
    ---Carrega os interiors internos --
    local returnInteriors = getElementsByType("interiorReturn", getResourceRootElement(resource))
    for key, interiors in pairs (returnInteriors) do
        local id = getElementData(interiors, "refid")
        local posx, posy, posz = tonumber(getElementData(interiors, "posX")), tonumber(getElementData(interiors, "posY")), tonumber(getElementData(interiors, "posZ"))
        local rotation, interior, dimension = tonumber(getElementData(interiors, "rotation")), tonumber(getElementData(interiors, "interior")), tonumber(getElementData(interiors, "dimension"))
        if not id then outputDebugString ( "Interiors: Error, Id não especificado em returnInterior", 2 )
        end
        
        Interiors(id, posx, posy, posz, rotation, interior, dimension, "return")
    end
end
addEventHandler("onClientResourceStart", resourceRoot, Interiors.onResourceStart)