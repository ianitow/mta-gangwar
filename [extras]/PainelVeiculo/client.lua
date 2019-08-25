function abrir (_,state)
	if painel == false then
		showCursor(true)
		addEventHandler("onClientRender", root, abrir)
		painel = true
	else
		showCursor(false)
		removeEventHandler("onClientRender", root, abrir)
		painel = false
	end
end
bindKey("F5", "down", abrir)


local idModel = {
	[1] = 14399,
	[2] = 14400,
	[3] = 14401,
	[4] = 14402,
	[5] = 14403,
	[6] = 14404
}

local screenW,screenH = guiGetScreenSize()
local resW, resH = 1024,768
local x, y = (screenW/resW), (screenH/resH)

painel = false
function abrir ()
    dxDrawRectangle(319, 203, 39, 0, tocolor(255, 255, 255, 255), false)
    dxDrawLine(310 - 1, 168 - 1, 310 - 1, 573, tocolor(0, 0, 0, 255), 1, false)
    dxDrawLine(1076, 168 - 1, 310 - 1, 168 - 1, tocolor(0, 0, 0, 255), 1, false)
    dxDrawLine(310 - 1, 573, 1076, 573, tocolor(0, 0, 0, 255), 1, false)
    dxDrawLine(1076, 573, 1076, 168 - 1, tocolor(0, 0, 0, 255), 1, false)
    dxDrawRectangle(310, 168, 766, 405, tocolor(2, 0, 13, 158), false)
    dxDrawLine(311 - 1, 168 - 1, 311 - 1, 203, tocolor(0, 0, 0, 255), 1, false)
    dxDrawLine(1076, 168 - 1, 311 - 1, 168 - 1, tocolor(0, 0, 0, 255), 1, false)
    dxDrawLine(311 - 1, 203, 1076, 203, tocolor(0, 0, 0, 255), 1, false)
    dxDrawLine(1076, 203, 1076, 168 - 1, tocolor(0, 0, 0, 255), 1, false)
    dxDrawRectangle(311, 168, 765, 35, tocolor(182, 94, 8, 214), false)
    dxDrawText("Painel Veiculo", 309 - 1, 167 - 1, 1076 - 1, 203 - 1, tocolor(0, 0, 0, 255), 2.90, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Painel Veiculo", 309 + 1, 167 - 1, 1076 + 1, 203 - 1, tocolor(0, 0, 0, 255), 2.90, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Painel Veiculo", 309 - 1, 167 + 1, 1076 - 1, 203 + 1, tocolor(0, 0, 0, 255), 2.90, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Painel Veiculo", 309 + 1, 167 + 1, 1076 + 1, 203 + 1, tocolor(0, 0, 0, 255), 2.90, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Painel Veiculo", 309, 167, 1076, 203, tocolor(255, 255, 255, 255), 2.90, "default", "center", "center", false, false, false, false, false)
    dxDrawImage(366, 263, 125, 147, "gfx/arrow.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(411, 223, 35, 40, "gfx/seta.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(477, 310, 32, 36, "gfx/seta.png", 93, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(356, 308, 27, 38, "gfx/seta.png", 267, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(352, 352, 31, 48, "gfx/seta.png", 270, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(477, 352, 31, 48, "gfx/seta.png", 93, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(415, 414, 31, 48, "gfx/seta.png", 180, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawRectangle(558, 259, 83, 34, tocolor(149, 5, 1, 250), false)
    dxDrawRectangle(657, 259, 83, 34, tocolor(13, 142, 7, 250), false)
    dxDrawText("Ligar", 559 - 1, 261 - 1, 641 - 1, 293 - 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Ligar", 559 + 1, 261 - 1, 641 + 1, 293 - 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Ligar", 559 - 1, 261 + 1, 641 - 1, 293 + 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Ligar", 559 + 1, 261 + 1, 641 + 1, 293 + 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Ligar", 559, 261, 641, 293, tocolor(255, 255, 255, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Desligar", 658 - 1, 260 - 1, 740 - 1, 293 - 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Desligar", 658 + 1, 260 - 1, 740 + 1, 293 - 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Desligar", 658 - 1, 260 + 1, 740 - 1, 293 + 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Desligar", 658 + 1, 260 + 1, 740 + 1, 293 + 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Desligar", 658, 260, 740, 293, tocolor(255, 255, 255, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Motor", 574 - 1, 213 - 1, 722 - 1, 242 - 1, tocolor(0, 0, 0, 255), 1.40, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Motor", 574 + 1, 213 - 1, 722 + 1, 242 - 1, tocolor(0, 0, 0, 255), 1.40, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Motor", 574 - 1, 213 + 1, 722 - 1, 242 + 1, tocolor(0, 0, 0, 255), 1.40, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Motor", 574 + 1, 213 + 1, 722 + 1, 242 + 1, tocolor(0, 0, 0, 255), 1.40, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Motor", 574, 213, 722, 242, tocolor(255, 255, 255, 255), 1.40, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawRectangle(545, 434, 90, 38, tocolor(145, 3, 3, 250), false)
    dxDrawRectangle(651, 434, 90, 38, tocolor(16, 136, 11, 250), false)
	dxDrawText("Ligado", 545 - 1, 435 - 1, 635 - 1, 472 - 1, tocolor(0, 0, 0, 255), 1.90, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Ligado", 545 + 1, 435 - 1, 635 + 1, 472 - 1, tocolor(0, 0, 0, 255), 1.90, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Ligado", 545 - 1, 435 + 1, 635 - 1, 472 + 1, tocolor(0, 0, 0, 255), 1.90, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Ligado", 545 + 1, 435 + 1, 635 + 1, 472 + 1, tocolor(0, 0, 0, 255), 1.90, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Ligado", 545, 435, 635, 472, tocolor(255, 255, 255, 255), 1.90, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Desligado", 650 - 1, 435 - 1, 741 - 1, 472 - 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Desligado", 650 + 1, 435 - 1, 741 + 1, 472 - 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Desligado", 650 - 1, 435 + 1, 741 - 1, 472 + 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Desligado", 650 + 1, 435 + 1, 741 + 1, 472 + 1, tocolor(0, 0, 0, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Desligado", 650, 435, 741, 472, tocolor(255, 255, 255, 255), 1.70, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Farol", 569 - 1, 386 - 1, 714 - 1, 410 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Farol", 569 + 1, 386 - 1, 714 + 1, 410 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Farol", 569 - 1, 386 + 1, 714 - 1, 410 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Farol", 569 + 1, 386 + 1, 714 + 1, 410 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Farol", 569, 386, 714, 410, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawRectangle(827, 234, 53, 25, tocolor(213, 5, 0, 232), false)
    dxDrawRectangle(899, 234, 53, 25, tocolor(36, 14, 198, 232), false)
    dxDrawRectangle(967, 235, 53, 25, tocolor(47, 113, 22, 249), false)
    dxDrawRectangle(827, 289, 53, 25, tocolor(119, 115, 15, 249), false)
    dxDrawRectangle(899, 289, 53, 25, tocolor(110, 17, 116, 249), false)
    dxDrawRectangle(967, 289, 53, 25, tocolor(72, 60, 71, 249), false)
    dxDrawText("Neon", 847 - 1, 208 - 1, 1000 - 1, 225 - 1, tocolor(0, 0, 0, 255), 1.90, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Neon", 847 + 1, 208 - 1, 1000 + 1, 225 - 1, tocolor(0, 0, 0, 255), 1.90, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Neon", 847 - 1, 208 + 1, 1000 - 1, 225 + 1, tocolor(0, 0, 0, 255), 1.90, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Neon", 847 + 1, 208 + 1, 1000 + 1, 225 + 1, tocolor(0, 0, 0, 255), 1.90, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Neon", 847, 208, 1000, 225, tocolor(255, 255, 255, 255), 1.90, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Suspençao", 817 - 1, 376 - 1, 1052 - 1, 415 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Suspençao", 817 + 1, 376 - 1, 1052 + 1, 415 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Suspençao", 817 - 1, 376 + 1, 1052 - 1, 415 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Suspençao", 817 + 1, 376 + 1, 1052 + 1, 415 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawText("Suspençao", 817, 376, 1052, 415, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
    dxDrawImage(843, 425, 72, 47, "gfx/seta.png", 0, 0, 0, tocolor(129, 11, 2, 249), false)
    dxDrawImage(951, 425, 79, 57, "gfx/seta.png", 180, 0, 0, tocolor(59, 25, 105, 249), false)
	dxDrawLine(863 - 1, 340 - 1, 863 - 1, 358, tocolor(0, 0, 0, 255), 1, false)
    dxDrawLine(997, 340 - 1, 863 - 1, 340 - 1, tocolor(0, 0, 0, 255), 1, false)
    dxDrawLine(863 - 1, 358, 997, 358, tocolor(0, 0, 0, 255), 1, false)
    dxDrawLine(997, 358, 997, 340 - 1, tocolor(0, 0, 0, 255), 1, false)
    dxDrawRectangle(863, 340, 134, 18, tocolor(18, 59, 236, 45), false)
    dxDrawText("Tirar Neon", 863 - 1, 340 - 1, 997 - 1, 358 - 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Tirar Neon", 863 + 1, 340 - 1, 997 + 1, 358 - 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Tirar Neon", 863 - 1, 340 + 1, 997 - 1, 358 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Tirar Neon", 863 + 1, 340 + 1, 997 + 1, 358 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Tirar Neon", 863, 340, 997, 358, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("©Todos os Direitos Reservados >John", 312 - 1, 548 - 1, 1075 - 1, 577 - 1, tocolor(0, 0, 0, 255), 1.40, "default", "center", "center", false, false, false, false, false)
    dxDrawText("©Todos os Direitos Reservados >John", 312 + 1, 548 - 1, 1075 + 1, 577 - 1, tocolor(0, 0, 0, 255), 1.40, "default", "center", "center", false, false, false, false, false)
    dxDrawText("©Todos os Direitos Reservados >John", 312 - 1, 548 + 1, 1075 - 1, 577 + 1, tocolor(0, 0, 0, 255), 1.40, "default", "center", "center", false, false, false, false, false)
    dxDrawText("©Todos os Direitos Reservados >John", 312 + 1, 548 + 1, 1075 + 1, 577 + 1, tocolor(0, 0, 0, 255), 1.40, "default", "center", "center", false, false, false, false, false)
    dxDrawText("©Todos os Direitos Reservados >John", 312, 548, 1075, 577, tocolor(255, 255, 255, 255), 1.40, "default", "center", "center", false, false, false, false, false)
   

end
-------[SUSPENSÃO]-------
function subir (_, state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (843, 425, 72, 47) then
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle and getVehicleController(theVehicle) == localPlayer then
					triggerServerEvent ("subir", getLocalPlayer())
					playSound("Som/murchado.mp3")
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, subir)

function descer(_, state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (951, 425, 79, 57) then
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle and getVehicleController(theVehicle) == localPlayer then
					triggerServerEvent ("descer", getLocalPlayer())
					playSound("Som/murchado.mp3")
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, descer)

function zerar (_, state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement () then
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle and getVehicleController(theVehicle) == localPlayer then
					triggerServerEvent ("zerar", getLocalPlayer())
					playSound("Som/murchado.mp3")
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, zerar)
-------[SUSPENSÃO]-------

-------[NEON]-------
function neonvermelho (_, state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (827, 234, 53, 25) then
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle and getVehicleController(theVehicle) == localPlayer then
					setElementData( localPlayer, "neon", idModel[1] )
					outputChatBox("#000000[ #999999Painel Veiculo #000000] #bebebe Cor Do Neon: #ff0000Vermelho", 255,255,255, true)
					triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
					triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, neonvermelho)

function neonazul (_, state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (899, 234, 53, 25) then
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle and getVehicleController(theVehicle) == localPlayer then
					setElementData( localPlayer, "neon", idModel[2] )
					outputChatBox("#000000[ #999999Painel Veiculo #000000] #bebebe Cor Do Neon: #0000ffAzul", 255,255,255, true)
					triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
					triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, neonazul)

function neonverde (_, state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (967, 235, 53, 25) then
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle and getVehicleController(theVehicle) == localPlayer then
					setElementData( localPlayer, "neon", idModel[3] )
					outputChatBox("#000000[ #999999Painel Veiculo #000000] #bebebe Cor Do Neon: #00ff00Verde", 255,255,255, true)
					triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
					triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, neonverde)

function neonamarelo (_, state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (827, 289, 53, 25) then
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle and getVehicleController(theVehicle) == localPlayer then
					setElementData( localPlayer, "neon", idModel[4] )
					outputChatBox("#000000[ #999999Painel Veiculo #000000] #bebebe Cor Do Neon: #ffcc00Amarelo", 255,255,255, true)
					triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
					triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, neonamarelo)

function neonrosa (_, state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (899, 289, 53, 25) then
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle and getVehicleController(theVehicle) == localPlayer then
					setElementData( localPlayer, "neon", idModel[5] )
					outputChatBox("#000000[ #999999Painel Veiculo #000000] #bebebe Cor Do Neon: #f754e1Rosa", 255,255,255, true)
					triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
					triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, neonrosa)

function neonbranco (_, state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (967, 289, 53, 25) then
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle and getVehicleController(theVehicle) == localPlayer then
					setElementData( localPlayer, "neon", idModel[6] )
					outputChatBox("#000000[ #999999Painel Veiculo #000000] #bebebe Cor Do Neon: #ffffffBranco", 255,255,255, true)
					triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
					triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, neonbranco)

function neonresetado (_, state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (863, 340, 134, 18) then
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle and getVehicleController(theVehicle) == localPlayer then
					setElementData( localPlayer, "neon", 0 )
					outputChatBox("#000000[ #999999Painel Veiculo #000000] #bebebeNeon Resetado", 255,255,255, true)
                    triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, neonresetado)

------[PORTAS]-------
function porta1 (_,state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (411, 223, 35, 40) then
				triggerServerEvent ("porta1", getLocalPlayer())
			end
		end
	end
end
addEventHandler ("onClientClick", root, porta1)

function porta2 (_,state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (356, 308, 27, 38) then
				triggerServerEvent ("porta2", getLocalPlayer())
			end
		end
	end
end
addEventHandler ("onClientClick", root, porta2)

function porta3 (_,state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (477, 310, 32, 36) then
				triggerServerEvent ("porta3", getLocalPlayer())
			end
		end
	end
end
addEventHandler ("onClientClick", root, porta3)

function porta4 (_,state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (477, 352, 31, 48) then
				triggerServerEvent ("porta4", getLocalPlayer())
			end
		end
	end
end
addEventHandler ("onClientClick", root, porta4)

function porta5 (_,state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (352, 352, 31, 48) then
				triggerServerEvent ("porta5", getLocalPlayer())
			end
		end
	end
end
addEventHandler ("onClientClick", root, porta5)

function porta6 (_,state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (415, 414, 31, 48) then
				triggerServerEvent ("porta6", getLocalPlayer())
			end
		end
	end
end
addEventHandler ("onClientClick", root, porta6)

------[PORTAS]-------

function onClientClick (_, state)
	if (source == Btn3) then

	elseif (source == Btn4) then
		setElementData( localPlayer, "neon", idModel[4] )
		outputChatBox("#bebebe Cor Do Neon: #ffcc00Amarelo", 255,255,255, true)
		local theVehicle = getPedOccupiedVehicle ( localPlayer )
		triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
		triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
	elseif (source == Btn5) then
		setElementData( localPlayer, "neon", idModel[5] )
		outputChatBox("#bebebe Cor Do Neon: #f754e1Rosa", 255,255,255, true)
		local theVehicle = getPedOccupiedVehicle ( localPlayer )
		triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
		triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
	elseif (source == Btn6) then
		setElementData( localPlayer, "neon", idModel[6] )
		outputChatBox("#bebebe Cor Do Neon: #ffffffBranco", 255,255,255, true)
		local theVehicle = getPedOccupiedVehicle ( localPlayer )
		triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
		triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
	elseif (source == Btn7) then
		setElementData( localPlayer, "neon", 0 )
		outputChatBox("#bebebeNeon Resetado", 255,255,255, true)
		local theVehicle = getPedOccupiedVehicle ( localPlayer )
		triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
	end
end

function replaceTXD() 
	txd = engineLoadTXD ( "models/MatTextures.txd" )
	engineImportTXD ( txd, idModel[1] )
	engineImportTXD ( txd, idModel[2] )
	engineImportTXD ( txd, idModel[3] )
	engineImportTXD ( txd, idModel[4] )
	engineImportTXD ( txd, idModel[5] )
	engineImportTXD ( txd, idModel[6] )

	col = engineLoadCOL("models/RedNeonTube1.col")
	engineReplaceCOL(col, idModel[1])
	col = engineLoadCOL("models/BlueNeonTube1.col")
	engineReplaceCOL(col, idModel[2])
	col = engineLoadCOL("models/GreenNeonTube1.col")
	engineReplaceCOL(col, idModel[3])
	col = engineLoadCOL("models/YellowNeonTube1.col")
	engineReplaceCOL(col, idModel[4])
	col = engineLoadCOL("models/PinkNeonTube1.col")
	engineReplaceCOL(col, idModel[5])
	col = engineLoadCOL("models/WhiteNeonTube1.col")
	engineReplaceCOL(col, idModel[6])

	dff = engineLoadDFF ( "models/RedNeonTube1.dff", idModel[1] )
	engineReplaceModel ( dff, idModel[1] ) 
	dff = engineLoadDFF ( "models/BlueNeonTube1.dff", idModel[2] )
	engineReplaceModel ( dff, idModel[2] ) 
	dff = engineLoadDFF ( "models/GreenNeonTube1.dff", idModel[3] )
	engineReplaceModel ( dff, idModel[3] ) 
	dff = engineLoadDFF ( "models/YellowNeonTube1.dff", idModel[4] )
	engineReplaceModel ( dff, idModel[4] ) 
	dff = engineLoadDFF ( "models/PinkNeonTube1.dff", idModel[5] )
	engineReplaceModel ( dff, idModel[5] ) 
	dff = engineLoadDFF ( "models/WhiteNeonTube1.dff", idModel[6] )
	engineReplaceModel ( dff, idModel[6] ) 
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceTXD)



function isCursorOnElement(x,y,w,h)
	local mx,my = getCursorPosition ()
	local fullx,fully = guiGetScreenSize()
	cursorx,cursory = mx*fullx,my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end

-------Farol------
function farolon (_,state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (545, 434, 90, 38) then
				triggerServerEvent ("farolon", getLocalPlayer())
			end
		end
	end
end
addEventHandler ("onClientClick", root, farolon)

function faroloff (_,state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (651, 434, 90, 38) then
				triggerServerEvent ("faroloff", getLocalPlayer())
			end
		end
	end
end
addEventHandler ("onClientClick", root, faroloff)

-------Farol------

-------Motor------
function motoron (_,state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (558, 259, 83, 34) then
				triggerServerEvent ("motoron", getLocalPlayer())
			end
		end
	end
end
addEventHandler ("onClientClick", root, motoron)

function motoroff (_,state)
	if painel == true then
		if state == "down" then
			if isCursorOnElement (657, 259, 83, 34) then
				triggerServerEvent ("motoroff", getLocalPlayer())
			end
		end
	end
end
addEventHandler ("onClientClick", root, motoroff)
-------Motor------