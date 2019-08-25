addEvent("onAccountTryLogin",true)
addEventHandler("onAccountTryLogin",root,function (username,password)
	local class = Account.getInstance()
	if(class:login(client,username,password)) then
		triggerClientEvent(client,"onAccountLogged",client)
	end
end)

addEvent("onAccountTryRegister",true)
addEventHandler("onAccountTryRegister",root,function (username,password)
	local class =  Account.getInstance()
	if(class:create(client,username,password)) then
		triggerClientEvent( client,"onAccountRegister",client)
	end
end)