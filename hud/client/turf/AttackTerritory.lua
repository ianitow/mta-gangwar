--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("AttackTerritory", Panel, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
    
end).getSuperclass()

function AttackTerritory:init()
	super.init(self)

	self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    self:setBounds(10,self.screenY/4,260,270)
    self:setBackground(tocolor(0,0,0,120))
    self:setBorder(LineBorder(tocolor(0,255,0),1))
    self:setBorder(LineBorder(tocolor(0,0,0),1.2))
    self:setVisible(true)
    self:setZOrder(-2)
    
    self.panelHeader = Panel()
    self.panelHeader:setBounds(0,0,self:getWidth(),25)
    self.panelHeader:setBackground(tocolor(10, 189, 227))
    self.panelHeader:setVisible(true)
    self:add(self.panelHeader)
    
    
    self.textDomination = Label("Dominação")
    self.textDomination:setBounds(0,0,self.panelHeader:getWidth(),self.panelHeader:getHeight())
    self.textDomination:setForeground(tocolor(255,255,255))
    self.textDomination:setBackground(tocolor(0,0,0))
    self.textDomination:setScale(1.3)
    self.textDomination:setAlignment(Label.CENTER)
    self.panelHeader:add(self.textDomination)
    
    self.panelHeaderDecorator = Panel()
    self.panelHeaderDecorator.decorator = true
    self.panelHeaderDecorator:setBounds(0,self.panelHeader:getHeight(),self:getWidth(),5)
    self.panelHeaderDecorator:setBackground(tocolor(84, 160, 255))
    self.panelHeader:add(self.panelHeaderDecorator)

    local fontZone = dxCreateFont("/gfx/turf/COOPBL.TTF",15,false,"draft")
    self.textNameZone = Label("Come a Lot - Castelo")
    self.textNameZone:setFont(fontZone)
    self.textNameZone:setBounds(0,self.panelHeaderDecorator:getY(),self:getWidth(),40)
    self.textNameZone:setForeground(tocolor(255,255,255))
    self.textNameZone:setScale(1)
    self.textNameZone:setBackground(tocolor(0,0,0))
    self.textNameZone:setAlignment(Label.CENTER)
    self:add(self.textNameZone)

    self.gangFirstName = Label("*GrooveStreet*")
    self.gangFirstName:setBounds(0,55,self:getWidth(),40)
    self.gangFirstName:setForeground(tocolor(0,0,255))
    self.gangFirstName:setScale(1.4)
    self.gangFirstName:setBackground(tocolor(0,0,0))
    self.gangFirstName:setAlignment(Label.CENTER)
    self:add(self.gangFirstName)

    self.gangFirstPoints = Label("Pontos: 1564")
    self.gangFirstPoints:setBounds(0,75,self:getWidth(),40)
    self.gangFirstPoints:setForeground(tocolor(255,255,255))
    self.gangFirstPoints:setScale(1)
    self.gangFirstPoints:setBackground(tocolor(0,0,0))
    self.gangFirstPoints:setAlignment(Label.CENTER)
    self:add(self.gangFirstPoints)

    self.gangFirstDeaths = Label("Mortes: 3")
    self.gangFirstDeaths:setBounds(0,95,self:getWidth(),40)
    self.gangFirstDeaths:setForeground(tocolor(255,255,255))
    self.gangFirstDeaths:setScale(1)
    self.gangFirstDeaths:setBackground(tocolor(0,0,0))
    self.gangFirstDeaths:setAlignment(Label.CENTER)
    self:add(self.gangFirstDeaths)

    self.gangFirstInArea = Label("Players na área: 0")
    self.gangFirstInArea:setBounds(0,115,self:getWidth(),40)
    self.gangFirstInArea:setForeground(tocolor(255,255,255))
    self.gangFirstInArea:setScale(1)
    self.gangFirstInArea:setBackground(tocolor(0,0,0))
    self.gangFirstInArea:setAlignment(Label.CENTER)
    self:add(self.gangFirstInArea)

    self.gangSecondName = Label("*Wanteds*")
    self.gangSecondName:setBounds(0,145,self:getWidth(),40)
    self.gangSecondName:setForeground(tocolor(255,120,255))
    self.gangSecondName:setScale(1.4)
    self.gangSecondName:setBackground(tocolor(0,0,0))
    self.gangSecondName:setAlignment(Label.CENTER)
    self:add(self.gangSecondName)

    self.gangSecondPoints = Label("Pontos: 2558")
    self.gangSecondPoints:setBounds(0,165,self:getWidth(),40)
    self.gangSecondPoints:setForeground(tocolor(255,255,255))
    self.gangSecondPoints:setScale(1)
    self.gangSecondPoints:setBackground(tocolor(0,0,0))
    self.gangSecondPoints:setAlignment(Label.CENTER)
    self:add(self.gangSecondPoints)
    
    
    self.gangSecondDeaths = Label("Mortes: 3")
    self.gangSecondDeaths:setBounds(0,185,self:getWidth(),40)
    self.gangSecondDeaths:setForeground(tocolor(255,255,255))
    self.gangSecondDeaths:setScale(1)
    self.gangSecondDeaths:setBackground(tocolor(0,0,0))
    self.gangSecondDeaths:setAlignment(Label.CENTER)
    self:add(self.gangSecondDeaths)

    self.gangSecondInArea = Label("Players na área: 0")
    self.gangSecondInArea:setBounds(0,205,self:getWidth(),40)
    self.gangSecondInArea:setForeground(tocolor(255,255,255))
    self.gangSecondInArea:setScale(1)
    self.gangSecondInArea:setBackground(tocolor(0,0,0))
    self.gangSecondInArea:setAlignment(Label.CENTER)
    self:add(self.gangSecondInArea)

    
    self.timeLeft = Label("Tempo restante: 2 minutos e 30 segundos")
    self.timeLeft:setBounds(0,235,self:getWidth(),40)
    self.timeLeft:setForeground(tocolor(255,255,255))
    self.timeLeft:setScale(1)
    self.timeLeft:setBackground(tocolor(0,0,0))
    self.timeLeft:setAlignment(Label.CENTER)
    self:add(self.timeLeft)
   
    self:setVisible(false)
    return self
