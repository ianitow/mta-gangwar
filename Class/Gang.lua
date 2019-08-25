local super = Class("Gang",LuaObject,function ()
	static.instances = {}
 	
	static.gangCost = 400000
		
	static.Levels = {
		"Convidado",
        "Membro",
        "Comandante",
        "Lider"
	}

	static.LevelsID = {
		["Convidado"] = 1,
        ["Membro"] = 2,
        ["Comandante"] = 3,
        ["Lider"] = 4
	}
	
	static.getInstance = function()
        return LuaObject.getSingleton(static)
    end

    static.database = Database("tbl_gangs")
    static.database:custom([[
        CREATE TABLE IF NOT EXISTS tbl_gangs(
			id INT AUTO_INCREMENT NOT NULL,
            name VARCHAR(50) UNIQUE,
            leader VARCHAR(50) UNIQUE,
            tag VARCHAR(3),
            serial TEXT,
            xp INT NOT NULL DEFAULT '0',
            color VARCHAR(50),
            slogan TEXT,
            lastActivity DATE,
            PRIMARY KEY (id))]]):execute()
             
   
end).getSuperclass()

function Gang:init(name, color, xp, active,tag,slogan)
	super.init(self)								
						
	self.id = Gang.getFreeId()
    self.name = name
    self.xp = xp or 0
    self.active = active
    self.color = color
    self.tag = tag
    self.slogan = slogan
    self.blipMark = nil
 
    if (active == true) then
        self.team = Team(name,unpack(fromJSON(self.color)))
        self.team:setData("ID", self.id)
        self.team:setData("xp", self.xp)
        self.team:setData("tag",self.tag)
        self.team:setData("slogan",self.slogan)
    else
        self.team = nil
    end
	
    table.insert(Gang.instances,self)
	return self;
end

function Gang.onResourceStart()
    local dxScoreLevel = exports [ "scoreboard" ]:addScoreboardColumn ( "Level", 3 )

    local result = Gang.database:select():getAll()
    for _,row in pairs(result) do
        local instance = Gang(row.name,row.color,row.xp,false,row.tag,row.slogan)
    end

    for index,player in pairs (getElementsByType("player")) do
        if(Gang.getFromName(player:getData("gang"))) then
            local gangObject = Gang.getFromName(player:getData("gang"))
            if not gangObject:isActive() then
                gangObject:setActive(true)
            end
            gangObject:addMember(player,Gang.LevelsID[player:getData("Level")])
        end
    end
end
addEventHandler("onResourceStart", resourceRoot, Gang.onResourceStart)
	

function Gang.getLevelFromName(name)
    if name then
        return Gang.LevelsID[name];
    end
end


function Gang:getTeamElement()
    return self.team
end
function Gang:setTagName(tagName)
    if tagName then
        tagName = string.upper(tagName)
      self.tag = tagName
      self.team:setData("tag",tagName)
      for i, player in pairs(self:getMembers()) do
        player:setData("gang.tag",tagName)
      end
    else
        self.tag = nil
        for i, player in pairs(self:getMembers()) do
            player:setData("gang.tag",nil)
        end
        self.team:setData("tag",nil)
    end
end

function Gang:getTagName()
    return self.tag
end

function Gang.getFromMember(member) 
    for index, gang in pairs(Gang.instances) do
        if(gang.team == member.team) then
            return gang
        end
    end 
    return false
end

function Gang.getFromName(name) 
    for index, gang in pairs(Gang.instances) do
        if(gang.name == name) then
            return gang
        end
    end  
    return false
end

function Gang.getFromID(id)
    for index,gang in pairs(Gang.instances) do
        if (gang.id == id) then
            return gang
        end
    end
    return false
end

function Gang.getFromXP(xp)
    for index, gang in pairs(Gang.instances) do
        if (gang.xp == xp) then
            return gang.name
        end
    end
    return false
end

