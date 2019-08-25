--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("Login", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
    
end).getSuperclass()

function Login:init()
	super.init(self)
	self:css([[
button {
	color: #FFFFFF;
	background-color: #990000;
	cursor: pointer;
}
button:hover {
	color: #FFFFFF;
	background-color: #770000;
	cursor: pointer;
}
button:active{
	color: #FFFFFF;
	background-color: #AA0000;
	cursor: pointer;
}    

  
]])
	self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    self:setBounds(0,0,self.screenX,self.screenY)
    self:setBackground(tocolor(0,0,0,255))
	self:setVisible(true)
	self:setZOrder(999)
	

	self.lblImage = Image()
	self.lblImage:setSource("gfx/login/logo.png")
	self.lblImage:setLocation(15,self.screenY/9)
	self.lblImage:setSize(self.lblImage:getImageWidth(),self.lblImage:getImageHeight())

	self:add(self.lblImage)


--	self.panelExtern:setBounds(15,225,250,335)
--1280/720
	self.panelExtern = Panel()
	self.panelExtern:setBounds(15,self.screenY/3.2,250,335)
	self.panelExtern:setBackground(0,0,0,150)
	self.panelExtern:setBorder(LineBorder(tocolor(0,0,0),1))
	self.panelExtern.decorator = true
	self:add(self.panelExtern)

	self.lblLogin = Label("Login")
	self.lblLogin:setForeground(255,255,255)
	self.lblLogin:setLocation(90,25)
	self.lblLogin:setScale(2)
	self.lblLogin:setTextBorder(2)

	self.panelExtern:add(self.lblLogin)

	self.fieldLogin = TextField();
    self.fieldLogin:setPlaceholder("Digite o Login...")
	self.fieldLogin:setBounds(20,60,205,30)
    self.fieldLogin:setForeground(0,0,0)
    self.fieldLogin:setBackground(255,255,255,200)  
    self.fieldLogin:setZOrder(20)
	self.panelExtern:add(self.fieldLogin)

	self.fieldPassword = PasswordField()
	self.fieldPassword:setBounds(20,120,205,30)
	self.fieldPassword:setPlaceholder("Digite a senha...")
	self.fieldPassword:setForeground(0,0,0)
	self.fieldPassword:setBackground(255,255,255,200)
	self.panelExtern:add(self.fieldPassword)
	
	self.chkRemember = Checkbox("Lembrar-me ?",false,nil)
	self.chkRemember:setBounds(155,160,10,10)
	self.chkRemember:setBackground(0,0,0)
	self.chkRemember:setForeground(tocolor(255,255,255,255))
	self.chkRemember:setLabelColor(tocolor(255,255,255))
	self.chkRemember:getLabel()
	self.panelExtern:add(self.chkRemember)
	

	self.buttonLogin = Button("Logar")
	self.buttonLogin:setBounds(23,190,205,30)
	self.buttonLogin:addMouseListener(self)
	self.buttonLogin:setStyleClass("btnLogin")
	self.panelExtern:add(self.buttonLogin)

	self.buttonRegister = Button("Registrar-se")
	self.buttonRegister:setBounds(23,245,205,30)
	self.buttonRegister:addMouseListener(self)
	self.buttonRegister:setStyleClass("btnLogin")
	self.panelExtern:add(self.buttonRegister)

	self.website = Label("www.maingames.com.br")
	self.website:setLocation(56,310)
	self.website:setForeground(255,255,255)
	self.website:setBackground(0,0,0)
	self.panelExtern:add(self.website)
	self:loadPrefs()

	self.functionBlur = function ()
		Blur.render(255,0.215)
	end
	return self
end

function Login:mousePressed(e)
	if(e:getButton() == MouseEvent.BUTTON1) then
		if(e.source == self.buttonRegister) then
			self:setVisible(false)
			Register.getInstance():setVisible(true)
		elseif(e.source == self.buttonLogin) then
			if(self.fieldLogin:getText() and self.fieldPassword:getText()) then
				triggerServerEvent("onAccountTryLogin",localPlayer,self.fieldLogin:getText(),self.fieldPassword:getText())
			end
		end
	end
end


function Login:paintComponent(g)
 	 g:drawSetColor(tocolor(0,0,0,150))
	 g:drawFilledRect(0, 0, 275, self.screenY)
	 g:drawSetColor(tocolor(0,0,0,255))
	 g:drawSetLineWidth(2.0)
	 g:drawLine(276,0,276,self.screenY)
	 super.paintComponent(self, g)
end


function Login:loadPrefs()
	showCursor( true)
	showPlayerHudComponent("radar", false)
	
	localPlayer:setInterior(0)
	Camera.setMatrix( 2077.12500, 1489.07703, 36.67678, -1000, 5500, -1900)
	Camera.fade(true)
end

function Login:stopEffectsPreLogin()
	removeCamHandler()
	removeEventHandler("onClientRender",root,self.functionBlur)
	return true
end


addEventHandler("onClientResourceStart", resourceRoot, function()
	showCursor( true)
	smoothMoveCamera(2068.15454, 786.03772, 31.97630,2000,2000,-200,2135.79858, 2283.18579, 55.38252,2000,2000,0,20000)	
	if(Blur.createShader()) then
		addEventHandler("onClientRender",root,Login.getInstance().functionBlur)
		addEventHandler("onClientPreRender",root,camRender)
	end
	showPlayerHudComponent("radar", false)
	Camera.fade(true)
	Toolkit.getInstance():add(Login.getInstance())
end)
