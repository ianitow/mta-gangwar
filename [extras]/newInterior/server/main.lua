local interiors = {[6] = true, [7] = true, [6] = true, [10] = true, [9] = true, [5] = true, [10] = true, [3] = true, [4] = true, [1] = true,   [15] = true, [18] = true, [3] = true, [5] = true, [1] = true, [12] = true}

addEvent("setPlayerInsideInterior", true)
addEventHandler("setPlayerInsideInterior", getRootElement(), function(int,dim,rot,x,y,z)
	setElementInterior(client, int)
    setCameraInterior(client, int)
    setElementDimension(client, dim)
    setPedRotation(client, rot%360)
    setTimer(function(p) if isElement(p) then setCameraTarget(p, p) end end, 200,1, client)
    setElementPosition(client, x, y, z+1)
    setTimer(fadeCamera, 500, 1, client, true, 1.0)
	if(interiors[int]) then
		toggleControl(client,"fire", false) 
		toggleControl(client,"next_weapon", false)
		toggleControl(client,"previous_weapon", false)
		toggleControl(client,"aim_weapon", false)
		setPedWeaponSlot(client, 0)
	else
		toggleControl(client, "fire", true) 
		toggleControl(client,"next_weapon", true)
		toggleControl(client,"previous_weapon", true)
		toggleControl(client,"aim_weapon", true)
	end
end)