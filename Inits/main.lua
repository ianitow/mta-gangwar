function startGameMode ()
    outputDebugString("GAMEMODE STARTED = GANG WAR")
    setGlitchEnabled("fastsprint", true)
    setGameType("GangWar")
    setFPSLimit(60)
    dxScoreLevel = exports [ "scoreboard" ]:addScoreboardColumn ( "kills", 4 )
	 dxScoreLevel = exports [ "scoreboard" ]:addScoreboardColumn ( "deaths", 5 )
     dxScoreLevel = exports [ "scoreboard" ]:addScoreboardColumn ( "ratio", 6 )
      dxScoreLevel = exports [ "scoreboard" ]:addScoreboardColumn ( "money", 3 )
      updateAllMoney()
end
addEventHandler("onResourceStart", getResourceRootElement(),startGameMode)

function stopGameMode ()
	print("stop")
end
addEventHandler("onResourceStop", getResourceRootElement(), stopGameMode)

function updateAllMoney()
    setTimer(function()
       for i,k in pairs (getElementsByType( "player")) do 
       k:setData("money",k:getMoney())
    end
    end,1000,0)
end

function nickChangeHandler(oldNick, newNick)
    cancelEvent()
end
-- add an event handler
addEventHandler("onPlayerChangeNick", getRootElement(), nickChangeHandler)