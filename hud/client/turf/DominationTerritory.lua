--[[
	@author: Iaan
	@since:1.0
	@website: www.maingames.com.br
	@description: Se caso você roubar(ou se eu vender ou doar), deixe meus creditos. Obg
]]--
local super = Class("DominationTerritory", Container3D, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
    
end).getSuperclass()

function DominationTerritory:init()
    super.init(self)
    self.screenX, self.screenY = Graphics.getInstance():getSize() -- podes usar Graphics.getInstance():getSize()
    self:setBounds(Graphics.getInsets(0, 0, 800, 600))
	self:setBackground(tocolor(255, 255, 255, 255))
    self.panelArea = Panel()
    
    self.panelArea:setBounds(self.screenX/4.5,self.screenY-270,210,120)
    self.panelArea:setBackground(tocolor(0,0,0,0))
    self.panelArea:setVisible(true)
    self:add(self.panelArea)

    
    self.typeArea = Label("Território: Palominos Greek")
    self.typeArea:setBounds(0,0,self.panelArea:getWidth(),40)
    self.typeArea:setForeground(tocolor(255,255,255))
    self.typeArea:setScale(1.4)
    self.typeArea:setBackground(tocolor(0,0,255))
    self.typeArea:setAlignment(Label.CENTER)
    self.panelArea:add(self.typeArea)


    self.gangFirstName = Label("Dominante: Nenhum")
    --self.gangFirstName:setBorder(LineBorder(tocolor(255,0,255)))
    self.gangFirstName:setBounds(0,self.typeArea:getTextHeight()+5,self.panelArea:getWidth(),40)
    self.gangFirstName:setForeground(tocolor(255,255,255))
    self.gangFirstName:setScale(1.4)
    self.gangFirstName:setBackground(tocolor(0,0,255))
    self.gangFirstName:setAlignment(Label.CENTER)
    self.panelArea:add(self.gangFirstName)

    self.slogan = Label("")
    self.slogan:setBounds(0,self.gangFirstName:getHeight()+5,self.panelArea:getWidth(),40)
    self.slogan:setForeground(tocolor(255,255,255))
    self.slogan:setScale(1)
    self.slogan:setBackground(tocolor(0,0,255))
    self.slogan:setAlignment(Label.CENTER)
    self.panelArea:add(self.slogan)

    self.progress = ProgressBar(nil, 0, 100)
    self.progress:setVisible(false)
    local x,y = self.slogan:getLocationOnScreen()
    self.progress:setBounds(self.screenX/4.5,y+35,self.panelArea:getWidth(),20)
    self.progress:setForeground(tocolor(0, 210, 211))
    self.progress:setBackground(tocolor(0,0,0,255))
    self:add(self.progress)
	
    self.labelProgress = Label()
    self.labelProgress:setVisible(false)
    self.labelProgress:setForeground(tocolor(255,255,255))
    self.labelProgress:setBackground(tocolor(0,0,0))
    self.labelProgress:setScale(1)
    self.labelProgress:setText("Atacando Territorio...")
    self.labelProgress:setAlignment(Label.CENTER)
    local xL,yL = self.progress:getLocationOnScreen()
	self.labelProgress:setBounds(xL,yL, self.progress:getSize())
    self:add(self.labelProgress)

    self:setVisible(false)
   
    return self
end


function DominationTerritory:setOwner(ownerName)
    if ownerName then
        self.gangFirstName:setText("Dominante:" ..tostring(ownerName))
        if Team.getFromName(ownerName) then
            if(Team.getFromName(ownerName):getData("slogan")) then
                self.slogan:setText(Team.getFromName(ownerName):getData("slogan"))
            else
                self.slogan:setText("")
            end
        end
        return true
    else
        self.gangFirstName:setText("Dominante: N/A")
        self.slogan:setText("")
        return true
    end
end

function DominationTerritory:setArea(typeArea,nameArea)
    typeArea = typeArea or ""
    nameArea = nameArea or "[BUG] Sem nome"
    self.typeArea:setText(typeArea..": "..nameArea)
    return true
end

addEvent("onPlayerEnterArea",true)
addEventHandler("onPlayerEnterArea",root,function(area)
    local name = area:getData("name")
    local hud = DominationTerritory.getInstance()
    local targetOwner = area:getData("owner")

	if not targetOwner then
        targetOwner = "N/A"
    end
    local targetType = area:getData("type")
    local areaType
	if (targetType == "territorio") then
		areaType = "Território"
	elseif (targetType == "gangzona") then
		areaType = "Gang Zona"
	elseif (targetType == "villa") then
		areaType = "Villa"
    end
    hud:setOwner(targetOwner)
    hud:setArea(areaType,name)
    hud:setVisible(true)
end)

addEvent("onPlayerExitArea",true)
addEventHandler("onPlayerExitArea",root,function()
    DominationTerritory.getInstance():setVisible(false)
    DominationTerritory.getInstance().progress:setValue(0)
    DominationTerritory.getInstance().progress:setVisible(false)
    DominationTerritory.getInstance().labelProgress:setVisible(false)
end)

addEvent("onTeamStartDomination",true)
addEventHandler("onTeamStartDomination",root,function(area, team,currentTime,maxTime)
    if(source:getTeam() == team) then
        local instance = DominationTerritory.getInstance()
        instance.progress:setVisible(true)
        instance.labelProgress:setVisible(true)
        instance.progress:setMaximum(maxTime)
        instance.progress:setValue(currentTime)
	end
end)

addEvent("onTeamFinishDomination",true)
addEventHandler("onTeamFinishDomination",root,function(team)
	if(localPlayer:getTeam() == team) then
		if(localPlayer:isWithinColShape(source)) then
            DominationTerritory.getInstance().progress:setVisible(false)
            DominationTerritory.getInstance().labelProgress:setVisible(false)
		end
	end
end)

addEvent("onTeamFinishAttack",true)
addEventHandler("onTeamFinishAttack",root,function(radarArea,winTeam,loseTeam,defended)
	DominationTerritory.getInstance():setOwner(winTeam)
end)



addEventHandler("onClientResourceStart", resourceRoot, function()
	Camera.fade(true)
	Toolkit.getInstance():add(DominationTerritory.getInstance())
end)