function Gang.getFreeId()
    for i=1, 300 do
        if not (Gang.getFromID(i)) then
            return i
        end
    end
end

function Gang.getActiveGangs()
    for index,gang in pairs(Gang.instances) do
        if(gang.active == true) then
            return gang
        end
    end
    return false
end


function Gang:dispose()
    for index,instance in pairs(Gang.instances) do
        if (instance == self) then
            Gang.database:delete():where("name",self.name):execute()
		    if(self:isActive()) then
		        self.team:destroy() 
			end
			self.name = nil
            table.remove(Gang.instances,index)
            
        end
    end
end

function Gang:isMember(member)
    return (member.team == self.team)
end

function Gang:setName(name)
    if(self.active) then
        self.team:setName(name)
	end
	self.name = name
end

function Gang:getName()
    return self.name
end

function Gang:getColor()
    if (self.active) then
        return self.team:getColor()
    end
    local r,g,b = unpack(fromJSON(self.color))
    return r,g,b
end

function Gang:setColor(r, g, b)
    self.color = {r,g,b}
    if (self.active) then
        self.team:setColor(r, g, b)
        return true
    end
    return false
end

function Gang:getMembers()
    return getPlayersInTeam(self.team)
end

function Gang:getTeamCount()
    return self.team.playerCount
end

function Gang:getXP()
    return self.xp 
end

function Gang:setXP(xp)
    self.xp = xp
    self.team:setData("xp", xp)
    return true
end

function Gang:incrementXP(xp)
    self.xp = self:getXP() + xp
    if(self.team) then
        self.team:setData("xp",self.xp)
    end
        return true
end
function Gang:decrementXP(xp)
    self.xp = self:getXP() - xp
    if(self.xp < 0 ) then
        self.xp = 0
    end
   if(self.team) then
     self.team:setData("xp",self.xp)     
    end
    
end

function Gang:isActive()
    return self.active
end

function Gang:setActive(bool)
    if (bool == true) then
        self.team = Team(self.name, unpack(fromJSON(self.color)))
        self.active = true
        self.team:setData("ID", self.id)
        self.team:setData("xp", self.xp)
        self.team:setData("tag",self.tag)
        self.team:setData("slogan",self.slogan)
    else
        self.team:destroy()
        self.active = false
    end
end

function Gang:addMember(member, level)
    member.team = self.team 
    member:setData("Level", Gang.Levels[level])
    member:setData("gang",self.name)
    member:setData("gang.tag",self.tag)
    member:setNametagColor(unpack(fromJSON(self.color)))
	
	-- update blip
	for index,element in ipairs(getAttachedElements(member)) do
	    if (isElement(element)) and (element:getType() == "blip") then
		    local r,g,b = getPlayerNametagColor(member)
		    setBlipColor(element, r, g, b, 255 )
		end
	end
end

function Gang:removeMember(member)
    member.team = nil
    member:removeData("Level")
    member:removeData("gang")
    member:setData("gang.tag",nil)
    member:setNametagColor(163, 163, 163)
	
	if(self:getTeamCount() == 0) then
	    self:setActive(false)
	end
	
	-- update blip
	for index,element in ipairs(getAttachedElements(member)) do
	    if (isElement(element)) and (element:getType() == "blip") then
		   setBlipColor(element, 163, 163, 163, 255)
		end
	end	
end

function Gang:getLevel(member)
    return member:getData("Level")
end

function Gang:setLevel(member, level)
    member:setData("Level", Gang.Levels[level])   
    return true
end


