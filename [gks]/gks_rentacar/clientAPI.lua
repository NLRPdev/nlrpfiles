
function CarKeysTrigger (callback_vehicle)
    exports['LegacyFuel']:SetFuel(callback_vehicle, 100)
    TriggerEvent("vehiclekeys:client:SetOwner", Config.Core.Functions.GetPlate(callback_vehicle))   -- You may need to write your car key function
end