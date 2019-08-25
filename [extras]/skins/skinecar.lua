local tableSkins = 
{
        {"skin-dilma",298},
        {'skin-lula',292},
        {"skin-police",280},
        {"skin-police-bope",285},
        {"army",287},
        {'skin-police1',281},
        {'vehicle-police-ranger',599},
        {'polmav',497},
        {'bolsonaro',291},
        {'vehicle-police-normal',598},
        {'skin-swag',2},
        {'skin-swag2',7},
        {'skin-fem',9},
        {'skin-police-rj',282},
        {'skin-police-fem',284},
        {'skin-police-op',283},
        {'skin-police-trip',288},
        {'fbi',286},
        {'vehicle-police-rj',596},
        {'vehicle-police-sf',597},
        {'hitler',60},
        {'461',461},
        {'522',522},
        {'sultan',560},
        {'293',293},
        {'7',7},
        {'24',24},
        {'35',35},
        {'61',61},
        {'94',94},
        {'213',213},
        {'253',253},
        {'310',310},
        {'137',137},
        {'312',312},
        {'skin-fem-rand',10},
        {'skin-anime',51},
         {'skin-vip-ran',54},
         {'eric',54},
         {'dylan',55},
         {'sanchez',468},
         {'521',521},
         {'copbike',523},
         {'gokux',306},
         {'luffy',308},
         {'L',290},
         {'narsn2',48},
         {'fam1',30},
         {'sasuke',10},
         {'matrix',50},
         {'xxx',19},
         {'Hashirama',52},
         {'Tobirama',57 },
         {'Hiruzen',58 },
         {'yondaime',59 },
         {'tsunade',56 },
        
    
}




addEventHandler( "onClientResourceStart",getResourceRootElement( ),function()
    for index,value in pairs(tableSkins) do
        local txd = engineLoadTXD("Skin+Car/"..value[1]..".txd")
        engineImportTXD(txd, value[2])
        local dff = engineLoadDFF("Skin+Car/"..value[1]..".dff")
        engineReplaceModel(dff, value[2])
    end
end)

