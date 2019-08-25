idTable = {}
 
function thisResourceStart()
	exports.scoreboard:addScoreboardColumn("ID", getRootElement(), 1, 0.05)
    local players = getElementsByType("player")
    for i,player in ipairs (players) do
        assignID(player)
    end
end
 
function thisResourceStop()
	exports.scoreboard:removeScoreboardColumn("ID")
    idTable = {}
    local players = getElementsByType("player")
    for i,player in ipairs (players) do
        removeElementData(player ,"ID")
    end
end
 
function playerJoin()
    assignID(source)
end
 
function playerLeave()
    idTable[source] = nil
end
 
function assignID(player)
    for i=1,128 do
        if not table.find(idTable,i) then
            idTable[player] = i
            setElementData(player, "ID", i)
            return true
        end
    end
end
 
function table.find(tableToSearch, value)
    for k,v in pairs (tableToSearch) do
        if v == value then
            return k
        end
    end
    return false
end
 
function getIDFromName(playersName)
    local playerFound = getPlayerFromName(playersName)
    for k,v in pairs (idTable) do
        if k == playerFound then
            return v
        end
    end
end
 
function getPlayerFromID(ID)
    for k,v in pairs ( idTable ) do
        if v == ID then
            return k
        end
    end
end
 
addEventHandler("onPlayerQuit", getRootElement(), playerLeave)
addEventHandler("onPlayerJoin", getRootElement(), playerJoin)
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), thisResourceStart)
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), thisResourceStop)