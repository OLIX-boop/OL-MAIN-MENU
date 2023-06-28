RegisterNetEvent("main-menu:quit")
AddEventHandler("main-menu:quit", function() 
    DropPlayer(source, "Hai lasciato il server!") -- here you can edit the player quit message
end)