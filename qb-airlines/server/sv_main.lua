local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-airlines:Server:Rent', function(source, cb, airplane)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('bank', Config.Planes[airplane].price, "pay-rental") then
        cb(true)
    else
        cb(false)
    end
end)