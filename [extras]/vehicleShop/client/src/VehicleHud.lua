local super = Class("VehicleHud", Container3D, function()
		static.items = {
			{ "Bicicletas", {
				{509, 5000},
				{481, 6000},
				{510, 7000},
				{"Voltar"}
			} },
			
			{ "Motos", {
				{468, 15000},
				{463, 17000},
				{581, 20000},
				{522, 22000},
				{461, 25000},
				{521, 27000},
				{"Voltar"}
			} },
			
			{ "Carros", {
				{535, 30000},
				{536, 28000},
				{415, 30000},
				{477, 35000},
				{506, 32000},
				{503, 35000},
				{565, 28000},
				{541, 40000},
				{411, 50000},
				{"Voltar"}
			} },
			
			{ "Outros", {
				{434, 25000},
				{568, 27000},
				{424, 22000},
				{471, 20000},
				{571, 25000},
				{557, 35000},
				{"Voltar"}
			} },
			
			{"Sair"}
		}

    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
end).getSuperclass()

function VehicleHud:paintComponent(g)
	local x, y = self:getLocationOnScreen()
	local w = self.width
	local h = self.height
  
	g:drawSetColor(self:getBackground())
	g:drawFilledRect(x, y, w, h)
	
	super.paintComponent(self, g)
end

local sx, sy = guiGetScreenSize()

function VehicleHud:init()
    super.init(self)

    self:setBounds(Graphics.getInsets(0, 0, 800, 600))
	self:setBackground(tocolor(0, 0, 0, 0))
	
	self.panel = Panel()
	self.panel:setBounds(sx - 300, 210, 250, 300)
	self.panel:setBorder(LineBorder(tocolor(0,0,0),2))
	self.panel:setBackground(tocolor(0, 0, 0, 150))
	self:add(self.panel)
	
	self.vehiclesLabel = Label()
    self.vehiclesLabel:setForeground(tocolor(255,255,0))
    self.vehiclesLabel:setBackground(tocolor(0,0,0))
    self.vehiclesLabel:setScale(2.5)
    self.vehiclesLabel:setText("VEICULOS")
    self.vehiclesLabel:setAlignment(Label.CENTER)
	local width, heigth = self.panel:getSize()
    self.vehiclesLabel:setBounds(0, 0, width, 35)
    self.panel:add(self.vehiclesLabel)
				
	for i, v in ipairs (VehicleHud.items) do
		if (i == 1) then
			self.lblItems = Label(v[1])
			self.lblItems:setBounds(5, 40*i, 290, 20)
			self.lblItems:setScale(1)
			self.lblItems:setAlignment(Label.LEFT)
			self.lblItems:setForeground(tocolor(255, 255, 255))
			self.lblItems:setBackground(tocolor(0, 0, 0))
			self.lblItems:setZOrder(999)
			self.lblItems:addMouseListener(self)
			self.panel:add(self.lblItems)
			self.lblItems.itemID = i
			self.lblItems.itemName = v[1]
		else
			self.lblItems = Label(v[1])
			self.lblItems:setBounds(5, (25*i) + 15, 290, 20)
			self.lblItems:setScale(1)
			self.lblItems:setAlignment(Label.LEFT)
			self.lblItems:setForeground(tocolor(255, 255, 255))
			self.lblItems:setBackground(tocolor(0, 0, 0))
			self.lblItems:setZOrder(999)
			self.lblItems:addMouseListener(self)
			self.panel:add(self.lblItems)
			self.lblItems.itemID = i
			self.lblItems.itemName = v[1]
		end
	end
	local posx, posy = self.lblItems:getLocation()
	local width, heigth = self.lblItems:getSize()
	self.panel:setSize(250, (posy+heigth) + 10)
	
	self:setVisible(false)
	
    return self
end
Toolkit.getInstance():add(VehicleHud.getInstance())