end

function AttackTerritory:setTeams(team, teamEnemy,r2,g2,b2)
	self.gangFirstName:setText(team)
	self.gangSecondName:setText(teamEnemy)
    self.gangFirstName:setForeground(tocolor(getTeamFromName(team):getColor()))
    self.gangSecondName:setForeground(tocolor(r2, g2, b2))
end



function AttackTerritory:setPoints(points, pointsEnemy)
	if (points and pointsEnemy) then
		self.gangFirstPoints:setText("Pontos: ".. tostring(points))
		self.gangSecondPoints:setText("Pontos: "..tostring(pointsEnemy))
	else
		self.gangFirstPoints:setText("")
		self.gangSecondPoints:setText("")
	end
end

function AttackTerritory:setDeaths(deaths, deathsEnemy)
	if (deaths and deathsEnemy) then
		self.gangFirstDeaths:setText("Mortes: "..tostring(deaths))
		self.gangSecondDeaths:setText("Mortes: "..tostring(deathsEnemy))
	else
		self.gangFirstDeaths:setText("")
		self.gangSecondDeaths:setText("")
	end
end

function AttackTerritory:setPlayersInArea(attackerPlayers,defensePlayers)
    attackerPlayers = attackerPlayers or 0
    defensePlayers = defensePlayers or 0
    self.gangFirstInArea:setText("Players na área: "..attackerPlayers)
    self.gangSecondInArea:setText("Players na área: "..defensePlayers)
end

