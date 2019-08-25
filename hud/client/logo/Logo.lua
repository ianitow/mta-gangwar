--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
    @description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
    
    EU ODIEIIIII CALCULAAAAAAAARRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
]]--
local super = Class("Logo", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
    
end).getSuperclass()

function Logo:init()
	super.init(self)
    self.decorator = true
    self:setZOrder(-1)
	self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    self:setBounds(0,0,self.screenX,self.screenY)
    self:setBackground(tocolor(0,0,0,255))
    self:setVisible(true)
    
    self.panel = Panel()
    self.panel:setBounds(self.screenX-160,self.screenY-150,150,150)
    --self.panel:setBorder(LineBorder(tocolor(0,255,0),1))
    self.panel:setBackground(tocolor(255,0,255,0))
    self:add(self.panel)


    self.lblImage = Image()

	self.lblImage:setSource("gfx/logo/logo-main.png")
    self.lblImage:setBounds(0,0,self.panel:getWidth(),self.panel:getHeight() )
    self.lblImage:setColor(tocolor(255,255,255,200))
    --self.lblImage:setBorder(LineBorder(tocolor(255,255,0)))
    self.panel:add(self.lblImage)

    self.website = Label("www.maingames.com.br")
    self.website:setForeground(255,255,255)
    self.website:setBackground(0,0,0)
    self.website:setAlignment(Label.CENTER)
    self.website:setBounds(0,self.panel:getHeight()-self.website:getTextHeight()-10,self.panel:getWidth(),self.website:getTextHeight())
    self.panel:add(self.website)
    
    local time = getRealTime()


   

    self.hour = Label("22:10:52")
    self.hour:setForeground(255,255,255)
    self.hour:setBackground(0,0,0)
    self.hour:setAlignment(Label.CENTER)
    self.hour:setBounds(0,self.panel:getHeight()-self.hour:getTextHeight()-25,self.panel:getWidth(),self.hour:getTextHeight())
    self.panel:add(self.hour)

    self.date = Label("23/02/2018")
    self.date:setForeground(255,255,255)
    self.date:setBackground(0,0,0)
    self.date:setAlignment(Label.CENTER)
    self.date:setBounds(0,self.panel:getHeight()-self.date:getTextHeight()-40,self.panel:getWidth(),self.date:getTextHeight())
    self.panel:add(self.date)
	return self
end


function Logo:updateHour()
    Logo.getInstance().hour:setText(getRealHour())
end


function Logo:paintComponent(g)
     self:updateHour()
	 super.paintComponent(self, g)
end



addEventHandler("onClientResourceStart", resourceRoot, function()
    Toolkit.getInstance():add(Logo.getInstance())
end)
