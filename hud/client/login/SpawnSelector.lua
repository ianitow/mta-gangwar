--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("SpawnSelector", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
    static.SKINS = 
    {
        ['polices'] = {280,281,282,283,284,285,286,287,288},
        --DILMA,BOLSONARO,LULA
        ['bandits'] = {293,310,137,7,24,35,61,94,213,253},
        --KEFERA,ZOI,COCIELO,
        ['animes'] = {306,308,290,48,10,52,57,58,59,56},
        ['skin-cj'] = {0},
        ['vips'] = {298,291,292,312,60,54,55,50,51,30,19},
        ['others'] = {
            2,8,9,11,12,13,14,15,16,17,18,20,21,22,
            23,25,26,27,28,29,31,32,33,34,36,37,38,39,40,41,
            43,44,45,46,47,49,53,60,62,
            63,64,66,67,68,69,70,71,72,73,75,76,0, 1, 66, 67, 68, 78, 79, 80, 81, 82, 83, 84, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 163, 164,77, 85, 87, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 139, 140, 141, 145, 148, 150, 151, 152, 157, 169, 172, 178, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 218, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263, 304, 165, 166, 167, 168, 170, 171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 204, 206, 209, 210, 212, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 249, 250, 252, 254, 255, 258, 259, 260, 261, 262, 264, 265, 266, 267, 268, 269, 270, 271, 272, 274, 275, 276, 277, 278, 279, 294, 295, 296, 297, 299, 300, 301, 302, 303, 305, 307, 309, 311
        }

 
    }
end).getSuperclass()

function SpawnSelector:init()
	super.init(self)
	self:css([[
button {
	color: #FFFFFF;
	background-color: #22A7F0;
    cursor: pointer;
}
button:hover {
	color: #FFFFFF;
	background-color: #1F3A93;
	cursor: pointer;
}
button:active{
	color: #FFFFFF;
	background-color: #19B5FE;
	cursor: pointer;
}    

  
]])
	self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    self:setBounds(0,0,self.screenX,self.screenY)
    self:setBackground(tocolor(0,0,0,255))
	self:setVisible(true)
    self:setZOrder(5)


	self.panelExtern = Panel()
	self.panelExtern:setBounds(50,self.screenY/3.2,self.screenX/3,275)
	self.panelExtern:setBackground(0,0,0,150)
	self.panelExtern:setBorder(LineBorder(tocolor(0,0,0),1))
	self.panelExtern.decorator = true
	self:add(self.panelExtern)

    self.panelTitle = Panel()
    self.panelTitle:setBounds(0,0,self.panelExtern:getWidth(),25)
    self.panelTitle:setBackground(tocolor(30, 139, 195))
    self.panelExtern:add(self.panelTitle)
    
    self.panelTitleDecorator = Panel()
    self.panelTitleDecorator:setBounds(0,self.panelTitle:getHeight(),self.panelExtern:getWidth(),5)
    self.panelTitleDecorator:setBackground(tocolor(37, 116, 169))
    self.panelExtern:add(self.panelTitleDecorator)

    self.panelTitleLabel = Label("Selecione sua skin")
    self.panelTitleLabel:setBounds(0,0,self.panelTitle:getWidth(),self.panelTitle:getHeight())
    self.panelTitleLabel:setAlignment(Label.CENTER)
    self.panelTitleLabel:setScale(1.5)
    self.panelTitleLabel:setForeground(tocolor(255,255,255))
    self.panelTitleLabel:setBackground(tocolor(0,0,0))
    self.panelTitle:add(self.panelTitleLabel)

    self.panelButtons = Container()
    self.panelButtons:setBounds(0,40,self.panelExtern:getWidth(),self.panelExtern:getHeight() - (self.panelTitle:getHeight()) -15)
    self.panelButtons:setBackground(tocolor(255,255,255))
    self.panelExtern:add(self.panelButtons)

    self.buttonPolice = Button("Policiais")
    self.buttonPolice:setScale(1.2)
	self.buttonPolice:setBounds(0,0,self.panelButtons:getWidth(),35)
	self.buttonPolice:addMouseListener(self)
    self.panelButtons:add(self.buttonPolice)
    
    self.buttonBandit = Button("Bandidos")
	self.buttonBandit:setBounds(0,self.buttonPolice:getHeight()+self.buttonBandit:getHeight()+4,self.panelButtons:getWidth(),35)
    self.buttonBandit:addMouseListener(self)
    self.buttonBandit:setScale(1.2)
    self.panelButtons:add(self.buttonBandit)
    
    self.buttonAnimes = Button("Animes")
	self.buttonAnimes:setBounds(0,self.buttonBandit:getY()+self.buttonBandit:getHeight()+4,self.panelButtons:getWidth(),35)
    self.buttonAnimes:addMouseListener(self)
    self.buttonAnimes:setScale(1.2)
    self.panelButtons:add(self.buttonAnimes)

    self.buttonSkinCJ = Button("Skin CJ")
	self.buttonSkinCJ:setBounds(0,self.buttonAnimes:getY()+self.buttonAnimes:getHeight()+4,self.panelButtons:getWidth(),35)
    self.buttonSkinCJ:addMouseListener(self)
    self.buttonSkinCJ:setScale(1.2)
	self.panelButtons:add(self.buttonSkinCJ)
   
    self.buttonVips= Button("VIP's")
	self.buttonVips:setBounds(0,self.buttonSkinCJ:getY()+self.buttonSkinCJ:getHeight()+4,self.panelButtons:getWidth(),35)
    self.buttonVips:addMouseListener(self)
    self.buttonVips:setScale(1.2)
    self.panelButtons:add(self.buttonVips)
    
    self.buttonOthers = Button("Outros")
	self.buttonOthers:setBounds(0,self.buttonVips:getY()+self.buttonVips:getHeight()+4,self.panelButtons:getWidth(),35)
    self.buttonOthers:addMouseListener(self)
    self.buttonOthers:setScale(1.2)
    self.panelButtons:add(self.buttonOthers)
    
    


    self.buttonLeft = Button("<<")
	self.buttonLeft:setBounds(self.screenX/4.1,self.screenY/1.2,self.screenX/5,35)
    self.buttonLeft:addMouseListener(self)
    self.buttonLeft:setScale(1.2)
     self:add(self.buttonLeft)

     
    self.buttonSpawn = Button("SPAWN")
	self.buttonSpawn:setBounds(self.buttonLeft:getX()+self.buttonLeft:getWidth()+10,self.buttonLeft:getY(),self.screenX/7,35)
    self.buttonSpawn:addMouseListener(self)
    self.buttonSpawn:setScale(1.2)
    self:add(self.buttonSpawn)

    self.buttonRight = Button(">>")
	self.buttonRight:setBounds(self.buttonSpawn:getX()+self.buttonSpawn:getWidth()+10,self.buttonLeft:getY(),self.screenX/5,35)
    self.buttonRight:addMouseListener(self)
    self.buttonRight:setScale(1.2)
    self:add(self.buttonRight)
    
   

    self.selectedTableSkin = SpawnSelector.SKINS['polices']
    self.selectedTableIndex = 1

    self.playerRealDimension = localPlayer.dimension or 0;
    self.playerRealInterior =localPlayer.interior or 0 
  
    self:setVisible(false)

        	return self