function VehicleHud:mouseReleased(e)
	if ( e.source.itemName ) then
		if ( e.source.itemName == "Sair") then
			showCursor(false)
			self:setVisible(false)
			setCameraTarget(localPlayer)
			playSoundFrontEnd(6)
			removeEventHandler("onClientRender", getRootElement(), rotationVehicleRender)
			if (vehicle) then
				vehicle:destroy()
			end
		elseif (e.source.itemName == "Voltar") then
			self:remove(self.panelClass)
			self.panel:setVisible(true)
		elseif (e.source.itemName == "Bicicletas" or e.source.itemName == "Motos" or e.source.itemName == "Carros" or e.source.itemName == "Outros") then
			local sx,sy = Graphics.getInstance():getSize()
			local x,y =  (sx/800), (sy/600)
			self.panelClass = Panel()
			self.panelClass:setBounds(sx - 300, 210, 250, 300)
			self.panelClass:setBorder(LineBorder(tocolor(0,0,0),2))
			self.panelClass:setBackground(tocolor(0, 0, 0, 150))
			self:add(self.panelClass)
			
			self.nameClass = Label()
			self.nameClass:setForeground(tocolor(255,255,0))
			self.nameClass:setBackground(tocolor(0,0,0))
			self.nameClass:setScale(2.5)
			self.nameClass:setText(e.source.itemName)
			self.nameClass:setAlignment(Label.CENTER)
			local width, heigth = self.panelClass:getSize()
			self.nameClass:setBounds(0, 0, width, 35)
			self.panelClass:add(self.nameClass)
			
			self.panel:setVisible(false)
			self.panelClass:setVisible(true)
			
			for i, v in ipairs (VehicleHud.items[e.source.itemID][2]) do
				if (i == 1) then
					if (v[2]) then
						self.lblItemsBuyPrice = Label(v[2].."$")
						self.lblItemsBuyPrice:setBounds(5, 40*i, 240, 20)
						self.lblItemsBuyPrice:setScale(1)
						self.lblItemsBuyPrice:setAlignment(Label.RIGHT)
						self.lblItemsBuyPrice:setForeground(tocolor(255, 255, 255))
						self.lblItemsBuyPrice:setBackground(tocolor(0, 0, 0))
						self.lblItemsBuyPrice:setZOrder(10)
						self.panelClass:add(self.lblItemsBuyPrice)
						
						self.lblItemsBuy = Label(getVehicleNameFromModel(v[1]))
						self.lblItemsBuy:setBounds(5, 40*i, 240, 20)
						self.lblItemsBuy:setScale(1)
						self.lblItemsBuy:setAlignment(Label.LEFT)
						self.lblItemsBuy:setForeground(tocolor(255, 255, 255))
						self.lblItemsBuy:setBackground(tocolor(0, 0, 0))
						self.lblItemsBuy:setZOrder(999)
						self.lblItemsBuy:addMouseListener(self)
						self.panelClass:add(self.lblItemsBuy)
						self.lblItemsBuy.itemID = i
						self.lblItemsBuy.itemName = v[1]
						self.lblItemsBuy.price = v[2]
						self.lblItemsBuy.lblPrice = self.lblItemsBuyPrice
					end
				else
					if (v[2]) then
						self.lblItemsBuyPrice = Label(v[2].."$")
						self.lblItemsBuyPrice:setBounds(5, (25*i) + 15, 240, 20)
						self.lblItemsBuyPrice:setScale(1)
						self.lblItemsBuyPrice:setAlignment(Label.RIGHT)
						self.lblItemsBuyPrice:setForeground(tocolor(255, 255, 255))
						self.lblItemsBuyPrice:setBackground(tocolor(0, 0, 0))
						self.lblItemsBuyPrice:setZOrder(10)
						self.panelClass:add(self.lblItemsBuyPrice)
						
						self.lblItemsBuy = Label(getVehicleNameFromModel(v[1]))
						self.lblItemsBuy:setBounds(5, (25*i) + 15, 240, 20)
						self.lblItemsBuy:setScale(1)
						self.lblItemsBuy:setAlignment(Label.LEFT)
						self.lblItemsBuy:setForeground(tocolor(255, 255, 255))
						self.lblItemsBuy:setBackground(tocolor(0, 0, 0))
						self.lblItemsBuy:setZOrder(999)
						self.lblItemsBuy:addMouseListener(self)
						self.panelClass:add(self.lblItemsBuy)
						self.lblItemsBuy.itemID = i
						self.lblItemsBuy.itemName = v[1]
						self.lblItemsBuy.price = v[2]
						self.lblItemsBuy.lblPrice = self.lblItemsBuyPrice
					else
						self.lblItemsBuy = Label(v[1])
						self.lblItemsBuy:setBounds(5, (25*i) + 15, 240, 20)
						self.lblItemsBuy:setScale(1)
						self.lblItemsBuy:setAlignment(Label.LEFT)
						self.lblItemsBuy:setForeground(tocolor(255, 255, 255))
						self.lblItemsBuy:setBackground(tocolor(0, 0, 0))
						self.lblItemsBuy:setZOrder(999)
						self.lblItemsBuy:addMouseListener(self)
						self.panelClass:add(self.lblItemsBuy)
						self.lblItemsBuy.itemID = i
						self.lblItemsBuy.itemName = v[1]
					end
				end
				
				local posx, posy = self.lblItemsBuy:getLocation()
				local width, heigth = self.lblItemsBuy:getSize()
				self.panelClass:setSize(250, (posy+heigth) + 10)
			end
		else
			triggerServerEvent("onPlayerBuyVehicle", localPlayer, e.source.itemName, e.source.price)
		end
	end
