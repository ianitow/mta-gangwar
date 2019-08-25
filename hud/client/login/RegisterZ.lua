--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("Register", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
    
end).getSuperclass()

function Register:init()
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
    self:setBackground(tocolor(255,255,255,255))
self:setZOrder(999)
	self:setVisible(false)

	

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

	self.lblRegister = Label("Registre-se")
	self.lblRegister:setForeground(255,255,255)
	self.lblRegister:setLocation(60,25)
	self.lblRegister:setScale(2)
	self.lblRegister:setTextBorder(2)

	self.panelExtern:add(self.lblRegister)
	self.fieldRegister = TextField();
    self.fieldRegister:setPlaceholder("Digite o Login...")
	self.fieldRegister:setBounds(20,60,205,30)

    self.fieldRegister:setForeground(0,0,0)
    self.fieldRegister:setBackground(255,255,255,200)  
    self.fieldRegister:setZOrder(2)
	self.panelExtern:add(self.fieldRegister)

	self.fieldPassword = PasswordField()
	self.fieldPassword:setBounds(20,110,205,30)
	self.fieldPassword:setPlaceholder("Digite a senha...")
	self.fieldPassword:setForeground(0,0,0)
	self.fieldPassword:setBackground(255,255,255,200)
	self.panelExtern:add(self.fieldPassword)

	self.fieldRepeatPass = PasswordField()
	self.fieldRepeatPass:setBounds(20,160,205,30)
	self.fieldRepeatPass:setPlaceholder("Repita a senha...")
	self.fieldRepeatPass:setForeground(0,0,0)
	self.fieldRepeatPass:setBackground(255,255,255,200)
	self.panelExtern:add(self.fieldRepeatPass)
	
	

	self.buttonRegister = Button("Registrar-se")
	self.buttonRegister:setBounds(23,205,205,30)
	self.buttonRegister:addMouseListener(self)
	self.buttonRegister:setStyleClass("btnLogin")
	self.panelExtern:add(self.buttonRegister)

	self.buttonBack = Button("Voltar")
	self.buttonBack:setBounds(23,255,205,30)
	self.buttonBack:addMouseListener(self)
	self.buttonBack:setStyleClass("btnLogin")
	self.panelExtern:add(self.buttonBack)

	self.website = Label("www.maingames.com.br")
	self.website:setLocation(56,310)
	self.website:setForeground(255,255,255)
	self.website:setBackground(0,0,0)
	self.panelExtern:add(self.website)
	return self
end







function Register:mousePressed(e)
	if(e:getButton() == MouseEvent.BUTTON1) then
		if(e.source == self.buttonBack) then
			self:setVisible(false)
			Login.getInstance():setVisible(true)
		elseif(e.source == self.buttonRegister) then
			if(self.fieldPassword:getText() == self.fieldRepeatPass:getText()) then
				triggerServerEvent("onAccountTryRegister",localPlayer,self.fieldRegister:getText(),self.fieldPassword:getText())
			else
				outputChatBox(" #FF6600[SERVER]:#FFFFFF Senhas não se igualam.",255,255,255,true)
			end

		end
	end
end




function Register:paintComponent(g)
 
 g:drawSetColor(tocolor(0,0,0,150))
 g:drawFilledRect(0, 0, 275, self.screenY)
 g:drawSetColor(tocolor(0,0,0,255))
 g:drawSetLineWidth(2.0)
 g:drawLine(276,0,276,self.screenY)

 
 super.paintComponent(self, g)
end

addEventHandler("onClientResourceStart", resourceRoot, function()
			Toolkit.getInstance():add(Register.getInstance())

	end)