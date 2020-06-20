--[[
	@author: Ianito
	@since:1.0
	@website: www.maingames.com.br
	@description: Account system 1.0
]]--

local super = Class("Account",LuaObject,function ()	
	static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
 	static.database = Database("tbl_users")
	static.database:custom([[
		CREATE TABLE IF NOT EXISTS tbl_users(
			id INT AUTO_INCREMENT NOT NULL,
			username VARCHAR(20) UNIQUE,
			password TEXT,
			serialCreate TEXT,
			lastLogin DATE,
			PRIMARY KEY (id))
	]]):execute()
	static.database:custom(
		[[
			CREATE TABLE IF NOT EXISTS tbl_users_data
			(
				id INT AUTO_INCREMENT NOT NULL,
				id_account INT,
				position TEXT,
                rotation TEXT,
                skin INT(3),
                health INT(3) DEFAULT '100',
                armor INT(3),
                money INT(9),
                interior INT(20),
                dimension INT(20),
                kills INT(3),
                deaths INT(3),
                clothes TEXT,
                weapons TEXT,
                gang VARCHAR(20),
                level TEXT,
				bank_balance INT(50),
				vip BOOLEAN NULL DEFAULT NULL,
				vip_date DATE,
				PRIMARY KEY(id)
			)
		]]
		):execute()
end).getSuperclass()

--[[
	function Account:init()
	return:void
	description:Default Constructor
]]--
function Account:init()
	super.init(self)
	outputDebugString( "Accounts loaded [ Account CLASS ]")

	 addEventHandler("onResourceStop", resourceRoot,
	function ()
		self:onResourceStop()
	end)

    addEventHandler("onPlayerQuit", root,
	function ()
		self: onPlayerQuit(source)
	end)	
	return self	
end

