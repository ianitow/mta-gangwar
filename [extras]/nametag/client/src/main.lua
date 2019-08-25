local normalDrawDistance = 70.0
local drawDistance = normalDrawDistance
local eventDrawDistance = 10.0

function onClientResourceStart(resource)
	visibleTick = getTickCount()
	counter = 0
	customHealthbar = false
	for k, player in pairs(getElementsByType("player")) do
		setPlayerNametagShowing(player, false)
	end	
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart )

function onClientResourceStop(resource)
	for k, player in pairs(getElementsByType("player")) do
		setPlayerNametagShowing(player, true)
	end	
end
addEventHandler( "onClientResourceStop", resourceRoot, onClientResourceStop)


function onClientPlayerJoin()
	setPlayerNametagShowing(source, false)
end
addEventHandler("onClientPlayerJoin", root, onClientPlayerJoin)

function drawHPBar( x, y, v, d)
	if(v < 0.0) then
		v = 0.0
	elseif(v > 100.0) then
		v = 100.0
	end
	dxDrawRectangle(x - 21, y, 42, 5, tocolor ( 0, 0, 0, 255-d ))
	dxDrawRectangle(x - 20, y + 1, v/2.5 , 3, tocolor ( (100-v) * 2.55, (v * 2.55), 0, 255-d ))
end

function drawArmourBar( x, y, v, d)
	if(v < 0.0) then
		v = 0.0
	elseif(v > 100.0) then
		v = 100.0
	end
	dxDrawRectangle(x - 21, y, 42, 5, tocolor ( 0, 0, 0, 255-d ))
	dxDrawRectangle(x - 20, y + 1, v/2.5 , 3, tocolor ( 255, 255, 255, 255-d ))
end

function drawHud()
	if (customHealthbar) then
		-- > 573 = baixo

		healthColor = tocolor (0,0,0,255)
		healthbgColor = tocolor (255,151,0,127)
		healthfgColor = tocolor (255,151,0,185)
		sx,sy = guiGetScreenSize ()
		healthx = sx/800*683
		healthy = sy/600*89
		healthxoverlay = sx/800*685
		healthyoverlay = sy/600*91

		vehiclehealthx = sx/800*619
		vehiclehealthy = sy/600*169
		vehiclehealthxoverlay = sx/800*621
		vehiclehealthyoverlay = sy/600*171
		
		--if(isPlayerHudComponentVisible("health")) then

			local health = getElementHealth(localPlayer)
			local armour = getPedArmor(localPlayer)
			local rate =  500 / getPedStat(localPlayer,24)
			if (getElementHealth(localPlayer) == 0) then
				if (getTickCount() - visibleTick < 500) then
					local healthRelative = health*rate/100
					local v = health*rate
					dxDrawRectangle (healthx, healthy, 76, 12, healthColor, false)
					dxDrawRectangle (healthxoverlay, healthyoverlay, 72, 8, tocolor((100-v) * 2.55, (v * 2.55), 0, 127), false)
					dxDrawRectangle (healthxoverlay, healthyoverlay, 72*healthRelative, 8, tocolor((100-v) * 2.55, (v * 2.55), 0, 185), false)
				else
					if(getTickCount() - visibleTick >= 1000) then
						visibleTick = getTickCount()
					end
				end
			else
				local healthRelative = health*rate/100
				local v = health*rate
				dxDrawRectangle (healthx, healthy, 76, 12, healthColor, false)
				dxDrawRectangle (healthxoverlay, healthyoverlay, 72, 8, tocolor((100-v) * 2.55, (v * 2.55), 0, 127), false)
				dxDrawRectangle (healthxoverlay, healthyoverlay, 72*healthRelative, 8, tocolor((100-v) * 2.55, (v * 2.55), 0, 185), false)
			end
		
		--end
	end
end

function unfuck(text)
	return string.gsub(text, "(#%x%x%x%x%x%x)", function(colorString) return "" end)
end

function chatCheckPulse()
    local chatting = isChatBoxInputActive() or isConsoleActive()
	if(chatting ~= g_oldChatting) then
		setElementData(localPlayer, "chatting", chatting)
		g_oldChatting = chatting
	end 
end
setTimer(chatCheckPulse, 500, 0)

