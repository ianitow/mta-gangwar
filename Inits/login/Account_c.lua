addEvent("onAccountLogged",true)
addEventHandler("onAccountLogged",localPlayer,function()
	exports.hud:callHud([[
		Login.getInstance():setVisible(false)
		Login.getInstance():stopEffectsPreLogin()
		Register.getInstance():setVisible(false)
		SpawnSelector.getInstance():setVisible(true)
		SpawnSelector.getInstance():protectPlayer()
		
		outputChatBox( "#FF6600[SERVER]:#FFFFFFSeja bem vindo ao servidor "..localPlayer:getName(),255,255,255,true)
	]])
end)
addEvent("onAccountRegister",true)
addEventHandler("onAccountRegister",localPlayer,function()
	exports.hud:callHud([[
		Login.getInstance():setVisible(true)
		Register.getInstance():setVisible(false)
		outputChatBox( "#FF6600[SERVER]:#FFFFFF Conta criada com sucesso, por favor, logue-se",255,255,255,true)
	]])
end)