--[[
	function Account:create(player,username,password)
	return:true or false
	description:Create player account with all arguments are true.
]]--
function Account:create(player,username,password)
	local username,password,serial = tostring(username),tostring(password),getPlayerSerial(player)
	Account.database:setTable("tbl_users")
	if  not (username) or not (password) or (#username == 0) or (#password == 0) then
		outputChatBox("#FF6600[SERVER]:#FFFFFF O usuário ou senha está vazio. ",player,255,255,255,true)
		return false
	end
	

	if (#username< 4)  then
	 	 outputChatBox("#FF6600[SERVER]:#FFFFFFO nome informado Ã© muito pequeno. (Min: 4)",player,255,255,255,true)
		return false
	end


	if (#password < 3)  then
	   outputChatBox("#FF6600[SERVER]:#FFFFFFA senha informada Ã© muito pequena. (Min: 3)",player,255,255,255,true)
		return false
	end
	if not (isStringValid(username))then
		outputChatBox("#FF6600[SERVER]:#FFFFFFInforme apenas letras e números.",player,255,255,255,true)
		return false
	end

	if (self:isExists(username)) then
		outputChatBox("#FF6600[SERVER]:#FFFFFFJÃ¡ existe uma conta registrada no sistema com esse usuÃ¡rio. ("..username..").",player,255,255,255,true)
		return false
	end	
	local countAccount =Account.database:select():where("serialCreate",serial):getAll()
	
	if(#countAccount >= 2) then
		outputChatBox("#FF6600[SERVER]:#FFFFFFÉ apenas permitido 2 contas por serial. Dúvidas, contatar a administração.",player,255,255,255,true)
		return false
	
	end
	Account.database:insert(
	{
		['username'] = username,
		['password'] = md5(password),
		['serialCreate'] = player.serial,
		['lastLogin'] = getServerTime()
	}
	):execute()
	Database("tbl_users_data"):insert(
	{
		['id_account'] =  Account.database:select("id"):where("username",username):getSingle().id
	}
	):execute()
	return true
end

--[[
	function Account:isExists(username)
	return:true or false
	description:Check if the account exists in database.
]]--
function Account:isExists (username)
	if not (username) then 
		return false
	end
	local result = Account.database:select():where("username",username):getSingle()
	if(result and #result.username > 0 ) then
		return true
	end

	return false
end

--[[
	function Account:playerIsLogged(player)
	return:account name
	description:Check if player is logged
]]--
function Account:playerIsLogged(player)
	return player:getData("account")
end

--[[
	function Account:login(player,name,password)
	return:void
	description: Check if arguments are true, then attach 'account' to data player.
]]--
function Account:login(player,name,password)
	Account.database:setTable("tbl_users")
	
  -- Checking if the player wrote the name and password.
	if not (player) or not (name) or not (password) or (#name == 0) or (#password ==0) then
	    outputChatBox("#FF6600[SERVER]:#FFFFFF Campos nÃ£o preenchidos. ",player,255,255,255,true)
		return false
	end

	if not (self:isExists(name)) then
	    outputChatBox("#FF6600[SERVER]:#FFFFFF A conta informada nÃ£o existe. ",player,255,255,255,true)
		return false
	end
	
	local result = Account.database:select("password"):where("username",name):getSingle()
	local thePassword = result.password
	    if (thePassword and thePassword ~= md5(password)) then 
			outputChatBox("#FF6600[SERVER]:#FFFFFF A senha informada estÃ¡ errada. ",player,255,255,255,true)
		return false
	end

	if (name and password) then
		for index, values in pairs(getElementsByType("player")) do
			local account = self:playerIsLogged(values)
			if(tostring(account) == name )then
				outputChatBox("#FF6600[SERVER]:#FFFFFF Sua conta já¡ está em uso. ",player,255,255,255,true)
				return false
			end
		end
	end
	return player:setData("account",name),self:loadAccount(player,name)
end

--[[
	function Account:loadAccount(player,username)
	return:void
	description:Try attach account player to data 'account' if all arguments are true.
]]--
function Account:loadAccount(player, username)
	local idAccount = Account.database:select("id"):where("username",username):getSingle().id
	local result = Database("tbl_users_data"):select():where("id_account",idAccount):getAll()[1]
	if not (result.position) then
		self:loadNewAccount(player)
		return
	end
	
	local x, y, z = unpack(fromJSON(result.position))
	local rotation  =  0
	local skin  = result.skin or 0
	local money = result.money or 500
	local interior = result.interior or 0
	local dimension = result.dimension or 0
	local armor = result.armour or 0
	local health = result.health or 100
	local kills = tonumber(result.kills) or 0
	local deaths = tonumber(result.deaths) or 0
	local gang = result.gang
	local level = result.level
	local vip = result.vip
	local balance = result.bank_balance or 0
	local ratio = (deaths == 0 and round(kills / 1,2) or round(kills / deaths,2))

	Spawn.getInstance():spawnPlayerAccount(player,"loadAccount",x,y,z+1.2,rotation,skin)
	--player:spawn(x, y, z, rotation, skin)
	player:setDimension(dimension)
	player:setInterior(interior)
	player.cameraTarget = player
	setPlayerBlurLevel(player, 0)
    player:setMoney(money)
    player:setArmor(armor)
    player:setHealth(health)
    player:setData('kills',kills)
	player:setData('deaths',deaths)
	player:setData('ratio',ratio)
	player:setData('bank_balance', balance)
	player:setData("gang",gang)
	player:setData("Level",level)
	player:setData("vip_account",vip)
	player:outputChat("#FF6464[BANCO]#00FF00 Saldo atual: "..tostring(balance).."$", 255, 255, 0, true)
	player:setData("account", username)
	player:setName(username)
	
	Gang.onPlayerLogin(player,gang,level)
	--exports.Gang:onPlayerEnterGang(player, gang, level)
	--exports.Spawn:setPlayerBlip(player)
	
	removeAllPedClothes(player)
	for _, clothe in pairs(fromJSON(result.clothes)) do
        local type, texture, model = unpack(clothe)
        player:addClothes(texture,model,type)
    end
	
	for weapon,ammo in pairs(fromJSON(result.weapons)) do
		 player:giveWeapon(weapon, ammo)
	end
	
	if (player:getInterior() ~= 0) then
	    player:toggleControl("fire", false) 
        player:toggleControl("next_weapon", false)
        player:toggleControl("previous_weapon", false)
        player:toggleControl("aim_weapon", false)
	    player:setWeaponSlot(0)
	end
end

--[[
	function Account:loadNewAccount(player)
	return:void
	description:When is new account, then loadAccount function is called with default settings.
]]--

function Account:loadNewAccount(player)
	Spawn.getInstance():spawnPlayerAccount(player,"default")
	player:setName(player:getData("account"))
	player:setData("kills", 0)
	player:setData("deaths", 0)
	player:setData("ratio", 0)
	player:setData("bank_balance", 100000)
	player:outputChat("#FF6464[BANCO]#00FF00 Saldo atual: $"..tostring(player:getData("bank_balance")), 255, 255, 0, true)
	player:setData("account", player:getData("account"))
end

--[[
	function Account:saveData(player)
	return:void
	description:Save the data player to the database.
]]--
function Account:saveData(player)
		Account.database:setTable("tbl_users")
		if not player:getData("account") then return false end
		local result = Account.database:select("id"):where("username",player:getData("account")):getSingle()
		if(result and result.id)then
			local idAccount = result.id
			Account.database:setTable("tbl_users_data"):update(
				{
					['position'] = toJSON({getElementPosition(player)}),
					['rotation'] = 0,
					['skin'] = getElementModel(player),
					['health'] = getElementHealth(player),
					['armor'] = getPedArmor(player),
					['money'] = getPlayerMoney(player),
					['interior'] = getElementInterior(player),
					['dimension'] = getElementDimension(player),
					['kills'] = player:getData("kills"),
					['deaths'] = player:getData("deaths"),
					['clothes'] = toJSON(getAllPedClothes(player)),
					['weapons'] = toJSON(getPedWeapons(player)),
					['gang'] = player:getData("gang"),
					['level'] = player:getData("Level"),
					['bank_balance'] = player:getData("bank_balance"),
					['vip'] = player:getData("vip")
				}
			):where("id_account",idAccount):execute()
		end
end


--[[
	function Account:onPlayerQuit(player)
	return:void
	description:When player quit, save data in database.
]]--
function Account:onPlayerQuit(player)
	outputDebugString("login: onPlayerQuit")
	self: saveData(player)
	return true
end

--[[
	function Account:onResourceStop()
	return:void
	description:When resources stop, save all data in database.
]]--
function Account:onResourceStop() 
	for index,player in pairs (getElementsByType('player')) do
		self:saveData(player)
	end	
	outputDebugString("login: onResourceStop")
end

--[[
	function Account:onResourceStart()
	return:void
	description:Initialize the instance.
]]--
addEventHandler('onResourceStart',resourceRoot,
function ()
   	Account()
  end)

  