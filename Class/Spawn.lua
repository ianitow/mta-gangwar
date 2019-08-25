local super = Class("Spawn",LuaObject,function ()
	static.STATS = {69, 70, 73, 75, 71, 72, 74, 76, 77, 78, 229, 230,74,229}
	
	static.RANDOM_POSITIONS = {
		{2160.32935, 2241.85425, 10.81253},
		{2104.01782, 2179.11938, 10.22997},
		{2166.68286, 2116.96045, 10.22998},
		{2028.21313, 1913.79297, 11.72204}, 
		{2221.36084, 1836.80579, 10.22999},
		{2178.56055, 1682.79626, 10.37473},
		{2133.88403, 1442.93823, 10.23009},
		{1954.17163, 1342.55054, 15.77461},
		{2233.10010, 1285.94299, 10.20140},
		{2177.30420, 1114.72534, 12.05228},
		{2017.43970, 1103.75366, 10.23429},
		{2241.06299, 963.93292, 10.22984}
	}
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
   static.SPAWN_TIME = 4000;
end).getSuperclass()

function Spawn:init()
    super.init(self)
	
	self.blips = {}
	self.spawnPlayer = function(player)
	    if (isElement(player)) then
		    self:onWasted(player)
		end
	end

	

	
	addEventHandler("onPlayerJoin", root,
	function ()
	    for _,stat in pairs (Spawn.STATS) do
			setPedStat(source, stat, 1000)
		end
		self:setBlip(source)
	end)
	
	addEventHandler("onPlayerQuit", root,
	function ()
		self:destroyBlip(source)
		Gang.onPlayerQuit(source)
	end)
	
	for _,player in pairs (getElementsByType("player")) do
	    self:setBlip(player)
	end
	
	setWeaponProperty(26, "pro", "damage", 5)
    setWeaponProperty(30, "pro", "damage", 18)
    setWeaponProperty(32, "pro", "damage", 8)
    setWeaponProperty(29, "pro", "damage", 15)
    setWeaponProperty(28, "pro", "damage", 8)
    setWeaponProperty(31, "pro", "damage", 18)
	setWeaponProperty(27, "pro", "damage", 7)
    setWeaponProperty(31, "pro", "accuracy", 0.99000001192093)
    setWeaponProperty(30, "pro", "accuracy", 0.99000001192093)
	
	return self
end
function Spawn:setSpawn(player, x, y, z, rotation)
	local skin = player:getModel()
	spawnPlayer(player, x, y, z, rotation, skin, 0, 0)
	self:setBlip(player)
	fadeCamera(player, true)
	setCameraTarget(player, player)
	
	local packGuns = getRandomPackWeapon("default")
	for index, gun in pairs(packGuns) do
		player:giveWeapon(gun[1],gun[2],true)
		if(gun[1] == 26) then
			setWeaponAmmo( player, gun[1], gun[2], 4 )
		end
	end
	local team = getPlayerTeam(player)
	if (team) then
		local fortcarson = Area.getAreaOwnerByName("Fort Carson")
		local blueberry = Area.getAreaOwnerByName("Blueberry")
		if (fortcarson == team.name) then
			player:setArmor(100)
		else
			player:setArmor(0)
		end
		
		if (blueberry == team.name) then
			player:setMoney(25000)
		else
			player:setMoney(500)
		end
	else
		player:setMoney(500)
	end
end
function getRandomPackWeapon(type)
    if type then
        if type == "default" then
            local machinesTable = {28,29,32}
            local pack = 
            {
                ['handgun'] = {24,math.random(90,120)},
                ['shotguns'] = {math.random(25,27),math.random(90,120) },
                ['machines'] = {machinesTable[math.random(3)],math.random(180,200)},
                ['assaultRifles'] = {math.random(30,31),math.random(180,200)},
            }
            return pack
        end
    end
    return false
end

