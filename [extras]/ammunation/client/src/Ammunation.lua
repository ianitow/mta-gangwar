local super = Class("Ammunation", Container3D, function()
		static.items = {
			{ "Melee", {
				{ "Golfclub", 2, 600},
				{ "Nightstick", 3, 700},
				{ "Knife", 4, 800},
				{ "Bat", 5, 800},
				{ "Shovel", 6, 600 },
				{ "Poolstick", 7, 500},
				{ "Katana", 8, 1000},
				{ "Chainsaw", 9, 1500},
				{ "Voltar"}
			} },
			{ "Pistols", {
				{ "9mm", 22, 240 },
				{ "Silenced 9mm", 23, 720 },
				{ "Desert Eagle", 24, 1440 },
				{ "Voltar"}
			} },
			
			{ "Micro SMGs", {
				{ "Tec-9", 32, 360 },
				{ "Micro Uzi", 28, 600 },
				{ "MP5", 29, 2400 },
				{ "Voltar"}
			} },
			
			{ "Shotguns", {
				{ "Shotgun", 25, 720 },
				{ "Sawnoff", 26, 960 },
				{ "Combat Shotgun", 27, 1200 },
				{ "Voltar"}
			} },
			
			{ "Assault", { 
				{ "AK47", 30, 4200 },
				{ "M4", 31, 5400 },
				{ "Voltar"}
			} },
			
			{ "Riffles", { 
				{ "Rifle", 33, 1200 },
				{ "Sniper Rifle", 34, 6000 },
				{ "Voltar"}
			} },
			
			{ "Equipamentos", { 
				{ "Colete", nil, 240 },
				{ "Voltar"}
			} },
			
			{ "Sair" }
		}
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
end).getSuperclass()

function Ammunation:paintComponent(g)
	local x, y = self:getLocationOnScreen()
	local w = self.width
	local h = self.height
  
	g:drawSetColor(self:getBackground())
	g:drawFilledRect(x, y, w, h)
	
	super.paintComponent(self, g)
end

function Ammunation:init()
    super.init(self)

    self:setBounds(Graphics.getInsets(0, 0, 800, 600))
	self:setBackground(tocolor(0, 0, 0, 0))
	
	self.panel = Panel()
	self.panel:setBounds(20, 210, 250, 300)
	self.panel:setBorder(LineBorder(tocolor(0,0,0),2))
	self.panel:setBackground(tocolor(0, 0, 0, 150))
	self:add(self.panel)
	
	self.ammunation = Label()
    self.ammunation:setForeground(tocolor(255,255,0))
    self.ammunation:setBackground(tocolor(0,0,0))
    self.ammunation:setScale(2.5)
    self.ammunation:setText("AMMU★NATION")
    self.ammunation:setAlignment(Label.CENTER)
	local width, heigth = self.panel:getSize()
    self.ammunation:setBounds(0, 0, width, 35)
    self.panel:add(self.ammunation)
	
	for i, v in ipairs (Ammunation.items) do
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
Toolkit.getInstance():add(Ammunation.getInstance())

function Ammunation:mouseReleased(e)
	if ( e.source.itemName ) then
		if ( e.source.itemName == "Sair") then
			showCursor(false)
			self:setVisible(false)
			playSoundFrontEnd ( 6 )
		elseif (e.source.itemName == "Voltar") then
			self:remove(self.panelClass)
			self.panel:setVisible(true)
		elseif (e.source.itemName == "Melee" or e.source.itemName == "Pistols" or e.source.itemName == "Micro SMGs" or e.source.itemName == "Shotguns" or e.source.itemName == "Assault" or e.source.itemName == "Riffles" or e.source.itemName == "Equipamentos") then
			self.panelClass = Panel()
			self.panelClass:setBounds(20, 210, 250, 300)
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
			
			for i, v in ipairs (Ammunation.items[e.source.itemID][2]) do
				if (i == 1) then
					if (v[3]) then
						self.lblItemsBuyPrice = Label(v[3].."$")
						self.lblItemsBuyPrice:setBounds(5, 40*i, 240, 20)
						self.lblItemsBuyPrice:setScale(1)
						self.lblItemsBuyPrice:setAlignment(Label.RIGHT)
						self.lblItemsBuyPrice:setForeground(tocolor(255, 255, 255))
						self.lblItemsBuyPrice:setBackground(tocolor(0, 0, 0))
						self.lblItemsBuyPrice:setZOrder(10)
						self.panelClass:add(self.lblItemsBuyPrice)
						
						self.lblItemsBuy = Label(v[1])
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
						self.lblItemsBuy.weaponid = v[2]
						self.lblItemsBuy.price = v[3]
						self.lblItemsBuy.lblPrice = self.lblItemsBuyPrice
					end
				else
					if (v[3]) then
						self.lblItemsBuyPrice = Label(v[3].."$")
						self.lblItemsBuyPrice:setBounds(5, (25*i) + 15, 240, 20)
						self.lblItemsBuyPrice:setScale(1)
						self.lblItemsBuyPrice:setAlignment(Label.RIGHT)
						self.lblItemsBuyPrice:setForeground(tocolor(255, 255, 255))
						self.lblItemsBuyPrice:setBackground(tocolor(0, 0, 0))
						self.lblItemsBuyPrice:setZOrder(10)
						self.panelClass:add(self.lblItemsBuyPrice)
						
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
						self.lblItemsBuy.weaponid = v[2]
						self.lblItemsBuy.price = v[3]
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
			playSoundFrontEnd(6)
		else
			triggerServerEvent("onPlayerBuyAmmuItem", localPlayer, e.source.itemName, e.source.weaponid, e.source.price)
		end
	end
