local super = Class("Database",LuaObject,function ()
	static.getInstance = function()
		return LuaObject.getSingleton(static)
	end
	static.dbName = "db_gangwar"
	static.host = "127.0.0.1"
	static.user = "dba_gangwar"
	static.password = "ianitolindo"
	static.port = "3306"
	static.typeConnection = "mysql"
	static.connection = (function ()
		local connection = nil
		if(static.typeConnection == "mysql") then
		connection = Connection(static.typeConnection, "dbname=" .. static.dbName .. ";host=" .. static.host .. ";port=" .. static.port, static.user.."", static.password.."", "share=1")
		elseif(static.typeConnection == "sqlite") then
			connection = dbConnect( "sqlite","database.db".." share=1;")
		end
		if(connection) then
			outputDebugString("DB Connected;")
		else
			outputDebugString("Não foi possível conectar ao banco de dados",1)
		end
		return connection
	end)()

end).getSuperclass()


function Database:init(table)
	super.init(self)
	self.query = nil
	self.currentTable = table or nil
	return self;
end
--[[

	Executa a query que foi informada, sem nenhum retorno. 

]]
function Database:execute()
	if not self.query then return false end
	if self.query then
		if(Database.connection:exec(self.query)) then
			self.query = nil
			return true
		end
	end
	return false
end
--[[

	Retorna o primeiro resultado da consulta em uma tabela.

	Exemplo:
	outputChatBox(result.columnName)


]]
function Database:getSingle()
	self.query = Database.connection:prepareString(self.query) 
	if self.query then
		local query = Database.connection:query(self.query)
		local result = query:poll(-1)

		if(type(result) == "table") then
			self.query = nil
			return result[1]
		end
	end
	return false
end

--[[
	Retorna todos os resultados da consulta em uma tabela
	
	Exemplo:
	result[1] = 1 row
	result[2] = 2 row
	outputChatBox(result[1].columnName)
]]
function Database:getAll()

	self.query = Database.connection:prepareString(self.query)
	if self.query then
		local query = Database.connection:query(self.query)
		local result = query:poll(-1)
		if(type(result) == "table") then
			self.query = nil
			return result
		end
	end
end

--[[

	Retorna a conexão da database em forma de elemento.
	Útil quando se deseja usar os metodos mais genéricos.
	dbPoll,dbFree,dbQuery e etc.

]]
function Database:getConnection()
	return Database.connection
end

function Database:getQuery()
	outputChatBox( self.query)
	return self.query
end

--[[

	A função custom é a mais genérica de todas, basicamente, você pode escrever toda uma query nela, 
	ou apenas complementar a que já está feita. 
	Exemplo:
	
	Database():custom("SELECT * FROM tbl_users") = SELECT * FROM tbl_users
	Database("table_name"):select():where("id = 1") = SELECT * from table_name where id=1;

]]--
function Database:custom(string,...)
	local result = {...} or nil
	if not self.query then
		self.query = Database.connection:prepareString(string,unpack{result})
	else
		self.query = self.query .. " "..Database.connection:prepareString(string,unpack{result})
	end
	return self
end

function Database:isConnected()
	return isElement(Database.connection)
end

--[[
	
	Metodo para fazer select na tabela informada.
	@Exemplo
	Database("table_name"):select() = SELECT * from table_name
	Database("table_name"):select("username") = SELECT username from table_name
	Database("table_name"):select("username","senha") = SELECT username,senha from table_name

]]--
function Database:select(...)
	local result = {...}
	local ps = nil
	local isTable = (type(result[1]) == "table"  and true or false)

	if not isTable then		
		for index, value in pairs(result)do 
			if ps then 
				ps = ps..", "..value
			else
				ps = "SELECT "..value
			end
		end
	else
		for iTable,vTable in pairs (result[1])do
			if ps then 
				ps = ps..", "..vTable
			else
				ps = "SELECT "..vTable
			end
		end
	end
	if not ps then ps = "SELECT *" end
	self.query = ps .. " FROM " ..self.currentTable
	return self
end

