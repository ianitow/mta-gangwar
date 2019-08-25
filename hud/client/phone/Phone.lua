--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("Phone", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
    static.icons = {
        ['phone'] = "gfx/phone/call.png",
        ['mission'] = "gfx/phone/mission.png",
        ['settings'] = "gfx/phone/settings.png",
        ['world'] = "gfx/phone/world.png",
        ['signal'] = "gfx/phone/signal-use.png",
        ['wifi']= "gfx/phone/wifi.png",
        ['battery']="gfx/phone/battery.png",
        ['stats'] = "gfx/phone/stats.png",
        ['bank'] = "gfx/phone/bank.png",
        ['map'] = "gfx/phone/map.png",
        ['war'] = "gfx/phone/war.png"
    }

    static.colorsConfig = {
        ['bg01'] = function (i)
            i.colorBackgroundApp = {0,100,100,100}
            i.appColorOnEntered, i.appColorOnExited = {0,100,90,200},i.colorBackgroundApp
            i.backgroundImage:setSource("gfx/phone/backgrounds/bg1.png")
        end,
          ['bg02'] = function (i)
            i.colorBackgroundApp = {100,100,100,100}
            i.appColorOnEntered, i.appColorOnExited = {100,100,100,200},i.colorBackgroundApp
            i.backgroundImage:setSource("gfx/phone/backgrounds/bg02.png")
        end,  
        ['bg03'] = function (i)
            i.colorBackgroundApp = {0,100,100,100}
            i.appColorOnEntered, i.appColorOnExited = {0,100,90,200},i.colorBackgroundApp
            i.backgroundImage:setSource("gfx/phone/backgrounds/bg03.jpg")
        end,
        ['bg04'] = function (i)
            i.colorBackgroundApp = {0,100,200,100}
            i.appColorOnEntered, i.appColorOnExited = {0,100,200,200},i.colorBackgroundApp
            i.backgroundImage:setSource("gfx/phone/backgrounds/bg04.jpg")
        end,
        ['pdu-bg'] = function (i)
            i.colorBackgroundApp = {100,0,0,200}
            i.appColorOnEntered, i.appColorOnExited = {200,0,0,200},i.colorBackgroundApp
            i.backgroundImage:setSource("gfx/phone/backgrounds/pdu.png")
        end
    }

end).getSuperclass()

function Phone:init()
    super.init(self)
    self.functionBack = nil
    local current = nil
    self.colorBackgroundApp = {255,255,255,100}
    self.appColorOnEntered,self.appColorOnExited = {255,255,90,190},self.colorBackgroundApp
    local fontWindows = dxCreateFont("gfx/phone/windows.TTF")
   

	self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    showCursor( true)
   
    --Image Windows Phone PNG
    local width,height,iWidth,iHeight = 80,80,50,50
    self.lblImage = Image()
    self.lblImage.decorator=true
	self.lblImage:setSource("gfx/phone/windows-phone.png")
	self.lblImage:setLocation(0,0)
    self.lblImage:setSize(310,600)
    self:add(self.lblImage)

    self:setSize(self.lblImage:getWidth(),self.lblImage:getHeight())
    self:setLocation(self.screenX-self:getWidth(),self.screenY-self:getHeight()-20)
    self:setVisible(true)

    self.barNotification = Panel()
    self.barNotification:setBounds(18,58,270,25)
    self.barNotification:setBackground(tocolor(0,0,0,150))
    self.barNotification:setZOrder(10)
    self:add(self.barNotification)

    self.signalImage = Image()
    self.signalImage:setSource(Phone.icons['signal'])
    self.signalImage:setBounds(15,1,25,25)
    self.signalImage.decorator = true
    self.barNotification:add(self.signalImage)

    self.label4G = Label("4G")
    self.label4G:setBounds(self.signalImage:getX()+self.signalImage:getWidth()+5,self.signalImage:getY(),25,25)
    self.label4G:setForeground(tocolor(255,255,255))
    self.barNotification:add(self.label4G)

    self.batteryImage = Image()
    self.batteryImage:setSource(Phone.icons['battery'])
    self.batteryImage:setBounds(self.barNotification:getWidth()-35,0,25,25)
    self.batteryImage.decorator = true
    self.barNotification:add(self.batteryImage)

    self.hourLabel = Label(getRealHour(true))
    self.hourLabel:setBounds(self.barNotification:getWidth()-75,self.signalImage:getY(),25,25)
    self.hourLabel:setForeground(tocolor(255,255,255))
    self.barNotification:add(self.hourLabel)
   
    --Background Effect Shadow 
    --OBS: Decorator only
    self.backgroundDecorator = Panel()
    self.backgroundDecorator.decorator = true
    self.backgroundDecorator:setZOrder(-1)
    self.backgroundDecorator:setBounds(self.barNotification:getX(),self.barNotification:getY(),270,490)
    self.backgroundDecorator:setBackground(tocolor(0,0,0,200))
    self.backgroundDecorator:setVisible(true)
    self:add(self.backgroundDecorator)
    
    --Container for apps
    self.backgroundContainer = Container()
    self.backgroundContainer:setBounds(self.barNotification:getX(),self.barNotification:getY(),270,490)
    self.backgroundContainer:setBackground(tocolor(255,255,255))
    self.backgroundContainer:setVisible(true)
    self:add(self.backgroundContainer)

    self.backgroundImage = Image()
    self.backgroundImage:setBounds(0,0,self.backgroundDecorator:getWidth(),self.backgroundDecorator:getHeight())
    self.backgroundImage.decorator = true
    self.backgroundImage:setColor(tocolor(255,255,255,200))
    self.backgroundContainer:add(self.backgroundImage)

   
    self.buttonBack = Panel()
    self.buttonBack:setBorder(LineBorder(tocolor(255,0,0),1))
     self.buttonBack:addMouseListener({
     
       mousePressed = function(e)
        if(e:getButton() == MouseEvent.BUTTON1) then
            if(self.functionBack) then
                self.functionBack()
            end
        end
    end
    })
    self.buttonBack:setBounds(30,self:getHeight()-55,35,30)
    self.buttonBack:setBackground(tocolor(0,255,0,0))
    self:add(self.buttonBack)

    Phone.colorsConfig['bg04'](self)
    return self
end

function Phone:setFunctionBack(f)
    if f then
        self.functionBack = f
    end
end

function Phone:loadApp(app)
    if app then
        if self.current then
            self.current:setVisible(false)
            self.current:dispose()
            Toolkit.getInstance():remove(self.current)
            self.current = nil
        end
        app:setLocation(20,0)
        app:setBounds(0,0,self.backgroundContainer:getWidth(),self.backgroundContainer:getHeight())  
        self.backgroundContainer:add(app.getInstance())
        app:setVisible(true)
        self.current = app.getInstance()
    end
end



addEventHandler("onClientResourceStart", resourceRoot, function()
    Toolkit.getInstance():add(Phone.getInstance())
    Phone.getInstance():loadApp(HomeApp.getInstance())
    
end)


