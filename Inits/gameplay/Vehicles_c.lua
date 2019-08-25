function onClientElementStreamIn()
    if(localPlayer:getData("Hud")) then return end
    if getElementType(source) == "vehicle" then
		createBlipAttachedTo(source, 0, 0.5, 100, 100, 100, 255, -1, 200.0)
	
    end
end
addEventHandler("onClientElementStreamIn", root, onClientElementStreamIn)

function destroyAttachedBlips(vehicle)
    if getElementType(vehicle) == "vehicle" then
		local attachedElements = getAttachedElements(vehicle)
		if(attachedElements) then
			for k,v in pairs(attachedElements) do
				if(getElementType(v) == "blip") then
					destroyElement(v)
				end
			end
		end
    end	
end

function onClientElementDestroy()
	destroyAttachedBlips(source)
end
addEventHandler("onClientElementDestroy", root, onClientElementDestroy)

function onClientElementStreamOut()
    destroyAttachedBlips(source)
end
addEventHandler("onClientElementStreamOut", root, onClientElementStreamOut)