addEvent("onTeamFinishAttack",true)
addEventHandler("onTeamFinishAttack",root,function(radarArea,winTeam,loseTeam,defended)
	local isType = source:getData("type")
	if (isType == "territorio") then
		turfInfo = "o territorio "
		turfType = "TERRITORIO"
	elseif (isType  == "gangzona") then
		turfInfo =  "a gang zona "
		turfType =  "GANGZONE"
	elseif (isType  == "villa") then
		turfInfo = "a villa "
		turfType = "VILLE"
	end
	
	if not (loseTeam) then
		outputChatBox("#FF6464["..turfType.."]#00FF00 A gang "..hexOwner(winTeam)..winTeam.."#00FF00 dominou "..turfInfo..source:getData("name"), 255, 255, 255, true)
		triggerServerEvent("server:soundDomina", root, Team.getFromName(winTeam), localPlayer)
		return
	end
	local r,g,b = radarArea:getColor()
    if(defended) then
		outputChatBox("#FF6464["..turfType.."]#00FF00 A gang "..RGBToHex(r,g,b)..winTeam.."#00FF00 defendeu "..turfInfo..source:getData("name").." da gang "..hexOwner(loseTeam)..loseTeam, 255, 255, 255, true)
		triggerServerEvent("server:soundDomina", root, Team.getFromName(winTeam), localPlayer)
	else
		outputChatBox("#FF6464["..turfType.."]#00FF00 A gang "..hexOwner(winTeam)..winTeam.."#00FF00 dominou "..turfInfo..source:getData("name").." da gang "..RGBToHex(r,g,b)..loseTeam, 255, 255, 255, true)
		triggerServerEvent("server:soundDomina", root, Team.getFromName(winTeam), localPlayer)
	end
    DominationTerritory.getInstance():setOwner(winTeam)
   if(localPlayer:isWithinColShape(source)) then
        AttackTerritory.getInstance():setVisible(false)
    end
    
end)

addEvent("onTeamStartAttack",true)
addEventHandler("onTeamStartAttack", root, function(area,radarArea, team, teamEnemy, currentTime)
	local type = area:getData("type")
	if (type == "territorio") then
		turfInfo = "o territorio "
		turfType = "TERRITORIO"
	elseif (type  == "gangzona") then
		turfInfo =  "a gang zona "
		turfType =  "GANGZONE"
	elseif (type  == "villa") then
		turfInfo = "a villa "
		turfType = "VILLE"
	end
   
    local r,g,b = radarArea:getColor()
    outputChatBox("#FF6464["..turfType.."]#00FF00 A gang "..hexOwner(team)..team.."#00FF00 está atacando "..turfInfo..area:getData("name").." da gang "..RGBToHex(r,g,b)..teamEnemy, 0, 0, 0, true)
    AttackTerritory.getInstance():setTeams(team, teamEnemy,radarArea:getColor())
  AttackTerritory.getInstance().textNameZone:setText(area:getData("name"))
	AttackTerritory.getInstance().timeLeft:setText("Tempo restante: "..formatMilliExtens(currentTime))
	AttackTerritory.getInstance():setDeaths(0, 0)
	AttackTerritory.getInstance():setPoints(0, 500)
    if(source:isWithinColShape(area)) then
        AttackTerritory.getInstance():setVisible(true)
	end
end)


addEvent("onTeamRefreshAttack",true)
addEventHandler( "onTeamRefreshAttack",root,function(area, radarArea,team, teamEnemy, currentTime,attackPoints,attackDeaths,defensePoints,defenseDeaths,attackerInArea,defenseInArea)
    local instance = AttackTerritory.getInstance()
    instance:setPoints(attackPoints,defensePoints)
    instance:setDeaths(attackDeaths,defenseDeaths)
    instance:setPlayersInArea(attackerInArea,defenseInArea)
    instance.timeLeft:setText("Tempo restante: "..formatMilliExtens(currentTime))
   
     AttackTerritory.getInstance().textNameZone:setText(area:getData("name"))
end)

addEvent("onPlayerExitArea",true)
addEventHandler("onPlayerExitArea",root,function()
    AttackTerritory.getInstance():setVisible(false)
end)
addEvent("onPlayerEnterArea",true)
addEventHandler("onPlayerEnterArea",root,function(area)
    
    if(area:getData("isAttacking")) then
        AttackTerritory.getInstance():setVisible(true)
        AttackTerritory.getInstance().textNameZone:setText(area:getData("name"))
    end
end)























addEvent("client:soundAtaque", true)
addEventHandler("client:soundAtaque", root, function()
	local sound = playSound("sfx/turf/ataque.ogg")
	setSoundVolume(sound, 0.5)
end)

addEvent("client:soundDefende", true)
addEventHandler("client:soundDefende", root, function()
	local sound = playSound("sfx/turf/defende.flac")
	setSoundVolume(sound, 0.5)
end)

addEvent("client:soundDomina", true)
addEventHandler("client:soundDomina", root, function()
	local sound = playSound("sfx/turf/domina.flac")
	setSoundVolume(sound, 0.5)
end)




addEventHandler("onClientResourceStart", resourceRoot, function()
	Camera.fade(true)
	Toolkit.getInstance():add(AttackTerritory.getInstance())
end)