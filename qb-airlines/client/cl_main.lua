local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerJob = {}
end)

AddEventHandler('onClientResourceStart',function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

local function CheckPlayers(vehicle)
    for i=-1, 5, 1 do                
        seat = GetPedInVehicleSeat(vehicle, i)
        if seat ~= 0 then
            TaskLeaveVehicle(seat, vehicle, 0)
        end
   end
end

local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function DeleteVehicleMenu()
    TriggerEvent('nh-context:createMenu', {
        {
            header = "< Store Airplane",
            context = "ESC or click to close",
            event = "nh-context:closeMenu"
        },
        {
            header = "Confirm",
            context = "This deletes the airplane",
            event = "qb-airlines:client:menu:DeleteVehicle",
        }
    })
end

CreateThread(function()
    exports['qb-target']:AddBoxZone("ArlinesLSIA", vector3(-1249.1, -3400.25, 13.94), 0.6, 0.6, {
        name = "ArlinesLSIA",
        heading = 62.38,
        debugPoly = false,
        minZ = 12.94,
        maxZ = 14.74
        }, {
        options = {
            {
                type = "client",
                event = "qb-airlines:Client:OpenLSIA",
                icon = "fas fa-plane",
                label = "Grab Plane",
                job = "airlines"
            },
            {
                type = "client",
                event = "qb-airlines:Client:ParachuteShop",
                icon = "fas fa-parachute-box",
                label = "Parachute",
                job = "airlines"
            }
        },
        distance = 2.0
    })

    exports['qb-target']:AddBoxZone("ArlinesSS", vector3(1725.6, 3300.79, 41.22), 0.6, 0.6, {
        name = "ArlinesSS",
        heading = 277.31,
        debugPoly = false,
        minZ = 40.22,
        maxZ = 42.02
        }, {
        options = {
            {
                type = "client",
                event = "qb-airlines:Client:OpenSS",
                icon = "fas fa-plane",
                label = "Grab Plane",
                job = "airlines"
            },
            {
                type = "client",
                event = "qb-airlines:Client:ParachuteShop",
                icon = "fas fa-parachute-box",
                label = "Parachute",
                job = "airlines"
            }
        },
        distance = 2.0
    })
end)

RegisterNetEvent('qb-airlines:client:menu:DeleteVehicle', function()
    local plane = GetVehiclePedIsIn(PlayerPedId(), true)
    CheckPlayers(plane)
    Wait(1500)
    NetworkFadeOutEntity(plane, true, false)
    Wait(2000)
    QBCore.Functions.DeleteVehicle(plane)
end)

RegisterNetEvent('qb-airlines:Client:OpenLSIA', function()
    local menu = {
        {
            header = "< Airlines",
            context = "ESC or click to close",
            event = "nh-context:closeMenu"
        }
    }
    for k, v in pairs(Config.Planes) do
        menu[#menu+1] = {
            header = v.label,
            context = "Price: $"..v.price.." | Passengers: "..v.capacity,
            event = "qb-airlines:Client:GrabPlane",
            image = v.url,
            args = {k, "LSIA"}
        }
    end
    TriggerEvent('nh-context:createMenu', menu)
end)

RegisterNetEvent('qb-airlines:Client:OpenSS', function()
    local menu = {
        {
            header = "< Airlines",
            context = "ESC or click to close",
            event = "nh-context:closeMenu"
        }
    }
    for k, v in pairs(Config.Planes) do
        menu[#menu+1] = {
            header = v.label,
            context = "Price: $"..v.price.." | Passengers: "..v.capacity,
            event = "qb-airlines:Client:GrabPlane",
            image = v.url,
            args = {k, "SS"}
        }
    end
    TriggerEvent('nh-context:createMenu', menu)
end)

RegisterNetEvent('qb-airlines:Client:GrabPlane', function(plane, airport)
    QBCore.Functions.TriggerCallback('qb-airlines:Server:Rent', function(canBuy)
        if canBuy then
            local coords = Config.Airports[airport]
            QBCore.Functions.SpawnVehicle(Config.Planes[plane].model, function(plane)
                SetEntityHeading(plane, coords.w)
                exports['LegacyFuel']:SetFuel(plane, 100.0)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(plane))
                --TriggerEvent('persistent-vehicles/register-vehicle', plane) -- Uncomment if you are using persistent vehicles
            end, coords, true)
        else
            QBCore.Functions.Notify("You don't have enough money..", "error", 2500)
        end
    end, plane)
end)

RegisterNetEvent('qb-airlines:Client:ParachuteShop', function ()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "airlines", Config.Items)
end)

CreateThread(function()
    local blip = AddBlipForCoord(-1271.62, -3380.61, 13.94)
	SetBlipSprite(blip, 90)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.0)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 74)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Airlines Company")
	EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    while true do
        Wait(3)
        if LocalPlayer.state.isLoggedIn and PlayerJob.name == "airlines" then
            local inRange = false
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            for k, v in pairs(Config.Airports) do
                if #(pos - v.xyz) < 10 then
                    if not IsPedOnFoot(ped) then
                        inRange = true
                        DrawMarker(33, v.x, v.y, v.z , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 242, 148, 41, 255, false, false, false, 1, false, false, false)
                        if #(pos - v.xyz) < 5 then
                            DrawText3Ds(v.x, v.y, v.z, "~g~[E]~w~ - Store Plane")
                            if IsControlJustPressed(0, 38) then
                                DeleteVehicleMenu()
                            end
                        end
                    end
                end
            end
            if not inRange then
                Wait(2500)
            end
        else
            Wait(10000)
        end
    end
end)