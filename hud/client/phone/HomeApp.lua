local super = Class("HomeApp", App, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
end).getSuperclass()

function HomeApp:init(father)
    super.init(self)
    local width,height,iWidth,iHeight = 80,80,50,50
    local phoneInstance = Phone.getInstance()
    -----------------------------------First App Info Player---------------------------------------------------------
    self.firstAppBig = Panel()
    self.firstAppBig:setBounds(10,phoneInstance.barNotification:getHeight()+10,width,height)
    self.firstAppBig:setBackground(tocolor(unpack(phoneInstance.colorBackgroundApp)))
    self.firstAppBig:addMouseListener({
        mouseEntered = function()      
            self.firstAppBig:setBackground(tocolor(unpack(phoneInstance.appColorOnEntered)))
        end,
        mouseExited = function()
            self.firstAppBig:setBackground(tocolor(unpack(phoneInstance.appColorOnExited)))
        end,
        mousePressed = function(e)
            if(e:getButton() == MouseEvent.BUTTON1) then
               self:unloadMe()
               self:loadApp(InfoApp.getInstance())
            end
        end
    })
    self:add(self.firstAppBig)
    self.iconFirst = Image()
    self.iconFirst:setSource(Phone.icons['stats'])
    self.iconFirst:setBounds((self.firstAppBig:getWidth()-50)/2,(self.firstAppBig:getHeight()-50)/2,50,50)
    self.iconFirst.decorator = true
    self.firstAppBig:add(self.iconFirst)

    self.labelFirstApp = Label("Informações")
    self.labelFirstApp.decorator = true
    self.labelFirstApp:setFont(self.fontDefault)
    self.labelFirstApp:setBounds(5,self.firstAppBig:getHeight()-25,self.firstAppBig:getWidth(),25)
    self.labelFirstApp:setForeground(tocolor(255,255,255))
    self.firstAppBig:add(self.labelFirstApp)


-- -----------------------------------------------------------------------------------------------------------------

-----------------------------------Second App Info Player---------------------------------------------------------
self.secondAppBig = Panel()
self.secondAppBig:setBounds(self.firstAppBig:getX()+self.firstAppBig:getWidth()+5,self.firstAppBig:getY(),width,height)
self.secondAppBig:setBackground(tocolor(unpack(phoneInstance.colorBackgroundApp)))
self.secondAppBig:addMouseListener({
    mouseEntered = function()      
          self.secondAppBig:setBackground(tocolor(unpack(phoneInstance.appColorOnEntered)))
    end,
    mouseExited = function()
         self.secondAppBig:setBackground(tocolor(unpack(phoneInstance.appColorOnExited)))
    end
})
self:add(self.secondAppBig)
self.iconSecond = Image()
self.iconSecond:setSource(Phone.icons['phone'])
self.iconSecond:setBounds((self.secondAppBig:getWidth()-iWidth)/2,(self.secondAppBig:getHeight()-iHeight)/2,iWidth,iHeight)
self.iconSecond.decorator = true
self.secondAppBig:add(self.iconSecond)

self.labelSecondApp = Label("Telefone")
self.labelSecondApp:setFont(self.fontDefault)
self.labelSecondApp.decorator = true
self.labelSecondApp:setBounds(5,self.secondAppBig:getHeight()-25,self.secondAppBig:getWidth(),25)
self.labelSecondApp:setForeground(tocolor(255,255,255))
self.secondAppBig:add(self.labelSecondApp)
-- -----------------------------------------------------------------------------------------------------------------

-- -----------------------------------Third App Info Player---------------------------------------------------------

self.thirdAppBig = Panel()
self.thirdAppBig:setBounds(self.secondAppBig:getX()+self.secondAppBig:getWidth()+5,self.firstAppBig:getY(),width,height)
self.thirdAppBig:setBackground(tocolor(unpack(phoneInstance.colorBackgroundApp)))
 self.thirdAppBig:addMouseListener({
    mouseEntered = function()      
          self.thirdAppBig:setBackground(tocolor(unpack(phoneInstance.appColorOnEntered)))
    end,
    mouseExited = function()
        self.thirdAppBig:setBackground(tocolor(unpack(phoneInstance.appColorOnExited)))
    end,
    mousePressed = function(e)
        if(e:getButton() == MouseEvent.BUTTON1) then
           self:unloadMe()
           self:loadApp(ConfigApp.getInstance())
        end
    end
})
self:add(self.thirdAppBig)

self.iconThird = Image()
self.iconThird:setSource(Phone.icons['settings'])
self.iconThird:setBounds((self.thirdAppBig:getWidth()-iWidth)/2,(self.thirdAppBig:getHeight()-iHeight)/2,iWidth,iHeight)
self.iconThird.decorator = true
self.thirdAppBig:add(self.iconThird)

self.labelThirdApp = Label("Config")
self.labelThirdApp.decorator = true
self.labelThirdApp:setFont(self.fontDefault)
self.labelThirdApp:setBounds(5,self.secondAppBig:getHeight()-25,self.secondAppBig:getWidth(),25)
self.labelThirdApp:setForeground(tocolor(255,255,255))
self.thirdAppBig:add(self.labelThirdApp)
-- -----------------------------------------------------------------------------------------------------------------

-- -----------------------------------Four App Info Player---------------------------------------------------------

