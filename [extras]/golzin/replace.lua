addEventHandler('onClientResourceStart', resourceRoot, 
function() 
	txd = engineLoadTXD ( "496.txd" )
	engineImportTXD ( txd, 496 )
        
	dff = engineLoadDFF ( "496.dff", 496 )
        engineReplaceModel ( dff, 496 )
end 
)