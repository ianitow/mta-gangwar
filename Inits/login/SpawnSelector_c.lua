local showAgain = false
local colorInfo = "#0000FF[SERVER] #FFFFFF"
local colorWarning = "#FFFF44[SERVER] #FFFFFF"
local colorDefault = "#FF0000[SERVER] #FFFFFF"

bindKey("F4","down",function()
    outputChatBox(colorInfo.."Quando você morrer, irá novamente para tela de skin.",255,255,255,true)
    if not (showAgain) then
        showAgain = true;
    end
end)

addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), function()

    if(showAgain) then
        exports.hud:callHud([[
            Login.getInstance():setVisible(false)
            Login.getInstance():stopEffectsPreLogin()
            Register.getInstance():setVisible(false)
            SpawnSelector.getInstance():setVisible(true)
            SpawnSelector.getInstance():protectPlayer()	
            showCursor(true)	
    ]])
    showAgain = false
    end
end ) --add an event for the local player only