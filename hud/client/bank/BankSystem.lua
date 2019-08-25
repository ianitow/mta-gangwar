--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("BankSystem", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end

end).getSuperclass()
function BankSystem:init()
	super.init(self)
	self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    self:setBounds(0,0,self.screenX,self.screenY)
    self:setBackground(tocolor(0,0,0,255))
    self:setZOrder(200)
	self:setVisible(false)
 	self:css([[
button {
	color: #FFFFFF;
	background-color: #000388;
    cursor: pointer;
}
button:hover {
	color: #FFFFFF;
	background-color: #0004a6;
	cursor: pointer;
}
button:active{
	color: #FFFFFF;
	background-color: #0005c3;
	cursor: pointer;
}    

  
]])


	self.panelExtern = Panel()
    self.panelExtern:setBounds(Graphics.getInsets(0,0,self.screenX/6.5,0))
    self.panelExtern:setSize(self.panelExtern:getWidth(),320)
    self.panelExtern:setLocation(50,self.screenY/3.2)
 
    self.panelExtern:setBackground(12,26,48,150)
	self.panelExtern:setBorder(LineBorder(tocolor(0,0,0),1))
    self.panelExtern.decorator = true
	self:add(self.panelExtern)

    self.panelTitle = Panel()
    self.panelTitle:setBounds(0,0,self.panelExtern:getWidth(),25)
    self.panelTitle:setBackground(0,17,43,255)
    self.panelExtern:add(self.panelTitle)
    
	self.lblImage = Image()
	self.lblImage:setSource("gfx/bank/header.png")
	self.lblImage:setLocation(0,0)
    self.lblImage:setSize(self.panelTitle:getWidth(),self.panelTitle:getHeight())
    self.panelTitle:add(self.lblImage)

    
    self.panelTitleDecorator = Panel()
    self.panelTitleDecorator:setBounds(0,self.panelTitle:getHeight(),self.panelExtern:getWidth(),5)
    self.panelTitleDecorator:setBackground(tocolor(0,20,90))
    self.panelExtern:add(self.panelTitleDecorator)

    self.panelInternInfo = Panel()
    self.panelInternInfo:setBounds(0,self.panelTitleDecorator:getHeight()+self.panelTitleDecorator:getY(),self.panelExtern:getWidth(),90)
    self.panelInternInfo:setBackground(tocolor(0,17,43,50))
    self.panelExtern:add(self.panelInternInfo)

    self.labelInfo = Label("Informações:")
    self.labelInfo:setBounds(0,0,self.panelInternInfo:getWidth(),25)
    self.labelInfo:setForeground(255,255,255)
    self.labelInfo:setAlignment(Label.CENTER)
    self.panelInternInfo:add(self.labelInfo)

    self.labelInfoNome = Label("Nome: #0000FF"..localPlayer:getName())
    self.labelInfoNome:setBounds(5,20,self.panelInternInfo:getWidth()-5,25)
    self.labelInfoNome:setForeground(255,255,255)
     self.labelInfoNome:setAlignment(Label.LEFT)
    self.panelInternInfo:add(self.labelInfoNome)
    
    self.labelInfoSaldo = Label("Saldo: #00FF00$"..(localPlayer:getData("bank_balance") and localPlayer:getData("bank_balance") or "0"))
    self.labelInfoSaldo:setBounds(5,40,self.panelInternInfo:getWidth()-5,25)
    self.labelInfoSaldo:setForeground(255,255,255)
    self.labelInfoSaldo:setAlignment(Label.LEFT)
    self.panelInternInfo:add(self.labelInfoSaldo)
    

    self.labelInfoVip = Label("Cliente VIP: #0000FF"..(localPlayer:getData("vip") and "Sim" or "Não"))
    self.labelInfoVip:setBounds(5,60,self.panelInternInfo:getWidth()-5,25)
    self.labelInfoVip:setForeground(255,255,255)
    self.labelInfoVip:setAlignment(Label.LEFT)
    self.panelInternInfo:add(self.labelInfoVip)
    
    self.panelButtons = Container()
    self.panelButtons:setBounds(0,self.panelInternInfo:getY()+self.panelInternInfo:getHeight()+5,self.panelExtern:getWidth(),150)
    self.panelButtons:setBackground(tocolor(0,0,0,255))
    self.panelButtons:setVisible(true)
    self.panelExtern:add(self.panelButtons)

    self.buttonDeposito = Button("Depositar")
    self.buttonDeposito:setScale(1.2)
	self.buttonDeposito:setBounds((self.panelExtern:getWidth()-self.panelButtons:getWidth())/2,0,self.panelButtons:getWidth(),35)
	self.buttonDeposito:addMouseListener(self)
    self.panelButtons:add(self.buttonDeposito)

    self.buttonSaque = Button("Sacar")
    self.buttonSaque:setScale(1.2)
	self.buttonSaque:setBounds((self.panelExtern:getWidth()-self.panelButtons:getWidth())/2,50,self.panelButtons:getWidth(),35)
	self.buttonSaque:addMouseListener(self)
    self.panelButtons:add(self.buttonSaque)

    self.buttonTrans = Button("Transferencia")
    self.buttonTrans:setScale(1.2)
	self.buttonTrans:setBounds((self.panelExtern:getWidth()-self.panelButtons:getWidth())/2,100,self.panelButtons:getWidth(),35)
	self.buttonTrans:addMouseListener(self)
    self.panelButtons:add(self.buttonTrans)
    

    self.buttonSair = Button("Sair do banco")
    self.buttonSair:setScale(1.2)
	self.buttonSair:setBounds((self.panelExtern:getWidth()-self.panelButtons:getWidth())/2,280,self.panelButtons:getWidth(),35)
	self.buttonSair:addMouseListener(self)
    self.panelExtern:add(self.buttonSair)

    self.panelDeposito = Panel()
    self.panelDeposito:setBounds(0,self.panelInternInfo:getY()+self.panelInternInfo:getHeight()+5,self.panelExtern:getWidth(),150)
    self.panelDeposito:setBackground(tocolor(0,0,0,120))
    self.panelExtern:add(self.panelDeposito)
    self.panelDeposito:setVisible(false)


    
    
    self.labelQuantidadeDepositoIntern = Label("Informe a quantidade:")
    self.labelQuantidadeDepositoIntern:setBounds(5,20,self.panelDeposito:getWidth(),15)
    self.labelQuantidadeDepositoIntern:setForeground(255,255,255)
    self.labelQuantidadeDepositoIntern:setAlignment(Label.CENTER)
    self.panelDeposito:add(self.labelQuantidadeDepositoIntern)

    self.fieldQuantityDepositoIntern = TextField();
    self.fieldQuantityDepositoIntern:setPlaceholder("Informe o dinheiro a ser depositado...")
	self.fieldQuantityDepositoIntern:setBounds((self.panelDeposito:getWidth()-self.panelDeposito:getWidth())/2,60,self.panelDeposito:getWidth(),25)
    self.fieldQuantityDepositoIntern:setForeground(0,0,0)
    self.fieldQuantityDepositoIntern:setBackground(255,255,255,200)  
    self.fieldQuantityDepositoIntern:setZOrder(20)
    self.panelDeposito:add(self.fieldQuantityDepositoIntern)

    self.buttonBackDeposito = Button("Voltar")
    self.buttonBackDeposito:setBounds((self.panelDeposito:getWidth()-260)/2,100,80,35)
    self.buttonBackDeposito:addMouseListener(self)
    self.panelDeposito:add(self.buttonBackDeposito)
    
    self.buttonDepositoIntern = Button("Depositar")
	self.buttonDepositoIntern:setBounds(self.buttonBackDeposito:getX()+self.buttonBackDeposito:getWidth()+20,100,120,35)
	self.buttonDepositoIntern:addMouseListener(self)
    self.panelDeposito:add(self.buttonDepositoIntern)
    
    self.panelSaque = Panel()
    self.panelSaque:setBounds(0,self.panelInternInfo:getY()+self.panelInternInfo:getHeight()+5,self.panelExtern:getWidth(),150)
    self.panelSaque:setBackground(tocolor(0,0,0,120))
    self.panelExtern:add(self.panelSaque)
    self.panelSaque:setVisible(false)

    self.labelQuantitySaqueIntern = Label("Informe a quantidade:")
    self.labelQuantitySaqueIntern:setBounds(5,20,self.panelDeposito:getWidth(),15)
    self.labelQuantitySaqueIntern:setForeground(255,255,255)
    self.labelQuantitySaqueIntern:setAlignment(Label.CENTER)
    self.panelSaque:add(self.labelQuantitySaqueIntern)

    self.fieldQuantitySaqueIntern = TextField();
    self.fieldQuantitySaqueIntern:setPlaceholder("Informe a quantidade a ser sacada...")
	self.fieldQuantitySaqueIntern:setBounds((self.panelDeposito:getWidth()-205)/2,60,205,25)
    self.fieldQuantitySaqueIntern:setForeground(0,0,0)
    self.fieldQuantitySaqueIntern:setBackground(255,255,255,200)  
    self.fieldQuantitySaqueIntern:setZOrder(20)
    self.panelSaque:add(self.fieldQuantitySaqueIntern)

    self.buttonBackSaque = Button("Voltar")
    self.buttonBackSaque:setBounds((self.panelDeposito:getWidth()-260)/2,100,120,35)
    self.buttonBackSaque:addMouseListener(self)
    self.panelSaque:add(self.buttonBackSaque)

    self.buttonSacarIntern = Button("Sacar")
	self.buttonSacarIntern:setBounds(self.buttonBackSaque:getX()+self.buttonBackSaque:getWidth()+20,100,120,35)
	self.buttonSacarIntern:addMouseListener(self)
    self.panelSaque:add(self.buttonSacarIntern)


    self.panelTransfer = Panel()
    self.panelTransfer:setBounds(0,self.panelInternInfo:getY()+self.panelInternInfo:getHeight()+5,self.panelExtern:getWidth(),150)
    self.panelTransfer:setBackground(tocolor(0,0,0,120))
    self.panelExtern:add(self.panelTransfer)
    self.panelTransfer:setVisible(false)

    self.labelReceptorTransferIntern = Label("Informe a conta:")
    self.labelReceptorTransferIntern:setBounds(5,5,self.panelTransfer:getWidth(),15)
    self.labelReceptorTransferIntern:setForeground(255,255,255)
    self.labelReceptorTransferIntern:setBackground(tocolor(0,0,0))
    self.labelReceptorTransferIntern:setAlignment(Label.CENTER)
    self.panelTransfer:add(self.labelReceptorTransferIntern)
    
    self.fieldReceptorTransferIntern = TextField();
    self.fieldReceptorTransferIntern:setPlaceholder("Informe a conta a ser depositada...")
	self.fieldReceptorTransferIntern:setBounds((self.panelTransfer:getWidth()-205)/2,25,205,25)
    self.fieldReceptorTransferIntern:setForeground(0,0,0)
    self.fieldReceptorTransferIntern:setBackground(255,255,255,200)  
    self.panelTransfer:add(self.fieldReceptorTransferIntern)

    self.labelQuantityTransferIntern = Label("Informe a quantidade:")
    self.labelQuantityTransferIntern:setBounds(5,55,self.panelTransfer:getWidth(),15)
    self.labelQuantityTransferIntern:setForeground(255,255,255)
    self.labelQuantityTransferIntern:setBackground(tocolor(0,0,0))
    self.labelQuantityTransferIntern:setAlignment(Label.CENTER)
    self.panelTransfer:add(self.labelQuantityTransferIntern)

    self.fieldQuantityTransferIntern = TextField();
    self.fieldQuantityTransferIntern:setPlaceholder("Informe a quantidade para transferir.")
	self.fieldQuantityTransferIntern:setBounds((self.panelTransfer:getWidth()-205)/2,75,205,25)
    self.fieldQuantityTransferIntern:setForeground(0,0,0)
    self.fieldQuantityTransferIntern:setBackground(255,255,255,200)  
    self.panelTransfer:add(self.fieldQuantityTransferIntern)

    self.buttonBackTransfer = Button("Voltar")
    self.buttonBackTransfer:setBounds((self.panelTransfer:getWidth()-260)/2,110,120,35)
    self.buttonBackTransfer:addMouseListener(self)
    self.panelTransfer:add(self.buttonBackTransfer)


    self.buttonTransferIntern = Button("Transferir")
	self.buttonTransferIntern:setBounds(self.buttonBackTransfer:getX()+self.buttonBackTransfer:getWidth()+20,110,120,35)
	self.buttonTransferIntern:addMouseListener(self)
    self.panelTransfer:add(self.buttonTransferIntern)

    

    return self