end


function SpawnSelector:changeSkin(typeChange)
    if(typeChange == "right") then
        if(self.selectedTableIndex >= #self.selectedTableSkin) then
            self.selectedTableIndex = 1
        else
            self.selectedTableIndex = self.selectedTableIndex +1
        end
    elseif(typeChange == "left") then
      if(self.selectedTableIndex == 1) then
            self.selectedTableIndex = #self.selectedTableSkin
        else
            self.selectedTableIndex = self.selectedTableIndex - 1
        end
    elseif(typeChange=="first") then
        self.selectedTableIndex = 1
    end
    triggerServerEvent( "changeSkinServer", localPlayer, self.selectedTableSkin[self.selectedTableIndex])
end



function SpawnSelector:mousePressed(e)
    if(e:getButton() == MouseEvent.BUTTON1) then
        if(e.source == self.buttonPolice) then
            self.selectedTableSkin = SpawnSelector.SKINS['polices']
            self:changeSkin("first")
        elseif(e.source == self.buttonBandit) then
            self.selectedTableSkin = SpawnSelector.SKINS['bandits']
            self:changeSkin("first")
        elseif(e.source == self.buttonSkinCJ) then
            self.selectedTableSkin = SpawnSelector.SKINS['skin-cj']
            self:changeSkin("first")
            elseif(e.source == self.buttonAnimes) then
            self.selectedTableSkin = SpawnSelector.SKINS['animes']
            self:changeSkin("first")
        elseif(e.source == self.buttonVips) then
            self.selectedTableSkin = SpawnSelector.SKINS['vips']
            self:changeSkin("first")
        elseif(e.source == self.buttonOthers) then
           self.selectedTableSkin = SpawnSelector.SKINS['others']
           self:changeSkin("first")
        end

        if(e.source == self.buttonRight) then
            self:changeSkin("right")
        elseif(e.source == self.buttonLeft) then
            self:changeSkin("left")
        elseif(e.source == self.buttonSpawn)  then
            self:destroySpawn()
        end
        localPlayer:setRotation(180,180,0)
    end
end


--[[function SpawnSelector:paintComponent(g)
 	 g:drawSetColor(tocolor(0,0,0,150))
	 g:drawFilledRect(0, 0, 275, self.screenY)
	 g:drawSetColor(tocolor(0,0,0,255))
	 g:drawSetLineWidth(2.0)
	 g:drawLine(276,0,276,self.screenY)
	 super.paintComponent(self, g)
end]]


function SpawnSelector:protectPlayer()
	
    self.playerRealDimension = localPlayer.dimension or 0;
    self.playerRealInterior =localPlayer.interior or 0 

    localPlayer:setAlpha(255)
    localPlayer:setRotation(180,180,0)
    setCameraTarget(localPlayer)

    --self:changeSkin("first")
    triggerServerEvent( "protectPlayerServer", localPlayer )

end

function SpawnSelector:destroySpawn()
    setCameraTarget(localPlayer)
    SpawnSelector.getInstance():setVisible(false)
    showCursor(false)
     triggerServerEvent( "unprotectPlayerServer", localPlayer,self.playerRealDimension,self.playerRealInterior)
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    Toolkit.getInstance():add(SpawnSelector.getInstance())
end)


function getPositionInfrontOfElement(element, meters)
    if (not element or not isElement(element)) then return false end
    local meters = (type(meters) == "number" and meters) or 3
    local posX, posY, posZ = getElementPosition(element)
    local _, _, rotation = getElementRotation(element)
    posX = posX - math.sin(math.rad(rotation)) * meters
    posY = posY + math.cos(math.rad(rotation)) * meters
    rot = rotation + math.cos(math.rad(rotation))
    return posX, posY, posZ,rot
end

function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end