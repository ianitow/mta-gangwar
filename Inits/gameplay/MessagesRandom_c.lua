local colorInfo = "#0000FF[SERVER] #FFFFFF"
local colorWarning = "#FFFF44[SERVER] #FFFFFF"
local colorDefault = "#FF0000[SERVER] #FFFFFF"

function playerCount()
   outputChatBox(colorDefault.."Atualmente existem #FF0000" ..#getElementsByType("player").." players" .."#FFFFFF no servidor.",255,255,255,true)
end
setTimer(playerCount,360000,0)