end
function BankSystem:mouseEntered(e)
	if (e.source) then
		playSoundFrontEnd(3)
	end
end
function BankSystem:mousePressed(e)
    if(e:getButton() == MouseEvent.BUTTON1) then
       if(e.source == self.buttonSair) then
            self:setVisible(false)
            showCursor( false)
       elseif(e.source == self.buttonDeposito) then
            self.panelButtons:setVisible(false)
            self.panelDeposito:setVisible(true)
       elseif(e.source == self.buttonTrans) then
            self.panelButtons:setVisible(false)
            self.panelTransfer:setVisible(true)
       elseif(e.source == self.buttonSaque) then
            self.panelButtons:setVisible(false)
            self.panelSaque:setVisible(true)
       elseif(e.source == self.buttonBackDeposito or e.source == self.buttonBackSaque or e.source== self.buttonBackTransfer) then
            self.panelSaque:setVisible(false)
            self.panelTransfer:setVisible(false)
            self.panelDeposito:setVisible(false) 
            self.panelButtons:setVisible(true)
        end
        if(e.source == self.buttonSacarIntern) then
            triggerServerEvent("onPlayerWithdraw",localPlayer,self.fieldQuantitySaqueIntern:getText())
        elseif(e.source == self.buttonDepositoIntern) then
            triggerServerEvent("onPlayerDeposit",localPlayer,self.fieldQuantityDepositoIntern:getText())
        elseif(e.source == self.buttonTransferIntern) then
             triggerServerEvent("onPlayerTransfer",localPlayer,self.fieldReceptorTransferIntern:getText(),self.fieldQuantityTransferIntern:getText())
        end
    end
end

function BankSystem:updateInfos()
    self.labelInfoNome:setText("Nome: #0000FF"..localPlayer:getName())
    self.labelInfoSaldo:setText("Saldo: #00FF00$"..(localPlayer:getData("bank_balance") and localPlayer:getData("bank_balance") or "0"))
    self.labelInfoVip:setText("Cliente VIP: #0000FF"..(localPlayer:getData("vip") and "Sim" or "Não"))
    return true
end




addEventHandler("onClientResourceStart", resourceRoot, function()
    Toolkit.getInstance():add(BankSystem.getInstance())
end)


