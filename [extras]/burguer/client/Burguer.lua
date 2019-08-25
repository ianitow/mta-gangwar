local super = Class("HealthEat", Container3D, function()
    
    static.items = {
            
                { "Pequeno", 5, 10 },
                { "Medio", 10, 20 },
                { "Grande", 15, 30 },
                { "Muito Grande ",20,30},
                
                { "Sair" }
        
             }
             
 static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
end).getSuperclass()

function HealthEat:paintComponent(g)
    local x, y = self:getLocationOnScreen()
    local w = self.width
    local h = self.height
  
    g:drawSetColor(self:getBackground())
    g:drawFilledRect(x, y, w, h)
    
    super.paintComponent(self, g)
end

local screenX, screenY = guiGetScreenSize()

function HealthEat:init()
    super.init(self)

    self:setBounds(Graphics.getInsets(0, 0, 800, 600))
    self:setBackground(tocolor(0, 0, 0, 0))
    
    
    self.panelClass = Panel()
    self.panelClass:setBounds((screenX - 250) /2, (screenY - 300) /2, 250, 300)
    self.panelClass:setBorder(LineBorder(tocolor(0,0,0),2))
    self.panelClass:setBackground(tocolor(0, 0, 0, 150))
    self:add(self.panelClass)
            
    self.nameClass = Label()
    self.nameClass:setForeground(tocolor(255,255,0))
    self.nameClass:setBackground(tocolor(0,0,0))
    self.nameClass:setScale(2.5)
    self.nameClass:setText("")
    self.nameClass:setAlignment(Label.CENTER)
    local width, heigth = self.panelClass:getSize()
    self.nameClass:setBounds(0, 0, width, 35)
    self.panelClass:add(self.nameClass)    
         
    self.panelClass:setVisible(false)
            
    for i, v in ipairs (HealthEat.items) do
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
                self.lblItemsBuy.health= v[2]
                self.lblItemsBuy.price = v[3]
				self.lblItemsBuy.type = self.nameClass:getText()
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
                self.lblItemsBuy.health = v[2]
                self.lblItemsBuy.price = v[3]
				self.lblItemsBuy.type = self.nameClass:getText()
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
            
    self:setVisible(true)
    
    return self
end
Toolkit.getInstance():add(HealthEat.getInstance())

function HealthEat:mouseEntered(e)
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

function HealthEat:mouseExited(e)
    if ( e.source ) then
        if (e.source.lblPrice) then
            e.source:setForeground(tocolor(255,255,255))
            e.source.lblPrice:setForeground(tocolor(255,255,255))
        else
            e.source:setForeground(tocolor(255,255,255))
        end
    end
end

function HealthEat:mouseReleased(e)
    if ( e.source.itemName ) then
        if ( e.source.itemName == "Sair") then
            showCursor(false)
            self.panelClass:setVisible(false)
            playSoundFrontEnd(6)
        else
            triggerServerEvent("onBuyEatHealth", localPlayer, e.source.itemName, e.source.health, e.source.price, e.source.type)
        end
    end
end




local position = {
    { 377.10623168945, -67.435386657715, 1000, 0, 10, "BURGUER" },
    { 376.70318603516, -68.459686279297, 1000, 1, 10, "BURGUER" },
    { 376.70318603516, -68.459686279297, 1000, 7, 10, "BURGUER" },
    { 376.70318603516, -68.459686279297, 1000, 8, 10, "BURGUER" },
    { 376.70318603516, -68.459686279297, 1000, 5, 10, "BURGUER" },
    { 376.70318603516, -68.459686279297, 1000, 6, 10, "BURGUER" },
    { 376.70318603516, -68.459686279297, 1000, 9, 10, "BURGUER" },
    { 376.70318603516, -68.459686279297, 1000, 3, 10, "BURGUER" },
    { 376.70318603516, -68.459686279297, 1000, 2, 10, "BURGUER" },
    { 376.70318603516, -68.459686279297, 1000, 4, 10, "BURGUER" },                 

    { 373.43643188477, -118.8117980957, 1000.4921875, 0, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 1, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 2, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 3, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 4, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 5, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 6, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 7, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 8, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 9, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 10, 5, "PIZZA" },
    { 373.43643188477, -118.8117980957, 1000.4921875, 11, 5, "PIZZA" },

    { 369.17388916016, -6.0179758071899, 1000.8515625, 0, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 1, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 2, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 3, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 4, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 5, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 6, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 7, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 8, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 9, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 10, 9, "CHICKEN" },
    { 369.17388916016, -6.0179758071899, 1000.8515625, 11, 9, "CHICKEN" }
}

function onMenuEatStart()
    for index, data in pairs (position) do
        local marker = createMarker(data[1], data[2], data[3], "cylinder", 2.0, 255, 0, 0, 200)
        setElementInterior(marker, data[5])
        setElementDimension(marker, data[4])
        setElementData(marker, "type", data[6])
        addEventHandler("onClientMarkerHit", marker, function(hitPlayer, matchingDimension)
            if(hitPlayer == localPlayer and matchingDimension)then
                showCursor(true)
                HealthEat.getInstance().panelClass:setVisible(true)
                local typeName = getElementData(source, "type")
                HealthEat.getInstance().nameClass:setText(typeName)
            end
        end)
    end
end
addEventHandler("onClientResourceStart", resourceRoot, onMenuEatStart)