self.fourApp = Panel()
self.fourApp:setBounds(10,self.firstAppBig:getY()+self.firstAppBig:getHeight()+5,(width*2)+5,(height*2)+5)
self.fourApp:setBackground(tocolor(unpack(phoneInstance.colorBackgroundApp)))
self.fourApp:addMouseListener({
    mouseEntered = function()      
          self.fourApp:setBackground(tocolor(unpack(phoneInstance.appColorOnEntered)))
    end,
    mouseExited = function()
        self.fourApp:setBackground(tocolor(unpack(phoneInstance.appColorOnExited)))
    end
})
self:add(self.fourApp)

self.iconFour = Image()
self.iconFour:setSource(Phone.icons['world'])
self.iconFour:setBounds((self.fourApp:getWidth()-iWidth*2)/2,(self.fourApp:getHeight()-iHeight*2)/2,100,100)
self.iconFour.decorator = true

self.fourApp:add(self.iconFour)

self.labelFourApp = Label("Informações Gang War")
self.labelFourApp.decorator = true
self.labelFourApp:setFont(self.fontDefault)
self.labelFourApp:setBounds((self.fourApp:getWidth()-self.fourApp:getWidth()+10)/2,self.fourApp:getHeight()-25,self.fourApp:getWidth(),25)
self.labelFourApp:setForeground(tocolor(255,255,255))
self.fourApp:add(self.labelFourApp)

-- -----------------------------------------------------------------------------------------------------------------



self.fiveApp = Panel()
self.fiveApp:setBounds(self.fourApp:getX()+self.fourApp:getWidth()+5,self.fourApp:getY(),width,height)
self.fiveApp:setBackground(tocolor(unpack(phoneInstance.colorBackgroundApp)))
self.fiveApp:addMouseListener({
    mouseEntered = function()      
        self.fiveApp:setBackground(tocolor(unpack(phoneInstance.appColorOnEntered)))
    end,
    mouseExited = function()
        self.fiveApp:setBackground(tocolor(unpack(phoneInstance.appColorOnExited)))
    end
})
self:add(self.fiveApp)

self.iconFive = Image()
self.iconFive:setSource(Phone.icons['bank'])
self.iconFive:setBounds((self.fiveApp:getWidth()-iWidth)/2,(self.fiveApp:getHeight()-iHeight)/2,iWidth,iHeight)
self.iconFive.decorator = true
self.fiveApp:add(self.iconFive)

self.labelFiveApp = Label("Banco App")
self.labelFiveApp.decorator = true
self.labelFiveApp:setFont(self.fontDefault)
self.labelFiveApp:setBounds(5,self.secondAppBig:getHeight()-25,self.secondAppBig:getWidth(),25)
self.labelFiveApp:setForeground(tocolor(255,255,255))
self.fiveApp:add(self.labelFiveApp)

-- -----------------------------------------------------------------------------------------------------------------

self.sixApp = Panel()
self.sixApp:setBounds(self.fiveApp:getX(),self.fiveApp:getHeight()+self.fiveApp:getY()+5,width,height)
self.sixApp:setBackground(tocolor(unpack(phoneInstance.colorBackgroundApp)))
self.sixApp:addMouseListener({
    mouseEntered = function()      
       self.sixApp:setBackground(tocolor(unpack(phoneInstance.appColorOnEntered)))
    end,
    mouseExited = function()
       self.sixApp:setBackground(tocolor(unpack(phoneInstance.appColorOnExited)))
    end
})
self:add(self.sixApp)

self.iconSix = Image()
self.iconSix:setSource(Phone.icons['map'])
self.iconSix:setBounds((self.sixApp:getWidth()-iWidth)/2,(self.sixApp:getHeight()-iHeight)/2,iWidth,iHeight)
self.iconSix.decorator = true
self.sixApp:add(self.iconSix)

self.labelSixApp = Label("Maps")
self.labelSixApp.decorator = true
self.labelSixApp:setFont(self.fontDefault)
self.labelSixApp:setBounds(5,self.sixApp:getHeight()-25,self.sixApp:getWidth(),25)
self.labelSixApp:setForeground(tocolor(255,255,255))
self.sixApp:add(self.labelSixApp)

-- -----------------------------------------------------------------------------------------------------------------


self.sevenApp = Panel()
self.sevenApp:setBounds(10,self.sixApp:getHeight()+self.sixApp:getY()+5,(width*3) +10,height*2.3)
self.sevenApp:setBackground(tocolor(unpack(phoneInstance.colorBackgroundApp)))
self.sevenApp:addMouseListener({
    mouseEntered = function()      
     self.sevenApp:setBackground(tocolor(unpack(phoneInstance.appColorOnEntered)))
    end,
    mouseExited = function()
        self.sevenApp:setBackground(tocolor(unpack(phoneInstance.appColorOnExited)))
    end
})
self:add(self.sevenApp)

self.iconSeven = Image()
self.iconSeven:setSource(Phone.icons['war'])
self.iconSeven:setBounds(0,0,self.sevenApp:getWidth(),self.sevenApp:getHeight())
self.iconSeven.decorator = true
self.sevenApp:add(self.iconSeven)
-- -----------------------------------------------------------------------------------------------------------------
Phone.getInstance():setFunctionBack(function()
    return nil
end)   
return self
end





