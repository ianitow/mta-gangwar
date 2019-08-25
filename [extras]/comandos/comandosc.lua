function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,checkBuildings,checkVehicles,checkPeds,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getElementPosition(localPlayer)
	local distance = distance or 20
	local height = height or 1
    local checkBuildings = checkBuildings or true
    local checkVehicles = checkVehicles or false
    local checkPeds = checkPeds or false
    local checkObjects = checkObjects or true
    local checkDummies = checkDummies or true
    local seeThroughStuff = seeThroughStuff or false
    local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false
    local ignoredElement = ignoredElement or nil
    if getPedMoveState(TheElement) == "crouch" then
    	height = height - 0.8
    end
	if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end

addEventHandler ( "onClientPlayerDamage",root,
function ()
    if getElementData(source,"god_mode") then
        cancelEvent()
    end
end)
 
addEventHandler("onClientPlayerStealthKill",localPlayer,
function (targetPlayer)
    if getElementData(targetPlayer,"god_mode") then
        cancelEvent()
    end
end)

addEventHandler( "onClientRender", getRootElement(), function()
	for k, v in  pairs (getElementsByType("player")) do
		if getElementData(v, "god_mode") then
       		dxDrawTextOnElement(v, "GOD ON",1,20,255,255,255,255,1.5,"default-bold")
    	end
    end
end)

function kickAFK()
	if getElementData(localPlayer, "afk") then
		kickTimer = setTimer(
		function()
			if getElementData(localPlayer, "afk") then
				triggerServerEvent("timeToKick", resourceRoot)
			end
		end, 300000, 1)
	end
end

addEventHandler("onClientRender", getRootElement(  ), 
function()
	local sx, sy, sz = getElementVelocity(localPlayer)
	if getPedOccupiedVehicle(localPlayer) then
		sx, sy, sz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
	end
	local actualSpeed  = (sx^2 + sy^2 + sz^2)^(0.5)
	if actualSpeed == 0 then
		if getElementData(localPlayer, "afk") == false then
			setElementData(localPlayer, "afk", true)
			triggerEvent("onPlayerAFK", localPlayer)
		end
	else
		if getElementData(localPlayer, "afk") == true then
			setElementData(localPlayer, "afk", false)
			if isTimer(kickTimer) then
				killTimer(kickTimer)
			end
		end
	end
end
)
addEvent("onPlayerAFK")
addEventHandler("onPlayerAFK", localPlayer, kickAFK)


function tocarDueloSom(desafiado)
	if getElementData(desafiado, "duelo") == "desafiado" then
		local dx, dy, dz = getElementPosition(desafiado)
		local mx, my, mz = getElementPosition(localPlayer)
		local pimba = playSound3D("match.wav", dx, dy, dz)
		setSoundMaxDistance(pimba, 100)
		local distancia = getDistanceBetweenPoints3D(dx, dy, dz, mx, my, mz)
		local altura = 1 - distancia/100
		setSoundVolume(pimba, altura)
	end
end

function tocarPmSom(myself)
	playSound("bip.wav")
end

addEvent("onDuelInvite", true)
addEventHandler("onDuelInvite", root, tocarDueloSom)
addEvent("onReceivePm", true)
addEventHandler("onReceivePm", root, tocarPmSom)