end

addEvent("onPlayerClientBuyVehcile", true)
addEventHandler("onPlayerClientBuyVehcile", getRootElement(), function()
	showCursor(false)
	VehicleHud.getInstance():setVisible(false)
	setCameraTarget(localPlayer)
	removeEventHandler("onClientRender", getRootElement(), rotationVehicleRender)
	if (vehicle) then
		vehicle:destroy()
	end
end)

function VehicleHud:mouseEntered(e)
	if ( e.source ) then
		if (e.source.lblPrice) then
			e.source:setForeground(tocolor(255,255,0))
			e.source.lblPrice:setForeground(tocolor(255,255,0))
			playSoundFrontEnd ( 3 )
			if (vehicle) then
				setElementModel(vehicle, e.source.itemName)
			end
		else
			e.source:setForeground(tocolor(255,255,0))
			playSoundFrontEnd ( 3 )
		end
	end
end

function VehicleHud:mouseExited(e)
	if ( e.source ) then
		if (e.source.lblPrice) then
			e.source:setForeground(tocolor(255,255,255))
			e.source.lblPrice:setForeground(tocolor(255,255,255))
		else
			e.source:setForeground(tocolor(255,255,255))
		end
	end
end

addEvent("onHitVehicleShop", true)
addEventHandler("onHitVehicleShop", getRootElement(), function()
	VehicleHud.getInstance():setVisible(true)
	showCursor(true)
	setCameraMatrix(2386.4521484375, 1041.6126708984, 11.770000457764, 2386.4294433594, 1042.607421875, 11.670100212097)
	vehicle = createVehicle(411, 2386.6281738281, 1052.685546875, 11.2, 0, 0, 180)
	setElementFrozen(vehicle, true)
	addEventHandler("onClientRender", getRootElement(), rotationVehicleRender)
end)

function rotationVehicleRender()
	if (vehicle) then
		local rotationx, rotationy, rotationz = getElementRotation(vehicle)
		setElementRotation(vehicle, 0, 0, rotationz+1)
	end
end

function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,checkBuildings,checkVehicles,checkPeds,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getElementPosition(localPlayer)
	local distance = distance or 20
	local height = height or 1
    local checkBuildings = checkBuildings or true
    local checkVehicles = checkVehicles or false
    local checkPeds = checkPeds or false
    local checkObjects = checkObjects or true
    local checkDummies = checkDummies or true
    local seeThroughStuff = seeThroughStuff or false
    local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false
    local ignoredElement = ignoredElement or nil
	if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawText(text, sx, sy, sx, sy, tocolor(0, 0, 0, 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
				dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end

addEventHandler("onClientRender", getRootElement(), 
function ()
	for k,v in ipairs(getElementsByType("vehicle")) do
		if (v:getData("owner")) then
			owner = v:getData("owner")

			if (not Player(owner)) then
				r, g, b = 255, 255, 255
			else
				r, g, b = getPlayerNametagColor(getPlayerFromName(owner))
			end
			
			dxDrawTextOnElement(v, owner, 1, 20, r, g, b, 255, 1, "default-bold")
		end
	end
end
)