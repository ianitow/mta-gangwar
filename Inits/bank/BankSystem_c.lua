addEvent("updatePlayerInfoBank",true)
addEventHandler("updatePlayerInfoBank",localPlayer,function()
	exports.hud:callHud([[
		BankSystem.getInstance():updateInfos()
	]])
end)
addEvent("onPlayerBankHit",true)
addEventHandler("onPlayerBankHit",localPlayer,function()
	exports.hud:callHud([[
        BankSystem.getInstance():updateInfos()
        BankSystem.getInstance():setVisible(true)
        showCursor(true)
	]])
end)

addEvent("onPlayerBankLeave",true)
addEventHandler("onPlayerBankLeave",localPlayer,function()
	exports.hud:callHud([[
        BankSystem.getInstance():updateInfos()
        BankSystem.getInstance():setVisible(false)
        showCursor(false)
	]])
end)