function Gang.onPlayerLogin(player, gangName, level)
    if not (gangName) or (gangName == "") or not (Gang.getFromName(gangName)) then
        player:outputChat("#FF6464[GANG]#00FF00 Você não possui uma gang", 255, 255, 255, true)
        player:setData("Level",nil)
        player:setData("gang",nil)
        player:setNametagColor(163, 163, 163)
        return
    end
    
    -- Se o player tem uma gang e a gang já está criada
    if (gangName) and (Gang.getFromName(gangName)) and (Gang.getFromName(gangName):isActive()) then
        local gang = Gang.getFromName(gangName)
        gang:addMember(player, Gang.LevelsID[level])
        
		player:outputChat("#FF6464[GANG]#00FF00 Bem vindo a gang "..gangName, 255, 255, 255, true)
        
        for _,member in pairs (gang:getMembers()) do
            if (player ~= member) then
				member:outputChat("#FF6464[GANG]#00FF00 "..player.name.." [ "..level.." ] entrou na gang.", 255, 255, 0, true)
            end
        end
    
    -- Se o jogador tem uam gang na database, mais a gang nã oestá criada no server
    elseif (gangName) and (Gang.getFromName(gangName)) and not (Gang.getFromName(gangName):isActive()) then
        local gang = Gang.getFromName(gangName)
        gang:setActive(true)
        gang:addMember(player,Gang.LevelsID[level])
		player:outputChat("#FF6464[GANG]#00FF00 Bem vindo a gang "..gangName, 255, 255, 255, true)
    end
end

function Gang.onPlayerQuit(player)
    if (Gang.getFromMember(player)) then
        local gang = Gang.getFromMember(player)
        if (gang:getTeamCount() <= 1) then
            gang:setActive(false)
        end
    end
end

function Gang:onAreaChange(previous, new, areaXP)
    local gang = Gang.getFromName(new)
    if (gang) then
        local xp = gang:getXP()
        gang:setXP(xp+areaXP)
    end

    if (previous ~= "") then
        local gang = Gang.getFromName(previous)
        if (gang) then
            local xp = gang:getXP()
            gang:setXP(xp-areaXP)
        end
    end
end

function Gang.getByTagName(tag)
    for index, gang in pairs(Gang.instances) do
        if(gang.tag == tag) then
            return gang
        end
    end  
    return false
end

function Gang:setSlogan(slogan)
    if slogan then
        self.slogan = table.concat(slogan," ")
        if(self.team) then
            self.team:setData("slogan",self.slogan)
        end
    else
        if(self.team) then
            self.team:setData("slogan",nil)
        end
        self.slogan = nil
    end
    return true
end

function Gang:getSlogan()
    if(self.slogan) then
        return self.slogan
    end
    return false
end