--[[

	Metodo para alterar a tabela,a adicionando colunas, deletando colunas ou alterando colunas.
	Exemplo:
	Database("table_name"):select():where("id=1"):getSingle()

]]--
function Database:alter(...)
	local result = {...}
	local ps = nil
	if not result then return nil end
	if result[1] and result[2] then
		ps = "ALTER TABLE "..self.currentTable

		if(string.lower(result[1]) == "add") then
			ps = ps.." ADD "..result[1].." "..result[2].. " "..result[3]
		elseif(string.lower(result[1]) == "drop") then
				ps = ps.." DROP "..result[2]
				
		elseif(string.lower(result[1]) == "modify") then
			ps = ps .." MODIFY COLUMN "..result[2].. " "..result[3]
		end
	end
	self.query = ps or false
	return self
end
--[[

	Metodo para deletar a
	Exemplo:
	Database("table_name"):delete():where("id=1"):getSingle()

]]--
--[[
	
	Metodo para fazer select na tabela informada.
	@Exemplo
	Database("table_name"):select() = SELECT * from table_name
	Database("table_name"):select("username") = SELECT username from table_name
	Database("table_name"):select("username","senha") = SELECT username,senha from table_name

]]--
function Database:delete()
	local ps = nil
	if not ps then ps = "DELETE" end
	self.query = ps .. " FROM " ..self.currentTable
	return self
end
--[[
	
	Insere dados na tabela de forma simples.
	Exemplo:
	Database("tbl_users"):insert(
	{
		['username'] = "Iaan",
		['password'] = "123321"
		['serial'] = getPlayerSerial(getPlayerFromName("Iaan"))
	}
	):execute()

]]
function Database:insert(table)
	local ps = nil
	local columns = nil
	local values = nil
	if(table) then
		ps = "INSERT INTO "..self.currentTable.." "
		local current = 1
		for index, tValue in pairs(table) do
			if tValue then
				if not (columns)then
					columns = "("..index
				else
					columns = columns..", "..index 
				end	
					if(getTableLength(table) == current) then
						columns = columns.. ")"
					end
				if not (values) then
					values = "(".."\'"..tValue.."\'"
				
				else
					values = values..", ".."\'"..tValue.."\'"
					
				end
				if(getTableLength(table) == current) then
					values = values.. ")"
				end 			
			end
			current = current +1
		end
		self.query = ps..columns.." VALUES "..values or false
		
	end
	--outputChatBox(columns)
	return self
end
--[[

	Atualiza dados na tabela de forma simples.
	Exemplo:
	Database("tbl_users"):update(
	{
		['username'] = "Iaan",
		['password'] = "123321"
		['serial'] = getPlayerSerial(getPlayerFromName("Iaan"))
	}
	):execute()

]]
function Database:update(table)
	local ps = nil
	if(table) then
		ps = "UPDATE "..self.currentTable.." SET "
		local columns = nil
		for index, tValue in pairs(table) do
			if not (columns)then
				if tValue == "NULL" then
					columns = index.."= NULL"
				else
					columns = index.."="..(tValue and "'"..tValue.."'" or "NULL")..""
				end
			else
				if tValue == "NULL" then
						columns = columns..", "..index .."= NULL"
				
				else
					columns = columns..", "..index .."="..(tValue and "'"..tValue.."'" or "NULL")..""
				end
			end		
		end
		ps = ps ..columns

		self.query = ps or false

	end
	return self
end

--[[
	
	Esse metodo é um complemento.
	Exemplo:
	Database("tbl_users"):select():where("id = 1"):getSingle() = SELECT * FROM tbl_users WHERE id=1;
	Database("tbl_users"):select():where("id","1"):getSingle() = SELECT * FROM tbl_users WHERE id=1;

]]
function Database:where(string,value)
	if not self.query or not string then return nil end
	value = (value and (string.." = ".."\'"..value.."\'") or string)
		self.query = self.query .." WHERE "..value
	return self 
end

function Database:setTable(tableName)
	if tableName then
		self.currentTable = tableName
	end
	return self
end

function Database:getTable()
	return self.currentTable
end

--Esse metodo é usado pra ver como sua query está, sem executa-la
function Database:debug()
	outputDebugString( self.query,0)
	self.query = nil
	return self.query
end


function getTableLength(table)
	if type(table) == "table" and table ~= nil then
		local count = 0
		for index, values in pairs(table)do
			count = count + 1
		end
		return count
	end
	return nil
end