function drawPlayerTags()
	local cx, cy, cz, lx, ly, lz = getCameraMatrix()
	if(getElementData(localPlayer, "special.event")) then
		drawDistance = eventDrawDistance
	else
		drawDistance = normalDrawDistance
	end
	local target = getPedTarget(localPlayer)
	for k, player in pairs(getElementsByType("player", root, true)) do
		if(player ~= localPlayer or getElementData(player, "isgod")) then
			local vx, vy, vz = getPedBonePosition(player, 8)
			local dist = getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz )
			if dist < drawDistance or player == target then
				if( isLineOfSightClear(cx, cy, cz, vx, vy, vz, true, false, false) ) then
					local x, y = getScreenFromWorldPosition (vx, vy, vz + 0.3)
					if(x and y) then
						local tag = (getElementData(player, "gang.tag") and "["..getElementData(player, "gang.tag").."] ") or ""
						local name = unfuck(tag .. getPlayerName(player)) .. "(" .. (getElementData(player, "ID") or "?") .. ")"
						--local nameU = unfuck(tag .. getPlayerName(player) .. "(" .. (getElementData(player, "id") or "?") .. ")")
						local w = dxGetTextWidth(name, 1, "default-bold")
						local h = dxGetFontHeight(1, "default-bold")
						local color = tocolor(getPlayerNametagColor(player))
						dxDrawText(name, x - 1  - w / 2,y - 1 - h - 12, w, h, tocolor(1,1,1), 1, "default-bold")
						dxDrawText(name, x - w / 2,y - h - 12, w, h, color, 1, "default-bold", "left", "top", false, false, false, true, false)

						if(getElementData(player, "chatting")) then
							dxDrawImage ( x - 1  - w / 2 - h-h/5,y - 1 - h - 12, h, h, "gfx/level_typing.png", 0, 0, 0, color)
						end
	
						local health = getElementHealth ( player )
						local armour = getPedArmor ( player )

						if(health > 0.0) then
							local rate =   math.ceil(500/(getPedStat(player,24)))
							drawHPBar(x, y-6.0, health*rate, dist)
							if(armour > 0.0) then
								drawArmourBar(x, y-12.0, armour, dist)
							end
							if(getElementData(player, "isgod")) then
								w = dxGetTextWidth('GOD ON', 1, "default-bold")
								dxDrawText('GOD ON', x - 1  - w / 2,y - 1 - h - 12-18, w, h, tocolor(0,0,0), 1, "default-bold")
								dxDrawText('GOD ON', x - w / 2,y - h - 12-18, w, h, tocolor(255,255,255), 1, "default-bold")
							end					
						end
					end
				end
			end
		end
	end
end

function drawPedTags()
	local cx, cy, cz, lx, ly, lz = getCameraMatrix()
	local target = getPedTarget(localPlayer)
	for k, ped in pairs(getElementsByType("ped", root, true)) do
		if(getElementData(ped, "nametagShowing")) then
			local vx, vy, vz = getPedBonePosition(ped, 8)
			local dist = getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz )
			if dist < drawDistance or ped == target then
				if( isLineOfSightClear(cx, cy, cz, vx, vy, vz, true, false, false) ) then
					local x, y = getScreenFromWorldPosition (vx, vy, vz + 0.3)
					if(x and y) then
						local tag =  ""
	
						local name = unfuck(tag .. (getElementData(ped, "pedName") or ""))
						local w = dxGetTextWidth(name, 1, "default-bold")
						local h = dxGetFontHeight(1, "default-bold")
						
						local color = tocolor(255,255,255)
						
						local pedNametagColor = getElementData(ped, "pedNametagColor")
						
						if(pedNametagColor) then
							local r,g,b = unpack(pedNametagColor)
							color = tocolor(r,g,b)
						end

						dxDrawText(name, x - 1  - w / 2,y - 1 - h - 12, w, h, tocolor(0,0,0), 1, "default-bold")
						dxDrawText(name, x - w / 2,y - h - 12, w, h, color, 1, "default-bold")

						local health = getElementHealth(ped)
						local armour = getPedArmor(ped)

						if(health > 0.0) then
							local rate =   math.ceil(500/(getPedStat(ped,24)))
							drawHPBar(x, y-6.0, health*rate, dist)
							if(armour > 0.0) then
								drawArmourBar(x, y-12.0, armour, dist)
							end				
						end
						if(getElementData(ped, "hologram")) then
							local text = "Desconectado"
							w = dxGetTextWidth(text, 1, "default-bold")
							dxDrawText(text, x - 1  - w / 2,y - 1 - h - 12-18, w, h, tocolor(0,0,0), 1, "default-bold")
							dxDrawText(text, x - w / 2,y - h - 12-18, w, h, tocolor(255,255,255), 1, "default-bold")
						end						
					end
				end
			end
		end
	end
end

function onClientRender( )
	drawHud()
	drawPlayerTags()
	drawPedTags()
end
addEventHandler("onClientRender", root, onClientRender)

 addCommandHandler("custombar", function()
	customHealthbar = not customHealthbar
 end)