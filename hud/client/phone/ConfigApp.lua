--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("ConfigApp", App, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
    static.icons = {
        ['sistema'] = "gfx/phone/system-icon.png",
        ['conta'] = "gfx/phone/conta-icon.png",
        ['personalizar'] = "gfx/phone/persona-icon.png",
        ['vip'] = "gfx/phone/vip-icon.png",
    }
end).getSuperclass()


function ConfigApp:init()
    local fontWindows = dxCreateFont("gfx/phone/windows.TTF",14,true)
    local fontTitle = dxCreateFont("gfx/phone/windows.TTF",12)
    local fontDesc = dxCreateFont( "gfx/phone/windows.TTF",10)
   
    super.init(self)
    self:setBounds(0,0,270,490)
    self:setBackground(tocolor(255,255,255))


    self.panel = Panel()
    self.panel:setBounds(0,25,self:getWidth(),self:getHeight())
    self.panel:setBackground(tocolor(unpack(Phone.getInstance().colorBackgroundApp)))
    self.panel:setVisible(true)
    self:add(self.panel)

    self.iconConfig = Image()
    self.iconConfig:setSource("gfx/phone/settings.png")
    self.iconConfig:setBounds(0,10,50,40)
    self.iconConfig.decorator = true
    self.panel:add(self.iconConfig)

    self.labelConfig = Label("Configurações")
    self.labelConfig:setFont(fontWindows)
    self.labelConfig:setForeground(tocolor(255,255,255))
    self.labelConfig:setBounds(self.iconConfig:getX()+self.iconConfig:getWidth(),15,self.panel:getWidth(),25)
    self.panel:add(self.labelConfig)

    self.panelRede = Panel()
    
    self.panelRede:addMouseListener({
        
        mouseEntered = function() 
            local phone = Phone.getInstance()    
            self.panelRede:setBackground(tocolor(unpack(phone.appColorOnEntered)))
        end,
        mouseExited = function()
            local phone = Phone.getInstance()
            self.panelRede:setBackground(tocolor(255,0,255,0))
        end
    })
    self.panelRede:setBackground(tocolor(255,0,255,0))
    self.panelRede:setBounds(0,self.iconConfig:getY()+self.iconConfig:getHeight()+10,self.panel:getWidth(),45)
    self.panel:add(self.panelRede)

    self.iconRede = Image()
    self.iconRede:setZOrder(-1)
    self.iconRede:setSource(ConfigApp.icons.sistema)
    self.iconRede:setBounds(15,2,30,40)
    self.iconRede.decorator = true
    self.panelRede:add(self.iconRede)

    self.labelRede = Label("Sistema")
    self.labelRede.decorator = true
    self.labelRede:setZOrder(-1)
    self.labelRede:setFont(fontTitle)
    self.labelRede:setForeground(tocolor(255,255,255))
    self.labelRede:setBounds(self.iconRede:getX()+self.iconRede:getWidth()+15,-3,self.labelRede:getTextWidth(),25)
    self.panelRede:add(self.labelRede)

    self.descRede = Label("Tela, notificações, gameplay")
    self.descRede.decorator =true
    self.descRede:setFont(fontDesc)
    self.descRede:setForeground(tocolor(150,150,150))
    self.descRede:setBounds(self.iconRede:getX()+self.iconRede:getWidth()+15,self.labelRede:getY()+20,self.panel:getWidth(),25)
    self.panelRede:add(self.descRede)

    self.panelConta = Panel()
    self.panelConta:addMouseListener({
        
        mouseEntered = function() 
            local phone = Phone.getInstance()    
            self.panelConta:setBackground(tocolor(unpack(phone.appColorOnEntered)))
        end,
        mouseExited = function()
            local phone = Phone.getInstance()
            self.panelConta:setBackground(tocolor(255,0,255,0))
        end
    })
    self.panelConta:setBackground(tocolor(255,0,255,0))
    self.panelConta:setBounds(0,self.panelRede:getY()+self.panelRede:getHeight()+15,self.panel:getWidth(),45)
    self.panel:add(self.panelConta)

    self.iconConta = Image()
    self.iconConta.decorator =true
    self.iconConta:setSource(ConfigApp.icons.conta)
    self.iconConta:setBounds(15,2,30,40)
    self.iconConta.decorator = true
    self.panelConta:add(self.iconConta)

    self.labelConta = Label("Conta")
    self.labelConta.decorator = true
    self.labelConta:setFont(fontTitle)
    self.labelConta:setForeground(tocolor(255,255,255))
    self.labelConta:setBounds(self.iconConta:getX()+self.iconConta:getWidth()+15,-3,self.labelConta:getTextWidth(),25)
    self.panelConta:add(self.labelConta)

    self.descRede = Label("Informações, VIP's, customização")
    self.descRede:setFont(fontDesc)
    self.descRede.decorator = true
    self.descRede:setForeground(tocolor(150,150,150))
    self.descRede:setBounds(self.iconConta:getX()+self.iconConta:getWidth()+15,self.labelRede:getY()+20,self.panel:getWidth(),25)
    self.panelConta:add(self.descRede)

    self.panelPersona = Panel()
    self.panelPersona:addMouseListener({
        
        mouseEntered = function() 
            local phone = Phone.getInstance()    
            self.panelPersona:setBackground(tocolor(unpack(phone.appColorOnEntered)))
        end,
        mouseExited = function()
            local phone = Phone.getInstance()
            self.panelPersona:setBackground(tocolor(255,0,255,0))
        end
    })
    self.panelPersona:setBackground(tocolor(255,0,255,0))
    self.panelPersona:setBounds(0,self.panelConta:getY()+self.panelConta:getHeight()+15,self.panel:getWidth(),45)
    self.panel:add(self.panelPersona)

    self.iconPersona = Image()
    self.iconPersona:setSource(ConfigApp.icons.personalizar)
    self.iconPersona:setBounds(15,2,30,40)
    self.iconPersona.decorator = true
    self.panelPersona:add(self.iconPersona)

    self.labelConta = Label("Personalização")
    self.labelConta.decorator = true
    self.labelConta:setFont(fontTitle)
    self.labelConta:setForeground(tocolor(255,255,255))
    self.labelConta:setBounds(self.iconPersona:getX()+self.iconPersona:getWidth()+15,-3,self.labelConta:getTextWidth(),25)
    self.panelPersona:add(self.labelConta)

    self.descConta = Label("Papel de parede, skins, texturas")
    self.descConta:setFont(fontDesc)
    self.descConta.decorator = true
    self.descConta:setForeground(tocolor(150,150,150))
    self.descConta:setBounds(self.iconPersona:getX()+self.iconPersona:getWidth()+15,self.labelConta:getY()+20,self.panel:getWidth(),25)
    self.panelPersona:add(self.descConta)

    self.panelVips = Panel()
     self.panelVips:addMouseListener({
        
        mouseEntered = function() 
            local phone = Phone.getInstance()    
            self.panelVips:setBackground(tocolor(unpack(phone.appColorOnEntered)))
        end,
        mouseExited = function()
            local phone = Phone.getInstance()
            self.panelVips:setBackground(tocolor(255,0,255,0))
        end
    })
    self.panelVips:setBackground(tocolor(255,0,255,0))
    self.panelVips:setBounds(0,self.panelPersona:getY()+self.panelPersona:getHeight()+15,self.panel:getWidth(),45)
    self.panel:add(self.panelVips)

    self.iconVips = Image()
    self.iconVips.decorator = true
    self.iconVips:setSource(ConfigApp.icons.vip)
    self.iconVips:setBounds(15,2,30,40)
    self.iconVips.decorator = true
    self.panelVips:add(self.iconVips)

    self.labelConta = Label("Painel VIP")
    self.labelConta:setFont(fontTitle)
    self.labelConta:setForeground(tocolor(255,255,255))
    self.labelConta:setBounds(self.iconVips:getX()+self.iconVips:getWidth()+15,-5,self.labelConta:getTextWidth(),25)
    self.panelVips:add(self.labelConta)

    self.descConta = Label("**Opções exclusivas**")
    self.descConta:setFont(fontDesc)
    self.descConta.decorator = true
    self.descConta:setForeground(tocolor(150,150,150))
    self.descConta:setBounds(self.iconVips:getX()+self.iconVips:getWidth()+15,self.labelConta:getY()+20,self.panel:getWidth(),25)
    self.panelVips:add(self.descConta)

    Phone.getInstance():setFunctionBack(function()
        ConfigApp.getInstance():unloadMe()
        Phone.getInstance():loadApp(HomeApp.getInstance())
    end)
    return self
end
