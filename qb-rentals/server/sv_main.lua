local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-rentals:Server:Rent', function(source, cb, car)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('cash', Config.Cars[car].price, "pay-rental") then
        cb(true)
    elseif Player.Functions.RemoveMoney('bank', Config.Cars[car].price, "pay-rental") then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-rentals:Server:GetPapers', function(licenseplate, model)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {
        name = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." "..Player.PlayerData.citizenid,
        veh = QBCore.Shared.Vehicles[model]["brand"].." "..QBCore.Shared.Vehicles[model]["name"],
        plate = licenseplate
    }
    Player.Functions.AddItem("rentalpapers", 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['rentalpapers'], "add")
end)

QBCore.Functions.CreateUseableItem("rentalpapers", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("vehiclekeys:client:SetOwner", source, item.info.plate)
    end
end)