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
	if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawText(text, sx, sy, sx, sy, tocolor(0, 0, 0, 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
				dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end

addEventHandler("onClientRender", getRootElement(), 
function ()
	for k,v in ipairs(getElementsByType("pickup")) do
		if (v:getData("isPropertie")) then
			name = v:getData("name")
			price = v:getData("price")
			lucro = v:getData("lucre")
			owner = v:getData("owner")

			if (owner == nil) then
				owner = "Offline"
				r, g, b = 255, 255, 255
			else
				if(owner ~= nil) then
					if (not Player(owner)) then
						owner = "Offline"
						r, g, b = 255, 255, 255
					else
						r, g, b = getPlayerNametagColor(getPlayerFromName(owner))
					end
				else
					owner = "Offline"
					r, g, b = 255, 255, 255
				end
			end
			dxDrawTextOnElement(v, "Nome: "..name, 1.2, 20, r, g, b, 255, 1, "default-bold")
			dxDrawTextOnElement(v, "Preço: "..tostring(price).."$", 1, 20, r, g, b, 255, 1, "default-bold")
			dxDrawTextOnElement(v, "Lucro: "..tostring(lucro).."$", 0.8, 20, r, g, b, 255, 1, "default-bold")
			dxDrawTextOnElement(v, "Dono: "..owner, 0.6, 20, r, g, b, 255, 1, "default-bold")
		end
	end
end
)
