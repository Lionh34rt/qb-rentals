local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    -- BLIP
    local blip = AddBlipForCoord(110.59, -1088.84, 29.3)
    SetBlipSprite(blip, 473)
    SetBlipColour(blip, 3)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Vehicle Rental")
    EndTextCommandSetBlipName(blip)
    -- QB TARGET
    exports['qb-target']:AddBoxZone("CarRental", vector3(110.97, -1090.61, 29.3), 0.6, 0.6, {
        name = "CarRental",
        heading = 23.99,
        debugPoly = false,
        minZ = 28.30,
        maxZ = 30.10
        }, {
        options = {
            {
                type = "client",
                event = "qb-rentals:Client:OpenMenu",
                icon = "fas fa-clipboard",
                label = "Rent Vehicle",
            }
        },
        distance = 2.0
    })
end)

RegisterNetEvent('qb-rentals:Client:OpenMenu', function()
    local menu = {
        {
            header = "< Vehicle Rental",
            context = "ESC or click to close",
            event = "nh-context:closeMenu"
        }
    }
    for k, v in pairs(Config.Cars) do
        menu[#menu+1] = {
            header = v.name,
            context = "Price: $"..v.price,
            event = "qb-rentals:Client:RentVehicle",
            image = v.url,
            args = {k}
        }
    end
    TriggerEvent('nh-context:createMenu', menu)
end)

RegisterNetEvent('qb-rentals:Client:RentVehicle', function(model)
    QBCore.Functions.TriggerCallback('qb-rentals:Server:Rent', function(canRent)
        if canRent then 
            -- SPAWN VEHICLE
            local coords = vector4(121.32, -1081.9, 29.19, 0.02)
            QBCore.Functions.SpawnVehicle(model, function(veh)
                SetEntityHeading(veh, coords.w)
                exports['LegacyFuel']:SetFuel(veh, 100.0)
                --TriggerEvent('persistent-vehicles/register-vehicle', veh) -- Uncomment if you use persistent vehicles
                TriggerServerEvent('qb-rentals:Server:GetPapers', GetVehicleNumberPlateText(veh), model)
            end, coords, true)
        else
            QBCore.Functions.Notify("You don't have enough money..", "error", 2500)
        end
    end, model)
end)