addCommandHandler("gang",
function (player, command, type,...)
    if not player:getData("account") then
        return false
    end 
    local parameters = {...}
    if not type or  #type == 0 or (type == "") then
        player:outputChat("#FF6464[GANG]#00FF00 Use /gang [criar/deletar/sair/convite/marcar/aceitar/recusar/level/kick/lider/tag/slogan]", 255, 0, 0, true)
        return
    end
    if    (type == "criar") then 
        if (Gang.getFromMember(player)) then
            player:outputChat("#FF6464[GANG]#00FF00 Você já está em uma gang, use #FF6464/gang abandonar #00FF00para abandonar e criar uma.", 0, 255, 0, true)  
            return false
        end
        local gangName = parameters[1] or 0
        if(string.len(gangName) <= 3) then
            player:outputChat("#FF6464[GANG]#00FF00Nome da gang muito pequeno. (Min: 3)", 0, 255, 0, true)
            return false
        elseif(string.len(gangName) >= 20) then
            player:outputChat("#FF6464[GANG]#00FF00 Nome muito grande. (Max: 20)", 0, 255, 0, true)
            return false
        end

        if player:getMoney() < Gang.gangCost then
            player:outputChat("#FF6464[GANG]#00FF00 Dinheiro insuficiente, preço: $"..Gang.gangCost, 0, 255, 0, true)
            return false
        end
        if not Gang.getFromName(parameters[1]) then
            local r,g,b = math.random(0,255), math.random(0,255), math.random(0,255)
            local gang = Gang(gangName, toJSON({r,g,b}), 0, true)
            gang:addMember(player, 4)
            player:takeMoney(Gang.getInstance().gangCost)
            player:outputChat("#FF6464[GANG] "..gangName.." #00FF00criada com sucesso!", 0, 255, 0, true)  
            Gang.database:insert({
                ['name'] = gangName,
                ['color'] = toJSON({r,g,b}),
                ['serial'] = md5(gangName),
                ['lastActivity'] = getServerTime(),
                ['leader'] = player.name
            }):execute()
        end
    elseif(type == "abandonar") then
         if (Gang.getFromMember(player)) then
            if not (Gang.getInstance():getLevel(player) == "Lider") then

                local gang = Gang.getFromMember(player)
				player:outputChat("#FF6464[GANG]#00FF00 Você abandonou a gang", 255, 0, 0, true)
				
                for _,member in pairs (gang:getMembers()) do
                    if (player ~= member) then
						member:outputChat("#FF6464[GANG]#00FF00 "..player.name.." abandonou a gang", 255, 0, 0, true)
                    end
                end
                gang:removeMember(player)
            else
                player:outputChat("#FF6464[GANG]#00FF00 O Lider não pode abandonar a gang, use #FF6464/gang deletar.", 255, 0, 0, true)
            end
        else
            player:outputChat("#FF6464[GANG]#00FF00 Você não possui uma gang", 255, 255, 0, true)
        end
    elseif(type == "convite") then
       if(parameters) then
            local allowedLevels = {["Lider"] = true, ["Comandante"] = true}
            local level = player:getData("Level")
            if not (allowedLevels[level]) then
                player:outputChat("#FF6464[GANG]#00FF00 Você não tem permissão para convidar jogadores  para gang", 255, 255, 0, true)
                return
            end	    
            local gang = Gang.getFromMember(player)
            local targetElement = exports.systemID:getPlayerFromID(tonumber(parameters[1]))
            if not gang then
                 player:outputChat("#FF6464[GANG]#00FF00 Você não possui uma gang para convidar.", 0, 255, 0, true)
                return false
            end

            if(targetElement) then
                if(gang:isMember(targetElement)) then
                    player:outputChat("#FF6464[GANG]#00FF00 O jogador #FF6464"..target.name.."#00FF00 já esta na gang!", 0, 255, 0, true)
                    return false
                end
                if not (targetElement:getData("convite-data") == gang:getName()) then
                            setTimer(function()
                                if (isElement(target)) then
                                    if (targetElement:getData("convite-data")) then
                                        targetElement:removeData("convite-data")
                                    end
                                end
                            end, 60000, 1)

                            targetElement:setData("convite-data", gang:getName(), false)

                            player:outputChat("#FF6464[GANG]#00FF00 Você convidou o jogador #FF6464"..targetElement.name.."#00FF00 para a gang!", 0, 255, 0, true)
                            targetElement:outputChat("#FF6464[GANG]#00FF00 Você recebeu um convite para entrar na gang "..gang:getName(), 255, 255, 0, true)
                            targetElement:outputChat("#FF6464[GANG]#00FF00 Para responder o convite, use #FF6464 /gang aceitar #00FF00ou #FF6464 /gang recusar.", 255, 255, 0, true)

                        else
                            player:outputChat("#FF6464[GANG]#00FF00 O jogador #FF6464"..targetElement.name.."#00FF00 ja foi convidado para entrar na gang!", 0, 255, 0, true)
                        end
            else
                player:outputChat("#FF6464[GANG]#00FF00 Jogador não encontrado, sintaxe: #FF6464/gang convite <id>.", 0, 255, 0, true)
            end
         end
    elseif(type == "aceitar") then
        if (Gang.getFromMember(player)) then
            player:outputChat("#FF6464[GANG]#00FF00 Você já esta em uma gang.", 0, 255, 0, true)
            return false
        elseif (player:getData("convite-data") == false) then
            player:outputChat("#FF6464[GANG]#00FF00 Você não recebeu nenhum convite de gang", 255, 255, 0, true)
            return false
        end
        local gangName = player:getData("convite-data")
        if (Gang.getFromName(gangName)) then
            local gang = Gang.getFromName(gangName)
            if(gang:isActive()) then    
                gang:addMember(player, 1)
                player:removeData("convite-data")
                player:outputChat("#FF6464[GANG]#00FF00 Bem vindo a gang "..gangName, 0, 255, 0, true)
                for _,member in pairs (gang:getMembers()) do
                    if (player ~= member) then
                        member:outputChat("#FF6464[GANG]#00FF00 "..player.name.. " entrou na gang!", 0, 255, 0, true)
                    end
                end
            end
        end
    elseif(type == "recusar")then
        local invite = player:getData("convite-data")
        if (invite) then
                local gang = Gang.getFromName(invite) 
                player:outputChat("#FF6464[GANG]#00FF00 Você recusou o convite da gang #FF6464"..invite, 0, 255, 0, true)
                player:removeData("convite-data")
        else
            player:outputChat("#FF6464[GANG]#00FF00 Você não recebeu nenhum convite de gang", 255, 255, 0, true)
        end
    elseif(type == "deletar") then
        if (Gang.getFromMember(player)) then
            local gang = Gang.getFromMember(player)
            if (Gang.getInstance():getLevel(player) == "Lider") then
				for _,member in pairs (gang:getMembers()) do
					if (player ~= member) then
						member:outputChat("#FF6464[GANG]#00FF00 "..player.name.." deletou a gang.", 255, 255, 0, true)
						gang:removeMember(member)
					end
				end
			    player:outputChat("#FF6464[GANG]#00FF00 Gang deletada com sucesso!", 255, 255, 0, true)
				gang:removeMember(player)  
                for i,k in pairs(Area.getByOwner(gang.name)) do
                    k:setOwner(nil)
                end
                gang:dispose()
			else
				player:outputChat("#FF6464[GANG]#00FF00 Você não tem permissão para deletar a gang", 255, 255, 0, true)
			end
		else
			player:outputChat("#FF6464[GANG]#00FF00 Você não possui uma gang", 255, 255, 0, true)
        end
    elseif(type == "kick") then
        local target = tonumber(parameters[1])
        if (target) and (target ~= "") then
            if (exports.systemID:getPlayerFromID(target)) then
                local target = exports.systemID:getPlayerFromID(target)
                if (Gang.getFromMember(player)) then
					local gang = Gang.getFromMember(player)
                    if (gang == Gang.getFromMember(target)) then
                        if not (player == target) then
                            
							local myLevel = Gang.getInstance():getLevel(player)
							local targetLevel = Gang.getInstance():getLevel(target)
                        
                            if not (Gang.getInstance().LevelsID[myLevel] <= Gang.getInstance().LevelsID[targetLevel]) then
								gang:removeMember(target)
                            
								target:outputChat("#FF6464[GANG]#00FF00 #FF6464"..player.name.." #00FF00expulsou você da gang", 255, 0, 0, true)
								player:outputChat("#FF6464[GANG]#00FF00 Você expulsou #FF6464"..target.name.."#00FF00 da gang", 255, 0, 0, true)
                            
								for _,member in pairs (gang:getMembers()) do
									if (player ~= member) then
										member:outputChat("#FF6464[GANG] "..player.name.."#00FF00 expulsou #FF6464"..target.name.."#00FF00 da gang!", 255, 255, 0, true)
									end
								end     
                        
							else
								player:outputChat("#FF6464[GANG]#00FF00 Você não tem level para expulsar esse jogador da gang", 255, 0, 0, true)
							end
						else
							player:outputChat("#FF6464[GANG]#00FF00 Use /gang abandonar para sair da gang", 255, 0, 0, true)
						end
					else
						player:outputChat("#FF6464[GANG]#00FF00 Este jogador não pertence a gang", 255, 0, 0, true)
					end
				else
					player:outputChat("#FF6464[GANG]#00FF00 Você não possui uma gang", 255, 0, 0, true)
				end
			else
				player:outputChat("#FF6464[GANG]#00FF00 Jogador não encontrado", 255, 0, 0, true)
			end
		else
			player:outputChat("#FF6464[GANG]#00FF00 Uso correto: /gang kick [ID do jogador]", 255, 0, 0, true)
        end
    elseif(type == "level")then

		local target = tonumber(parameters[1])
		local level = tonumber(parameters[2])
    
		if (target) and (target ~= "") and (level) and (level ~= "") then
			if (exports.systemID:getPlayerFromID(target)) then
				local target = exports.systemID:getPlayerFromID(target)
				if (Gang.getFromMember(player)) then
					local gang = Gang.getFromMember(player)
					if (Gang.getFromMember(target) == gang) then
						if not (target == player) then
							if (level <= 3) and (level >= 1) then
                        
								local myLevel = Gang.getInstance():getLevel(player)
								local targetLevel = Gang.getInstance():getLevel(target)

								if not (Gang.getInstance().LevelsID[myLevel] <= Gang.getInstance().LevelsID[targetLevel]) and (Gang.getInstance().LevelsID[myLevel] > level) then
                                
									if (level > Gang.getInstance().LevelsID[targetLevel]) then
										action = "promoveu"
										target:outputChat("#FF6464[GANG]#00FF00 Você foi promovido para "..Gang.getInstance().Levels[level].." pelo jogador "..player.name, 0, 255, 0, true)
										player:outputChat("#FF6464[GANG]#00FF00 Você promoveu "..target.name.." para "..Gang.getInstance().Levels[level], 0, 255, 0, true)
									elseif (level < Gang.LevelsID[targetLevel]) then
										action = "rebaixou"
										target:outputChat("#FF6464[GANG]#00FF00 Você foi rebaixado para "..Gang.getInstance().Levels[level].." pelo jogador "..player.name, 0, 255, 0, true)
										player:outputChat("#FF6464[GANG]#00FF00 Você rebaixou "..target.name.." para "..Gang.getInstance().Levels[level], 0, 255, 0, true)
									end
                                
                                    for _,member in pairs (gang:getMembers()) do
                                        if (player ~= member) and (target ~= member) then
											member:outputChat("#FF6464[GANG]#00FF00 "..player.name.." "..action.." "..target.name.." para "..Gang.getInstance().Levels[level], 255, 255, 0, true)
                                        end
                                    end
                            
                                    Gang.getInstance():setLevel(target,level)
                            
                                else
                                    player:outputChat("#FF6464[GANG]#00FF00 Você não pode promover o jogador "..target.name, 255, 0, 0, true)
                                end
                            else 
                                player:outputChat("#FF6464[GANG]#00FF00 Level invalido", 255, 0, 0, true)
                            end
                        else
                            player:outputChat("#FF6464[GANG]#00FF00 Você não pode se auto promover", 255, 0, 0, true)
                        end
                    else
                        player:outputChat("#FF6464[GANG]#00FF00 Este jogador não está na mesma gang", 255, 0, 0, true)
                    end
                else
                    player:outputChat("#FF6464[GANG]#00FF00 Você não possui uma gang", 255, 0, 0, true)
                end
            else
                player:outputChat("#FF6464[GANG]#00FF00 Jogador não encontrado", 255, 0, 0, true)
            end
        else
            player:outputChat("#FF6464[GANG]#00FF00 Comando correto: /gang level [ID DO JOGADOR] [1-3]", 255, 0, 0, true)
        end
    elseif(type == "lider") then
        if (Gang.getFromMember(player)) then
            local gang = Gang.getFromMember(player)
            local targetElement = exports.systemID:getPlayerFromID(tonumber(parameters[1]))
            if not targetElement then
                player:outputChat("#FF6464[GANG]#00FF00 Jogador não encontrado", 255, 0, 0, true)
                return false
            end
            if not (Gang.getFromMember(targetElement) == gang) then
                player:outputChat("#FF6464[GANG]#00FF00 Este jogador não está na mesma gang", 255, 0, 0, true)
                return false
            end
            if (Gang.getInstance():getLevel(player) == "Lider") then
                for _,member in pairs (gang:getMembers()) do
                    member:outputChat("#FF6464[GANG]#00FF00 "..player.name.." deu o lider para: #FF6464"..targetElement.name, 255, 255, 0, true)
                end
                gang:setLevel(player,3)
                gang:setLevel(targetElement,4)
                Gang.database:update({
                    ['leader'] = targetElement.name
                }):where('name',gang.name):execute()
            else
              player:outputChat("#FF6464[GANG]#00FF00 Você não tem permissão para passar o líder.", 255, 255, 0, true)
            end
        else
            player:outputChat("#FF6464[GANG]#00FF00 Você não possui uma gang", 255, 255, 0, true)
        end
    elseif(type == "tag") then
        local allowedLevels = {["Lider"] = true}
        local level = player:getData("Level")
        if not (allowedLevels[level]) then
            player:outputChat("#FF6464[GANG]#00FF00 Você não tem permissão para definir uma tag para a gang.", 255, 255, 0, true)
            return
        end	   
        if not parameters[1] or parameters[1]== "" then
            local gang = Gang.getFromMember(player)
            gang:setTagName(nil)
            player:outputChat("#FF6464[GANG]#00FF00Tag removida com sucesso.", 255, 255, 0, true)
            return true
        end
        if(string.len(parameters[1]) > 4 ) then
            player:outputChat("#FF6464[GANG]#00FF00Tag invalida. (Max:4)", 255, 255, 0, true)
            return false
        end
        if(Gang.getByTagName(parameters[1])) then
            player:outputChat("#FF6464[GANG]#00FF00Tag Existente, selecionar outra", 255, 255, 0, true)
            return false
        end

            local gang = Gang.getFromMember(player)
            gang:setTagName(parameters[1])
            player:outputChat("#FF6464[GANG]#00FF00Tag setada. #FF6464"..parameters[1], 255, 255, 0, true)
    elseif(type=="slogan") then
        local allowedLevels = {["Lider"] = true}
        if not (Gang.getFromMember(player)) then
            player:outputChat("#FF6464[GANG]#00FF00 Você não possui uma gang", 255, 255, 0, true)
        end
        local level = player:getData("Level")
        if not (allowedLevels[level]) then
            player:outputChat("#FF6464[GANG]#00FF00 Você não tem permissão para definir um slogan para a gang.", 255, 255, 0, true)
            return
        end	   
        if not parameters[1] then
            local gang = Gang.getFromMember(player)
            player:outputChat("#FF6464[GANG]#00FF00Slogan: #FF6464"..(gang:getSlogan() and gang:getSlogan() or "Nenhum."), 255, 255, 0, true)
            player:outputChat("#FF6464[GANG]#00FF00Para remover digite: #FF6464/gang slogan NULL", 255, 255, 0, true)
            return true
        end
        if parameters[1]== "NULL" then
            local gang = Gang.getFromMember(player)
            gang:setSlogan(nil)
            player:outputChat("#FF6464[GANG]#00FF00Slogan removido com sucesso.", 255, 255, 0, true)
            return true
        end
        if(string.len(parameters[1]) > 20 ) then
            player:outputChat("#FF6464[GANG]#00FF00Slogan inválido. (Max:20 caractéres)", 255, 255, 0, true)
            return false
        end
            local gang = Gang.getFromMember(player)
            gang:setSlogan(parameters)
            player:outputChat("#FF6464[GANG]#00FF00Slogan alterado: #FF6464"..tostring(gang:getSlogan()), 255, 255, 0, true)
    elseif(type=="marcar") then
        if not (Gang.getFromMember(player)) then
            player:outputChat("#FF6464[GANG]#00FF00 Você não possui uma gang", 255, 255, 0, true)
        end
        local allowedLevels = {["Lider"] = true,["Comandante"] = true}
        local level = player:getData("Level")
        if not (allowedLevels[level]) then
            player:outputChat("#FF6464[GANG]#00FF00 Você não tem permissão para marcar o mapa da gang.", 255, 255, 0, true)
            return
        end
        local x,y,z = player:getPosition()
        local gang = Gang.getFromMember(player)
        gang.blipMark = createBlip(x,y,z,56)
        gang:refreshMark()
        for i,k in pairs(gang:getMembers()) do
            outputChatBox("#FF6464[GANG]#FF6464"..player.name.." #00FF00 marcou um local no mapa.",k,255,255,255,true)
        end
    end
end)

