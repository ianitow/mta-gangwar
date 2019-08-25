--[[-------------------------------------------------

    SA-MP Kill Messages для MTA:SA (DX версия)
    от MX_Master'а

    * Это серверный скрипт
    * Кодировка файла - UTF8
    * Протестировано на MTA:SA 1.0.4

--]]---------------




-- НАСТРОЙКИ (нельзя изменять) --

local root =            getRootElement()
local resourceRoot =    getResourceRootElement()











-- если умер какой-то онлайн игрок
addEventHandler( "onPlayerWasted", root,
    function ( killerWeaponAmmo, killer, deathReason )
        -- если жертва это не игрок, то выводить на экран кил сообщение не надо
        if getElementType(source) ~= "player" then return end

        local killerName, killerNameColor

        -- если киллер это не игрок, а например тачка, то
        if not isElement(killer) or getElementType(killer) ~= "player" then
            killerName =        ""
            killerNameColor =   {0,0,0}
        -- а если киллер это игрок, то
        else
            killerName =        getPlayerName(killer)
            killerNameColor =   { getPlayerNametagColor(killer) }
        end

        -- если использовалась одна из 2 видов ракет
        if (deathReason == 19) or (deathReason == 20) or (deathReason == 21) then
            if getElementType(killer) == "player" then
                deathReason = getPedWeapon(killer)
            end
        end

        -- добавим в кил панельку каждого игрока новый ряд
        triggerClientEvent( "showDeathMessage", resourceRoot,
            killerName, killerNameColor,
            deathReason,
            getPlayerName(source), { getPlayerNametagColor(source) } )
    end
)




-- если какой-то игрок вошел на сервер
addEventHandler( "onPlayerJoin", root,
    function()
        -- добавим в кил панельку каждого игрока новый ряд
        triggerClientEvent( "showDeathMessage", resourceRoot,
            getPlayerName(source), {255,255,255},
            "connected",
            "", {0,0,0} )
    end
)




-- если какой-то игрок вышел с сервера
addEventHandler( "onPlayerQuit", root,
    function()
        -- добавим в кил панельку каждого игрока новый ряд
        triggerClientEvent( "showDeathMessage", resourceRoot,
            getPlayerName(source), {200,200,200},
            "disconnected",
            "", {0,0,0} )
    end
)