function Spawn:setBlip(player)
    if not (self.blips[player]) then
	    if not (player:isDead()) then
            self.blips[player] = createBlipAttachedTo(player, 0, 2, getPlayerNametagColor(player))
		end
    else
	    self:destroyBlip(player)
		self.blips[player] = createBlipAttachedTo(player, 0, 2, getPlayerNametagColor(player))
	end
end

function Spawn:destroyBlip(player)
    if self.blips[player] then 
        self.blips[player]:destroy()
        self.blips[player] = nil 
    end 
end

function Spawn:onWasted(player)
	local team = player:getTeam()
	if not (team) then
		x,y,z = unpack(Spawn.RANDOM_POSITIONS[math.random(#Spawn.RANDOM_POSITIONS)])
		self:setSpawn(player, x,y,z, player:getModel())
		for _,stat in pairs (Spawn.STATS) do
			setPedStat(player, stat, 999)
		end
		return 
	end
	
	if (team) and not (Base.getGangBase(team:getName())) then 
		local gangzonaPriority = Area.getGangZonaRespawn(team.name)
		if (gangzonaPriority) then
			local x, y, z, rot = unpack(spawnLocation[gangzonaPriority][math.random(#spawnLocation[gangzonaPriority])])
			self:setSpawn(player, x,y,z, rot)
			for _,stat in pairs (Spawn.STATS) do
				setPedStat(player, stat, 999)
			end
		else
			x,y,z = unpack(Spawn.RANDOM_POSITIONS[math.random(#Spawn.RANDOM_POSITIONS)])
			self:setSpawn(player, x,y,z, 0)
			for _,stat in pairs (Spawn.STATS) do
				setPedStat(player, stat, 999)
			end
		end
	-- se team gang e base -- base
	else
	    local base = Base.getGangBase(team:getName()):getName()
	    if (base ~= false) then
		    local x, y, z, rot = unpack(spawnLocation[base][math.random(#spawnLocation[base])])
			self:setSpawn(player, x,y,z, rot)
			for _,stat in pairs (self.STATS) do
				setPedStat(player, stat, 999)
			end
		end
	end
end

function Spawn:spawnPlayerAccount(player,type,...)
	local args = {...}
	if(type == "" or type=="default") then
		local x,y,z = unpack( Spawn.RANDOM_POSITIONS[math.random(#Spawn.RANDOM_POSITIONS)])
		spawnPlayer( player,x,y,z)
		local packGuns = getRandomPackWeapon("default")
		for index, gun in pairs(packGuns) do
			player:giveWeapon(gun[1],gun[2],true)
			if(gun[1] == 26) then
				setWeaponAmmo( player, gun[1], gun[2], 4 )
			end
		end
		
	elseif(type == "loadAccount") then
		spawnPlayer( player,unpack(args))
	end
	player:fadeCamera(true)
	player:setNametagColor(163, 163, 163)
	player.cameraTarget = player
	setPlayerBlurLevel(player, 0)
	player:setMoney(500)
	for _,stat in pairs (Spawn.STATS) do
		setPedStat(player, stat, 999)
	end
	self:setBlip(player)
end


function Spawn.onPlayerWasted(_,killer)
	Spawn.getInstance():destroyBlip(source)
	setTimer(Spawn.getInstance().spawnPlayer, Spawn.SPAWN_TIME, 1, source);
	
	if killer and killer ~= source then 
		local killerKill = killer:getData("kills")
		local killerDeaths = killer:getData("deaths")
		killer:setData("kills",killerKill+1)
		killer:setData("ratio",round(killerKill/killerDeaths,2))
	end
	local playerDeaths = source:getData("deaths")
	local playerKills = source:getData("kills")
	source:setData("deaths", playerDeaths+1)
	source:setData("ratio",round( playerKills/playerDeaths,2))
end
addEventHandler("onPlayerWasted", root, Spawn.onPlayerWasted)



addEventHandler("onResourceStart", resourceRoot,
function ()
	Spawn()
	outputDebugString( "Spawn Loaded: ",3 )
end)
