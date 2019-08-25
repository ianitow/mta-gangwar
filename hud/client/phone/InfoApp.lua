local super = Class("InfoApp", App, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
end
end).getSuperclass()

function InfoApp:init()
    super.init(self)
    local fontWindows = dxCreateFont("gfx/phone/windows.TTF",14,true)
    local fontTitle = dxCreateFont("gfx/phone/windows.TTF",12)
    local fontPlayer = dxCreateFont("gfx/phone/windows.TTF",11,true)
    
    local fontDesc = dxCreateFont( "gfx/phone/windows.TTF",10)
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


    self.labelConfig = Label("Informações do Player")
    self.labelConfig:setFont(fontWindows)
    self.labelConfig:setForeground(tocolor(255,255,255))
    self.labelConfig:setBounds(self.iconConfig:getX()+self.iconConfig:getWidth(),15,self.panel:getWidth(),25)
    self.panel:add(self.labelConfig)

    self.panelPlayerSearch = Panel()
    self.panelPlayerSearch:setBackground(tocolor(255,0,0,0))
    self.panelPlayerSearch:setBounds(0,self.iconConfig:getY()+self.iconConfig:getHeight()+5,self.panel:getWidth(),90)
    self.panel:add(self.panelPlayerSearch)

    self.lblPlayerSearch = Label("Informe a conta:")
    self.lblPlayerSearch.decorator = true
    self.lblPlayerSearch:setBounds(5,0,self.panelPlayerSearch:getWidth()-5,15)
    self.lblPlayerSearch:setForeground(255,255,255)
    self.lblPlayerSearch:setBackground(tocolor(0,0,0))
    self.lblPlayerSearch:setAlignment(Label.CENTER)
    self.panelPlayerSearch:add(self.lblPlayerSearch)


    self.fieldPlayer = TextField();
    self.fieldPlayer:setPlaceholder("Nome do jogador...")
	self.fieldPlayer:setBounds((self.panelPlayerSearch:getWidth()-205)/2,20,205,25)
    self.fieldPlayer:setForeground(0,0,0)
    self.fieldPlayer:setBackground(255,255,255,200)  
    self.panelPlayerSearch:add(self.fieldPlayer)


    self.buttonSearch = Panel()
    self.buttonSearch:setZOrder(10)
	self.buttonSearch:setBounds((self.panelPlayerSearch:getWidth()-100)/2,self.fieldPlayer:getY()+self.fieldPlayer:getHeight()+5,100,25)
    self.buttonSearch:addMouseListener(self)
    self.buttonSearch:setBorder(LineBorder(tocolor(10,10,10,200),1))
    self.buttonSearch:addMouseListener({
        mouseEntered = function() 
            local phone = Phone.getInstance()    
            self.buttonSearch:setBackground(tocolor(unpack(phone.appColorOnEntered)))
        end,
        mouseExited = function()
            local phone = Phone.getInstance()
            self.buttonSearch:setBackground(tocolor(unpack(phone.appColorOnExited)))
        end})
    self.panelPlayerSearch:add(self.buttonSearch)

    self.lblSearch = Label("Pesquisar")
    self.lblSearch.decorator = true
    self.lblSearch:setBounds(0,0,self.buttonSearch:getWidth(),self.buttonSearch:getHeight())
    self.lblSearch:setForeground(255,255,255)
    self.lblSearch:setBackground(tocolor(0,0,0))
    self.lblSearch:setAlignment(Label.CENTER)
    self.buttonSearch:add(self.lblSearch)

    self.lineDecorator = Panel()
    self.lineDecorator:setBounds(20,self.panelPlayerSearch:getHeight()-1,self.panel:getWidth()-40,1)
    self.lineDecorator:setBackground(tocolor(unpack(Phone.getInstance().appColorOnExited)))
    self.panelPlayerSearch:add(self.lineDecorator)

    self.panelFindedPlayer = Panel()
    self.panelFindedPlayer:setBounds(0,self.panelPlayerSearch:getY()+self.panelPlayerSearch:getHeight(),self.panel:getWidth(),(self.panel:getHeight() - (self.panelPlayerSearch:getHeight() + self.panelPlayerSearch:getY()) ))
    self.panelFindedPlayer:setBackground(tocolor(0,0,0,0))
    self.panel:add(self.panelFindedPlayer)

    self.panelAvatar = Panel()
    self.panelAvatar:setBorder(LineBorder(0,0,0),1)
    self.panelAvatar:setBounds(0,2,50,50)
    self.panelAvatar:setBackground(tocolor(0,0,0,0))
    self.panelAvatar:setLocation((self.panelFindedPlayer:getWidth()-self.panelAvatar:getWidth())/2,2)
    self.panelFindedPlayer:add(self.panelAvatar)

    self.imageAvatar = Image()
    self.imageAvatar:setBorder(LineBorder(tocolor(0,0,0),1))
	self.imageAvatar:setSource("gfx/phone/avatar/iNeewbie.png")
	self.imageAvatar:setLocation(0,0)
    self.imageAvatar:setSize(self.panelAvatar:getWidth(),self.panelAvatar:getHeight())
    self.panelAvatar:add(self.imageAvatar)


    self.lblPlayerName = Label("iNeewbie")
    self.lblPlayerName.decorator = true
    self.lblPlayerName:setFont(fontPlayer)
    self.lblPlayerName:setBounds(0,50,self.panelFindedPlayer:getWidth(),35)
    self.lblPlayerName:setForeground(255,255,255)
    self.lblPlayerName:setBackground(tocolor(0,0,0))
    self.lblPlayerName:setAlignment(Label.CENTER)
    self.panelFindedPlayer:add(self.lblPlayerName)

    self.lblPlayerDesc = Label("O cara malha pra pegar mulhéé")
    self.lblPlayerDesc.decorator = true
    self.lblPlayerDesc:setFont(fontDesc)
    self.lblPlayerDesc:setBounds(0,self.lblPlayerName:getY()+self.lblPlayerName:getHeight()-10,self.panelFindedPlayer:getWidth(),25)
    self.lblPlayerDesc:setForeground(220,220,220)
    self.lblPlayerDesc:setBackground(tocolor(0,0,0))
    self.lblPlayerDesc:setAlignment(Label.CENTER)
    self.panelFindedPlayer:add(self.lblPlayerDesc)

    self.lblKills = Label("Kills: 224")  
    self.lblKills.decorator = true
    self.lblKills:setBounds(10,100,self.panelFindedPlayer:getWidth(),25)
    self.lblKills:setForeground(255,255,255)
    self.lblKills:setBackground(tocolor(0,0,0))
    self.lblKills:setAlignment(Label.LEFT)
    self.panelFindedPlayer:add(self.lblKills)

    self.lblDeaths = Label("Deaths: 1324654")  
    self.lblDeaths.decorator = true
    self.lblDeaths:setBounds(self.lblKills:getX(),125,self.panelFindedPlayer:getWidth(),25)
    self.lblDeaths:setForeground(255,255,255)
    self.lblDeaths:setBackground(tocolor(0,0,0))
    self.lblDeaths:setAlignment(Label.LEFT)
    self.panelFindedPlayer:add(self.lblDeaths)

    self.lblTimeOnline = Label("Tempo Online: 2 dias 2 horas e 24 minutos.")  
    self.lblTimeOnline.decorator = true
    self.lblTimeOnline:setBounds(self.lblKills:getX(),175,self.panelFindedPlayer:getWidth(),25)
    self.lblTimeOnline:setForeground(255,255,255)
    self.lblTimeOnline:setBackground(tocolor(0,0,0))
    self.lblTimeOnline:setAlignment(Label.LEFT)
    self.panelFindedPlayer:add(self.lblTimeOnline)

    self.lblGroupFacebook = Label("Grupinho: FDB,PDU,KEK")  
    self.lblGroupFacebook.decorator = true
    self.lblGroupFacebook:setBounds(self.lblKills:getX(),150,self.panelFindedPlayer:getWidth(),25)
    self.lblGroupFacebook:setForeground(255,255,255)
    self.lblGroupFacebook:setBackground(tocolor(0,0,0))
    self.lblGroupFacebook:setAlignment(Label.LEFT)
    self.panelFindedPlayer:add(self.lblGroupFacebook)

    self.lblMoney = Label("Temers: #00FF00$15.000 + ($30.000 BANK)")  
    self.lblMoney.decorator = true
    self.lblMoney:setBounds(self.lblKills:getX(),200,self.panelFindedPlayer:getWidth(),25)
    self.lblMoney:setForeground(255,255,255)
    self.lblMoney:setBackground(tocolor(0,0,0))
    self.lblMoney:setAlignment(Label.LEFT)
    self.panelFindedPlayer:add(self.lblMoney)

    self.lblFacebook = Label("Facebook: fb.com/iNeewbie")  
    self.lblFacebook.decorator = true
    self.lblFacebook:setBounds(self.lblKills:getX(),225,self.panelFindedPlayer:getWidth(),25)
    self.lblFacebook:setForeground(255,255,255)
    self.lblFacebook:setBackground(tocolor(0,0,0))
    self.lblFacebook:setAlignment(Label.LEFT)
    self.panelFindedPlayer:add(self.lblFacebook)

    self.lblIsVip = Label("Gasta dinheiro com webjogos?: #FFFF00 SIM <3")  
    self.lblIsVip.decorator = true
    self.lblIsVip:setBounds(self.lblKills:getX(),250,self.panelFindedPlayer:getWidth(),25)
    self.lblIsVip:setForeground(255,255,255)
    self.lblIsVip:setBackground(tocolor(0,0,0))
    self.lblIsVip:setAlignment(Label.LEFT)
    self.panelFindedPlayer:add(self.lblIsVip)

    self.lblTags = Label("Tags:Magnata,Autista,Corno,Macacto")  
    self.lblTags.decorator = true
    self.lblTags:setBounds(self.lblKills:getX(),275,self.panelFindedPlayer:getWidth(),25)
    self.lblTags:setForeground(255,255,255)
    self.lblTags:setBackground(tocolor(0,0,0))
    self.lblTags:setAlignment(Label.LEFT)
    self.panelFindedPlayer:add(self.lblTags)

    


    Phone.getInstance():setFunctionBack(function()
        InfoApp.getInstance():unloadMe()
        Phone.getInstance():loadApp(HomeApp.getInstance())
    end)
    return self
end

function InfoApp:loadPlayerInfo(player)

end