end

function Ammunation:mouseEntered(e)
	if ( e.source ) then
		if (e.source.lblPrice) then
			e.source:setForeground(tocolor(255,255,0))
			e.source.lblPrice:setForeground(tocolor(255,255,0))
			playSoundFrontEnd ( 3 )
		else
			e.source:setForeground(tocolor(255,255,0))
			playSoundFrontEnd ( 3 )
		end
	end
end

function Ammunation:mouseExited(e)
	if ( e.source ) then
		if (e.source.lblPrice) then
			e.source:setForeground(tocolor(255,255,255))
			e.source.lblPrice:setForeground(tocolor(255,255,255))
		else
			e.source:setForeground(tocolor(255,255,255))
		end
	end
end

addEventHandler( 'onClientResourceStart', resourceRoot,
	function( )
		createammu( 295.92, -37.82, 1000.30, 1, 0, 295.9, -40.2, 1001.5, 0 )
		createammu( 295.92, -37.82, 1000.30, 1, 1, 295.9, -40.2, 1001.5, 0 )
		createammu( 289.91, -109.10, 1000.30, 6, 5, 289.99, -111.51, 1001.5, 0 )
		createammu( 289.91, -109.10, 1000.30, 6, 4, 289.99, -111.51, 1001.5, 0 )
		createammu( 289.91, -109.10, 1000.30, 6, 3, 289.99, -111.51, 1001.5, 0 )
		createammu( 289.91, -109.10, 1000.30, 6, 6, 289.99, -111.51, 1001.5, 0 )
		createammu( 295.45, -80.04, 1000.30, 4, 0, 295.52, -82.52, 1001.51, 0 )
		createammu( 295.45, -80.04, 1000.30, 4, 1, 295.5, -82.5, 1001.5, 0 )
		createammu( 295.45, -80.04, 1000.30, 4, 2, 295.5, -82.5, 1001.5, 0 )
		createammu( 295.45, -80.04, 1000.30, 4, 3, 295.5, -82.5, 1001.5, 0 )
		createammu( 312.62, -165.53, 998.30, 6, 0, 312.68, -167.9, 999.59, 0 )
	end
)

function createammu( ammuY, ammuX, ammuZ, ammuInter, ammuDim, pedY, pedX, pedZ, rotPed )

	local ammuMarker = createMarker( ammuY, ammuX, ammuZ, 'cylinder', 1.5, 255, 0, 0, 180 )
	local ammuped = createPed( 179, pedY, pedX, pedZ, rotPed )
	ammuped:setData("nametagShowing",true)
	ammuped:setData("pedName","Cleyton")
	
	setElementInterior( ammuMarker, (ammuInter or 0),  ammuY, ammuX, ammuZ )
	setElementInterior( ammuped, (ammuInter or 0),  pedY, pedX, pedZ )
	setElementDimension( ammuMarker, ammuDim )
	setElementDimension( ammuped, ammuDim )
	setPedAnimation ( ammuped, "WEAPONS", "SHP_Tray_Pose", -1, true, false)
	setElementFrozen( ammuped, true)
	addEventHandler( 'onClientPedDamage', ammuped, cancelEvent )
	addEventHandler( 'onClientMarkerHit', ammuMarker,
		function( hitPlayer, matchingDimension )
			if( hitPlayer == localPlayer )and( matchingDimension )then
				Ammunation.getInstance():setVisible(true)
				showCursor(true)
			end 
		end)
end