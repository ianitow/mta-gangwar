local sx,sy = guiGetScreenSize()
local px,py = 1366,768
local x,y =  (sx/px), (sy/py)
local rootElement = getResourceRootElement(getThisResource())

function onClientResourceStart()
	messages = {}
	showPlayerHudComponent("area_name",false)
	local x, y, z = getElementPosition(localPlayer)
	zone = getZoneName(x, y, z)
	zoneHud = {
		isRendering = false,
		alpha = nil
	}

	tick = getTickCount()
	triggerServerEvent("onPlayerRequestImage",localPlayer)
end
addEventHandler("onClientResourceStart",resourceRoot,onClientResourceStart)
tick = getTickCount()
function barra ()
vida = getElementHealth ( getLocalPlayer() ) + 0.40000152596
local colete = math.floor(getPedArmor(getLocalPlayer()))
local oxigenio = math.floor(getPedOxygenLevel(getLocalPlayer()))
        dxDrawImage(x*75,y*745,x*118,y*10, "barra.png", 0, 0, 0, tocolor(255, 255, 255, 50), true)
        dxDrawImage(x*75,y*745,x*118/getPedMaxHealth(localPlayer)*vida,y*10, "barra2.png", 0, 0, 0, tocolor(9, 245, 176, 170), true)
        dxDrawImage(x*195,y*745,x*68,y*10, "barra.png", 0, 0, 0, tocolor(255, 255, 255, 50), false)
        dxDrawImage(x*195,y*745,x*68/100*colete,y*10, "barra3.png", 0, 0, 0, tocolor(0, 179, 254, 170),true)
        dxDrawImage(x*265,y*745,x*63,y*10, "barra.png", 0, 0, 0, tocolor(254, 215, 0, 50), false)
        dxDrawImage(x*265,y*745,x*63/1000*oxigenio,y*10, "barra4.png", 0, 0, 0, tocolor(254, 215, 0,170),true)
  tickJ = getTickCount()
	
	if #messages > 7 then
		table.remove(messages, 1)
	end	
	for i, v in ipairs(messages) do
		dxDrawImage(x*80, y*580-(i*y*30), x*256, y*28, "rect.png",180,0,0,tocolor(255, 255, 255, v[3]))
		dxDrawText(v[1],x*90, y*595-(i*y*30), x*50, y*562-(i*y*30)+y*28, tocolor(255, 255, 255, v[3]+75),y*1,"sans","left","center", false,false,false,true)
		if tickJ >= v[2] then
			messages[i][3] = v[3]-2
			if v[3] <= 25 then
				table.remove(messages,i)
			end
		end
	end
end

addEventHandler("onClientRender", root,barra)

function getPedMaxHealth(ped)
    local stat = getPedStat(ped, 24)
    local maxhealth = 100 + (stat - 569) / 4.31
    return math.max(1, maxhealth)
end

function dxDrawBorder(posX, posY,posW,posH,color,scale)
	dxDrawLine(posX, posY, posX+posW, posY, color, scale,false)
	dxDrawLine(posX, posY, posX, posY+posH, color, scale,false)
	dxDrawLine(posX, posY+posH, posX+posW, posY+posH, color, scale,false)
	dxDrawLine(posX+posW, posY, posX+posW, posY+posH, color, scale,false)
end

function findRotation(x1, y1, x2, y2)
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end
  return t
end

function getPointAway(x, y, angle, dist)
        local a = -math.rad(angle)
        dist = dist / 57.295779513082
        return x + (dist * math.deg(math.sin(a))), y + (dist * math.deg(math.cos(a)))
end

function onClientPlayerDamage(attacker, weapon, _, bodypart)
	local part = attacker and getElementType(attacker) == "player" and getPedWeaponSlot(attacker) and getPedWeaponSlot(attacker) or false	
	if attacker and attacker ~= source and not (part == 8 or (part == 7 and weapon ~= 38)) then
		Map.damageEfect[#Map.damageEfect + 1] = {getTickCount(), 0, math.min(25.5 * bodypart, 255)}
	else
		Map.damageEfect[#Map.damageEfect + 1] = {getTickCount(), 0, math.min(40 * bodypart, 255)}
	end
	if #Map.damageEfect > 18 then
		repeat
			table.remove(Map.damageEfect, 1)
		until #Map.damageEfect < 18
	end
end
addEventHandler("onClientPlayerDamage", localPlayer,onClientPlayerDamage)

function outputJoinquitMessage(message)
	table.insert(messages,{message, tickJ+5000, 180})
end

function onClientPlayerJoin()
	outputJoinquitMessage("#FFFFFF"..getPlayerName(source).."#00FF00 Entrou no servidor.")
end
addEventHandler("onClientPlayerJoin", root, onClientPlayerJoin)

function onClientPlayerQuit(r)
	if r == "Timed out" then
		reason = "Net caiu"
	elseif r == "Banned" then
		reason = "Banido"
	elseif r == "Kicked" then
		reason = "Expulso"
	end
	outputJoinquitMessage("#FFFFFF"..getPlayerName(source).."#FF0000 Saiu do servidor. "..(reason and "("..reason..")" or ""))
end
addEventHandler("onClientPlayerQuit", root, onClientPlayerQuit)

function onClientPlayerWasted(killer)
	if killer then
		outputJoinquitMessage("#FFFFFF"..getPlayerName(killer).."#FFFFFF matou "..getPlayerName(source)..".")
	else
		outputJoinquitMessage("#FFFFFF"..getPlayerName(source).."#FFFFFF Cometeu suicidio.")
	end
end
addEventHandler("onClientPlayerWasted", root, onClientPlayerWasted)

function onClientPlayerChangeNick(old,new)
	outputJoinquitMessage("#FFFFFF"..old.."#FFFFFF trocou o nick para "..new..".")
end
addEventHandler("onClientPlayerChangeNick", root, onClientPlayerChangeNick)