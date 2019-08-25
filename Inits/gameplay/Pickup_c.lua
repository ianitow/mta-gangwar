function addSparks()
	for i=0, 5 do
		local elementX, elementY, elementZ = getElementPosition(source)
		fxAddSparks( elementX, elementY, elementZ, 0, 0, 5, 0.5, 15, 0, 0, 0, false, 10, 7 );
	end
end
addEvent("addSparks", true )
addEventHandler("addSparks", root, addSparks)