function Gang:refreshMark()
    setElementVisibleTo(self.blipMark,getRootElement(),false)
    if self.blipMark then
        for i,k in pairs(self:getMembers()) do
            if(k) then
                setElementVisibleTo(self.blipMark,k,true)
            end
        end
    end
end

function Gang.getTops()
    local topGang = {}
	for index, gang in pairs (Gang.instances) do
		if (gang.xp ~= 0) then
			table.insert(topGang, gang)
		end
    end	
    table.sort(topGang, function (a, b) return a > b end)
    for index,instance in pairs(topGang)do
        local r,g,b = instance:getColor()
        if(index == 10) then
            return topGang
        end
    end
    return topGang
end

function Gang.getFirstTop()
    local topGang = {}
	for index, gang in pairs (Gang.instances) do
		if (gang.xp ~= 0) then
			table.insert(topGang, gang)
		end
    end	
    table.sort(topGang, function (a, b) return a:getXP() > b:getXP() end)
    return topGang[1]
end

function getTopGangList(player, commandName)
    local topGang = {}
	for index, gang in pairs (Gang.instances) do
		if (gang.xp ~= 0) then
			table.insert(topGang, gang)
		end
    end	
    if(#topGang > 0) then
        table.sort(topGang, function (a, b) return a:getXP() > b:getXP() end)
        outputChatBox("#0000FF[SERVER]:#FFFFFFGang dominantes do servidor:",player, 0, 255, 0, true)
        for index,instance in pairs(topGang)do
            local r,g,b = instance:getColor()
            outputChatBox("#0000FF["..tostring(index).."°] - "..RGBToHex(r,g,b)..instance:getName().."#FFFFFF - #0000FF"..instance:getXP().."XP #FFFFFF- "..(instance:getSlogan() and instance:getSlogan() or "Sem slogan."),player, 0, 255, 0, true)
            if(index == 10) then
                return
            end
        end
    end
end
addCommandHandler("top", getTopGangList)


function Gang.onResourceStop()	
    for index,gang in pairs (Gang.instances) do
        Gang.database:custom(string.format([[UPDATE tbl_gangs SET xp ='%s',tag = %s, slogan = %s WHERE name = '%s']],Area.getOwnerXp(gang.name),(gang.tag and "'"..gang.tag.."'" or "NULL"),(gang.slogan and "'"..gang.slogan.."'" or "NULL"),gang.name)):execute()
         --Gang.database:custom(string.format([[UPDATE tbl_gangs SET xp ='%s',tag = %s, slogan = %s WHERE name = '%s']],Area.getOwnerXp(gang.name),(gang.tag and "'"..gang.tag.."'" or "NULL"),(gang.slogan and "'"..gang.slogan.."'" or "NULL"),gang.name)):debug()
    end
end 
addEventHandler("onResourceStop", resourceRoot, Gang.onResourceStop)


