local colorInfo = "#0000FF[SERVER] #FFFFFF"
local colorWarning = "#FFFF44[SERVER] #FFFFFF"
local colorDefault = "#FF0000[SERVER] #FFFFFF"
local randomMessagesStatic = {
    colorInfo.."Visite nosso site e adquira nossos vips para mais vantagens. #0000FF".."http://www.maingames.com.br",
    colorInfo.."Para ajuda de alguns de nossos administradores digite #0000FF/ajuda.",
    colorInfo.."Fique de olho nas regras e não seja banido.",
    colorInfo.."Racismo não será tolerado.",
    colorDefault.."Seja um colaborador, ajude na administração.",
    colorDefault.."Visite nosso discord: #FF0000https://discord.me/maingamesofficial",
    colorInfo.."Para mais comandos, aperte #0000FF F9.",
    colorDefault.."Deseja caçar a cabeça de um jogador? #FF0000/hitman <id|nick> <quantidade>.",
    colorInfo.."Compre seu próprio veículo na transfender e tenha sempre disponível.",
    colorDefault.."Vilas dão benefícios a sua Gang."

}
lastRandom = nil
function randomMessagesInfo()
    local random = randomMessagesStatic[math.random(#randomMessagesStatic)]
    while (random ~= lastRandom) do
        outputChatBox(random,root,255,255,255,true)
        break;
    end
    lastRandom = random
end
setTimer(randomMessagesInfo,90000,0)

function showGangDominante()
    local gangTop = Gang.getFirstTop()
    if(gangTop) then
        outputChatBox(colorDefault.."A gang dominante do servidor:",root,255,255,255,true)
        outputChatBox(RGBToHex(gangTop:getColor())..gangTop:getName().."#FFFFFF - #FF0000"..gangTop:getXP().."XP#FFFFFF - "..(gangTop:getSlogan() and gangTop:getSlogan() or "Sem slogan"),root,255,255,255,true)
    end
end
setTimer(showGangDominante,120000,0)